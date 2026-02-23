module Mujoco.MJCF.Common
  ( Named
  , Oriented
  , Pos
  , Real
  , Vec
  , Vec4
  , Vec5
  )
  where

import Data.Tuple.Nested (type (/\))

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

type Real = Number
type Vec a = a /\ a /\ a
type Vec4 a = a /\ a /\ a /\ a
type Vec5 a = a /\ a /\ a /\ a /\ a
