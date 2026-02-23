module Mujoco.MJCF.Keyword where

import Data.Either.Inject (class Inject, inj)
import Mujoco.MJCF.XML.Prop (class Serialize)

kw :: forall kw sum. Inject kw sum => kw -> sum
kw = inj

true_ :: forall sum. Inject Boolean sum => sum
true_ = inj true

false_ :: forall sum. Inject Boolean sum => sum
false_ = inj false

data None = None

instance Serialize None where
  serialize None = "none"

data Integrator = Integrator

instance Serialize Integrator where
  serialize Integrator = "integrator"

data Filter = Filter

instance Serialize Filter where
  serialize Filter = "filter"

data FilterExact = FilterExact

instance Serialize FilterExact where
  serialize FilterExact = "filterexact"

data Muscle = Muscle

instance Serialize Muscle where
  serialize Muscle = "muscle"

data User = User

instance Serialize User where
  serialize User = "user"

data Fixed = Fixed

instance Serialize Fixed where
  serialize Fixed = "fixed"

data Affine = Affine

instance Serialize Affine where
  serialize Affine = "affine"

data Zoh = Zoh

instance Serialize Zoh where
  serialize Zoh = "zoh"

data Linear = Linear

instance Serialize Linear where
  serialize Linear = "linear"

data Cubic = Cubic

instance Serialize Cubic where
  serialize Cubic = "cubic"

data Convex = Convex

instance Serialize Convex where
  serialize Convex = "convex"

data Exact = Exact

instance Serialize Exact where
  serialize Exact = "exact"

data Legacy = Legacy

instance Serialize Legacy where
  serialize Legacy = "legacy"

data Shell = Shell

instance Serialize Shell where
  serialize Shell = "shell"

data TwoD = TwoD

instance Serialize TwoD where
  serialize TwoD = "2d"

data Cube = Cube

instance Serialize Cube where
  serialize Cube = "cube"

data Skybox = Skybox

instance Serialize Skybox where
  serialize Skybox = "skybox"

data SRGB = SRGB

instance Serialize SRGB where
  serialize SRGB = "sRGB"

data Gradient = Gradient

instance Serialize Gradient where
  serialize Gradient = "gradient"

data Checker = Checker

instance Serialize Checker where
  serialize Checker = "checker"

data Flat = Flat

instance Serialize Flat where
  serialize Flat = "flat"

data Edge = Edge

instance Serialize Edge where
  serialize Edge = "edge"

data Cross = Cross

instance Serialize Cross where
  serialize Cross = "cross"

data Random = Random

instance Serialize Random where
  serialize Random = "random"

data Rgb = Rgb

instance Serialize Rgb where
  serialize Rgb = "rgb"

data Normal = Normal

instance Serialize Normal where
  serialize Normal = "normal"

data Occlusion = Occlusion

instance Serialize Occlusion where
  serialize Occlusion = "occlusion"

data Roughness = Roughness

instance Serialize Roughness where
  serialize Roughness = "roughness"

data Metallic = Metallic

instance Serialize Metallic where
  serialize Metallic = "metallic"

data Opacity = Opacity

instance Serialize Opacity where
  serialize Opacity = "opacity"

data Emissive = Emissive

instance Serialize Emissive where
  serialize Emissive = "emissive"

data Orm = Orm

instance Serialize Orm where
  serialize Orm = "orm"

data Rgba = Rgba

instance Serialize Rgba where
  serialize Rgba = "rgba"

data Auto = Auto

instance Serialize Auto where
  serialize Auto = "auto"

data Never = Never

instance Serialize Never where
  serialize Never = "never"

data Allowed = Allowed

instance Serialize Allowed where
  serialize Allowed = "allowed"

data Init = Init

instance Serialize Init where
  serialize Init = "init"

data Free = Free

instance Serialize Free where
  serialize Free = "free"

data Ball = Ball

instance Serialize Ball where
  serialize Ball = "ball"

data Slide = Slide

instance Serialize Slide where
  serialize Slide = "slide"

data Hinge = Hinge

instance Serialize Hinge where
  serialize Hinge = "hinge"

data Sphere = Sphere

instance Serialize Sphere where
  serialize Sphere = "sphere"

data Capsule = Capsule

instance Serialize Capsule where
  serialize Capsule = "capsule"

data Ellipsoid = Ellipsoid

instance Serialize Ellipsoid where
  serialize Ellipsoid = "ellipsoid"

data Cylinder = Cylinder

instance Serialize Cylinder where
  serialize Cylinder = "cylinder"

data Box = Box

instance Serialize Box where
  serialize Box = "box"

data Track = Track

instance Serialize Track where
  serialize Track = "track"

data Trackcom = Trackcom

instance Serialize Trackcom where
  serialize Trackcom = "trackcom"

data Targetbody = Targetbody

instance Serialize Targetbody where
  serialize Targetbody = "targetbody"

data Targetbodycom = Targetbodycom

instance Serialize Targetbodycom where
  serialize Targetbodycom = "targetbodycom"

data Perspective = Perspective

instance Serialize Perspective where
  serialize Perspective = "perspective"

data Orthographic = Orthographic

instance Serialize Orthographic where
  serialize Orthographic = "orthographic"

data Depth = Depth

instance Serialize Depth where
  serialize Depth = "depth"

data Distance = Distance

instance Serialize Distance where
  serialize Distance = "distance"

data Segmentation = Segmentation

instance Serialize Segmentation where
  serialize Segmentation = "segmentation"

data Spot = Spot

instance Serialize Spot where
  serialize Spot = "spot"

data Directional = Directional

instance Serialize Directional where
  serialize Directional = "directional"

data Point = Point

instance Serialize Point where
  serialize Point = "point"

data Image = Image

instance Serialize Image where
  serialize Image = "image"

data Plane = Plane

instance Serialize Plane where
  serialize Plane = "plane"

data Hfield = Hfield

instance Serialize Hfield where
  serialize Hfield = "hfield"

data Mesh = Mesh

instance Serialize Mesh where
  serialize Mesh = "mesh"

data Sdf = Sdf

instance Serialize Sdf where
  serialize Sdf = "sdf"

data Euler = Euler

instance Serialize Euler where
  serialize Euler = "Euler"

data RK4 = RK4

instance Serialize RK4 where
  serialize RK4 = "RK4"

data Implicit = Implicit

instance Serialize Implicit where
  serialize Implicit = "implicit"

data ImplicitFast = ImplicitFast

instance Serialize ImplicitFast where
  serialize ImplicitFast = "implicitfast"

data Pyramidal = Pyramidal

instance Serialize Pyramidal where
  serialize Pyramidal = "pyramidal"

data Elliptic = Elliptic

instance Serialize Elliptic where
  serialize Elliptic = "elliptic"

data Dense = Dense

instance Serialize Dense where
  serialize Dense = "dense"

data Sparse = Sparse

instance Serialize Sparse where
  serialize Sparse = "sparse"

data PGS = PGS

instance Serialize PGS where
  serialize PGS = "PGS"

data CG = CG

instance Serialize CG where
  serialize CG = "CG"

data Newton = Newton

instance Serialize Newton where
  serialize Newton = "Newton"

data Enable = Enable

instance Serialize Enable where
  serialize Enable = "enable"

data Disable = Disable

instance Serialize Disable where
  serialize Disable = "disable"

data Local = Local

instance Serialize Local where
  serialize Local = "local"

data Global = Global

instance Serialize Global where
  serialize Global = "global"

data Radian = Radian

instance Serialize Radian where
  serialize Radian = "radian"

data Degree = Degree

instance Serialize Degree where
  serialize Degree = "degree"

data Dist = Dist

instance Serialize Dist where
  serialize Dist = "dist"

data Dir = Dir

instance Serialize Dir where
  serialize Dir = "dir"

data Origin = Origin

instance Serialize Origin where
  serialize Origin = "origin"

data Body = Body

instance Serialize Body where
  serialize Body = "body"

data Xbody = Xbody

instance Serialize Xbody where
  serialize Xbody = "xbody"

data Geom = Geom

instance Serialize Geom where
  serialize Geom = "geom"

data Site = Site

instance Serialize Site where
  serialize Site = "site"

data Camera = Camera

instance Serialize Camera where
  serialize Camera = "camera"

data Found = Found

instance Serialize Found where
  serialize Found = "found"

data Force = Force

instance Serialize Force where
  serialize Force = "force"

data Torque = Torque

instance Serialize Torque where
  serialize Torque = "torque"

data Pos = Pos

instance Serialize Pos where
  serialize Pos = "pos"

data Vel = Vel

instance Serialize Vel where
  serialize Vel = "vel"

data Acc = Acc

instance Serialize Acc where
  serialize Acc = "acc"

data Tangent = Tangent

instance Serialize Tangent where
  serialize Tangent = "tangent"

data MinDist = MinDist

instance Serialize MinDist where
  serialize MinDist = "mindist"

data MaxForce = MaxForce

instance Serialize MaxForce where
  serialize MaxForce = "maxforce"

data NetForce = NetForce

instance Serialize NetForce where
  serialize NetForce = "netforce"

data Real = Real

instance Serialize Real where
  serialize Real = "real"

data Positive = Positive

instance Serialize Positive where
  serialize Positive = "positive"

data Axis = Axis

instance Serialize Axis where
  serialize Axis = "axis"

data Quaternion = Quaternion

instance Serialize Quaternion where
  serialize Quaternion = "quaternion"
