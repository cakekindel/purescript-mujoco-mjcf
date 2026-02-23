module Test.Mujoco.MJCF.Deformable where

import Prelude

import Data.Tuple.Nested ((/\))
import Mujoco.MJCF as X
import Mujoco.MJCF.Deformable as Deformable
import Mujoco.MJCF.Deformable.Flex as Flex
import Mujoco.MJCF.Deformable.Skin as Skin
import Test.Mujoco.MJCF.Util (MjcfSpec, parseOk)
import Test.Spec (describe, it)

spec :: MjcfSpec Unit
spec =
  describe "deformable" do
    describe "flex" do
      it "basic" $ parseOk $ X.mujoco {}
        [ X.compiler { inertiafromgeom: X.true_ }
        , Deformable.deformable {}
            [ Flex.flex { name: "f1", dim: 3, body: [ "world", "world", "world", "world" ], vertex: [ 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0 ], element: [ 0, 1, 2, 3 ] }
                unit
            ]
        , X.worldbody {}
            [ X.body { pos: 0.0 /\ 0.0 /\ 0.0 }
                [ X.geom { type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ] } unit ]
            ]
        ]

      it "with edge" $ parseOk $ X.mujoco {}
        [ X.compiler { inertiafromgeom: X.true_ }
        , Deformable.deformable {}
            [ Flex.flex { name: "f2", dim: 3, body: [ "world", "world", "world", "world" ], vertex: [ 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0 ], element: [ 0, 1, 2, 3 ] }
                [ Flex.edge { stiffness: 100.0, damping: 1.0 } ]
            ]
        , X.worldbody {}
            [ X.body { pos: 0.0 /\ 0.0 /\ 0.0 }
                [ X.geom { type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ] } unit ]
            ]
        ]

      it "with elasticity" $ parseOk $ X.mujoco {}
        [ X.compiler { inertiafromgeom: X.true_ }
        , Deformable.deformable {}
            [ Flex.flex { name: "f3", dim: 3, body: [ "world", "world", "world", "world" ], vertex: [ 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0 ], element: [ 0, 1, 2, 3 ] }
                [ Flex.elasticity { young: 1000.0, poisson: 0.3, damping: 0.01 } ]
            ]
        , X.worldbody {}
            [ X.body { pos: 0.0 /\ 0.0 /\ 0.0 }
                [ X.geom { type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ] } unit ]
            ]
        ]

      it "with contact" $ parseOk $ X.mujoco {}
        [ X.compiler { inertiafromgeom: X.true_ }
        , Deformable.deformable {}
            [ Flex.flex { name: "f4", dim: 3, body: [ "world", "world", "world", "world" ], vertex: [ 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0 ], element: [ 0, 1, 2, 3 ] }
                [ Flex.contact { internal: true } ]
            ]
        , X.worldbody {}
            [ X.body { pos: 0.0 /\ 0.0 /\ 0.0 }
                [ X.geom { type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ] } unit ]
            ]
        ]

      it "rgba + group" $ parseOk $ X.mujoco {}
        [ X.compiler { inertiafromgeom: X.true_ }
        , Deformable.deformable {}
            [ Flex.flex { name: "f5", dim: 3, body: [ "world", "world", "world", "world" ], vertex: [ 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0 ], element: [ 0, 1, 2, 3 ], rgba: 1.0 /\ 0.0 /\ 0.0 /\ 1.0, group: 0 }
                unit
            ]
        , X.worldbody {}
            [ X.body { pos: 0.0 /\ 0.0 /\ 0.0 }
                [ X.geom { type: X.kw X.Sphere, size: [ 0.1, 0.0, 0.0 ] } unit ]
            ]
        ]

    describe "skin" do
      it "basic" $ parseOk $ X.mujoco {}
        [ Deformable.deformable {}
            [ Skin.skin { name: "sk1", vertex: [ 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0 ], face: [ 0, 1, 2 ] }
                [ Skin.bone { body: "world", bindpos: 0.0 /\ 0.0 /\ 0.0, bindquat: 1.0 /\ 0.0 /\ 0.0 /\ 0.0, vertid: [ 0, 1, 2 ], vertweight: [ 1.0, 1.0, 1.0 ] } ]
            ]
        , X.worldbody {} unit
        ]

      it "inflate + rgba" $ parseOk $ X.mujoco {}
        [ Deformable.deformable {}
            [ Skin.skin { name: "sk2", vertex: [ 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0 ], face: [ 0, 1, 2 ], inflate: 0.01, rgba: 0.5 /\ 0.5 /\ 1.0 /\ 0.8 }
                [ Skin.bone { body: "world", bindpos: 0.0 /\ 0.0 /\ 0.0, bindquat: 1.0 /\ 0.0 /\ 0.0 /\ 0.0, vertid: [ 0, 1, 2 ], vertweight: [ 1.0, 1.0, 1.0 ] } ]
            ]
        , X.worldbody {} unit
        ]
