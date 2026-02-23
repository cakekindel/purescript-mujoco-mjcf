module Mujoco.MJCF.Custom where

import Mujoco.MJCF.Prelude

custom = tag @() "custom" :: Tag ()

type Props_numeric =
  ( name :: String
  , size :: Int
  , data :: Array Real
  )

numeric = tagNoContent @Props_numeric "numeric" :: TagNoContent Props_numeric

type Props_text =
  ( name :: String
  , data :: String
  )

text = tagNoContent @Props_text "text" :: TagNoContent Props_text

type Props_tuple = (name :: String)
tuple = tag @Props_tuple "tuple" :: Tag Props_tuple

type Props_element =
  ( objtype :: String
  , objname :: String
  , prm :: Real
  )

element = tagNoContent @Props_element "element" :: TagNoContent Props_element
