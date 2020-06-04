{-# OPTIONS_GHC -fno-warn-orphans #-}

module Pandora.Paradigm.Structure.Rose where

import Pandora.Core.Functor (type (:.), type (:=))
import Pandora.Core.Morphism ((!), (%))
import Pandora.Pattern.Category ((.), ($))
import Pandora.Pattern.Functor.Covariant (Covariant ((<$>)))
import Pandora.Pattern.Functor.Extractable (extract)
import Pandora.Pattern.Functor.Avoidable (Avoidable (empty))
import Pandora.Pattern.Transformer.Liftable (lift)
import Pandora.Paradigm.Primary.Functor.Maybe (Maybe (Just, Nothing), maybe)
import Pandora.Paradigm.Primary.Functor.Product (Product ((:*:)))
import Pandora.Paradigm.Primary.Functor.Tagged (Tagged (Tag))
import Pandora.Paradigm.Primary.Transformer.Construction (Construction (Construct), deconstruct)
import Pandora.Paradigm.Schemes.TU (TU (TU), type (<:.>))
import Pandora.Paradigm.Controlflow.Effect.Interpreted (run)
import Pandora.Paradigm.Inventory.Store (Store (Store))
import Pandora.Paradigm.Structure.Stack (Stack)
import Pandora.Paradigm.Structure.Ability.Nonempty (Nonempty)
import Pandora.Paradigm.Structure.Ability.Focusable (Focusable (Focus, top, singleton))
import Pandora.Paradigm.Structure.Ability.Substructure (Substructure (Substructural, substructure))

type Rose = Maybe <:.> Construction Stack

instance Focusable Rose where
	type Focus Rose a = Maybe a
	top (TU Nothing) = Store $ Nothing :*: TU . (<$>) (Construct % empty)
	top (TU (Just x)) = Store $ Just (extract x) :*: maybe
		(lift x) -- TODO: Nothing at top's lens - should it remove something?
		(lift . Construct % deconstruct x)
	singleton = lift . Construct % empty

instance Substructure Just Rose where
	type Substructural Just Rose a = Stack :. Construction Stack := a
	substructure (run . extract -> Nothing) = Store $ TU Nothing :*: (Tag (TU Nothing) !)
	substructure (run . extract -> Just (Construct x xs)) = Store $ xs :*: Tag . lift . Construct x

type instance Nonempty Rose = Construction Stack

instance Substructure Just (Construction Stack) where
	type Substructural Just (Construction Stack) a = Stack :. Construction Stack := a
	substructure (Tag (Construct x xs)) = Store $ xs :*: Tag . Construct x

instance Focusable (Construction Stack) where
	type Focus (Construction Stack) a = a
	top rose = Store $ extract rose :*: Construct % deconstruct rose
	singleton = Construct % empty
