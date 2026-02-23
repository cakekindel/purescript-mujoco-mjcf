module Mujoco.Wasm where

import Control.Promise (Promise)
import Effect (Effect)

foreign import data Mujoco :: Type
foreign import data Spec :: Type

foreign import loadMujoco :: Effect (Promise Mujoco)
foreign import parseXMLString :: Mujoco -> String -> Effect Spec
