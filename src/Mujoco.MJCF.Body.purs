module Mujoco.MJCF.Body
  ( CameraMode
  , CameraOutput
  , JointType
  , LightType
  , Projection
  , Props_attach
  , Props_body
  , Props_camera
  , Props_frame
  , Props_freejoint
  , Props_inertial
  , Props_joint
  , Props_light
  , Props_site
  , SiteType
  , SleepPolicy
  , attach
  , body
  , camera
  , frame
  , freejoint
  , inertial
  , joint
  , light
  , site
  , worldbody
  , module X
  )
  where

import Mujoco.Prelude

import Mujoco.MJCF.Geom (Props_geom, geom) as X
import Mujoco.MJCF.Keyword as Kw

type SleepPolicy = Kw.Auto \/ Kw.Never \/ Kw.Allowed \/ Kw.Init

type Props_body =
  ( name :: String
  , childclass :: String
  , mocap :: Boolean
  , pos :: Vec Real
  , quat :: Vec4 Real
  , axisangle :: Vec4 Real
  , xyaxes :: Array Real
  , zaxis :: Vec Real
  , euler :: Vec Real
  , gravcomp :: Real
  , sleep :: SleepPolicy
  , user :: Array Real
  )
body = tag @Props_body "body" :: Tag Props_body
worldbody = tag @Props_body "worldbody" :: Tag Props_body

type Props_inertial =
  ( pos :: Vec Real
  , quat :: Vec4 Real
  , axisangle :: Vec4 Real
  , xyaxes :: Array Real
  , zaxis :: Vec Real
  , euler :: Vec Real
  , mass :: Real
  , diaginertia :: Vec Real
  , fullinertia :: Array Real
  )
inertial = tagNoContent @Props_inertial "inertial" :: TagNoContent Props_inertial

type JointType = Kw.Free \/ Kw.Ball \/ Kw.Slide \/ Kw.Hinge

type Props_joint =
  ( name :: String
  , class :: String
  , type :: JointType
  , group :: Int
  , pos :: Vec Real
  , axis :: Vec Real
  , springdamper :: Real /\ Real
  , solreflimit :: Real /\ Real
  , solimplimit :: Vec5 Real
  , solreffriction :: Real /\ Real
  , solimpfriction :: Vec5 Real
  , stiffness :: Real
  , range :: Real /\ Real
  , limited :: Kw.Auto \/ Boolean
  , actuatorfrcrange :: Real /\ Real
  , actuatorfrclimited :: Kw.Auto \/ Boolean
  , actuatorgravcomp :: Boolean
  , margin :: Real
  , ref :: Real
  , springref :: Real
  , armature :: Real
  , damping :: Real
  , frictionloss :: Real
  , user :: Array Real
  )
joint = tagNoContent @Props_joint "joint" :: TagNoContent Props_joint

type Props_freejoint =
  ( name :: String
  , group :: Int
  , align :: Kw.Auto \/ Boolean
  )
freejoint = tagNoContent @Props_freejoint "freejoint" :: TagNoContent Props_freejoint

type SiteType = Kw.Sphere \/ Kw.Capsule \/ Kw.Ellipsoid \/ Kw.Cylinder \/ Kw.Box

type Props_site =
  ( name :: String
  , class :: String
  , type :: SiteType
  , group :: Int
  , material :: String
  , rgba :: Vec4 Real
  , size :: Vec Real
  , fromto :: Array Real
  , pos :: Vec Real
  , quat :: Vec4 Real
  , axisangle :: Vec4 Real
  , xyaxes :: Array Real
  , zaxis :: Vec Real
  , euler :: Vec Real
  , user :: Array Real
  )
site = tagNoContent @Props_site "site" :: TagNoContent Props_site

type CameraMode = Kw.Fixed \/ Kw.Track \/ Kw.Trackcom \/ Kw.Targetbody \/ Kw.Targetbodycom
type Projection = Kw.Perspective \/ Kw.Orthographic
type CameraOutput = Kw.Rgb \/ Kw.Depth \/ Kw.Distance \/ Kw.Normal \/ Kw.Segmentation

type Props_camera =
  ( name :: String
  , class :: String
  , mode :: CameraMode
  , target :: String
  , projection :: Projection
  , fovy :: Real
  , resolution :: Int /\ Int
  , output :: CameraOutput
  , sensorsize :: Real /\ Real
  , focal :: Real /\ Real
  , focalpixel :: Real /\ Real
  , principal :: Real /\ Real
  , principalpixel :: Real /\ Real
  , ipd :: Real
  , pos :: Vec Real
  , quat :: Vec4 Real
  , axisangle :: Vec4 Real
  , xyaxes :: Array Real
  , zaxis :: Vec Real
  , euler :: Vec Real
  , user :: Array Real
  )
camera = tagNoContent @Props_camera "camera" :: TagNoContent Props_camera

type LightType = Kw.Spot \/ Kw.Directional \/ Kw.Point \/ Kw.Image

type Props_light =
  ( name :: String
  , class :: String
  , mode :: CameraMode
  , target :: String
  , type :: LightType
  , directional :: Boolean
  , castshadow :: Boolean
  , active :: Boolean
  , pos :: Vec Real
  , dir :: Vec Real
  , diffuse :: Vec Real
  , texture :: String
  , intensity :: Real
  , ambient :: Vec Real
  , specular :: Vec Real
  , range :: Real
  , bulbradius :: Real
  , attenuation :: Vec Real
  , cutoff :: Real
  , exponent :: Real
  )
light = tagNoContent @Props_light "light" :: TagNoContent Props_light

-- TODO: body/composite reuses row types of joint, geom, site, skin, plugin

type Props_attach =
  ( model :: String
  , body :: String
  , prefix :: String
  )
attach = tagNoContent @Props_attach "attach" :: TagNoContent Props_attach

type Props_frame =
  ( name :: String
  , childclass :: String
  , pos :: Vec Real
  , quat :: Vec4 Real
  , axisangle :: Vec4 Real
  , xyaxes :: Array Real
  , zaxis :: Vec Real
  , euler :: Vec Real
  )
frame = tagNoContent @Props_frame "frame" :: TagNoContent Props_frame
