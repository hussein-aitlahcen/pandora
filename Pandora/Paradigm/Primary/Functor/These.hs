module Pandora.Paradigm.Primary.Functor.These where

import Pandora.Pattern.Category (($))
import Pandora.Pattern.Functor.Covariant (Covariant ((<$>)))
import Pandora.Pattern.Functor.Pointable (Pointable (point))
import Pandora.Pattern.Functor.Traversable (Traversable ((->>)))

data These e a = This a | That e | These e a

instance Covariant (These e) where
	f <$> This x = This $ f x
	_ <$> That y = That y
	f <$> These y x = These y $ f x

instance Pointable (These e) where
	point = This

instance Traversable (These e) where
	This x ->> f = This <$> f x
	That y ->> _ = point $ That y
	These y x ->> f = These y <$> f x

these :: (a -> r) -> (e -> r) -> (e -> a -> r) -> These e a -> r
these f _ _ (This x) = f x
these _ g _ (That y) = g y
these _ _ h (These y x) = h y x
