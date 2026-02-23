module Test.Mujoco.MJCF.Sensor where

import Prelude

import Data.Tuple.Nested ((/\))
import Mujoco.MJCF as X
import Mujoco.MJCF.Actuator as Act
import Mujoco.MJCF.Sensor as Sens
import Mujoco.MJCF.XML (Node)
import Test.Mujoco.MJCF.Util (MjcfSpec, parseOk)
import Test.Spec (describe, it)

-- | Model with body, site, joint, tendon, and actuator for sensor tests
m :: Node -> Node
m s = X.mujoco {}
  [ X.compiler { inertiafromgeom: X.true_ }
  , X.worldbody {}
      [ X.body { name: "b1", pos: 0.0 /\ 0.0 /\ 0.5 }
          [ X.joint { name: "j1", type: X.kw X.Hinge, axis: 1.0 /\ 0.0 /\ 0.0 }
          , X.geom { name: "g1", type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ] } unit
          , X.site { name: "s1", pos: 0.0 /\ 0.0 /\ 0.1, size: 0.01 /\ 0.01 /\ 0.01 }
          , X.camera { name: "cam1", pos: 0.0 /\ (-1.0) /\ 0.5, fovy: 60.0 }
          ]
      , X.body { name: "b2", pos: 1.0 /\ 0.0 /\ 0.5 }
          [ X.joint { name: "j2", type: X.kw X.Hinge, axis: 1.0 /\ 0.0 /\ 0.0 }
          , X.geom { name: "g2", type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ] } unit
          , X.site { name: "s2", pos: 0.0 /\ 0.0 /\ 0.1, size: 0.01 /\ 0.01 /\ 0.01 }
          ]
      ]
  , Act.actuator {} [ Act.motor { name: "a1", joint: "j1" } ]
  , s
  ]

spec :: MjcfSpec Unit
spec =
  describe "sensor" do
    describe "site-based" do
      it "touch" $ parseOk $ m $
        X.sensor {} [ Sens.touch { name: "se_touch", site: "s1" } ]

      it "accelerometer" $ parseOk $ m $
        X.sensor {} [ Sens.accelerometer { name: "se_accel", site: "s1" } ]

      it "velocimeter" $ parseOk $ m $
        X.sensor {} [ Sens.velocimeter { name: "se_velo", site: "s1" } ]

      it "gyro" $ parseOk $ m $
        X.sensor {} [ Sens.gyro { name: "se_gyro", site: "s1" } ]

      it "force" $ parseOk $ m $
        X.sensor {} [ Sens.force { name: "se_force", site: "s1" } ]

      it "torque" $ parseOk $ m $
        X.sensor {} [ Sens.torque { name: "se_torque", site: "s1" } ]

      it "magnetometer" $ parseOk $ m $
        X.sensor {} [ Sens.magnetometer { name: "se_mag", site: "s1" } ]

      it "rangefinder" $ parseOk $ m $
        X.sensor {} [ Sens.rangefinder { name: "se_range", site: "s1" } ]

      it "camprojection" $ parseOk $ m $
        X.sensor {} [ Sens.camprojection { name: "se_camp", site: "s1", camera: "cam1" } ]

    describe "joint-based" do
      it "jointpos" $ parseOk $ m $
        X.sensor {} [ Sens.jointpos { name: "se_jpos", joint: "j1" } ]

      it "jointvel" $ parseOk $ m $
        X.sensor {} [ Sens.jointvel { name: "se_jvel", joint: "j1" } ]

      it "jointactuatorfrc" $ parseOk $ m $
        X.sensor {} [ Sens.jointactuatorfrc { name: "se_jafrc", joint: "j1" } ]

      it "jointlimitpos" $ parseOk $ m $
        X.sensor {} [ Sens.jointlimitpos { name: "se_jlpos", joint: "j1" } ]

      it "jointlimitvel" $ parseOk $ m $
        X.sensor {} [ Sens.jointlimitvel { name: "se_jlvel", joint: "j1" } ]

      it "jointlimitfrc" $ parseOk $ m $
        X.sensor {} [ Sens.jointlimitfrc { name: "se_jlfrc", joint: "j1" } ]

    describe "actuator-based" do
      it "actuatorpos" $ parseOk $ m $
        X.sensor {} [ Sens.actuatorpos { name: "se_apos", actuator: "a1" } ]

      it "actuatorvel" $ parseOk $ m $
        X.sensor {} [ Sens.actuatorvel { name: "se_avel", actuator: "a1" } ]

      it "actuatorfrc" $ parseOk $ m $
        X.sensor {} [ Sens.actuatorfrc { name: "se_afrc", actuator: "a1" } ]

    describe "frame-based" do
      it "framepos" $ parseOk $ m $
        X.sensor {} [ Sens.framepos { name: "se_fpos", objtype: X.kw X.Body, objname: "b1" } ]

      it "framequat" $ parseOk $ m $
        X.sensor {} [ Sens.framequat { name: "se_fquat", objtype: X.kw X.Body, objname: "b1" } ]

      it "framexaxis" $ parseOk $ m $
        X.sensor {} [ Sens.framexaxis { name: "se_fxax", objtype: X.kw X.Body, objname: "b1" } ]

      it "frameyaxis" $ parseOk $ m $
        X.sensor {} [ Sens.frameyaxis { name: "se_fyax", objtype: X.kw X.Body, objname: "b1" } ]

      it "framezaxis" $ parseOk $ m $
        X.sensor {} [ Sens.framezaxis { name: "se_fzax", objtype: X.kw X.Body, objname: "b1" } ]

      it "framelinvel" $ parseOk $ m $
        X.sensor {} [ Sens.framelinvel { name: "se_flv", objtype: X.kw X.Body, objname: "b1" } ]

      it "frameangvel" $ parseOk $ m $
        X.sensor {} [ Sens.frameangvel { name: "se_fav", objtype: X.kw X.Body, objname: "b1" } ]

      it "framelinvel with ref" $ parseOk $ m $
        X.sensor {} [ Sens.framelinvel { name: "se_flvr", objtype: X.kw X.Body, objname: "b1", reftype: X.kw X.Body, refname: "b2" } ]

      it "framelinacc" $ parseOk $ m $
        X.sensor {} [ Sens.framelinacc { name: "se_fla", objtype: X.kw X.Body, objname: "b1" } ]

      it "frameangacc" $ parseOk $ m $
        X.sensor {} [ Sens.frameangacc { name: "se_faa", objtype: X.kw X.Body, objname: "b1" } ]

    describe "subtree" do
      it "subtreecom" $ parseOk $ m $
        X.sensor {} [ Sens.subtreecom { name: "se_stcom", body: "b1" } ]

      it "subtreelinvel" $ parseOk $ m $
        X.sensor {} [ Sens.subtreelinvel { name: "se_stlv", body: "b1" } ]

      it "subtreeangmom" $ parseOk $ m $
        X.sensor {} [ Sens.subtreeangmom { name: "se_stam", body: "b1" } ]

    describe "collision" do
      it "distance" $ parseOk $ m $
        X.sensor {} [ Sens.distance { name: "se_dist", geom1: "g1", geom2: "g2" } ]

      it "normal" $ parseOk $ m $
        X.sensor {} [ Sens.normal { name: "se_norm", geom1: "g1", geom2: "g2" } ]

      it "fromto" $ parseOk $ m $
        X.sensor {} [ Sens.fromto { name: "se_ft", geom1: "g1", geom2: "g2" } ]

      it "contact" $ parseOk $ m $
        X.sensor {} [ Sens.contact { name: "se_cont", body1: "b1", body2: "b2" } ]

    describe "other" do
      it "insidesite" $ parseOk $ m $
        X.sensor {} [ Sens.insidesite { name: "se_inside", objtype: X.kw X.Geom, objname: "g1", site: "s1" } ]

      it "e_potential" $ parseOk $ m $
        X.sensor {} [ Sens.e_potential { name: "se_ep" } ]

      it "e_kinetic" $ parseOk $ m $
        X.sensor {} [ Sens.e_kinetic { name: "se_ek" } ]

      it "clock" $ parseOk $ m $
        X.sensor {} [ Sens.clock { name: "se_clock" } ]

      it "user" $ parseOk $ m $
        X.sensor {} [ Sens.user { name: "se_user", objtype: "body", objname: "b1", datatype: X.kw X.Real, needstage: X.kw X.Vel, dim: 1 } ]

    describe "common props" do
      it "noise + cutoff" $ parseOk $ m $
        X.sensor {} [ Sens.touch { name: "se_noisy", site: "s1", noise: 0.01, cutoff: 100.0 } ]
