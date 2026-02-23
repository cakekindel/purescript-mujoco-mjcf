module Test.Mujoco.MJCF where

import Prelude

import Control.Monad.Error.Class (try)
import Data.Either (isLeft)
import Data.Tuple.Nested ((/\))
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Mujoco.MJCF as X
import Mujoco.MJCF.Geom as X.G
import Mujoco.Wasm (renderSpec)
import Mujoco.XML.Node (Node)
import Mujoco.XML.Node as XML
import Test.Assert (assertTrue)
import Test.Spec (Spec, describe, it)

ok :: Node -> Aff Unit
ok = void <<< renderSpec

fail :: Node -> Aff Unit
fail = (liftEffect <<< assertTrue <<< isLeft) <=< (try <<< renderSpec)

w :: forall a. XML.Children a => a -> Node
w = X.mujoco {} <<< X.worldbody {}

spec :: Spec Unit
spec =
  describe "MJCF" do
    it "</>" $ fail $ X.empty
    it "<mujoco>" $ ok $ X.mujoco {} unit
    it "<worldbody>" $ ok $ X.mujoco {} $ X.worldbody {} unit

    describe "compiler" do
      it "empty" $ ok $ X.mujoco {}
        [ X.compiler {}
        , X.worldbody {} unit
        ]

      it "angle=radian" $ ok $ X.mujoco {}
        [ X.compiler { angle: X.kw X.Radian }
        , X.worldbody {} unit
        ]

      it "autolimits + coordinate" $ ok $ X.mujoco {}
        [ X.compiler { autolimits: true, coordinate: X.kw X.Local }
        , X.worldbody {} unit
        ]

      it "inertiafromgeom=auto" $ ok $ X.mujoco {}
        [ X.compiler { inertiafromgeom: X.kw X.Auto }
        , X.worldbody {} unit
        ]

      it "boundmass + boundinertia" $ ok $ X.mujoco {}
        [ X.compiler { boundmass: 0.01, boundinertia: 0.001 }
        , X.worldbody {} unit
        ]

    describe "size" do
      it "empty" $ ok $ X.mujoco {}
        [ X.size {}
        , X.worldbody {} unit
        ]

      it "memory" $ ok $ X.mujoco {}
        [ X.size { memory: "16M" }
        , X.worldbody {} unit
        ]

      it "nuser fields" $ ok $ X.mujoco {}
        [ X.size { nuser_body: 2, nuser_jnt: 1, nuser_geom: 3 }
        , X.worldbody {} unit
        ]

    describe "option" do
      it "timestep + integrator" $ ok $ X.mujoco {}
        [ X.option { timestep: 0.001, integrator: X.kw X.RK4 } unit
        , X.worldbody {} unit
        ]

      it "gravity + solver" $ ok $ X.mujoco {}
        [ X.option { gravity: 0.0 /\ 0.0 /\ (-9.81), solver: X.kw X.Newton } unit
        , X.worldbody {} unit
        ]

    describe "statistic" do
      it "extent + center" $ ok $ X.mujoco {}
        [ X.statistic { extent: 2.0, center: 0.0 /\ 0.0 /\ 1.0 }
        , X.worldbody {} unit
        ]

    describe "asset" do
      describe "mesh" do
        it "inline vertex" $ ok $ X.mujoco {}
          [ X.asset {}
              [ X.mesh { name: "tetra", vertex: [0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0] } unit ]
          , X.worldbody {} unit
          ]

      describe "hfield" do
        it "nrow + ncol + size" $ ok $ X.mujoco {}
          [ X.asset {}
              [ X.hfield { name: "terrain", nrow: 10, ncol: 10, size: 1.0 /\ 1.0 /\ 0.5 /\ 0.1 } ]
          , X.worldbody {} unit
          ]

      describe "texture" do
        it "procedural checker" $ ok $ X.mujoco {}
          [ X.asset {}
              [ X.texture
                  { name: "grid"
                  , type: X.kw X.TwoD
                  , builtin: X.kw X.Checker
                  , width: 512
                  , height: 512
                  , rgb1: 0.9 /\ 0.9 /\ 0.9
                  , rgb2: 0.1 /\ 0.1 /\ 0.1
                  }
              ]
          , X.worldbody {} unit
          ]

      describe "material" do
        it "rgba + specular" $ ok $ X.mujoco {}
          [ X.asset {}
              [ X.material { name: "mat1", rgba: 0.8 /\ 0.2 /\ 0.2 /\ 1.0, specular: 0.8 } unit ]
          , X.worldbody {} unit
          ]

    describe "body" do
      describe "joint" do
        it "hinge" $ ok $ w $
          X.body { name: "b1", pos: 0.0 /\ 0.0 /\ 0.5 }
            [ X.joint { type: X.kw X.Hinge, axis: 1.0 /\ 0.0 /\ 0.0 }
            , X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit
            ]

        it "slide with range" $ ok $ w $
          X.body { name: "slider", pos: 0.0 /\ 0.0 /\ 1.0 }
            [ X.joint { type: X.kw X.Slide, axis: 0.0 /\ 0.0 /\ 1.0, range: (-1.0) /\ 1.0, limited: X.true_ }
            , X.geom { type: X.kw X.Box, size: [0.1, 0.1, 0.1] } unit
            ]

        it "stiffness + damping" $ ok $ w $
          X.body { pos: 0.0 /\ 0.0 /\ 0.0 }
            [ X.joint { type: X.kw X.Hinge, stiffness: 100.0, damping: 10.0, armature: 0.1 }
            , X.geom { type: X.kw X.Sphere, size: [0.05, 0.0, 0.0] } unit
            ]

      describe "freejoint" do
        it "basic" $ ok $ w $
          X.body { name: "free_body", pos: 0.0 /\ 0.0 /\ 1.0 }
            [ X.freejoint { name: "fj" }
            , X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit
            ]

      describe "geom" do
        it "sphere" $ ok $ w $
          X.geom { type: X.kw X.Sphere, size: [1.0, 0.0, 0.0] } unit

        it "capsule fromto" $ ok $ w $
          X.geom { type: X.kw X.Capsule, fromto: [0.0, 0.0, 0.0, 0.0, 0.0, 1.0], size: [0.05, 0.0, 0.0] } unit

        it "box with material" $ ok $ X.mujoco {}
          [ X.asset {}
              [ X.material { name: "red", rgba: 1.0 /\ 0.0 /\ 0.0 /\ 1.0 } unit ]
          , X.worldbody {} $
              X.geom { type: X.kw X.Box, size: [0.5, 0.5, 0.5], material: "red" } unit
          ]

        it "plane" $ ok $ w $
          X.geom { type: X.kw X.Plane, size: [5.0, 5.0, 0.1] } unit

        it "friction + density" $ ok $ w $
          X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0], friction: 0.5 /\ 0.005 /\ 0.0001, density: 500.0 } unit

      describe "site" do
        it "basic" $ ok $ w $
          X.body { pos: 0.0 /\ 0.0 /\ 0.0 }
            [ X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit
            , X.site { name: "s1", pos: 0.0 /\ 0.0 /\ 0.1, size: 0.01 /\ 0.01 /\ 0.01 }
            ]

      describe "camera" do
        it "fixed" $ ok $ w $
          X.camera { name: "cam1", pos: 0.0 /\ (-2.0) /\ 1.0, fovy: 60.0 }

        it "tracking" $ ok $ w $
          X.body { name: "target_body", pos: 0.0 /\ 0.0 /\ 0.5 }
            [ X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit
            , X.camera { name: "tracker", mode: X.kw X.Targetbody, target: "target_body", pos: 1.0 /\ 0.0 /\ 0.5 }
            ]

      describe "light" do
        it "spotlight" $ ok $ w $
          X.light { name: "spot1", pos: 0.0 /\ 0.0 /\ 3.0, dir: 0.0 /\ 0.0 /\ (-1.0), diffuse: 1.0 /\ 1.0 /\ 1.0 }

        it "directional" $ ok $ w $
          X.light { name: "sun", type: X.kw X.Directional, dir: 0.0 /\ (-1.0) /\ (-1.0), castshadow: true }

      describe "inertial" do
        it "explicit mass + diaginertia" $ ok $ w $
          X.body { pos: 0.0 /\ 0.0 /\ 0.0 }
            [ X.inertial { pos: 0.0 /\ 0.0 /\ 0.0, mass: 1.0, diaginertia: 0.01 /\ 0.01 /\ 0.01 }
            , X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit
            ]

    describe "composite" do
      it "full model"
        $ ok
        $ X.mujoco { model: "test" }
            [ X.compiler { angle: X.kw X.Radian, inertiafromgeom: X.true_ }
            , X.option { timestep: 0.002, gravity: 0.0 /\ 0.0 /\ (-9.81) }
                [ X.flag { contact: X.kw X.Enable } ]
            , X.asset {}
                [ X.texture { name: "grid", type: X.kw X.TwoD, builtin: X.kw X.Checker, width: 256, height: 256, rgb1: 0.9 /\ 0.9 /\ 0.9, rgb2: 0.1 /\ 0.1 /\ 0.1 }
                , X.material { name: "floor_mat", texture: "grid", texrepeat: 5.0 /\ 5.0 } unit
                ]
            , X.worldbody {}
                [ X.geom { type: X.kw X.Plane, size: [5.0, 5.0, 0.1], material: "floor_mat" } unit
                , X.light { name: "top", pos: 0.0 /\ 0.0 /\ 3.0, dir: 0.0 /\ 0.0 /\ (-1.0) }
                , X.body { name: "ball", pos: 0.0 /\ 0.0 /\ 1.0 }
                    [ X.freejoint {}
                    , X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0], rgba: 1.0 /\ 0.0 /\ 0.0 /\ 1.0 } unit
                    ]
                ]
            ]

      it "bodies with joints" $ ok $ w
        [ X.light { name: "top", pos: 0.0 /\ 0.0 /\ 1.0 }
        , X.body {}
          [ X.joint { name: "v0_rx", damping: 1.0, stiffness: 10.0, axis: 1.0 /\ 0.0 /\ 0.0, pos: 0.0 /\ 0.0 /\ (-0.5) }
          , X.joint { name: "v0_ry", damping: 1.0, stiffness: 10.0, axis: 0.0 /\ 1.0 /\ 0.0, pos: 0.0 /\ 0.0 /\ (-0.5) }
          , X.geom { type: X.kw X.Cylinder, size: [1.0, 0.05] } unit
          , X.body { pos: zero /\ zero /\ 0.51 }
            [ X.joint { name: "b0a_rx", damping: 1.0, stiffness: 10.0, axis: 1.0 /\ 0.0 /\ 0.0, pos: 0.0 /\ 0.0 /\ (-0.5) }
            , X.joint { name: "b0a_ry", damping: 1.0, stiffness: 10.0, axis: 0.0 /\ 1.0 /\ 0.0, pos: 0.0 /\ 0.0 /\ (-0.5) }
            , X.geom { type: X.kw X.Cylinder, size: [0.05, 0.5] } unit
            , X.body { pos: zero /\ zero /\ one }
              [ X.joint { name: "b0b_rx", damping: 1.0, stiffness: 10.0, axis: 1.0 /\ 0.0 /\ 0.0, pos: 0.0 /\ 0.0 /\ (-0.5) }
              , X.joint { name: "b0b_ry", damping: 1.0, stiffness: 10.0, axis: 0.0 /\ 1.0 /\ 0.0, pos: 0.0 /\ 0.0 /\ (-0.5) }
              , X.geom { type: X.kw X.Cylinder, size: [0.05, 0.5] } unit
              , X.body { pos: zero /\ zero /\ 0.5 }
                [ X.joint { name: "v1_rx", damping: 1.0, stiffness: 10.0, axis: 1.0 /\ 0.0 /\ 0.0, pos: 0.0 /\ 0.0 /\ (-0.5) }
                , X.joint { name: "v1_ry", damping: 1.0, stiffness: 10.0, axis: 0.0 /\ 1.0 /\ 0.0, pos: 0.0 /\ 0.0 /\ (-0.5) }
                , X.geom { type: X.kw X.Cylinder, size: [1.0, 0.05] } unit
                ]
              ]
            ]
          ]
        ]
