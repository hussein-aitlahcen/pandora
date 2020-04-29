module Pandora.Paradigm.Primary.Transformer.Construction (Construction (..), deconstruct, coiterate, section) where

import Pandora.Core.Functor (type (:.), type (:=), type (|->), type (~>))
import Pandora.Pattern.Category ((.))
import Pandora.Pattern.Functor.Covariant (Covariant ((<$>), (<$$>)))
import Pandora.Pattern.Functor.Avoidable (Avoidable (empty))
import Pandora.Pattern.Functor.Pointable (Pointable (point))
import Pandora.Pattern.Functor.Extractable (Extractable (extract))
import Pandora.Pattern.Functor.Alternative (Alternative ((<+>)))
import Pandora.Pattern.Functor.Applicative (Applicative ((<*>), (<**>)))
import Pandora.Pattern.Functor.Traversable (Traversable ((->>), (->>>)))
import Pandora.Pattern.Functor.Bindable (Bindable ((>>=)))
import Pandora.Pattern.Functor.Extendable (Extendable ((=>>), extend))
import Pandora.Pattern.Functor.Monad (Monad)
import Pandora.Pattern.Functor.Comonad (Comonad)
import Pandora.Pattern.Transformer.Lowerable (Lowerable (lower))
import Pandora.Pattern.Functor.Divariant (($))
import Pandora.Pattern.Object.Setoid (Setoid ((==)))
import Pandora.Pattern.Object.Semigroup (Semigroup ((+)))
import Pandora.Pattern.Object.Ringoid ((*))
import Pandora.Pattern.Object.Monoid (Monoid (zero))
import Pandora.Paradigm.Controlflow.Joint.Schemes.TU (TU (TU))

data Construction t a = Construction a (t :. Construction t := a)

instance Covariant t => Covariant (Construction t) where
	f <$> Construction x xs = Construction (f x) $ f <$$> xs

instance Avoidable t => Pointable (Construction t) where
	point x = Construction x empty

instance Covariant t => Extractable (Construction t) where
	extract (Construction x _) = x

instance Applicative t => Applicative (Construction t) where
	Construction f fs <*> Construction x xs = Construction (f x) $ fs <**> xs

instance Traversable t => Traversable (Construction t) where
	Construction x xs ->> f = Construction <$> f x <*> xs ->>> f

instance Alternative t => Bindable (Construction t) where
	Construction x xs >>= f = case f x of Construction y ys -> Construction y $ ys <+> (>>= f) <$> xs

instance Covariant t => Extendable (Construction t) where
	x =>> f = Construction (f x) $ extend f <$> deconstruct x

instance (Avoidable t, Alternative t) => Monad (Construction t) where

instance Covariant t => Comonad (Construction t) where

instance Lowerable Construction where
	lower (Construction _ xs) = extract <$> xs

instance (Setoid a, forall b . Setoid b => Setoid (t b)) => Setoid (Construction t a) where
	Construction x xs == Construction y ys = (x == y) * (xs == ys)

instance (Semigroup a, forall b . Semigroup b => Semigroup (t b)) => Semigroup (Construction t a) where
	Construction x xs + Construction y ys = Construction (x + y) $ xs + ys

instance (Monoid a, forall b . Semigroup b => Monoid (t b)) => Monoid (Construction t a) where
	zero = Construction zero zero

deconstruct :: Construction t a -> (t :. Construction t) a
deconstruct (Construction _ xs) = xs

coiterate :: Covariant t => a |-> t -> a |-> Construction t
coiterate coalgebra x = Construction x $ coiterate coalgebra <$> coalgebra x

section :: Comonad t => t ~> Construction t
section as = Construction (extract as) $ extend section as

instance (Covariant t, Covariant u) => Covariant (TU Covariant Covariant u (Construction t)) where
	f <$> TU g = TU $ f <$$> g

instance (Avoidable t, Pointable u) => Pointable (TU Covariant Covariant u (Construction t)) where
	point x = TU . point . Construction x $ empty

instance (Applicative t, Applicative u) => Applicative (TU Covariant Covariant u (Construction t)) where
	TU f <*> TU x = TU $ f <**> x

instance (Covariant t, Alternative u) => Alternative (TU Covariant Covariant u (Construction t)) where
	TU x <+> TU y = TU $ x <+> y

instance (Covariant t, Avoidable u) => Avoidable (TU Covariant Covariant u (Construction t)) where
	empty = TU empty

instance (Traversable t, Traversable u) => Traversable (TU Covariant Covariant u (Construction t)) where
	TU g ->> f = TU <$> g ->>> f
