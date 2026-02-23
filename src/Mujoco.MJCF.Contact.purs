module Mujoco.MJCF.Contact where

import Mujoco.Prelude

contact = tag @() "contact" :: Tag ()

type Props_pair =
  ( name :: String
  , class :: String
  , geom1 :: String
  , geom2 :: String
  , condim :: Int
  , friction :: Vec5 Real
  , solref :: Real /\ Real
  , solimp :: Vec5 Real
  , solreffriction :: Real /\ Real
  , margin :: Real
  , gap :: Real
  )
pair = tagNoContent @Props_pair "pair" :: TagNoContent Props_pair

type Props_exclude =
  ( name :: String
  , body1 :: String
  , body2 :: String
  )
exclude = tagNoContent @Props_exclude "exclude" :: TagNoContent Props_exclude
