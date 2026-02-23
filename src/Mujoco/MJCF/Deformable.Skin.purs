module Mujoco.MJCF.Deformable.Skin where

import Mujoco.MJCF.Prelude

type Props_skin =
  ( name :: String
  , file :: String
  , vertex :: Array Real
  , texcoord :: Array Real
  , face :: Array Int
  , inflate :: Real
  , material :: String
  , rgba :: Vec4 Real
  , group :: Int
  )
skin = tag @Props_skin "skin" :: Tag Props_skin

type Props_bone =
  ( body :: String
  , bindpos :: Vec Real
  , bindquat :: Vec4 Real
  , vertid :: Array Int
  , vertweight :: Array Real
  )
bone = tagNoContent @Props_bone "bone" :: TagNoContent Props_bone
