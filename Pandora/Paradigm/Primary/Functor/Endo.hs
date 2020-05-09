module Pandora.Paradigm.Primary.Functor.Endo (Endo (..)) where

import Pandora.Pattern.Category (identity, (.))
import Pandora.Pattern.Functor.Invariant (Invariant (invmap))
import Pandora.Pattern.Object.Semigroup (Semigroup ((+)))
import Pandora.Pattern.Object.Monoid (Monoid (zero))

newtype Endo a = Endo { endo :: a -> a }

instance Invariant Endo where
	invmap f g (Endo x) = Endo (f . x . g)

instance Semigroup (Endo a) where
	Endo f + Endo g = Endo (g . f)

instance Monoid (Endo a) where
	zero = Endo identity