module Mujoco.MJCF
  ( Angle(..)
  , Cone(..)
  , Coordinate(..)
  , Enable(..)
  , InertiaFromGeom(..)
  , Integrator(..)
  , Jacobian(..)
  , Props_compiler
  , Props_flag
  , Props_option
  , Props_size
  , Props_mujoco
  , Props_statistic
  , Solver(..)
  , compiler
  , flag
  , mujoco
  , option
  , size
  , statistic
  , module X
  )
  where

import Mujoco.Prelude
import Mujoco.MJCF.Asset as X
import Mujoco.MJCF.Body as X
import Mujoco.XML.Node (empty, text, fragment) as X

type Props_mujoco = (model :: String)
mujoco = tag @Props_mujoco "mujoco" :: Tag Props_mujoco

data Integrator = Euler | RK4 | Implicit | ImplicitFast
instance Serialize Integrator where
  serialize Euler = "Euler"
  serialize RK4 = "RK4"
  serialize Implicit = "implicit"
  serialize ImplicitFast = "implicitfast"

data Cone = Pyramidal | Elliptic
instance Serialize Cone where
  serialize Pyramidal = "pyramidal"
  serialize Elliptic = "elliptic"

data Jacobian = Dense | Sparse
instance Serialize Jacobian where
  serialize Dense = "dense"
  serialize Sparse = "sparse"

data Solver = PGS | CG | Newton
instance Serialize Solver where
  serialize PGS = "PGS"
  serialize CG = "CG"
  serialize Newton = "Newton"

data Enable = Disable | Enable
instance Serialize Enable where
  serialize Enable = "enable"
  serialize Disable = "disable"

data Coordinate = Local | Global
instance Serialize Coordinate where
  serialize Local = "local"
  serialize Global = "global"

data Angle = Radian | Degree
instance Serialize Angle where
  serialize Radian = "radian"
  serialize Degree = "degree"

data InertiaFromGeom = InertiaFromGeomFalse | InertiaFromGeomTrue | InertiaFromGeomAuto
instance Serialize InertiaFromGeom where
  serialize InertiaFromGeomFalse = "false"
  serialize InertiaFromGeomTrue = "true"
  serialize InertiaFromGeomAuto = "auto"

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
  , integrator :: Integrator
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
option = tag @Props_option "option" :: Tag Props_option

type Props_flag =
  ( constraint :: Enable
  , equality :: Enable
  , frictionloss :: Enable
  , limit :: Enable
  , contact :: Enable
  , spring :: Enable
  , damper :: Enable
  , gravity :: Enable
  , clampctrl :: Enable
  , warmstart :: Enable
  , filterparent :: Enable
  , actuation :: Enable
  , refsafe :: Enable
  , sensor :: Enable
  , midphase :: Enable
  , nativeccd :: Enable
  , island :: Enable
  , eulerdamp :: Enable
  , autoreset :: Enable
  , override :: Enable
  , energy :: Enable
  , fwdinv :: Enable
  , invdiscrete :: Enable
  , multiccd :: Enable
  , sleep :: Enable
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

