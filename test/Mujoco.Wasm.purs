module Mujoco.Wasm where

import Control.Promise (Promise)
import Control.Promise as Promise
import Effect (Effect)
import Effect.Aff (Aff)

foreign import data Mujoco :: Type
foreign import data Spec :: Type

foreign import loadMujoco_ :: Effect (Promise Mujoco)
foreign import parseXMLString :: Mujoco -> String -> Effect Spec

loadMujoco :: Aff Mujoco
loadMujoco = Promise.toAffE loadMujoco_
