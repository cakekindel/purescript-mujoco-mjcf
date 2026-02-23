module Mujoco.MJCF.Deformable.Flex where

import Mujoco.Prelude
import Mujoco.MJCF.Geom as Geom

type Props_flex =
  ( name :: String
  , dim :: Int
  , radius :: Real
  , body :: Array String
  , vertex :: Array Real
  , texcoord :: Array Real
  , elemtexcoord :: Array Int
  , element :: Array Int
  , flatskin :: Boolean
  , material :: String
  , rgba :: Vec4 Real
  , group :: Int
  , node :: Array String
  )
flex = tag @Props_flex "flex" :: Tag Props_flex

type Props_edge =
  ( stiffness :: Real
  , damping :: Real
  )
edge = tagNoContent @Props_edge "edge" :: TagNoContent Props_edge

data Elastic2d = Elastic2dNone | Elastic2dBend | Elastic2dStretch | Elastic2dBoth
instance Serialize Elastic2d where
  serialize Elastic2dNone = "none"
  serialize Elastic2dBend = "bend"
  serialize Elastic2dStretch = "stretch"
  serialize Elastic2dBoth = "both"

type Props_elasticity =
  ( young :: Real
  , poisson :: Real
  , damping :: Real
  , thickness :: Real
  , elastic2d :: Elastic2d
  )
elasticity = tagNoContent @Props_elasticity "elasticity" :: TagNoContent Props_elasticity

data SelfCollide = SelfCollideNone | SelfCollideNarrow | SelfCollideBvh | SelfCollideSap | SelfCollideAuto
instance Serialize SelfCollide where
  serialize SelfCollideNone = "none"
  serialize SelfCollideNarrow = "narrow"
  serialize SelfCollideBvh = "bvh"
  serialize SelfCollideSap = "sap"
  serialize SelfCollideAuto = "auto"

type Props_contact =
  ( internal :: Boolean
  , selfcollide :: SelfCollide
  , vertcollide :: Boolean
  , activelayers :: Int
  , priority :: Int
  , friction :: Vec Real
  , passive :: Boolean
  | Geom.Solver
  + Geom.Contact
  + Geom.ContactSpacing ()
  )
contact = tagNoContent @Props_contact "contact" :: TagNoContent Props_contact
