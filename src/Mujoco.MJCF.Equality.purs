module Mujoco.MJCF.Equality where

import Mujoco.Prelude

type Common r =
  ( class :: String
  , active :: Boolean
  , solref :: Real /\ Real
  , solimp :: Vec5 Real
  | Named r
  )

equality = tag @() "equality" :: Tag ()

type Props_connect =
  ( body1 :: String
  , body2 :: String
  , anchor :: Vec Real
  , site1 :: String
  , site2 :: String
  | Common ()
  )
connect = tag @Props_connect "connect" :: Tag Props_connect

type Props_weld =
  ( body1 :: String
  , body2 :: String
  , relpose :: Array Real
  , anchor :: Vec Real
  , site1 :: String
  , site2 :: String
  , torquescale :: Real
  | Common ()
  )
weld = tagNoContent @Props_weld "weld" :: TagNoContent Props_weld

type Props_joint =
  ( joint1 :: String
  , joint2 :: String
  , polycoef :: Vec5 Real
  | Common ()
  )
joint = tagNoContent @Props_joint "joint" :: TagNoContent Props_joint

type Props_tendon =
  ( tendon1 :: String
  , tendon2 :: String
  , polycoef :: Vec5 Real
  | Common ()
  )
tendon = tagNoContent @Props_tendon "tendon" :: TagNoContent Props_tendon

type Props_flex =
  ( flex :: String
  | Common ()
  )
flex = tagNoContent @Props_flex "flex" :: TagNoContent Props_flex

type Props_flexvert =
  ( flex :: String
  | Common ()
  )
flexvert = tagNoContent @Props_flexvert "flexvert" :: TagNoContent Props_flexvert
