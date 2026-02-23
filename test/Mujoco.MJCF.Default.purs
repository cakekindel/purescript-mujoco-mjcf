module Test.Mujoco.MJCF.Default where

import Prelude

import Data.Tuple.Nested ((/\))
import Mujoco.MJCF as X
import Mujoco.MJCF.Default as Def
import Test.Mujoco.MJCF.Util (MjcfSpec, parseOk)
import Test.Spec (describe, it)

spec :: MjcfSpec Unit
spec =
  describe "default" do
    it "empty" $ parseOk $ X.mujoco {}
      [ Def.default {} unit
      , X.worldbody {} unit
      ]

    it "with class" $ parseOk $ X.mujoco {}
      [ Def.default { class: "main" } unit
      , X.worldbody {} unit
      ]

    it "geom defaults" $ parseOk $ X.mujoco {}
      [ Def.default {}
          [ Def.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0], rgba: 1.0 /\ 0.0 /\ 0.0 /\ 1.0 } ]
      , X.worldbody {}
          [ X.geom {} unit ]
      ]

    it "joint defaults" $ parseOk $ X.mujoco {}
      [ X.compiler { inertiafromgeom: X.true_ }
      , Def.default {}
          [ Def.joint { type: X.kw X.Hinge, damping: 1.0, stiffness: 10.0 }
          , Def.geom { type: X.kw X.Capsule, size: [0.05, 0.2] }
          ]
      , X.worldbody {}
          [ X.body { pos: 0.0 /\ 0.0 /\ 0.5 }
              [ X.joint { axis: 1.0 /\ 0.0 /\ 0.0 }
              , X.geom {} unit
              ]
          ]
      ]

    it "nested defaults" $ parseOk $ X.mujoco {}
      [ X.compiler { inertiafromgeom: X.true_ }
      , Def.default {}
          [ Def.geom { rgba: 1.0 /\ 1.0 /\ 1.0 /\ 1.0 }
          , Def.default { class: "red" }
              [ Def.geom { rgba: 1.0 /\ 0.0 /\ 0.0 /\ 1.0 } ]
          ]
      , X.worldbody {}
          [ X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit ]
      ]

    it "site defaults" $ parseOk $ X.mujoco {}
      [ Def.default {}
          [ Def.site { type: X.kw X.Sphere, size: 0.02 /\ 0.02 /\ 0.02, rgba: 0.0 /\ 1.0 /\ 0.0 /\ 1.0 } ]
      , X.worldbody {}
          [ X.site { name: "s1", pos: 0.0 /\ 0.0 /\ 0.0 } ]
      ]

    it "light defaults" $ parseOk $ X.mujoco {}
      [ Def.default {}
          [ Def.light { diffuse: 0.8 /\ 0.8 /\ 0.8, castshadow: true } ]
      , X.worldbody {}
          [ X.light { name: "l1", pos: 0.0 /\ 0.0 /\ 3.0 } ]
      ]

    it "camera defaults" $ parseOk $ X.mujoco {}
      [ Def.default {}
          [ Def.camera { fovy: 60.0 } ]
      , X.worldbody {}
          [ X.camera { name: "c1", pos: 0.0 /\ (-2.0) /\ 1.0 } ]
      ]

    it "motor defaults" $ parseOk $ X.mujoco {}
      [ X.compiler { inertiafromgeom: X.true_ }
      , Def.default {}
          [ Def.motor { ctrllimited: X.true_, ctrlrange: (-1.0) /\ 1.0 } ]
      , X.worldbody {}
          [ X.body { pos: 0.0 /\ 0.0 /\ 0.5 }
              [ X.joint { name: "j1", type: X.kw X.Hinge, axis: 1.0 /\ 0.0 /\ 0.0 }
              , X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit
              ]
          ]
      ]
