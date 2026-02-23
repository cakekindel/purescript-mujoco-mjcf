module Test.Mujoco.MJCF.XML.Prop where

import Prelude

import Data.Tuple.Nested (type (/\), (/\))
import Mujoco.MJCF.XML.Prop (class SerializeProps', serialize, serializeProps)
import Prim.Row (class Union)
import Prim.RowList (class RowToList)
import Test.Mujoco.MJCF.Util (MjcfSpec)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Unsafe.Coerce (unsafeCoerce)

type Props =
  ( int :: Int
  , string :: String
  , array :: Array Int
  , array2 :: Array (Array Int)
  , tuple :: Int /\ Int
  , tuple3 :: Int /\ Int /\ Int
  , bool :: Boolean
  )

spec :: MjcfSpec Unit
spec =
  describe "Mujoco.MJCF.XML.Prop" do
    describe "Serialize" do
      it "serializes boolean" $ serialize true `shouldEqual` "true"
      it "serializes string" $ serialize "a" `shouldEqual` "a"
      it "serializes array" $ serialize ["a", "b"] `shouldEqual` "a b"
      it "serializes nested array" $ serialize [["a", "b"], ["c"]] `shouldEqual` "a b c"
      it "serializes int" $ serialize 1 `shouldEqual` "1"
      it "serializes int array" $ serialize [1, 2] `shouldEqual` "1 2"
      it "serializes number array" $ serialize [1.0, 2.0] `shouldEqual` "1 2"
      it "serializes tuple" $ serialize (1 /\ 2) `shouldEqual` "1 2"
      it "serializes nested tuple" $ serialize (1 /\ 2 /\ 3) `shouldEqual` "1 2 3"
      it "serializes real(4)" $ serialize (1.0 /\ 1.0 /\ 0.5 /\ 0.1) `shouldEqual` "1 1 0.5 0.1"

    describe "SerializeProps" do
      let
        serializeProps'
          :: forall part missing propsrl x
           . RowToList Props propsrl
          => SerializeProps' Props propsrl
          => Union part missing Props
          => Record part
          -> Record x
        serializeProps' = unsafeCoerce <<< serializeProps @Props

      it "handles empty" $ serializeProps' {} `shouldEqual` {}
      it "handles int" $ serializeProps' { int: 1 } `shouldEqual` { int: "1" }
      it "handles string" $ serializeProps' { string: "a" } `shouldEqual` { string: "a" }
      it "handles array2" $ serializeProps' { array2: [[1, 2, 3], [4, 5]] } `shouldEqual` { array2: "1 2 3 4 5" }
