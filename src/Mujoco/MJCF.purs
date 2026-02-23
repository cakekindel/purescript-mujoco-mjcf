module Mujoco.MJCF
  ( Angle
  , Cone
  , Coordinate
  , EnableDisable
  , InertiaFromGeom
  , Jacobian
  , Props_compiler
  , Props_flag
  , Props_option
  , Props_size
  , Props_mujoco
  , Props_statistic
  , Props_plugin
  , Solver
  , plugin
  , compiler
  , flag
  , mujoco
  , option
  , size
  , statistic
  , module X
  ) where

import Mujoco.MJCF.Prelude

import Mujoco.MJCF.Keyword as Kw
import Mujoco.MJCF.Keyframe (Props_key, key, keyframe) as X
import Mujoco.MJCF.Keyword (Acc(..), Affine(..), Allowed(..), Auto(..), Axis(..), Ball(..), Body(..), Box(..), CG(..), Camera(..), Capsule(..), Checker(..), Convex(..), Cross(..), Cube(..), Cubic(..), Cylinder(..), Degree(..), Dense(..), Depth(..), Dir(..), Directional(..), Disable(..), Dist(..), Distance(..), Edge(..), Ellipsoid(..), Elliptic(..), Emissive(..), Enable(..), Euler(..), Exact(..), Filter(..), FilterExact(..), Fixed(..), Flat(..), Force(..), Found(..), Free(..), Geom(..), Global(..), Gradient(..), Hfield(..), Hinge(..), Image(..), Implicit(..), ImplicitFast(..), Init(..), Integrator(..), Legacy(..), Linear(..), Local(..), MaxForce(..), Mesh(..), Metallic(..), MinDist(..), Muscle(..), NetForce(..), Never(..), Newton(..), None(..), Normal(..), Occlusion(..), Opacity(..), Origin(..), Orm(..), Orthographic(..), PGS(..), Perspective(..), Plane(..), Point(..), Pos(..), Positive(..), Pyramidal(..), Quaternion(..), RK4(..), Radian(..), Random(..), Real(..), Rgb(..), Rgba(..), Roughness(..), SRGB(..), Sdf(..), Segmentation(..), Shell(..), Site(..), Skybox(..), Slide(..), Sparse(..), Sphere(..), Spot(..), Tangent(..), Targetbody(..), Targetbodycom(..), Torque(..), Track(..), Trackcom(..), TwoD(..), User(..), Vel(..), Xbody(..), Zoh(..), false_, kw, true_) as X
import Mujoco.MJCF.Asset (LayerRole, MeshInertia, Props_hfield, Props_layer, Props_material, Props_mesh, Props_model, Props_texture, TextureBuiltin, TextureColorspace, TextureMark, TextureType, asset, hfield, layer, material, mesh, model, texture) as X
import Mujoco.MJCF.Body (CameraMode, CameraOutput, JointType, LightType, Projection, Props_attach, Props_body, Props_camera, Props_frame, Props_freejoint, Props_geom, Props_inertial, Props_joint, Props_light, Props_site, SiteType, SleepPolicy, attach, body, camera, frame, freejoint, geom, inertial, joint, light, site, worldbody) as X
import Mujoco.MJCF.Contact (Props_exclude, Props_pair, contact, exclude, pair) as X
import Mujoco.MJCF.Sensor (sensor) as X
import Mujoco.MJCF.Actuator (actuator) as X
import Mujoco.MJCF.Tendon (tendon) as X
import Mujoco.MJCF.XML (empty, text, fragment) as X

type Props_mujoco = (model :: String)
mujoco = tag @Props_mujoco "mujoco" :: Tag Props_mujoco

type Cone = Kw.Pyramidal \/ Kw.Elliptic
type Jacobian = Kw.Dense \/ Kw.Sparse
type Solver = Kw.PGS \/ Kw.CG \/ Kw.Newton
type EnableDisable = Kw.Enable \/ Kw.Disable
type Coordinate = Kw.Local \/ Kw.Global
type Angle = Kw.Radian \/ Kw.Degree
type InertiaFromGeom = Kw.Auto \/ Boolean

type Props_option =
  ( timestep :: Real
  , impratio :: Real
  , gravity :: Vec Real
  , wind :: Vec Real
  , magnetic :: Vec Real
  , density :: Real
  , viscosity :: Real
  , o_margin :: Real
  , o_solref :: Real /\ Real
  , o_solimp :: Vec5 Real
  , integrator :: Kw.Euler \/ Kw.RK4 \/ Kw.Implicit \/ Kw.ImplicitFast
  , cone :: Cone
  , jacobian :: Jacobian
  , iterations :: Int
  , tolerance :: Real
  , ls_iterations :: Int
  , ls_tolerance :: Real
  , noslip_tolerance :: Real
  , ccd_iterations :: Int
  , ccd_tolerance :: Real
  , sleep_tolerance :: Real
  , sdf_iterations :: Int
  , sdf_initpoints :: Int
  , actuatorgroupdisable :: Array Int
  , solver :: Solver
  )

option = tag @Props_option "mjcf:option" :: Tag Props_option

type Props_flag =
  ( constraint :: EnableDisable
  , equality :: EnableDisable
  , frictionloss :: EnableDisable
  , limit :: EnableDisable
  , contact :: EnableDisable
  , spring :: EnableDisable
  , damper :: EnableDisable
  , gravity :: EnableDisable
  , clampctrl :: EnableDisable
  , warmstart :: EnableDisable
  , filterparent :: EnableDisable
  , actuation :: EnableDisable
  , refsafe :: EnableDisable
  , sensor :: EnableDisable
  , midphase :: EnableDisable
  , nativeccd :: EnableDisable
  , island :: EnableDisable
  , eulerdamp :: EnableDisable
  , autoreset :: EnableDisable
  , override :: EnableDisable
  , energy :: EnableDisable
  , fwdinv :: EnableDisable
  , invdiscrete :: EnableDisable
  , multiccd :: EnableDisable
  , sleep :: EnableDisable
  )

flag = tagNoContent @Props_flag "flag" :: TagNoContent Props_flag

type Props_compiler =
  ( autolimits :: Boolean
  , boundmass :: Real
  , boundinertia :: Real
  , settotalmass :: Real
  , balanceinertia :: Boolean
  , strippath :: Boolean
  , coordinate :: Coordinate
  , angle :: Angle
  , fitaabb :: Boolean
  , eulerseq :: String
  , meshdir :: String
  , texturedir :: String
  , assetdir :: String
  , discardvisual :: Boolean
  , usethread :: Boolean
  , fusestatic :: Boolean
  , inertiafromgeom :: InertiaFromGeom
  , alignfree :: Boolean
  , inertiagrouprange :: Int /\ Int
  , saveinertial :: Boolean
  )

compiler = tagNoContent @Props_compiler "compiler" :: TagNoContent Props_compiler

type Props_size =
  ( memory :: String
  , njmax :: Int
  , nconmax :: Int
  , nstack :: Int
  , nuserdata :: Int
  , nkey :: Int
  , nuser_body :: Int
  , nuser_jnt :: Int
  , nuser_geom :: Int
  , nuser_site :: Int
  , nuser_cam :: Int
  , nuser_tendon :: Int
  , nuser_actuator :: Int
  , nuser_sensor :: Int
  )

size = tagNoContent @Props_size "size" :: TagNoContent Props_size

type Props_statistic =
  ( meanmass :: Real
  , meaninertia :: Real
  , meansize :: Real
  , extent :: Real
  , center :: Vec Real
  )

statistic = tagNoContent @Props_statistic "statistic" :: TagNoContent Props_statistic

type Props_plugin = (plugin :: String, instance :: String)

-- | `body/plugin`, `asset/mesh/plugin`
plugin = tag @Props_plugin "plugin" :: Tag Props_plugin
