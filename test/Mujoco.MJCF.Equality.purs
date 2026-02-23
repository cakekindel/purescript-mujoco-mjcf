module Test.Mujoco.MJCF.Equality where

import Prelude

import Data.Tuple.Nested ((/\))
import Mujoco.MJCF as X
import Mujoco.MJCF.Equality as Eq
import Mujoco.MJCF.Tendon as Tendon
import Mujoco.MJCF.XML (Node)
import Test.Mujoco.MJCF.Util (MjcfSpec, parseOk)
import Test.Spec (describe, it)

-- | Model with two bodies, joints, and sites for equality constraint tests
m :: Node -> Node
m e = X.mujoco {}
  [ X.compiler { inertiafromgeom: X.true_ }
  , X.worldbody {}
      [ X.body { name: "b1", pos: 0.0 /\ 0.0 /\ 0.5 }
          [ X.joint { name: "j1", type: X.kw X.Hinge, axis: 1.0 /\ 0.0 /\ 0.0 }
          , X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit
          , X.site { name: "s1", pos: 0.0 /\ 0.0 /\ 0.1, size: 0.01 /\ 0.01 /\ 0.01 }
          ]
      , X.body { name: "b2", pos: 1.0 /\ 0.0 /\ 0.5 }
          [ X.joint { name: "j2", type: X.kw X.Hinge, axis: 1.0 /\ 0.0 /\ 0.0 }
          , X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit
          , X.site { name: "s2", pos: 0.0 /\ 0.0 /\ 0.1, size: 0.01 /\ 0.01 /\ 0.01 }
          ]
      ]
  , e
  ]

spec :: MjcfSpec Unit
spec =
  describe "equality" do
    describe "connect" do
      it "body1 + body2 + anchor" $ parseOk $ m $
        Eq.equality {} [ Eq.connect { body1: "b1", body2: "b2", anchor: 0.5 /\ 0.0 /\ 0.5 } unit ]

      it "site1 + site2" $ parseOk $ m $
        Eq.equality {} [ Eq.connect { site1: "s1", site2: "s2" } unit ]

      it "solref + solimp" $ parseOk $ m $
        Eq.equality {} [ Eq.connect { body1: "b1", body2: "b2", anchor: 0.5 /\ 0.0 /\ 0.5, solref: 0.02 /\ 1.0, solimp: 0.9 /\ 0.95 /\ 0.001 /\ 0.5 /\ 2.0 } unit ]

    describe "weld" do
      it "body1 + body2" $ parseOk $ m $
        Eq.equality {} [ Eq.weld { body1: "b1", body2: "b2" } ]

      it "site1 + site2" $ parseOk $ m $
        Eq.equality {} [ Eq.weld { site1: "s1", site2: "s2" } ]

      it "torquescale" $ parseOk $ m $
        Eq.equality {} [ Eq.weld { body1: "b1", body2: "b2", torquescale: 1.0 } ]

    describe "joint" do
      it "joint1 + joint2" $ parseOk $ m $
        Eq.equality {} [ Eq.joint { joint1: "j1", joint2: "j2" } ]

      it "polycoef" $ parseOk $ m $
        Eq.equality {} [ Eq.joint { joint1: "j1", joint2: "j2", polycoef: 0.0 /\ 1.0 /\ 0.0 /\ 0.0 /\ 0.0 } ]

    describe "tendon" do
      it "tendon1" $ parseOk $ X.mujoco {}
        [ X.compiler { inertiafromgeom: X.true_ }
        , X.worldbody {}
            [ X.body { name: "b1", pos: 0.0 /\ 0.0 /\ 0.5 }
                [ X.joint { name: "j1", type: X.kw X.Hinge, axis: 1.0 /\ 0.0 /\ 0.0 }
                , X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit
                ]
            ]
        , Tendon.tendon {} $ Tendon.fixed { name: "t1" } [ Tendon.joint { joint: "j1", coef: 1.0 } ]
        , Eq.equality {} [ Eq.tendon { tendon1: "t1" } ]
        ]
