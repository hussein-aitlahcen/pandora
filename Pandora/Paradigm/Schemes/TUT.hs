module Pandora.Paradigm.Schemes.TUT where

import Pandora.Core.Functor (type (:.), type (:=), type (~>))
import Pandora.Pattern.Category (identity, ($))
import Pandora.Pattern.Functor.Covariant (Covariant)
import Pandora.Pattern.Functor.Contravariant (Contravariant)
import Pandora.Pattern.Functor.Distributive (Distributive ((>>-)))
import Pandora.Pattern.Functor.Adjoint (Adjoint ((-|), (|-)))
import Pandora.Pattern.Transformer.Liftable (Liftable (lift))
import Pandora.Pattern.Transformer.Lowerable (Lowerable (lower))
import Pandora.Paradigm.Controlflow.Effect.Interpreted (Interpreted (Primary, run))

newtype TUT ct ct' cu t t' u a = TUT (t :. u :. t' := a)

type (<:<.>:>) = TUT Covariant Covariant Covariant
type (>:<.>:>) = TUT Contravariant Covariant Covariant
type (<:<.>:<) = TUT Covariant Covariant Contravariant
type (>:<.>:<) = TUT Contravariant Covariant Contravariant
type (<:>.<:>) = TUT Covariant Contravariant Covariant
type (>:>.<:>) = TUT Contravariant Contravariant Covariant
type (<:>.<:<) = TUT Covariant Contravariant Contravariant
type (>:>.<:<) = TUT Contravariant Contravariant Contravariant

instance Interpreted (TUT ct ct' cu t t' u) where
	type Primary (TUT ct ct' cu t t' u) a = t :. u :. t' := a
	run ~(TUT x) = x

instance (Adjoint t' t, Distributive t) => Liftable (t <:<.>:> t') where
	lift :: Covariant u => u ~> t <:<.>:> t' := u
	lift x = TUT $ x >>- (-| identity)

instance (Adjoint t t', Distributive t') => Lowerable (t <:<.>:> t') where
	lower :: Covariant u => (t <:<.>:> t' := u) ~> u
	lower (TUT x) = x |- (>>- identity)
