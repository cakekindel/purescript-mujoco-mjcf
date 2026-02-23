module Test.Mujoco.MJCF.Util where

import Prelude

import Control.Monad.Error.Class (class MonadError, class MonadThrow, try)
import Control.Monad.Reader (class MonadAsk, class MonadReader, ReaderT, ask, runReaderT)
import Control.Promise as Promise
import Data.Either (isLeft)
import Data.Identity (Identity)
import Data.Newtype (class Newtype, unwrap)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff, liftAff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Exception (Error)
import Mujoco.MJCF as X
import Mujoco.MJCF.XML (Node)
import Mujoco.MJCF.XML as XML
import Mujoco.Wasm (Mujoco)
import Mujoco.Wasm as Mj
import Test.Assert (assertTrue)
import Test.Spec (SpecT, Spec, hoistSpec)

newtype T a = T (ReaderT Mujoco Aff a)
derive instance Newtype (T a) _
derive newtype instance Functor T
derive newtype instance Applicative T
derive newtype instance Apply T
derive newtype instance Bind T
derive newtype instance Monad T
derive newtype instance MonadReader Mujoco T
derive newtype instance MonadAsk Mujoco T
derive newtype instance MonadEffect T
derive newtype instance MonadAff T
derive newtype instance MonadThrow Error T
derive newtype instance MonadError Error T

type MjcfSpec a = SpecT T Unit Identity a

mjcf :: forall a. MjcfSpec a -> Spec a
mjcf = hoistSpec identity (\_ -> runT)

runT :: forall a. T a -> Aff a
runT m = do
  mj <- liftAff $ Promise.toAffE Mj.loadMujoco
  runReaderT (unwrap m) mj

renderSpec :: XML.Node -> T Mj.Spec
renderSpec node = do
  mj <- ask
  liftEffect $ Mj.parseXMLString mj $ XML.render node

parseOk :: XML.Node -> T Unit
parseOk = void <<< renderSpec

parseFail :: XML.Node -> T Unit
parseFail = (liftEffect <<< assertTrue <<< isLeft) <=< (try <<< renderSpec)

w :: forall a. XML.Children a => a -> Node
w = X.mujoco {} <<< X.worldbody {}
