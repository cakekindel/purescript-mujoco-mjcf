module Test.Mujoco.MJCF.Contact where

import Prelude

import Data.Tuple.Nested ((/\))
import Mujoco.MJCF as X
import Test.Mujoco.MJCF.Util (MjcfSpec, parseOk)
import Test.Spec (describe, it)

spec :: MjcfSpec Unit
spec =
  describe "contact" do
    describe "pair" do
      it "geom1 + geom2" $ parseOk $ X.mujoco {}
        [ X.worldbody {}
            [ X.geom { name: "g1", type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ] } unit
            , X.geom { name: "g2", type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ], pos: 1.0 /\ 0.0 /\ 0.0 } unit
            ]
        , X.contact {} [ X.pair { geom1: "g1", geom2: "g2" } ]
        ]

      it "condim + friction" $ parseOk $ X.mujoco {}
        [ X.worldbody {}
            [ X.geom { name: "g1", type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ] } unit
            , X.geom { name: "g2", type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ], pos: 1.0 /\ 0.0 /\ 0.0 } unit
            ]
        , X.contact {} [ X.pair { geom1: "g1", geom2: "g2", condim: 3, friction: 1.0 /\ 0.005 /\ 0.0001 /\ 0.005 /\ 0.0001 } ]
        ]

      it "solref + solimp + margin + gap" $ parseOk $ X.mujoco {}
        [ X.worldbody {}
            [ X.geom { name: "g1", type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ] } unit
            , X.geom { name: "g2", type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ], pos: 1.0 /\ 0.0 /\ 0.0 } unit
            ]
        , X.contact {} [ X.pair { geom1: "g1", geom2: "g2", solref: 0.02 /\ 1.0, solimp: 0.9 /\ 0.95 /\ 0.001 /\ 0.5 /\ 2.0, margin: 0.01, gap: 0.0 } ]
        ]

    describe "exclude" do
      it "body1 + body2" $ parseOk $ X.mujoco {}
        [ X.worldbody {}
            [ X.body { name: "b1", pos: 0.0 /\ 0.0 /\ 0.0 }
                [ X.geom { type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ] } unit ]
            , X.body { name: "b2", pos: 1.0 /\ 0.0 /\ 0.0 }
                [ X.geom { type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ] } unit ]
            ]
        , X.contact {} [ X.exclude { body1: "b1", body2: "b2" } ]
        ]
