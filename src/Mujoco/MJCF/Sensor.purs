module Mujoco.MJCF.Sensor where

import Mujoco.MJCF.Prelude

import Mujoco.MJCF.Keyword as Kw

type ObjType = Kw.Body \/ Kw.Xbody \/ Kw.Geom \/ Kw.Site \/ Kw.Camera

type Common' r =
  ( noise :: Real
  , cutoff :: Real
  , user :: Array Real
  | Named r
  )

type Common r =
  ( nsample :: Int
  , interval :: Real /\ Real
  , delay :: Real
  , interp :: Kw.Zoh \/ Kw.Linear \/ Kw.Cubic
  | Common' r
  )

type Props_touch = Common (site :: String)
touch = tagNoContent @Props_touch "touch" :: TagNoContent Props_touch

type Props_accelerometer = Common (site :: String)
accelerometer = tagNoContent @Props_accelerometer "accelerometer" :: TagNoContent Props_accelerometer

type Props_velocimeter = Common (site :: String)
velocimeter = tagNoContent @Props_velocimeter "velocimeter" :: TagNoContent Props_velocimeter

type Props_gyro = Common (site :: String)
gyro = tagNoContent @Props_gyro "gyro" :: TagNoContent Props_gyro

type Props_force = Common (site :: String)
force = tagNoContent @Props_force "force" :: TagNoContent Props_force

type Props_torque = Common (site :: String)
torque = tagNoContent @Props_torque "torque" :: TagNoContent Props_torque

type Props_magnetometer = Common (site :: String)
magnetometer = tagNoContent @Props_magnetometer "magnetometer" :: TagNoContent Props_magnetometer

type Props_rangefinder =
  ( site :: String
  , camera :: String
  , data :: Array (Kw.Dist \/ Kw.Dir \/ Kw.Origin \/ Kw.Point \/ Kw.Normal \/ Kw.Depth)
  | Common ()
  )
rangefinder = tagNoContent @Props_rangefinder "rangefinder" :: TagNoContent Props_rangefinder

type Props_camprojection = Common (site :: String, camera :: String)
camprojection = tagNoContent @Props_camprojection "camprojection" :: TagNoContent Props_camprojection

type Props_jointpos = Common (joint :: String)
jointpos = tagNoContent @Props_jointpos "jointpos" :: TagNoContent Props_jointpos

type Props_jointvel = Common (joint :: String)
jointvel = tagNoContent @Props_jointvel "jointvel" :: TagNoContent Props_jointvel

type Props_jointactuatorfrc = Common (joint :: String)
jointactuatorfrc = tagNoContent @Props_jointactuatorfrc "jointactuatorfrc" :: TagNoContent Props_jointactuatorfrc

type Props_ballquat = Common (joint :: String)
ballquat = tagNoContent @Props_ballquat "ballquat" :: TagNoContent Props_ballquat

type Props_ballangvel = Common (joint :: String)
ballangvel = tagNoContent @Props_ballangvel "ballangvel" :: TagNoContent Props_ballangvel

type Props_jointlimitpos = Common (joint :: String)
jointlimitpos = tagNoContent @Props_jointlimitpos "jointlimitpos" :: TagNoContent Props_jointlimitpos

type Props_jointlimitvel = Common (joint :: String)
jointlimitvel = tagNoContent @Props_jointlimitvel "jointlimitvel" :: TagNoContent Props_jointlimitvel

type Props_jointlimitfrc = Common (joint :: String)
jointlimitfrc = tagNoContent @Props_jointlimitfrc "jointlimitfrc" :: TagNoContent Props_jointlimitfrc

type Props_tendonpos = Common (tendon :: String)
tendonpos = tagNoContent @Props_tendonpos "tendonpos" :: TagNoContent Props_tendonpos

type Props_tendonvel = Common (tendon :: String)
tendonvel = tagNoContent @Props_tendonvel "tendonvel" :: TagNoContent Props_tendonvel

type Props_tendonactuatorfrc = Common (tendon :: String)
tendonactuatorfrc = tagNoContent @Props_tendonactuatorfrc "tendonactuatorfrc" :: TagNoContent Props_tendonactuatorfrc

type Props_tendonlimitpos = Common (tendon :: String)
tendonlimitpos = tagNoContent @Props_tendonlimitpos "tendonlimitpos" :: TagNoContent Props_tendonlimitpos

type Props_tendonlimitvel = Common (tendon :: String)
tendonlimitvel = tagNoContent @Props_tendonlimitvel "tendonlimitvel" :: TagNoContent Props_tendonlimitvel

type Props_tendonlimitfrc = Common (tendon :: String)
tendonlimitfrc = tagNoContent @Props_tendonlimitfrc "tendonlimitfrc" :: TagNoContent Props_tendonlimitfrc

type Props_actuatorpos = Common (actuator :: String)
actuatorpos = tagNoContent @Props_actuatorpos "actuatorpos" :: TagNoContent Props_actuatorpos

type Props_actuatorvel = Common (actuator :: String)
actuatorvel = tagNoContent @Props_actuatorvel "actuatorvel" :: TagNoContent Props_actuatorvel

type Props_actuatorfrc = Common (actuator :: String)
actuatorfrc = tagNoContent @Props_actuatorfrc "actuatorfrc" :: TagNoContent Props_actuatorfrc

type Frame r =
  ( objtype :: ObjType
  , objname :: String
  , reftype :: ObjType
  , refname :: String
  | Common r
  )

type Props_framepos = Frame ()
framepos = tagNoContent @Props_framepos "framepos" :: TagNoContent Props_framepos

type Props_framequat = Frame ()
framequat = tagNoContent @Props_framequat "framequat" :: TagNoContent Props_framequat

type Props_framexaxis = Frame ()
framexaxis = tagNoContent @Props_framexaxis "framexaxis" :: TagNoContent Props_framexaxis

type Props_frameyaxis = Frame ()
frameyaxis = tagNoContent @Props_frameyaxis "frameyaxis" :: TagNoContent Props_frameyaxis

type Props_framezaxis = Frame ()
framezaxis = tagNoContent @Props_framezaxis "framezaxis" :: TagNoContent Props_framezaxis

type Props_framelinvel = Frame ()
framelinvel = tagNoContent @Props_framelinvel "framelinvel" :: TagNoContent Props_framelinvel

type Props_frameangvel = Frame ()
frameangvel = tagNoContent @Props_frameangvel "frameangvel" :: TagNoContent Props_frameangvel

type Props_framelinacc =
  ( objtype :: ObjType
  , objname :: String
  | Common ()
  )
framelinacc = tagNoContent @Props_framelinacc "framelinacc" :: TagNoContent Props_framelinacc

type Props_frameangacc =
  ( objtype :: ObjType
  , objname :: String
  | Common ()
  )
frameangacc = tagNoContent @Props_frameangacc "frameangacc" :: TagNoContent Props_frameangacc

type Props_subtreecom = Common (body :: String)
subtreecom = tagNoContent @Props_subtreecom "subtreecom" :: TagNoContent Props_subtreecom

type Props_subtreelinvel = Common (body :: String)
subtreelinvel = tagNoContent @Props_subtreelinvel "subtreelinvel" :: TagNoContent Props_subtreelinvel

type Props_subtreeangmom = Common (body :: String)
subtreeangmom = tagNoContent @Props_subtreeangmom "subtreeangmom" :: TagNoContent Props_subtreeangmom

type Props_insidesite =
  ( objtype :: ObjType
  , objname :: String
  , site :: String
  | Common ()
  )
insidesite = tagNoContent @Props_insidesite "insidesite" :: TagNoContent Props_insidesite

type Collision r = (geom1 :: String, geom2 :: String, body1 :: String, body2 :: String | Common r)

type Props_distance = Collision ()
distance = tagNoContent @Props_distance "distance" :: TagNoContent Props_distance

type Props_normal = Collision ()
normal = tagNoContent @Props_normal "normal" :: TagNoContent Props_normal

type Props_fromto = Collision ()
fromto = tagNoContent @Props_fromto "fromto" :: TagNoContent Props_fromto

type Props_contact =
  ( subtree1 :: String
  , subtree2 :: String
  , site :: String
  , num :: Int
  , data :: Array (Kw.Found \/ Kw.Force \/ Kw.Torque \/ Kw.Dist \/ Kw.Pos \/ Kw.Normal \/ Kw.Tangent)
  , reduce :: Kw.None \/ Kw.MinDist \/ Kw.MaxForce \/ Kw.NetForce
  | Collision ()
  )
contact = tagNoContent @Props_contact "contact" :: TagNoContent Props_contact

type Props_tactile =
  ( geom :: String
  , mesh :: String
  , nsample :: Int
  , interp :: Kw.Zoh \/ Kw.Linear \/ Kw.Cubic
  , interval :: Real /\ Real
  , delay :: Real
  , user :: Array Real
  | Named ()
  )
tactile = tagNoContent @Props_tactile "tactile" :: TagNoContent Props_tactile

type Props_e_potential = Common ()
e_potential = tagNoContent @Props_e_potential "e_potential" :: TagNoContent Props_e_potential

type Props_e_kinetic = Common ()
e_kinetic = tagNoContent @Props_e_kinetic "e_kinetic" :: TagNoContent Props_e_kinetic

type Props_clock = Common ()
clock = tagNoContent @Props_clock "clock" :: TagNoContent Props_clock

type Props_user =
  ( objtype :: String
  , objname :: String
  , datatype :: Kw.Real \/ Kw.Positive \/ Kw.Axis \/ Kw.Quaternion
  , needstage :: Kw.Pos \/ Kw.Vel \/ Kw.Acc
  , dim :: Int
  | Common' ()
  )
user = tagNoContent @Props_user "user" :: TagNoContent Props_user

type Props_plugin =
  ( plugin :: String
  , instance :: String
  , cutoff :: Real
  , objtype :: ObjType
  , objname :: String
  , reftype :: ObjType
  , refname :: String
  , user :: Array Real
  | Named ()
  )
plugin = tag @Props_plugin "plugin" :: Tag Props_plugin
