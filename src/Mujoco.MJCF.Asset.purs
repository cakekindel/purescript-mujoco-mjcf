module Mujoco.MJCF.Asset where

import Mujoco.Prelude

asset = tag @() "asset" :: Tag ()

data MeshInertia = Convex | Exact | Legacy | Shell
instance Serialize MeshInertia where
  serialize Convex = "convex"
  serialize Exact = "exact"
  serialize Legacy = "legacy"
  serialize Shell = "shell"

type Props_mesh =
  ( name :: String
  , class :: String
  , content_type :: String
  , file :: String
  , scale :: Vec Real
  , inertia :: MeshInertia
  , smoothnormal :: Boolean
  , maxhullvert :: Int
  , vertex :: Array Real
  , normal :: Array Real
  , texcoord :: Array Real
  , face :: Array Int
  , refpos :: Vec Real
  , refquat :: Vec4 Real
  , builtin :: String
  , params :: Array Real
  , material :: String
  )
mesh = tag @Props_mesh "mesh" :: Tag Props_mesh

type Props_hfield =
  ( name :: String
  , content_type :: String
  , file :: String
  , nrow :: Int
  , ncol :: Int
  , elevation :: Array Real
  , size :: Vec4 Real
  )
hfield = tagNoContent @Props_hfield "hfield" :: TagNoContent Props_hfield

data TextureType = Texture2d | TextureCube | TextureSkybox
instance Serialize TextureType where
  serialize Texture2d = "2d"
  serialize TextureCube = "cube"
  serialize TextureSkybox = "skybox"

data TextureColorspace = ColorspaceAuto | ColorspaceLinear | ColorspaceSRGB
instance Serialize TextureColorspace where
  serialize ColorspaceAuto = "auto"
  serialize ColorspaceLinear = "linear"
  serialize ColorspaceSRGB = "sRGB"

data TextureBuiltin = BuiltinNone | BuiltinGradient | BuiltinChecker | BuiltinFlat
instance Serialize TextureBuiltin where
  serialize BuiltinNone = "none"
  serialize BuiltinGradient = "gradient"
  serialize BuiltinChecker = "checker"
  serialize BuiltinFlat = "flat"

data TextureMark = MarkNone | MarkEdge | MarkCross | MarkRandom
instance Serialize TextureMark where
  serialize MarkNone = "none"
  serialize MarkEdge = "edge"
  serialize MarkCross = "cross"
  serialize MarkRandom = "random"

type Props_texture =
  ( name :: String
  , type :: TextureType
  , colorspace :: TextureColorspace
  , content_type :: String
  , file :: String
  , gridsize :: Int /\ Int
  , gridlayout :: String
  , fileright :: String
  , fileleft :: String
  , fileup :: String
  , filedown :: String
  , filefront :: String
  , fileback :: String
  , builtin :: TextureBuiltin
  , rgb1 :: Vec Real
  , rgb2 :: Vec Real
  , mark :: TextureMark
  , markrgb :: Vec Real
  , random :: Real
  , width :: Int
  , height :: Int
  , hflip :: Boolean
  , vflip :: Boolean
  , nchannel :: Int
  )
texture = tagNoContent @Props_texture "texture" :: TagNoContent Props_texture

type Props_material =
  ( name :: String
  , class :: String
  , texture :: String
  , texrepeat :: Real /\ Real
  , texuniform :: Boolean
  , emission :: Real
  , specular :: Real
  , shininess :: Real
  , reflectance :: Real
  , metallic :: Real
  , roughness :: Real
  , rgba :: Vec4 Real
  )
material = tag @Props_material "material" :: Tag Props_material

data LayerRole
  = RoleRgb
  | RoleNormal
  | RoleOcclusion
  | RoleRoughness
  | RoleMetallic
  | RoleOpacity
  | RoleEmissive
  | RoleOrm
  | RoleRgba

instance Serialize LayerRole where
  serialize RoleRgb = "rgb"
  serialize RoleNormal = "normal"
  serialize RoleOcclusion = "occlusion"
  serialize RoleRoughness = "roughness"
  serialize RoleMetallic = "metallic"
  serialize RoleOpacity = "opacity"
  serialize RoleEmissive = "emissive"
  serialize RoleOrm = "orm"
  serialize RoleRgba = "rgba"

type Props_layer =
  ( texture :: String
  , role :: LayerRole
  )
layer = tagNoContent @Props_layer "layer" :: TagNoContent Props_layer

type Props_model =
  ( name :: String
  , file :: String
  , content_type :: String
  )
model = tagNoContent @Props_model "model" :: TagNoContent Props_model

type Props_plugin = (plugin :: String, instance :: String)
plugin = tag @Props_plugin "plugin" :: Tag Props_plugin
