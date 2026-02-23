module Mujoco.MJCF.Actuator where

import Mujoco.MJCF.Prelude
import Mujoco.MJCF.Keyword as Kw

actuator = tag @() "actuator" :: Tag ()

type Interp = Kw.Zoh \/ Kw.Linear \/ Kw.Cubic
type DynType = Kw.None \/ Kw.Integrator \/ Kw.Filter \/ Kw.FilterExact \/ Kw.Muscle \/ Kw.User
type GainType = Kw.Fixed \/ Kw.Affine \/ Kw.Muscle \/ Kw.User
type BiasType = Kw.None \/ Kw.Affine \/ Kw.Muscle \/ Kw.User

type CommonMin r =
  ( class :: String
  , group :: Int
  , delay :: Real
  , forcelimited :: Kw.Auto \/ Boolean
  , ctrlrange :: Real /\ Real
  , forcerange :: Real /\ Real
  , user :: Array Real
  , interp :: Interp
  , nsample :: Int
  | Named r
  )

type Common r =
  ( ctrllimited :: Kw.Auto \/ Boolean
  , lengthrange :: Real /\ Real
  , gear :: Array Real
  , cranklength :: Real
  , joint :: String
  , jointinparent :: String
  , tendon :: String
  , cranksite :: String
  , slidersite :: String
  , site :: String
  , refsite :: String
  | CommonMin r
  )

type Props_general =
  ( actlimited :: Kw.Auto \/ Boolean
  , actrange :: Real /\ Real
  , actdim :: Int
  , dyntype :: DynType
  , gaintype :: GainType
  , biastype :: BiasType
  , dynprm :: Array Real
  , gainprm :: Array Real
  , biasprm :: Array Real
  , actearly :: Boolean
  , body :: String
  | Common ()
  )
general = tagNoContent @Props_general "general" :: TagNoContent Props_general

type Props_adhesion =
  ( body :: String
  , gain :: Real
  | CommonMin ()
  )
adhesion = tagNoContent @Props_adhesion "adhesion" :: TagNoContent Props_adhesion

type Props_plugin =
  ( actlimited :: Kw.Auto \/ Boolean
  , actdim :: Int
  , dynprm :: Array Real
  , actearly :: Boolean
  , actrange :: Real /\ Real
  , dyntype :: DynType
  , instance :: String
  , plugin :: String
  | Common ()
  )
plugin = tagNoContent @Props_plugin "plugin" :: TagNoContent Props_plugin

type Props_motor = Common ()
motor = tagNoContent @Props_motor "motor" :: TagNoContent Props_motor

type Props_position =
  ( kp :: Real
  , kv :: Real
  , dampratio :: Real
  , timeconst :: Real
  , inheritrange :: Real
  | Common ()
  )
position = tagNoContent @Props_position "position" :: TagNoContent Props_position

type Props_velocity =
  ( kv :: Real
  | Common ()
  )
velocity = tagNoContent @Props_velocity "velocity" :: TagNoContent Props_velocity

type Props_intvelocity =
  ( kp :: Real
  , kv :: Real
  , dampratio :: Real
  , inheritrange :: Real
  , actrange :: Real /\ Real
  | Common ()
  )
intvelocity = tagNoContent @Props_intvelocity "intvelocity" :: TagNoContent Props_intvelocity

type Props_damper =
  ( kv :: Real
  | Common ()
  )
damper = tagNoContent @Props_damper "damper" :: TagNoContent Props_damper

type Props_cylinder =
  ( timeconst :: Real
  , area :: Real
  , diameter :: Real
  , bias :: Vec Real
  | Common ()
  )
cylinder = tagNoContent @Props_cylinder "cylinder" :: TagNoContent Props_cylinder

type Props_muscle =
  ( timeconst :: Real /\ Real
  , tausmooth :: Real
  , range :: Real /\ Real
  , force :: Real
  , scale :: Real
  , lmin :: Real
  , lmax :: Real
  , vmax :: Real
  , fpmax :: Real
  , fvmax :: Real
  | Common ()
  )
muscle = tagNoContent @Props_muscle "muscle" :: TagNoContent Props_muscle
