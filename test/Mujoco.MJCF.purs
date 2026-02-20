module Test.Mujoco.MJCF where

import Prelude

import Control.Monad.Error.Class (try)
import Data.Either (isLeft)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Mujoco.MJCF as X
import Mujoco.Wasm (renderSpec)
import Mujoco.XML.Node (Node)
import Test.Assert (assertTrue)
import Test.Spec (Spec, describe, it)

ok :: Node -> Aff Unit
ok = void <<< renderSpec

fail :: Node -> Aff Unit
fail = (liftEffect <<< assertTrue <<< isLeft) <=< (try <<< renderSpec)

spec :: Spec Unit
spec =
  describe "MJCF" do
    it "</>" $ fail $ X.empty
    it "<mujoco>" $ ok $ X.mujoco {} unit
    it "<worldbody>" $ ok $ X.mujoco {} $ X.worldbody {} unit
