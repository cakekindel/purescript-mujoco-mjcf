module Mujoco.MJCF.Meta where

import Mujoco.MJCF.Prelude

type Props_frame :: Row Type
type Props_frame = ()

frame = tag @Props_frame "frame" :: Tag Props_frame

type Props_replicate = (count :: Int, sep :: String, offset :: Vec Number, euler :: Vec Number)
replicate = tag @Props_replicate "replicate" :: Tag Props_replicate

type Props_include = (file :: String)
include = tag @Props_include "include" :: Tag Props_include
