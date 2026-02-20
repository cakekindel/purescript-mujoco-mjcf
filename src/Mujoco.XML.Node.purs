module Mujoco.XML.Node
  ( Node
  , render
  , tag
  , tagNoContent
  , class Children
  , asChildren
  , fragment
  , empty
  , text
  , Tag
  , TagNoContent
  ) where

import Prelude

import Data.FoldableWithIndex (foldlWithIndex)
import Data.Map (Map)
import Data.Map as Map
import Data.String as String
import Data.Tuple as Tuple
import Data.Tuple.Nested ((/\))
import Elmish.HTML (empty, fragment, text) as HTML
import Elmish.HTML.Internal (tag, tagNoContent) as HTML
import Elmish.React (ReactElement)
import Mujoco.XML.Node.Prop (class SerializeProps', serializeProps)
import Mujoco.XML.Node.Prop as Prop
import Prim.Row (class Union)
import Prim.RowList (class RowToList)
import Unsafe.Coerce (unsafeCoerce)

unrenames :: Map String String
unrenames =
  let
    props = Map.fromFoldable $ map Tuple.swap $ (Map.toUnfoldable Prop.renames :: Array _)
    tags = Map.fromFoldable ["mjcf:option" /\ "option"]
  in
    Map.union props tags

foreign import renderToString :: ReactElement -> String

type Tag props
   = forall r missing a propsrl
   . Children a
  => Union r missing props
  => RowToList props propsrl
  => SerializeProps' props propsrl
  => Record r
  -> a
  -> Node

type TagNoContent props
   = forall r missing propsrl
   . Union r missing props
  => RowToList props propsrl
  => SerializeProps' props propsrl
  => Record r
  -> Node

foreign import data Node :: Type

render :: Node -> String
render =
  let
    unrename str =
      foldlWithIndex unrename' str unrenames

    unrename' from str to =
      String.replaceAll (String.Pattern from) (String.Replacement to) str
  in
    unrename <<< renderToString <<< toReact

fromReact :: ReactElement -> Node
fromReact = unsafeCoerce

toReact :: Node -> ReactElement
toReact = unsafeCoerce

tag
  :: forall @props propsrl
   . RowToList props propsrl
  => SerializeProps' props propsrl
  => String
  -> ( forall r missing a.
        Union r missing props
     => Children a
     => Record r
     -> a
     -> Node
     )
tag el p a = fromReact $ HTML.tag el (serializeProps @props p) $ toReact <$> asChildren a

tagNoContent
  :: forall @props propsrl
   . RowToList props propsrl
  => SerializeProps' props propsrl
  => String
  -> ( forall r missing.
        Union r missing props
     => Record r
     -> Node
     )
tagNoContent el p = fromReact $ HTML.tagNoContent el (serializeProps @props p)

fragment :: Array Node -> Node
fragment = fromReact <<< HTML.fragment <<< map toReact

empty :: Node
empty = fromReact HTML.empty

text :: String -> Node
text = fromReact <<< HTML.text

class Children a where
  asChildren :: a -> Array Node

instance Children (Array Node) where asChildren = identity
instance Children String where asChildren s = [ unsafeCoerce s ]
instance Children Node where asChildren e = [ e ]
instance Children Unit where asChildren _ = []
