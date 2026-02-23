module Mujoco.MJCF.Extension where

import Mujoco.MJCF.Prelude

extension = tag @() "extension" :: Tag ()

type Props_plugin = (plugin :: String)
plugin = tag @Props_plugin "plugin" :: Tag Props_plugin

type Props_instance = (name :: String)
instance_ = tag @Props_instance "instance" :: Tag Props_instance

type Props_config = (key :: String, value :: String)
config = tagNoContent @Props_config "config" :: TagNoContent Props_config
