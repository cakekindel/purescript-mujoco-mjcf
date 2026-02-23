module Test.Mujoco.MJCF.Custom where

import Prelude

import Mujoco.MJCF as X
import Mujoco.MJCF.Custom as Custom
import Test.Mujoco.MJCF.Util (MjcfSpec, parseOk)
import Test.Spec (describe, it)

spec :: MjcfSpec Unit
spec =
  describe "custom" do
    describe "numeric" do
      it "name + data" $ parseOk $ X.mujoco {}
        [ Custom.custom {}
            [ Custom.numeric { name: "params", data: [ 1.0, 2.0, 3.0 ] } ]
        , X.worldbody {} unit
        ]

      it "name + size" $ parseOk $ X.mujoco {}
        [ Custom.custom {}
            [ Custom.numeric { name: "zeros", size: 5 } ]
        , X.worldbody {} unit
        ]

    describe "text" do
      it "name + data" $ parseOk $ X.mujoco {}
        [ Custom.custom {}
            [ Custom.text { name: "info", data: "hello world" } ]
        , X.worldbody {} unit
        ]

    describe "tuple" do
      it "with elements" $ parseOk $ X.mujoco {}
        [ Custom.custom {}
            [ Custom.tuple { name: "body_list" }
                [ Custom.element { objtype: "body", objname: "world", prm: 1.0 } ]
            ]
        , X.worldbody {} unit
        ]

    describe "mixed" do
      it "numeric + text + tuple" $ parseOk $ X.mujoco {}
        [ Custom.custom {}
            [ Custom.numeric { name: "n1", data: [ 0.0 ] }
            , Custom.text { name: "t1", data: "value" }
            , Custom.tuple { name: "tup1" } unit
            ]
        , X.worldbody {} unit
        ]
