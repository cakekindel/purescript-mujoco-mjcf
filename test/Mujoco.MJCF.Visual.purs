module Test.Mujoco.MJCF.Visual where

import Prelude

import Data.Tuple.Nested ((/\))
import Mujoco.MJCF as X
import Mujoco.MJCF.Visual as Vis
import Mujoco.MJCF.XML (Node)
import Test.Mujoco.MJCF.Util (MjcfSpec, parseOk)
import Test.Spec (describe, it)

v :: Node -> Node
v c = X.mujoco {}
  [ Vis.visual {} [ c ]
  , X.worldbody {} unit
  ]

spec :: MjcfSpec Unit
spec =
  describe "visual" do
    describe "global" do
      it "fovy + linewidth" $ parseOk $ v $
        Vis.global { fovy: 45.0, linewidth: 2.0 }

      it "offwidth + offheight" $ parseOk $ v $
        Vis.global { offwidth: 1920, offheight: 1080 }

      it "orthographic + ellipsoidinertia" $ parseOk $ v $
        Vis.global { orthographic: true, ellipsoidinertia: true }

    describe "quality" do
      it "shadowsize + offsamples" $ parseOk $ v $
        Vis.quality { shadowsize: 4096, offsamples: 8 }

      it "numslices + numstacks + numquads" $ parseOk $ v $
        Vis.quality { numslices: 32, numstacks: 32, numquads: 4 }

    describe "headlight" do
      it "ambient + diffuse + specular" $ parseOk $ v $
        Vis.headlight { ambient: 0.3 /\ 0.3 /\ 0.3, diffuse: 0.6 /\ 0.6 /\ 0.6, specular: 0.2 /\ 0.2 /\ 0.2 }

      it "active" $ parseOk $ v $
        Vis.headlight { active: 0 }

    describe "map" do
      it "stiffness + force + torque" $ parseOk $ v $
        Vis.map { stiffness: 100.0, force: 0.05, torque: 0.1 }

      it "fogstart + fogend" $ parseOk $ v $
        Vis.map { fogstart: 2.0, fogend: 10.0 }

      it "znear + zfar" $ parseOk $ v $
        Vis.map { znear: 0.01, zfar: 50.0 }

      it "shadowclip + shadowscale" $ parseOk $ v $
        Vis.map { shadowclip: 0.5, shadowscale: 0.5 }

    describe "scale" do
      it "forcewidth + contactwidth + contactheight" $ parseOk $ v $
        Vis.scale { forcewidth: 0.1, contactwidth: 0.3, contactheight: 0.1 }

      it "jointlength + jointwidth" $ parseOk $ v $
        Vis.scale { jointlength: 0.5, jointwidth: 0.1 }

      it "framelength + framewidth" $ parseOk $ v $
        Vis.scale { framelength: 1.0, framewidth: 0.05 }

      it "actuatorlength + actuatorwidth" $ parseOk $ v $
        Vis.scale { actuatorlength: 0.7, actuatorwidth: 0.1 }

    describe "rgba" do
      it "fog + haze" $ parseOk $ v $
        Vis.rgba { fog: 0.0 /\ 0.0 /\ 0.0 /\ 1.0, haze: 1.0 /\ 1.0 /\ 1.0 /\ 1.0 }

      it "force + inertia + joint" $ parseOk $ v $
        Vis.rgba { force: 1.0 /\ 0.5 /\ 0.5 /\ 1.0, inertia: 0.8 /\ 0.2 /\ 0.2 /\ 0.6, joint: 0.2 /\ 0.6 /\ 0.8 /\ 1.0 }

      it "com + camera + light" $ parseOk $ v $
        Vis.rgba { com: 0.0 /\ 1.0 /\ 0.0 /\ 1.0, camera: 0.6 /\ 0.9 /\ 0.6 /\ 1.0, light: 0.9 /\ 0.9 /\ 0.3 /\ 1.0 }

      it "contact colors" $ parseOk $ v $
        Vis.rgba { contactpoint: 0.9 /\ 0.2 /\ 0.2 /\ 1.0, contactforce: 0.2 /\ 0.9 /\ 0.2 /\ 1.0, contactfriction: 0.2 /\ 0.2 /\ 0.9 /\ 1.0, contacttorque: 0.9 /\ 0.9 /\ 0.2 /\ 1.0 }
