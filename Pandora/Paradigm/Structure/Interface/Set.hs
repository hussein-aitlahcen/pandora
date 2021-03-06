module Pandora.Paradigm.Structure.Interface.Set where

import Pandora.Core.Morphism ((!), (%))
import Pandora.Pattern.Category ((.), ($))
import Pandora.Pattern.Functor.Traversable (Traversable ((->>)))
import Pandora.Pattern.Object.Setoid (Setoid ((/=)))
import Pandora.Pattern.Object.Semigroup ((+))
import Pandora.Pattern.Object.Quasiring (one)
import Pandora.Paradigm.Primary.Functor.Maybe (Maybe (Nothing))
import Pandora.Paradigm.Primary.Functor.Predicate (equate)
import Pandora.Paradigm.Primary.Functor.Product (attached)
import Pandora.Paradigm.Primary.Object.Boolean (Boolean (True, False))
import Pandora.Paradigm.Primary.Object.Natural (Natural (Zero))
import Pandora.Paradigm.Structure.Ability.Monotonic (Monotonic (reduce), find)
import Pandora.Paradigm.Inventory.State (State, modify)
import Pandora.Paradigm.Controlflow.Effect (run)

member :: forall e a . (Setoid a, Monotonic e a) => a -> e -> Boolean
member x = reduce @(Maybe a) @a (\_ _ -> True) False . find (equate x)

subset :: (Monotonic (t a) a, Traversable t, Setoid a, Setoid (t a)) => t a -> t a -> Boolean
subset ss s = Nothing /= (ss ->> find % s . equate)

cardinality :: Traversable t => t a -> Natural
cardinality s = attached . run @(State _) % Zero $ s ->> (!) (modify @Natural (+ one))
