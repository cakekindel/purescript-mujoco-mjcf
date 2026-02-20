module Mujoco.XML.Node.Prop (class Serialize, serialize, serializeProps, class SerializeProps', serializeProps', renames) where

import Prelude

import Data.Array as Array
import Data.Int as Int
import Data.Map (Map)
import Data.Map as Map
import Data.Maybe (fromMaybe)
import Data.Number.Format (toString) as Number
import Data.Symbol (class IsSymbol, reflectSymbol)
import Data.Tuple (Tuple)
import Data.Tuple.Nested ((/\))
import Prim.Row (class Cons, class Union)
import Prim.RowList (class RowToList, RowList)
import Prim.RowList as RL
import Record.Unsafe (unsafeSet, unsafeHas, unsafeGet) as Record
import Type.Prelude (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)

renames :: Map String String
renames = Map.fromFoldable ["size" /\ "mjcf:size"]

class Serialize a where
  serialize :: a -> String

instance Serialize String where
  serialize = identity
else instance Serialize Int where
  serialize = Int.toStringAs Int.decimal
else instance Serialize Number where
  serialize = Number.toString
else instance Serialize Boolean where
  serialize = show
else instance Serialize a => Serialize (Array a) where
  serialize = Array.intercalate " " <<< map serialize
else instance (Serialize a, Serialize b) => Serialize (Tuple a b) where
  serialize (a /\ b) = serialize [serialize a, serialize b]

serializeProps :: forall @props part missing propsrl. RowToList props propsrl => SerializeProps' props propsrl => Union part missing props => Record part -> {}
serializeProps =
  (unsafeCoerce :: Record props -> {})
  <<< serializeProps' @props @propsrl
  <<< (unsafeCoerce :: Record part -> Record props)

class SerializeProps' :: Row Type -> RowList Type -> Constraint
class SerializeProps' p prl | prl -> p where
  serializeProps' :: Record p -> Record p

instance
  ( IsSymbol k
  , RowToList p' prl'
  , RowToList p (RL.Cons k v prl')
  , Cons k v p' p
  , SerializeProps' p' prl'
  , Serialize v
  ) => SerializeProps' p (RL.Cons k v prl') where
  serializeProps' =
    patchUnsafe @k serialize
    <<< remember @k
    <<< serializeProps' @p' @prl'
    <<< forget @k
instance SerializeProps' () RL.Nil where
  serializeProps' = identity

patchUnsafe :: forall (@k :: Symbol) a b @r @lacksK. IsSymbol k => Cons k a lacksK r => (a -> b) -> Record r -> Record r
patchUnsafe f r =
  let
    k' = reflectSymbol $ Proxy @k

    k = fromMaybe k' $ Map.lookup k' renames

    btoa = unsafeCoerce :: b -> a
  in
    if Record.unsafeHas k' r then
      Record.unsafeSet k (btoa $ f $ Record.unsafeGet k' r) r
    else
      r

forget :: forall @k @r' @r a. Cons k a r' r => Record r -> Record r'
forget = unsafeCoerce

remember :: forall @k @r' @r a. Cons k a r' r => Record r' -> Record r
remember = unsafeCoerce
