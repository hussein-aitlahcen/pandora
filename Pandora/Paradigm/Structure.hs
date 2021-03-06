{-# OPTIONS_GHC -fno-warn-orphans #-}

module Pandora.Paradigm.Structure (module Exports) where

import Pandora.Paradigm.Structure.Ability as Exports
import Pandora.Paradigm.Structure.Interface as Exports
import Pandora.Paradigm.Structure.Rose as Exports
import Pandora.Paradigm.Structure.Splay as Exports
import Pandora.Paradigm.Structure.Binary as Exports
import Pandora.Paradigm.Structure.Stack as Exports
import Pandora.Paradigm.Structure.Stream as Exports

import Pandora.Pattern (($), (.), extract)
import Pandora.Paradigm.Controlflow.Effect.Interpreted (run)
import Pandora.Paradigm.Inventory (Store (Store), (^.), (.~))
import Pandora.Paradigm.Primary.Functor.Delta (Delta ((:^:)))
import Pandora.Paradigm.Primary.Functor.Product (Product ((:*:)), type (:*:), attached)
import Pandora.Paradigm.Primary.Functor.Tagged (Tagged (Tag))
import Pandora.Paradigm.Primary.Functor.Wye (Wye (Left, Right))
import Pandora.Paradigm.Primary.Transformer.Tap (Tap (Tap))
import Pandora.Paradigm.Schemes.TU (type (<:.>))

instance Monotonic a s => Monotonic (s :*: a) s where
	reduce f r x = reduce f (f (attached x) r) $ extract x

instance Substructure Left (Product s) where
	type Substructural Left (Product s) a = s
	substructure (extract -> s :*: x) = Store $ s :*: Tag . (:*: x)

instance Substructure Right (Product s) where
	type Substructural Right (Product s) a = a
	substructure (extract -> s :*: x) = Store $ x :*: Tag . (s :*:)

instance Substructure Left Delta where
	type Substructural Left Delta a = a
	substructure (extract -> l :^: r) = Store $ l :*: Tag . (:^: r)

instance Substructure Right Delta where
	type Substructural Right Delta a = a
	substructure (extract -> l :^: r) = Store $ r :*: Tag . (l :^:)

instance Substructure Left t => Substructure Left (Tap (t <:.> u)) where
	type Substructural Left (Tap (t <:.> u)) a = Substructural Left t (u a)
	substructure (extract -> Tap x xs) = Store $
		sub @Left ^. run xs :*: Tag . (\new -> sub @Left .~ new $ Tap x xs)

instance Substructure Right t => Substructure Right (Tap (t <:.> u)) where
	type Substructural Right (Tap (t <:.> u)) a = Substructural Right t (u a)
	substructure (extract -> Tap x xs) = Store $
		sub @Right ^. run xs :*: Tag . (\new -> sub @Right .~ new $ Tap x xs)
