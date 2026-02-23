module Mujoco.MJCF.Geom where

import Mujoco.MJCF.Prelude
import Mujoco.MJCF.Keyword as Kw

type Contact r =
  ( contype :: Int
  , conaffinity :: Int
  , condim :: Int
  , priority :: Int
  | r
  )

type ContactSpacing r =
  ( margin :: Real
  , gap :: Real
  | r
  )

type Solver r =
  ( solmix :: Real
  , solref :: Real /\ Real
  , solimp :: Vec5 Real
  | r
  )

type Props_geom =
    ( class :: String
    , type :: Kw.Plane \/ Kw.Hfield \/ Kw.Sphere \/ Kw.Capsule \/ Kw.Ellipsoid \/ Kw.Cylinder \/ Kw.Box \/ Kw.Mesh \/ Kw.Sdf
    , group :: Int
    , size :: Array Real
    , material :: String
    , rgba :: Vec4 Real
    , friction :: Vec Real
    , mass :: Real
    , density :: Real
    , shellinertia :: Boolean
    , fromto :: Array Real
    , hfield :: String
    , mesh :: String
    , fitscale :: Real
    , fluidshape :: Kw.None \/ Kw.Ellipsoid
    , fluidcoef :: Vec5 Real
    , user :: Array Real
    | Named
    + Contact
    + ContactSpacing
    + Solver
    + Positioned
    + Oriented ()
    )
geom = tag @Props_geom "geom" :: Tag Props_geom
