module Test.Mujoco.MJCF.Keyframe where

import Prelude

import Data.Tuple.Nested ((/\))
import Mujoco.MJCF as X
import Test.Mujoco.MJCF.Util (MjcfSpec, parseOk)
import Test.Spec (describe, it)

spec :: MjcfSpec Unit
spec =
  describe "keyframe" do
    it "empty" $ parseOk $ X.mujoco {}
      [ X.worldbody {} unit
      , X.keyframe {} unit
      ]

    it "key with time" $ parseOk $ X.mujoco {}
      [ X.worldbody {} unit
      , X.keyframe {}
          [ X.key { name: "home", time: 0.0 } ]
      ]

    it "key with qpos + qvel" $ parseOk $ X.mujoco {}
      [ X.compiler { inertiafromgeom: X.true_ }
      , X.worldbody {}
          [ X.body { pos: 0.0 /\ 0.0 /\ 0.5 }
              [ X.joint { name: "j1", type: X.kw X.Hinge, axis: 1.0 /\ 0.0 /\ 0.0 }
              , X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit
              ]
          ]
      , X.keyframe {}
          [ X.key { name: "init", time: 0.0, qpos: [0.5], qvel: [0.0] } ]
      ]

    it "key with ctrl" $ parseOk $ X.mujoco {}
      [ X.compiler { inertiafromgeom: X.true_ }
      , X.worldbody {}
          [ X.body { pos: 0.0 /\ 0.0 /\ 0.5 }
              [ X.joint { name: "j1", type: X.kw X.Hinge, axis: 1.0 /\ 0.0 /\ 0.0 }
              , X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit
              ]
          ]
      , X.keyframe {}
          [ X.key { name: "start", ctrl: [0.0] } ]
      ]

    it "multiple keys" $ parseOk $ X.mujoco {}
      [ X.worldbody {} unit
      , X.keyframe {}
          [ X.key { name: "k1", time: 0.0 }
          , X.key { name: "k2", time: 1.0 }
          ]
      ]
