module Test.Mujoco.MJCF.Actuator where

import Prelude

import Data.Tuple.Nested ((/\))
import Mujoco.MJCF as X
import Mujoco.MJCF.Actuator as Act
import Mujoco.MJCF.XML (Node)
import Test.Mujoco.MJCF.Util (MjcfSpec, parseOk)
import Test.Spec (describe, it)

-- | Model with a body + hinge joint for actuator tests
m :: Node -> Node
m a = X.mujoco {}
  [ X.compiler { inertiafromgeom: X.true_ }
  , X.worldbody {}
      [ X.body { name: "b1", pos: 0.0 /\ 0.0 /\ 0.5 }
          [ X.joint { name: "j1", type: X.kw X.Hinge, axis: 1.0 /\ 0.0 /\ 0.0 }
          , X.geom { type: X.kw X.Sphere, size: [0.1, 0.0, 0.0] } unit
          ]
      ]
  , a
  ]

spec :: MjcfSpec Unit
spec =
  describe "actuator" do
    describe "general" do
      it "basic" $ parseOk $ m $
        Act.actuator {} [ Act.general { name: "a_gen", joint: "j1" } ]

      it "dyntype + gaintype + biastype" $ parseOk $ m $
        Act.actuator {}
          [ Act.general { name: "a_gen2", joint: "j1", dyntype: X.kw X.Filter, gaintype: X.kw X.Fixed, biastype: X.kw X.Affine } ]

      it "ctrlrange + forcerange" $ parseOk $ m $
        Act.actuator {}
          [ Act.general { name: "a_gen3", joint: "j1", ctrllimited: X.true_, ctrlrange: (-1.0) /\ 1.0, forcelimited: X.true_, forcerange: (-100.0) /\ 100.0 } ]

    describe "motor" do
      it "basic" $ parseOk $ m $
        Act.actuator {} [ Act.motor { name: "a_motor", joint: "j1" } ]

      it "ctrlrange + gear" $ parseOk $ m $
        Act.actuator {}
          [ Act.motor { name: "a_motor2", joint: "j1", ctrllimited: X.true_, ctrlrange: (-1.0) /\ 1.0, gear: [100.0, 0.0, 0.0, 0.0, 0.0, 0.0] } ]

    describe "position" do
      it "basic" $ parseOk $ m $
        Act.actuator {} [ Act.position { name: "a_pos", joint: "j1" } ]

      it "kp + kv" $ parseOk $ m $
        Act.actuator {}
          [ Act.position { name: "a_pos2", joint: "j1", kp: 100.0, kv: 10.0 } ]

    describe "velocity" do
      it "basic" $ parseOk $ m $
        Act.actuator {} [ Act.velocity { name: "a_vel", joint: "j1" } ]

      it "kv" $ parseOk $ m $
        Act.actuator {}
          [ Act.velocity { name: "a_vel2", joint: "j1", kv: 10.0 } ]

    describe "intvelocity" do
      it "basic" $ parseOk $ m $
        Act.actuator {} [ Act.intvelocity { name: "a_iv", joint: "j1" } ]

      it "kp + actrange" $ parseOk $ m $
        Act.actuator {}
          [ Act.intvelocity { name: "a_iv2", joint: "j1", kp: 100.0, actrange: (-1.0) /\ 1.0 } ]

    describe "damper" do
      it "basic" $ parseOk $ m $
        Act.actuator {} [ Act.damper { name: "a_damp", joint: "j1" } ]

      it "kv" $ parseOk $ m $
        Act.actuator {}
          [ Act.damper { name: "a_damp2", joint: "j1", kv: 10.0 } ]

    describe "cylinder" do
      it "basic" $ parseOk $ m $
        Act.actuator {} [ Act.cylinder { name: "a_cyl", joint: "j1" } ]

      it "timeconst + area" $ parseOk $ m $
        Act.actuator {}
          [ Act.cylinder { name: "a_cyl2", joint: "j1", timeconst: 0.1, area: 0.01 } ]

    describe "muscle" do
      it "basic" $ parseOk $ m $
        Act.actuator {} [ Act.muscle { name: "a_musc", joint: "j1" } ]

      it "force + range + timeconst" $ parseOk $ m $
        Act.actuator {}
          [ Act.muscle { name: "a_musc2", joint: "j1", force: 100.0, range: 0.75 /\ 1.05, timeconst: 0.01 /\ 0.04 } ]

    describe "adhesion" do
      it "basic" $ parseOk $ m $
        Act.actuator {} [ Act.adhesion { name: "a_adh", body: "b1" } ]

      it "gain" $ parseOk $ m $
        Act.actuator {}
          [ Act.adhesion { name: "a_adh2", body: "b1", gain: 1.0 } ]
