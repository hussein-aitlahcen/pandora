module Pandora.Paradigm.Basis.Variation (Variation (..), variation) where

import Pandora.Core.Morphism (($))
import Pandora.Pattern.Functor.Covariant (Covariant ((<$>)))
import Pandora.Pattern.Functor.Pointable (Pointable (point))
import Pandora.Pattern.Functor.Traversable (Traversable ((->>)))

data Variation e a = This a | That e | These e a

instance Covariant (Variation e) where
	f <$> This x = This $ f x
	f <$> That y = That y
	f <$> These y x = These y (f x)

instance Pointable (Variation e) where
	point = This

instance Traversable (Variation e) where
	This x ->> f = This <$> f x
	That y ->> _ = point $ That y
	These y x ->> f = These y <$> f x

variation :: (a -> r) -> (e -> r) -> (e -> a -> r) -> Variation e a -> r
variation f _ _ (This x) = f x
variation _ g _ (That y) = g y
variation _ _ h (These y x) = h y x
