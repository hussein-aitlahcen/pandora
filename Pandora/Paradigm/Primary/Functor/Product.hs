module Pandora.Paradigm.Primary.Functor.Product where

import Pandora.Pattern.Functor.Covariant (Covariant ((<$>)))
import Pandora.Pattern.Functor.Extractable (Extractable (extract))
import Pandora.Pattern.Functor.Traversable (Traversable ((->>)))
import Pandora.Pattern.Functor.Extendable (Extendable ((=>>)))
import Pandora.Pattern.Functor.Comonad (Comonad)
import Pandora.Pattern.Functor.Bivariant (Bivariant ((<->)))
import Pandora.Pattern.Object.Setoid (Setoid ((==)))
import Pandora.Pattern.Object.Semigroup (Semigroup ((+)))
import Pandora.Pattern.Object.Monoid (Monoid (zero))
import Pandora.Pattern.Object.Ringoid (Ringoid ((*)))
import Pandora.Pattern.Object.Quasiring (Quasiring (one))
import Pandora.Pattern.Object.Semilattice (Infimum ((/\)), Supremum ((\/)))
import Pandora.Pattern.Object.Lattice (Lattice)
import Pandora.Pattern.Object.Group (Group (invert))

infixr 1 :*:

data Product s a = s :*: a

type (:*:) = Product

instance Covariant (Product s) where
	f <$> x = attached x :*: f (extract x)

instance Extractable (Product a) where
	extract ~(_ :*: y) = y

instance Traversable (Product s) where
	x ->> f = (attached x :*:) <$> f (extract x)

instance Extendable (Product s) where
	x =>> f = attached x :*: f (attached x :*: extract x)

instance Comonad (Product s) where

instance Bivariant Product where
	f <-> g = \ ~(s :*: x) -> f s :*: g x

instance (Setoid s, Setoid a) => Setoid (s :*: a) where
	x == y = (attached x == attached y) * (extract x == extract y)

instance (Semigroup s, Semigroup a) => Semigroup (s :*: a) where
	x + y = attached x + attached y :*: extract x + extract y

instance (Monoid s, Monoid a) => Monoid (s :*: a) where
	zero = zero :*: zero

instance (Ringoid s, Ringoid a) => Ringoid (s :*: a) where
	x * y = attached x * attached y :*: extract x * extract y

instance (Quasiring s, Quasiring a) => Quasiring (s :*: a) where
	one = one :*: one

instance (Infimum s, Infimum a) => Infimum (s :*: a) where
	x /\ y = attached x /\ attached y :*: extract x /\ extract y

instance (Supremum s, Supremum a) => Supremum (s :*: a) where
	x \/ y = attached x \/ attached y :*: extract x \/ extract y

instance (Lattice s, Lattice a) => Lattice (s :*: a) where

instance (Group s, Group a) => Group (s :*: a) where
	invert x = invert (attached x) :*: invert (extract x)

delta :: a -> a :*: a
delta x = x :*: x

swap :: a :*: b -> b :*: a
swap ~(x :*: y) = y :*: x

attached :: a :*: b -> a
attached ~(x :*: _) = x
