module Mujoco.MJCF.Visual where

import Mujoco.MJCF.Prelude

visual = tag @() "visual" :: Tag ()

type Props_global =
  ( cameraid :: Int
  , orthographic :: Boolean
  , fovy :: Real
  , ipd :: Real
  , azimuth :: Real
  , elevation :: Real
  , linewidth :: Real
  , glow :: Real
  , realtime :: Real
  , offwidth :: Int
  , offheight :: Int
  , ellipsoidinertia :: Boolean
  , bvactive :: Boolean
  )
global = tagNoContent @Props_global "global" :: TagNoContent Props_global

type Props_quality =
  ( shadowsize :: Int
  , offsamples :: Int
  , numslices :: Int
  , numstacks :: Int
  , numquads :: Int
  )
quality = tagNoContent @Props_quality "quality" :: TagNoContent Props_quality

type Props_headlight =
  ( ambient :: Vec Real
  , diffuse :: Vec Real
  , specular :: Vec Real
  , active :: Int
  )
headlight = tagNoContent @Props_headlight "headlight" :: TagNoContent Props_headlight

type Props_map =
  ( stiffness :: Real
  , stiffnessrot :: Real
  , force :: Real
  , torque :: Real
  , alpha :: Real
  , fogstart :: Real
  , fogend :: Real
  , znear :: Real
  , zfar :: Real
  , haze :: Real
  , shadowclip :: Real
  , shadowscale :: Real
  , actuatortendon :: Real
  )
map = tagNoContent @Props_map "map" :: TagNoContent Props_map

type Props_scale =
  ( forcewidth :: Real
  , contactwidth :: Real
  , contactheight :: Real
  , connect :: Real
  , com :: Real
  , camera :: Real
  , light :: Real
  , selectpoint :: Real
  , jointlength :: Real
  , jointwidth :: Real
  , actuatorlength :: Real
  , actuatorwidth :: Real
  , framelength :: Real
  , framewidth :: Real
  , constraint :: Real
  , slidercrank :: Real
  , frustum :: Real
  )
scale = tagNoContent @Props_scale "scale" :: TagNoContent Props_scale

type Props_rgba =
  ( fog :: Vec4 Real
  , haze :: Vec4 Real
  , force :: Vec4 Real
  , inertia :: Vec4 Real
  , joint :: Vec4 Real
  , actuator :: Vec4 Real
  , actuatornegative :: Vec4 Real
  , actuatorpositive :: Vec4 Real
  , com :: Vec4 Real
  , camera :: Vec4 Real
  , light :: Vec4 Real
  , selectpoint :: Vec4 Real
  , connect :: Vec4 Real
  , contactpoint :: Vec4 Real
  , contactforce :: Vec4 Real
  , contactfriction :: Vec4 Real
  , contacttorque :: Vec4 Real
  , contactgap :: Vec4 Real
  , rangefinder :: Vec4 Real
  , constraint :: Vec4 Real
  , slidercrank :: Vec4 Real
  , crankbroken :: Vec4 Real
  , frustum :: Vec4 Real
  , bv :: Vec4 Real
  , bvactive :: Vec4 Real
  )
rgba = tagNoContent @Props_rgba "rgba" :: TagNoContent Props_rgba
