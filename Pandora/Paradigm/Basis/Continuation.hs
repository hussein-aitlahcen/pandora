module Pandora.Paradigm.Basis.Continuation (Continuation (..), oblige, cwcc, reset, shift) where

import Pandora.Core.Morphism ((.), ($), (!), (?))
import Pandora.Pattern.Functor.Covariant (Covariant ((<$>)))
import Pandora.Pattern.Functor.Pointable (Pointable (point))
import Pandora.Pattern.Functor.Applicative (Applicative ((<*>)))
import Pandora.Pattern.Functor.Bindable (Bindable ((>>=)))
import Pandora.Pattern.Functor.Monad (Monad)

newtype Continuation r t a = Continuation { continue :: (a -> t r) -> t r }

instance Covariant t => Covariant (Continuation r t) where
	f <$> Continuation continuation = Continuation $ continuation . (. f)

instance Covariant t => Pointable (Continuation r t) where
	point x = Continuation ($ x)

instance Covariant t => Applicative (Continuation r t) where
	f <*> x = Continuation $ \h -> continue f $ \g -> continue x (h . g)

instance Covariant t => Bindable (Continuation r t) where
	x >>= f = Continuation $ \g -> continue x $ \y -> continue (f y) g

instance Monad t => Monad (Continuation r t) where

-- | Make any bindable action continue
oblige :: Bindable t => t a -> Continuation r t a
oblige x = Continuation (x >>=)

-- | Call with current continuation
cwcc :: ((a -> Continuation r t b) -> Continuation r t a) -> Continuation r t a
cwcc f = Continuation $ \g -> continue ? g . f $ Continuation . (!) . g

-- | Delimit the continuation of any 'shift'
reset :: (Bindable t, Pointable t) => Continuation r t r -> Continuation s t r
reset = oblige . continue ? point

-- | Capture the continuation up to the nearest enclosing 'reset' and pass it
shift :: Pointable t => ((a -> t r) -> Continuation r t r) -> Continuation r t a
shift f = Continuation $ continue ? point . f
