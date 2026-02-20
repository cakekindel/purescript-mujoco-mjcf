module Mujoco.Prelude (module X, Real, Vec, Vec4, Vec5) where

import Prelude (class Applicative, class Apply, class Bind, class BooleanAlgebra, class Bounded, class Category, class CommutativeRing, class Discard, class DivisionRing, class Eq, class EuclideanRing, class Field, class Functor, class HeytingAlgebra, class Monad, class Monoid, class Ord, class Ring, class Semigroup, class Semigroupoid, class Semiring, class Show, type (~>), Ordering(..), Unit, Void, absurd, add, ap, append, apply, between, bind, bottom, clamp, compare, comparing, compose, conj, const, degree, discard, disj, div, eq, flap, flip, gcd, identity, ifM, join, lcm, liftA1, liftM1, map, max, mempty, min, mod, mul, negate, not, notEq, one, otherwise, pure, recip, show, sub, top, unit, unless, unlessM, void, when, whenM, zero, (#), ($), ($>), (&&), (*), (*>), (+), (-), (/), (/=), (<), (<#>), (<$), (<$>), (<*), (<*>), (<<<), (<=), (<=<), (<>), (<@>), (=<<), (==), (>), (>=), (>=>), (>>=), (>>>), (||)) as X
import Mujoco.XML.Node
  ( tag
  , tagNoContent
  , Tag
  , TagNoContent
  ) as X

import Mujoco.XML.Node.Prop (class Serialize, serialize) as X

import Data.Tuple (Tuple(..)) as X
import Data.Tuple.Nested (type (/\), (/\)) as X
import Data.Tuple.Nested (type (/\))
import Data.Maybe (Maybe(..), maybe, fromMaybe) as X

type Real = Number
type Vec a = a /\ a /\ a
type Vec4 a = a /\ a /\ a /\ a
type Vec5 a = a /\ a /\ a /\ a /\ a
