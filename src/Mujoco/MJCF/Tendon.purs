module Mujoco.MJCF.Tendon where

import Mujoco.MJCF.Prelude

import Mujoco.MJCF.Keyword as Kw

tendon = tag @() "tendon" :: Tag ()

type Common r =
  ( class :: String
  , group :: Int
  , limited :: Kw.Auto \/ Boolean
  , range :: Real /\ Real
  , solimplimit :: Vec5 Real
  , solimpfriction :: Vec5 Real
  , solreflimit :: Real /\ Real
  , solreffriction :: Real /\ Real
  , margin :: Real
  , frictionloss :: Real
  , springlength :: Real /\ Real
  , stiffness :: Real
  , damping :: Real
  , user :: Array Real
  | Named r
  )

type Props_spatial =
  ( actuatorfrcrange :: Real /\ Real
  , actuatorfrclimited :: Kw.Auto \/ Boolean
  , width :: Real
  , material :: String
  , rgba :: Vec4 Real
  , armature :: Real
  | Common ()
  )
spatial = tag @Props_spatial "spatial" :: Tag Props_spatial

type Props_site = (site :: String)
site = tagNoContent @Props_site "site" :: TagNoContent Props_site

type Props_pulley = (divisor :: Real)
pulley = tagNoContent @Props_pulley "pulley" :: TagNoContent Props_pulley

type Props_geom = (geom :: String, sidesite :: String)
geom = tagNoContent @Props_geom "geom" :: TagNoContent Props_geom

type Props_fixed = Common ()
fixed = tag @Props_fixed "fixed" :: Tag Props_fixed

type Props_joint = (joint :: String, coef :: Real)
joint = tagNoContent @Props_joint "joint" :: TagNoContent Props_joint
