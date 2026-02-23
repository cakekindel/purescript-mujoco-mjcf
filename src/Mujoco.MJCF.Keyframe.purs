module Mujoco.MJCF.Keyframe where

import Mujoco.MJCF.Prelude

keyframe = tag @() "keyframe" :: Tag ()

type Props_key =
  ( time :: Real
  , qpos :: Array Real
  , qvel :: Array Real
  , act :: Array Real
  , ctrl :: Array Real
  , mpos :: Array Real
  , mquat :: Array Real
  | Named ()
  )
key = tagNoContent @Props_key "key" :: TagNoContent Props_key
