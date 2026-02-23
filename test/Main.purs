module Test.Main where

import Prelude

import Effect (Effect)
import Test.Mujoco.MJCF.XML.Prop as Test.Mujoco.MJCF.XML.Prop
import Test.Mujoco.MJCF as Test.Mujoco.MJCF
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)

main :: Effect Unit
main =
  runSpecAndExitProcess [consoleReporter] do
    Test.Mujoco.MJCF.spec
    Test.Mujoco.MJCF.XML.Prop.spec
