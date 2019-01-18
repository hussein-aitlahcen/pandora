module Paradigm.Basis.Functor.Composition (U (..), UU (..), UUU (..)) where

import Core.Composition ((:.:))
import Core.Morphism ((.), ($))
import Core.Variant (Variant (Co, Contra))
import Pattern.Functor.Covariant (Covariant ((<$>), comap))
import Pattern.Functor.Contravariant (Contravariant ((>$<), contramap))
import Pattern.Functor.Extractable (Extractable (extract))
import Pattern.Functor.Exclusive (Exclusive (exclusive))
import Pattern.Functor.Pointable (Pointable (point))
import Pattern.Functor.Alternative (Alternative ((<+>)))
import Pattern.Functor.Applicative (Applicative ((<*>), apply))
import Pattern.Functor.Adjoint (Adjoint (phi, psi))

type (:-|:) t u = (Extractable t, Pointable t, Extractable u, Pointable u, Adjoint t u)

newtype U ct cu t u a = U { u :: (t :.: u) a }

instance (Covariant t, Covariant u) => Covariant (U Co Co t u) where
	f <$> U x = U $ (comap . comap) f x

instance (Covariant t, Contravariant u) => Contravariant (U Co Contra t u) where
	f >$< U x = U $ contramap f <$> x

instance (Contravariant t, Covariant u) => Contravariant (U Contra Co t u) where
	f >$< U x = U $ contramap (comap f) x

instance (Contravariant t, Contravariant u) => Covariant (U Contra Contra t u) where
	f <$> U x = U $ contramap (contramap f) x

instance (Applicative t, Applicative u) => Applicative (U Co Co t u) where
	U f <*> U x = U $ apply <$> f <*> x

instance (Alternative t, Covariant u) => Alternative (U Co Co t u) where
	U x <+> U y = U $ x <+> y

instance (Exclusive t, Covariant u) => Exclusive (U Co Co t u) where
	exclusive = U exclusive

instance (Pointable t, Pointable u) => Pointable (U Co Co t u) where
	point = U . point . point

instance (Extractable t, Extractable u) => Extractable (U Co Co t u) where
	extract = extract . extract . u

instance (t :-|: u, v :-|: w) => Adjoint (U Co Co t v) (U Co Co u w) where
	phi f = point . f . point
	psi f = extract . extract . comap f


newtype UU ct cu cv t u v a = UU { uu :: (t :.: u :.: v) a }

instance (Covariant t, Covariant u, Covariant v) => Covariant (UU Co Co Co t u v) where
	f <$> UU x = UU $ (comap . comap . comap) f x

instance (Covariant t, Covariant u, Contravariant v) => Contravariant (UU Co Co Contra t u v) where
	f >$< UU x = UU $ (comap . comap) (contramap f) x

instance (Covariant t, Contravariant u, Covariant v) => Contravariant (UU Co Contra Co t u v) where
	f >$< UU x = UU $ contramap (comap f) <$> x

instance (Contravariant t, Covariant u, Covariant v) => Contravariant (UU Contra Co Co t u v) where
	f >$< UU x = UU $ comap (comap f) >$< x

instance (Contravariant t, Contravariant u, Covariant v) => Covariant (UU Contra Contra Co t u v) where
	f <$> UU x = UU $ contramap (comap f) >$< x

instance (Covariant t, Contravariant u, Contravariant v) => Covariant (UU Co Contra Contra t u v) where
	f <$> UU x = UU $ contramap (contramap f) <$> x

instance (Contravariant t, Covariant u, Contravariant v) => Covariant (UU Contra Co Contra t u v) where
	f <$> UU x = UU $ comap (contramap f) >$< x

instance (Contravariant t, Contravariant u, Contravariant v) => Contravariant (UU Contra Contra Contra t u v) where
	f >$< UU x = UU $ (contramap . contramap . contramap) f x

instance (Applicative t, Applicative u, Applicative v) => Applicative (UU Co Co Co t u v) where
	UU f <*> UU x = UU $ (comap apply . (comap . comap) apply $ f) <*> x

instance (Alternative t, Covariant u, Covariant v) => Alternative (UU Co Co Co t u v) where
	UU x <+> UU y = UU $ x <+> y

instance (Exclusive t, Covariant u, Covariant v) => Exclusive (UU Co Co Co t u v) where
	exclusive = UU exclusive

instance (Pointable t, Pointable u, Pointable v) => Pointable (UU Co Co Co t u v) where
	point = UU . point . point . point

instance (Extractable t, Extractable u, Extractable v) => Extractable (UU Co Co Co t u v) where
	extract = extract . extract . extract . uu

instance (t :-|: w, v :-|: x, u :-|: y) => Adjoint (UU Co Co Co t v u) (UU Co Co Co w x y) where
	phi f = point . f . point
	psi f = extract . extract . comap f


newtype UUU ct cu cv cw t u v w a = UUU { uuu :: (t :.: u :.: v :.: w) a }

instance (Covariant t, Covariant u, Covariant v, Covariant w) => Covariant (UUU Co Co Co Co t u v w) where
	f <$> UUU x = UUU $ (comap . comap . comap . comap) f x

instance (Covariant t, Covariant u, Covariant v, Contravariant w) => Contravariant (UUU Co Co Co Contra t u v w) where
	f >$< UUU x = UUU $ (comap . comap . comap) (contramap f) x

instance (Covariant t, Covariant u, Contravariant v, Covariant w) => Contravariant (UUU Co Co Contra Co t u v w) where
	f >$< UUU x = UUU $ (comap . comap) (contramap (comap f)) x

instance (Covariant t, Contravariant u, Covariant v, Covariant w) => Contravariant (UUU Co Contra Co Co t u v w) where
	f >$< UUU x = UUU $ (contramap (comap (comap f))) <$> x

instance (Contravariant t, Covariant u, Covariant v, Covariant w) => Contravariant (UUU Contra Co Co Co t u v w) where
	f >$< UUU x = UUU $ comap (comap (comap f)) >$< x

instance (Contravariant t, Contravariant u, Covariant v, Covariant w) => Covariant (UUU Contra Contra Co Co t u v w) where
	f <$> UUU x = UUU $ (contramap . contramap . comap . comap $ f) x

instance (Covariant t, Contravariant u, Contravariant v, Covariant w) => Covariant (UUU Co Contra Contra Co t u v w) where
	f <$> UUU x = UUU $ (comap . contramap . contramap . comap $ f) x

instance (Covariant t, Covariant u, Contravariant v, Contravariant w) => Covariant (UUU Co Co Contra Contra t u v w) where
	f <$> UUU x = UUU $ (comap . comap) (contramap . contramap $ f) x

instance (Covariant t, Contravariant u, Covariant v, Contravariant w) => Covariant (UUU Co Contra Co Contra t u v w) where
	f <$> UUU x = UUU $ (comap . contramap . comap . contramap $ f) x

instance (Contravariant t, Covariant u, Contravariant v, Covariant w) => Covariant (UUU Contra Co Contra Co t u v w) where
	f <$> UUU x = UUU $ (contramap . comap . contramap . comap $ f) x

instance (Contravariant t, Covariant u, Covariant v, Contravariant w) => Covariant (UUU Contra Co Co Contra t u v w) where
	f <$> UUU x = UUU $ (contramap . comap . comap . contramap $ f) x

instance (Contravariant t, Contravariant u, Contravariant v, Covariant w) => Contravariant (UUU Contra Contra Contra Co t u v w) where
	f >$< UUU x = UUU $ (contramap . contramap . contramap . comap) f x

instance (Covariant t, Contravariant u, Contravariant v, Contravariant w) => Contravariant (UUU Co Contra Contra Contra t u v w) where
	f >$< UUU x = UUU $ (comap . contramap . contramap . contramap) f x

instance (Contravariant t, Covariant u, Contravariant v, Contravariant w) => Contravariant (UUU Contra Co Contra Contra t u v w) where
	f >$< UUU x = UUU $ (contramap . comap . contramap . contramap) f x

instance (Contravariant t, Contravariant u, Covariant v, Contravariant w) => Contravariant (UUU Contra Contra Co Contra t u v w) where
	f >$< UUU x = UUU $ (contramap . contramap . comap . contramap) f x

instance (Contravariant t, Contravariant u, Contravariant v, Contravariant w) => Covariant (UUU Contra Contra Contra Contra t u v w) where
	f <$> UUU x = UUU $ (contramap . contramap . contramap . contramap) f x

instance (Applicative t, Applicative u, Applicative v, Applicative w) => Applicative (UUU Co Co Co Co t u v w) where
	UUU f <*> UUU x = UUU $ (comap apply . (comap . comap) apply . (comap . comap . comap) apply $ f) <*> x

instance (Alternative t, Covariant u, Covariant v, Covariant w) => Alternative (UUU Co Co Co Co t u v w) where
	UUU x <+> UUU y = UUU $ x <+> y

instance (Exclusive t, Covariant u, Covariant v, Covariant w) => Exclusive (UUU Co Co Co Co t u v w) where
	exclusive = UUU exclusive

instance (Pointable t, Pointable u, Pointable v, Pointable w) => Pointable (UUU Co Co Co Co t u v w) where
	point = UUU . point . point . point . point

instance (Extractable t, Extractable u, Extractable v, Extractable w) => Extractable (UUU Co Co Co Co t u v w) where
	extract = extract . extract . extract . extract . uuu

instance (t :-|: u, v :-|: w, q :-|: q, r :-|: s) => Adjoint (UUU Co Co Co Co t v q r) (UUU Co Co Co Co u w q s) where
	phi f = point . f . point
	psi f = extract . extract . comap f