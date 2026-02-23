module Mujoco.MJCF.Asset where

import Mujoco.MJCF.Prelude

import Mujoco.MJCF.Keyword as Kw

asset = tag @() "asset" :: Tag ()

type MeshInertia = Kw.Convex \/ Kw.Exact \/ Kw.Legacy \/ Kw.Shell

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

type TextureType = Kw.TwoD \/ Kw.Cube \/ Kw.Skybox
type TextureColorspace = Kw.Auto \/ Kw.Linear \/ Kw.SRGB
type TextureBuiltin = Kw.None \/ Kw.Gradient \/ Kw.Checker \/ Kw.Flat
type TextureMark = Kw.None \/ Kw.Edge \/ Kw.Cross \/ Kw.Random

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

type LayerRole = Kw.Rgb \/ Kw.Normal \/ Kw.Occlusion \/ Kw.Roughness \/ Kw.Metallic \/ Kw.Opacity \/ Kw.Emissive \/ Kw.Orm \/ Kw.Rgba

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
