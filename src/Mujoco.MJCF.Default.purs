module Mujoco.MJCF.Default where

import Mujoco.MJCF.Prelude

import Mujoco.MJCF.Actuator as Actuator
import Mujoco.MJCF.Asset as Asset
import Mujoco.MJCF.Body as Body
import Mujoco.MJCF.Contact as Contact
import Mujoco.MJCF.Equality as Equality
import Mujoco.MJCF.Geom as Geom
import Mujoco.MJCF.Tendon as Tendon

type Props_default = (class :: String)
default = tag @Props_default "default" :: Tag Props_default

mesh = tagNoContent @Asset.Props_mesh "mesh" :: TagNoContent Asset.Props_mesh
material = tagNoContent @Asset.Props_material "material" :: TagNoContent Asset.Props_material
joint = tagNoContent @Body.Props_joint "joint" :: TagNoContent Body.Props_joint
geom = tagNoContent @Geom.Props_geom "geom" :: TagNoContent Geom.Props_geom
site = tagNoContent @Body.Props_site "site" :: TagNoContent Body.Props_site
camera = tagNoContent @Body.Props_camera "camera" :: TagNoContent Body.Props_camera
light = tagNoContent @Body.Props_light "light" :: TagNoContent Body.Props_light
pair = tagNoContent @Contact.Props_pair "pair" :: TagNoContent Contact.Props_pair
equality = tagNoContent @(Equality.Common ()) "equality" :: TagNoContent (Equality.Common ())
tendon = tagNoContent @(Tendon.Common ()) "tendon" :: TagNoContent (Tendon.Common ())
general = tagNoContent @Actuator.Props_general "general" :: TagNoContent Actuator.Props_general
motor = tagNoContent @Actuator.Props_motor "motor" :: TagNoContent Actuator.Props_motor
position = tagNoContent @Actuator.Props_position "position" :: TagNoContent Actuator.Props_position
velocity = tagNoContent @Actuator.Props_velocity "velocity" :: TagNoContent Actuator.Props_velocity
intvelocity = tagNoContent @Actuator.Props_intvelocity "intvelocity" :: TagNoContent Actuator.Props_intvelocity
damper = tagNoContent @Actuator.Props_damper "damper" :: TagNoContent Actuator.Props_damper
cylinder = tagNoContent @Actuator.Props_cylinder "cylinder" :: TagNoContent Actuator.Props_cylinder
muscle = tagNoContent @Actuator.Props_muscle "muscle" :: TagNoContent Actuator.Props_muscle
adhesion = tagNoContent @Actuator.Props_adhesion "adhesion" :: TagNoContent Actuator.Props_adhesion
