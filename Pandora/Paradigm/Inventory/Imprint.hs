{-# OPTIONS_GHC -fno-warn-orphans #-}

module Pandora.Paradigm.Inventory.Imprint (Imprint (..), Traceable) where

import Pandora.Pattern.Category ((.), ($))
import Pandora.Pattern.Functor.Covariant (Covariant ((<$>), (<$$>)))
import Pandora.Pattern.Functor.Extractable (Extractable (extract))
import Pandora.Pattern.Functor.Applicative (Applicative ((<*>), (<**>)))
import Pandora.Pattern.Functor.Distributive (Distributive ((>>-)))
import Pandora.Pattern.Functor.Extendable (Extendable ((=>>)))
import Pandora.Pattern.Functor.Comonad (Comonad)
import Pandora.Pattern.Object.Monoid (Monoid (zero))
import Pandora.Pattern.Object.Semigroup (Semigroup ((+)))
import Pandora.Paradigm.Controlflow.Effect.Interpreted (Schematic, Interpreted (Primary, run))
import Pandora.Paradigm.Controlflow.Effect.Transformer.Comonadic (Comonadic (bring), (:<) (TC))
import Pandora.Paradigm.Controlflow.Effect.Adaptable (Adaptable)
import Pandora.Paradigm.Schemes.UT (UT (UT), type (<.:>))

newtype Imprint e a = Imprint (e -> a)

instance Covariant (Imprint e) where
	f <$> Imprint x = Imprint $ f . x

instance Distributive (Imprint e) where
	g >>- f = Imprint $ g >>- (run <$> f)

instance Monoid e => Extractable (Imprint e) where
	extract (Imprint x) = x zero

instance Semigroup e => Extendable (Imprint e) where
	Imprint x =>> f = Imprint $ \e -> f $ Imprint $ x . (e +)

instance Interpreted (Imprint e) where
	type Primary (Imprint e) a = (->) e a
	run ~(Imprint x) = x

type instance Schematic Comonad (Imprint e) = (<.:>) ((->) e)

instance Monoid e => Comonadic (Imprint e) where
	bring (TC (UT x)) = Imprint . extract $ x

instance Covariant u => Covariant ((->) e <.:> u) where
	f <$> UT x = UT $ f <$$> x

instance Applicative u => Applicative ((->) e <.:> u) where
	UT f <*> UT x = UT $ f <**> x

instance (Monoid e, Extractable u) => Extractable ((->) e <.:> u) where
	extract (UT x) = extract . extract $ x

instance (Semigroup e, Extendable u) => Extendable ((->) e <.:> u) where
	UT x =>> f = UT $ x =>> (\x' e -> f . UT . (<$>) (. (e +)) $ x')

type Traceable e t = Adaptable t (Imprint e)
