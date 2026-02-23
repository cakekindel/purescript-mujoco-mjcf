module Mujoco.MJCF.Common where

import Data.Tuple.Nested (type (/\))
import Mujoco.XML.Node.Prop (class Serialize)

type Named r = (name :: String | r)
type Pos r = (pos :: Vec Real | r)
type Oriented r =
  ( quat :: Vec4 Real
  , axisangle :: Vec4 Real
  , xyaxes :: Array Real
  , zaxis :: Vec Real
  , euler :: Vec Real
  | r
  )

data Auto = Auto
instance Serialize Auto where
  serialize Auto = "auto"

type Real = Number
type Vec a = a /\ a /\ a
type Vec4 a = a /\ a /\ a /\ a
type Vec5 a = a /\ a /\ a /\ a /\ a
