module Mujoco.Wasm where

import Prelude

import Control.Promise (Promise)
import Control.Promise as Promise
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Mujoco.MJCF.XML as XML

foreign import data Mujoco :: Type
foreign import data Spec :: Type

foreign import loadMujoco :: Effect (Promise Mujoco)
foreign import parseXMLString :: Mujoco -> String -> Effect Spec

renderSpec :: XML.Node -> Aff Spec
renderSpec node = do
  mj <- Promise.toAffE loadMujoco
  liftEffect $ parseXMLString mj $ XML.render node
