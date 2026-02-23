module Mujoco.MJCF.Geom where

import Mujoco.Prelude
import Prim hiding (Type)

data FluidShape = FluidNone | FluidEllipsoid
instance Serialize FluidShape where
  serialize FluidNone = "none"
  serialize FluidEllipsoid = "ellipsoid"

data Type = Plane | Hfield | Sphere | Capsule | Ellipsoid | Cylinder | Box | Mesh | Sdf
instance Serialize Type where
  serialize Plane = "plane"
  serialize Hfield = "hfield"
  serialize Sphere = "sphere"
  serialize Capsule = "capsule"
  serialize Ellipsoid = "ellipsoid"
  serialize Cylinder = "cylinder"
  serialize Box = "box"
  serialize Mesh = "mesh"
  serialize Sdf = "sdf"

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
    , type :: Type
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
    , fluidshape :: FluidShape
    , fluidcoef :: Vec5 Real
    , user :: Array Real
    | Named
    + Contact
    + ContactSpacing
    + Solver
    + Pos
    + Oriented ()
    )
geom = tag @Props_geom "geom" :: Tag Props_geom
