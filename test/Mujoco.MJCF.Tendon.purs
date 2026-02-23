module Test.Mujoco.MJCF.Tendon where

import Prelude

import Data.Tuple.Nested ((/\))
import Mujoco.MJCF as X
import Mujoco.MJCF.Tendon as Tendon
import Mujoco.MJCF.XML (Node)
import Test.Mujoco.MJCF.Util (MjcfSpec, parseOk)
import Test.Spec (describe, it)

-- | Model with two bodies, two hinge joints, and two sites for tendon routing
m :: Node -> Node
m t = X.mujoco {}
  [ X.compiler { inertiafromgeom: X.true_ }
  , X.worldbody {}
      [ X.body { name: "b1", pos: 0.0 /\ 0.0 /\ 0.5 }
          [ X.joint { name: "j1", type: X.kw X.Hinge, axis: 1.0 /\ 0.0 /\ 0.0 }
          , X.geom { type: X.kw X.Capsule, size: [0.05, 0.2] } unit
          , X.site { name: "s1", pos: 0.0 /\ 0.0 /\ 0.2, size: 0.01 /\ 0.01 /\ 0.01 }
          , X.body { name: "b2", pos: 0.0 /\ 0.0 /\ 0.5 }
              [ X.joint { name: "j2", type: X.kw X.Hinge, axis: 1.0 /\ 0.0 /\ 0.0 }
              , X.geom { type: X.kw X.Capsule, size: [0.05, 0.2] } unit
              , X.site { name: "s2", pos: 0.0 /\ 0.0 /\ 0.2, size: 0.01 /\ 0.01 /\ 0.01 }
              ]
          ]
      ]
  , t
  ]

spec :: MjcfSpec Unit
spec =
  describe "tendon" do
    describe "spatial" do
      it "basic site routing" $ parseOk $ m $ Tendon.tendon {} $
        Tendon.spatial { name: "t_spatial" }
          [ Tendon.site { site: "s1" }
          , Tendon.site { site: "s2" }
          ]

      it "with pulley" $ parseOk $ m $ Tendon.tendon {} $
        Tendon.spatial { name: "t_pulley" }
          [ Tendon.site { site: "s1" }
          , Tendon.pulley { divisor: 2.0 }
          , Tendon.site { site: "s2" }
          ]

      it "limited + range + stiffness + damping" $ parseOk $ m $ Tendon.tendon {} $
        Tendon.spatial { name: "t_props", limited: X.true_, range: (-1.0) /\ 1.0, stiffness: 100.0, damping: 10.0 }
          [ Tendon.site { site: "s1" }
          , Tendon.site { site: "s2" }
          ]

    describe "fixed" do
      it "basic joint" $ parseOk $ m $ Tendon.tendon {} $
        Tendon.fixed { name: "t_fixed" }
          [ Tendon.joint { joint: "j1", coef: 1.0 }
          , Tendon.joint { joint: "j2", coef: -1.0 }
          ]

      it "stiffness + damping" $ parseOk $ m $ Tendon.tendon {} $
        Tendon.fixed { name: "t_fixed2", stiffness: 50.0, damping: 5.0 }
          [ Tendon.joint { joint: "j1", coef: 1.0 }
          ]
