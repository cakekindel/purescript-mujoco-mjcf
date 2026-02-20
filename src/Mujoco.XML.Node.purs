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

import Elmish.HTML (empty, fragment, text) as HTML
import Elmish.HTML.Internal (tag, tagNoContent) as HTML
import Elmish.React (ReactElement)
import Elmish.React as React
import Mujoco.XML.Node.Prop (class SerializeProps', serializeProps)
import Prim.Row (class Union)
import Prim.RowList (class RowToList)
import Unsafe.Coerce (unsafeCoerce)

foreign import renderToString :: ReactElement -> String

type Tag props
   = forall r missing a propsrl
   . Children a
  => Union r missing props
  => React.ValidReactProps (Record r)
  => RowToList props propsrl
  => SerializeProps' props propsrl
  => Record r
  -> a
  -> Node

type TagNoContent props
   = forall r missing propsrl
   . Union r missing props
  => React.ValidReactProps (Record r)
  => RowToList props propsrl
  => SerializeProps' props propsrl
  => Record r
  -> Node

foreign import data Node :: Type

render :: Node -> String
render = renderToString <<< toReact

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
     => React.ValidReactProps (Record r)
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
     => React.ValidReactProps (Record r)
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
