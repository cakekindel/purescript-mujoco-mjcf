module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Mujoco.Wasm as Wasm
import Test.Mujoco.MJCF as Test.Mujoco.MJCF
import Test.Mujoco.MJCF.Actuator as Test.Mujoco.MJCF.Actuator
import Test.Mujoco.MJCF.Contact as Test.Mujoco.MJCF.Contact
import Test.Mujoco.MJCF.Custom as Test.Mujoco.MJCF.Custom
import Test.Mujoco.MJCF.Default as Test.Mujoco.MJCF.Default
import Test.Mujoco.MJCF.Deformable as Test.Mujoco.MJCF.Deformable
import Test.Mujoco.MJCF.Equality as Test.Mujoco.MJCF.Equality
import Test.Mujoco.MJCF.Keyframe as Test.Mujoco.MJCF.Keyframe
import Test.Mujoco.MJCF.Sensor as Test.Mujoco.MJCF.Sensor
import Test.Mujoco.MJCF.Tendon as Test.Mujoco.MJCF.Tendon
import Test.Mujoco.MJCF.Util (mjcf)
import Test.Mujoco.MJCF.Visual as Test.Mujoco.MJCF.Visual
import Test.Mujoco.MJCF.XML.Prop as Test.Mujoco.MJCF.XML.Prop
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)

main :: Effect Unit
main =
  launchAff_ do
    mj <- Wasm.loadMujoco
    liftEffect
      $ runSpecAndExitProcess [consoleReporter]
      $ mjcf mj do
          Test.Mujoco.MJCF.spec
          Test.Mujoco.MJCF.XML.Prop.spec
          Test.Mujoco.MJCF.Actuator.spec
          Test.Mujoco.MJCF.Contact.spec
          Test.Mujoco.MJCF.Custom.spec
          Test.Mujoco.MJCF.Deformable.spec
          Test.Mujoco.MJCF.Default.spec
          Test.Mujoco.MJCF.Equality.spec
          Test.Mujoco.MJCF.Keyframe.spec
          Test.Mujoco.MJCF.Sensor.spec
          Test.Mujoco.MJCF.Tendon.spec
          Test.Mujoco.MJCF.Visual.spec
