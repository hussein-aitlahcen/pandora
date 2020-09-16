{-# LANGUAGE UndecidableInstances #-}

module Pandora.Paradigm.Controlflow.Effect.Adaptable (Adaptable (..)) where

import Pandora.Core.Functor (type (~>))
import Pandora.Pattern.Category (identity, (.))
import Pandora.Pattern.Functor.Covariant (Covariant)
import Pandora.Pattern.Functor.Pointable (Pointable)
import Pandora.Pattern.Functor.Extractable (Extractable)
import Pandora.Pattern.Functor.Comonad (Comonad)
import Pandora.Pattern.Functor.Monad (Monad)
import Pandora.Pattern.Transformer (Liftable (lift), Lowerable (lower), Hoistable (hoist))
import Pandora.Paradigm.Controlflow.Effect.Interpreted (Schematic)
import Pandora.Paradigm.Controlflow.Effect.Transformer (Transformer, wrap, bring, (:>), (:<))

class Adaptable t u where
	{-# MINIMAL adapt #-}
	adapt :: t ~> u

type Lifting t u = (Transformer Monad t, Liftable (Schematic Monad t), Covariant u)
type Wrappable t u = (Transformer Monad t, Pointable u)
type Lowering t u = (Transformer Comonad t, Lowerable (Schematic Comonad t), Covariant u)
type Bringable t u = (Transformer Comonad t, Extractable u)

instance Covariant t => Adaptable t t where
	adapt = identity

instance (Covariant (t :> u), Lifting t u) => Adaptable u (t :> u) where
	adapt = lift

instance (Covariant (t :> u), Wrappable t u) => Adaptable t (t :> u) where
	adapt = wrap

instance (Covariant (t :> u), Lowering t u) => Adaptable (t :< u) u where
	adapt = lower

instance (Covariant (t :< u), Bringable t u) => Adaptable (t :< u) t where
	adapt = bring

instance
	( Covariant (t :> u :> v)
	, Transformer Monad t
	, Liftable (Schematic Monad t)
	, Covariant (Schematic Monad u v)
	, Wrappable u v
	) => Adaptable u (t :> u :> v) where
	adapt = lift . wrap

instance
	( Covariant (t :> u :> v)
	, Lifting t (Schematic Monad u v)
	, Lifting u v
	) => Adaptable v (t :> u :> v) where
	adapt = lift . lift

instance
	( Covariant (t :< u :< v)
	, Lowering t (Schematic Comonad u v)
	, Bringable u v
	) => Adaptable (t :< u :< v) u where
	adapt = bring . lower

instance
	( Covariant (t :< u :< v)
	, Lowering t (Schematic Comonad u v)
	, Lowering u v
	) => Adaptable (t :< u :< v) v where
	adapt = lower . lower

instance
	( Covariant (t :> u :> v :> w)
	, Liftable (Schematic Monad t)
	, Lifting t (Schematic Monad u (v :> w))
	, Lifting u (Schematic Monad v w)
	, Wrappable v w
	) => Adaptable v (t :> u :> v :> w) where
	adapt = lift . lift . wrap

instance
	( Covariant (t :> u :> v :> w)
	, Lifting t (Schematic Monad u v)
	, Lifting t (Schematic Monad u (v :> w))
	, Lifting u (Schematic Monad v w)
	, Lifting v w
	) => Adaptable w (t :> u :> v :> w) where
	adapt = lift . lift . lift

instance
	( Covariant (t :< u :< v :< w)
	, Lowering t (Schematic Comonad u (v :< w))
	, Lowering u (Schematic Comonad v w)
	, Bringable v w
	) => Adaptable (t :< u :< v :< w) v where
	adapt = bring . lower . lower

instance
	( Covariant (t :< u :< v :< w)
	, Lowering t (Schematic Comonad u v)
	, Lowering t (Schematic Comonad u (v :< w))
	, Lowering u (Schematic Comonad v w)
	, Lowering v w
	) => Adaptable (t :< u :< v :< w) w where
	adapt = lower . lower . lower

instance
	( Covariant (t :> u :> v :> w :> x)
	, Lifting t (Schematic Monad u (v :> w :> x))
	, Lifting u (Schematic Monad v (w :> x))
	, Lifting v (Schematic Monad w x)
	, Lifting w x
	) => Adaptable x (t :> u :> v :> w :> x) where
	adapt = lift . lift . lift . lift

instance
	( Covariant (t :> u :> v :> w :> x)
	, Lifting t (Schematic Monad u (v :> w :> x))
	, Lifting u (Schematic Monad v (w :> x))
	, Lifting v (Schematic Monad w x)
	, Wrappable w x
	) => Adaptable w (t :> u :> v :> w :> x) where
	adapt = lift . lift . lift . wrap

instance
	( Covariant (t :< u :< v :< w :< x)
	, Lowering t (Schematic Comonad u (v :< w :< x))
	, Lowering u (Schematic Comonad v (w :< x))
	, Lowering v (Schematic Comonad w x)
	, Lowering w x
	) => Adaptable (t :< u :< v :< w :< x) x where
	adapt = lower . lower . lower . lower

instance
	( Covariant (t :< u :< v :< w :< x)
	, Lowering t (Schematic Comonad u (v :< w :< x))
	, Lowering u (Schematic Comonad v (w :< x))
	, Lowering v (Schematic Comonad w x)
	, Bringable w x
	) => Adaptable (t :< u :< v :< w :< x) w where
	adapt = bring . lower . lower . lower

instance
	( Covariant (t :> u :> v :> w :> x :> y)
	, Lifting t (Schematic Monad u (v :> w :> x :> y))
	, Lifting u (Schematic Monad v (w :> x :> y))
	, Lifting v (Schematic Monad w (x :> y))
	, Lifting w (Schematic Monad x y)
	, Lifting x y
	) => Adaptable y (t :> u :> v :> w :> x :> y) where
	adapt = lift . lift . lift . lift . lift

instance
	( Covariant (t :> u :> v :> w :> x :> y)
	, Lifting t (Schematic Monad u (v :> w :> x :> y))
	, Lifting u (Schematic Monad v (w :> x :> y))
	, Lifting v (Schematic Monad w (x :> y))
	, Lifting w (Schematic Monad x y)
	, Wrappable x y
	) => Adaptable x (t :> u :> v :> w :> x :> y) where
	adapt = lift . lift . lift . lift . wrap

instance
	( Covariant (t :< u :< v :< w :< x :< y)
	, Lowering t (Schematic Comonad u (v :< w :< x :< y))
	, Lowering u (Schematic Comonad v (w :< x :< y))
	, Lowering v (Schematic Comonad w (x :< y))
	, Lowering w (Schematic Comonad x y)
	, Lowering x y
	) => Adaptable (t :< u :< v :< w :< x :< y) y where
	adapt = lower . lower . lower . lower . lower

instance
	( Covariant (t :< u :< v :< w :< x :< y)
	, Lowering t (Schematic Comonad u (v :< w :< x :< y))
	, Lowering u (Schematic Comonad v (w :< x :< y))
	, Lowering v (Schematic Comonad w (x :< y))
	, Lowering w (Schematic Comonad x y)
	, Bringable x y
	) => Adaptable (t :< u :< v :< w :< x :< y) x where
	adapt = bring . lower . lower . lower . lower

instance
	( Covariant (t :> u :> v :> w :> x :> y :> z)
	, Lifting t (Schematic Monad u (v :> w :> x :> y :> z))
	, Lifting u (Schematic Monad v (w :> x :> y :> z))
	, Lifting v (Schematic Monad w (x :> y :> z))
	, Lifting w (Schematic Monad x (y :> z))
	, Lifting x (Schematic Monad y z)
	, Lifting y z
	) => Adaptable z (t :> u :> v :> w :> x :> y :> z) where
	adapt = lift . lift . lift . lift . lift . lift

instance
	( Covariant (t :> u :> v :> w :> x :> y :> z)
	, Lifting t (Schematic Monad u (v :> w :> x :> y :> z))
	, Lifting u (Schematic Monad v (w :> x :> y :> z))
	, Lifting v (Schematic Monad w (x :> y :> z))
	, Lifting w (Schematic Monad x (y :> z))
	, Lifting x (Schematic Monad y z)
	, Wrappable y z
	) => Adaptable y (t :> u :> v :> w :> x :> y :> z) where
	adapt = lift . lift . lift . lift . lift . wrap

instance
	( Covariant (t :< u :< v :< w :< x :< y :< z)
	, Lowering t (Schematic Comonad u (v :< w :< x :< y :< z))
	, Lowering u (Schematic Comonad v (w :< x :< y :< z))
	, Lowering v (Schematic Comonad w (x :< y :< z))
	, Lowering w (Schematic Comonad x (y :< z))
	, Lowering x (Schematic Comonad y z)
	, Lowering y z
	) => Adaptable (t :< u :< v :< w :< x :< y :< z) z where
	adapt = lower . lower . lower . lower . lower . lower

instance
	( Covariant (t :< u :< v :< w :< x :< y :< z)
	, Lowering t (Schematic Comonad u (v :< w :< x :< y :< z))
	, Lowering u (Schematic Comonad v (w :< x :< y :< z))
	, Lowering v (Schematic Comonad w (x :< y :< z))
	, Lowering w (Schematic Comonad x (y :< z))
	, Lowering x (Schematic Comonad y z)
	, Bringable y z
	) => Adaptable (t :< u :< v :< w :< x :< y :< z) y where
	adapt = bring . lower . lower . lower . lower . lower

instance
	( Covariant (t :> u :> v :> w :> x :> y :> z :> f)
	, Lifting t (Schematic Monad u (v :> w :> x :> y :> z :> f))
	, Lifting u (Schematic Monad v (w :> x :> y :> z :> f))
	, Lifting v (Schematic Monad w (x :> y :> z :> f))
	, Lifting w (Schematic Monad x (y :> z :> f))
	, Lifting x (Schematic Monad y (z :> f))
	, Lifting y (Schematic Monad z f)
	, Lifting z f
	) => Adaptable f (t :> u :> v :> w :> x :> y :> z :> f) where
	adapt = lift . lift . lift . lift . lift . lift . lift

instance
	( Covariant (t :> u :> v :> w :> x :> y :> z :> f)
	, Lifting t (Schematic Monad u (v :> w :> x :> y :> z :> f))
	, Lifting u (Schematic Monad v (w :> x :> y :> z :> f))
	, Lifting v (Schematic Monad w (x :> y :> z :> f))
	, Lifting w (Schematic Monad x (y :> z :> f))
	, Lifting x (Schematic Monad y (z :> f))
	, Lifting y (Schematic Monad z f)
	, Wrappable z f
	) => Adaptable z (t :> u :> v :> w :> x :> y :> z :> f) where
	adapt = lift . lift . lift . lift . lift . lift . wrap

instance
	( Covariant (t :< u :< v :< w :< x :< y :< z :< f)
	, Lowering t (Schematic Comonad u (v :< w :< x :< y :< z :< f))
	, Lowering u (Schematic Comonad v (w :< x :< y :< z :< f))
	, Lowering v (Schematic Comonad w (x :< y :< z :< f))
	, Lowering w (Schematic Comonad x (y :< z :< f))
	, Lowering x (Schematic Comonad y (z :< f))
	, Lowering y (Schematic Comonad z f)
	, Lowering z f
	) => Adaptable (t :< u :< v :< w :< x :< y :< z :< f) f where
	adapt = lower . lower . lower . lower . lower . lower . lower

instance
	( Covariant (t :< u :< v :< w :< x :< y :< z :< f)
	, Lowering t (Schematic Comonad u (v :< w :< x :< y :< z :< f))
	, Lowering u (Schematic Comonad v (w :< x :< y :< z :< f))
	, Lowering v (Schematic Comonad w (x :< y :< z :< f))
	, Lowering w (Schematic Comonad x (y :< z :< f))
	, Lowering x (Schematic Comonad y (z :< f))
	, Lowering y (Schematic Comonad z f)
	, Bringable z f
	) => Adaptable (t :< u :< v :< w :< x :< y :< z :< f) z where
	adapt = bring . lower . lower . lower . lower . lower . lower

instance
	( Covariant (t :> u :> v :> w :> x :> y :> z :> f :> h)
	, Lifting t (Schematic Monad u (v :> w :> x :> y :> z :> f :> h))
	, Lifting u (Schematic Monad v (w :> x :> y :> z :> f :> h))
	, Lifting v (Schematic Monad w (x :> y :> z :> f :> h))
	, Lifting w (Schematic Monad x (y :> z :> f :> h))
	, Lifting x (Schematic Monad y (z :> f :> h))
	, Lifting y (Schematic Monad z (f :> h))
	, Lifting z (Schematic Monad f h)
	, Lifting f h
	) => Adaptable h (t :> u :> v :> w :> x :> y :> z :> f :> h) where
	adapt = lift . lift . lift . lift . lift . lift . lift . lift

instance
	( Covariant (t :> u :> v :> w :> x :> y :> z :> f :> h)
	, Lifting t (Schematic Monad u (v :> w :> x :> y :> z :> f :> h))
	, Lifting u (Schematic Monad v (w :> x :> y :> z :> f :> h))
	, Lifting v (Schematic Monad w (x :> y :> z :> f :> h))
	, Lifting w (Schematic Monad x (y :> z :> f :> h))
	, Lifting x (Schematic Monad y (z :> f :> h))
	, Lifting y (Schematic Monad z (f :> h))
	, Lifting z (Schematic Monad f h)
	, Wrappable f h
	) => Adaptable f (t :> u :> v :> w :> x :> y :> z :> f :> h) where
	adapt = lift . lift . lift . lift . lift . lift . lift . wrap

instance
	( Covariant (t :< u :< v :< w :< x :< y :< z :< f :< h)
	, Lowering t (Schematic Comonad u (v :< w :< x :< y :< z :< f :< h))
	, Lowering u (Schematic Comonad v (w :< x :< y :< z :< f :< h))
	, Lowering v (Schematic Comonad w (x :< y :< z :< f :< h))
	, Lowering w (Schematic Comonad x (y :< z :< f :< h))
	, Lowering x (Schematic Comonad y (z :< f :< h))
	, Lowering y (Schematic Comonad z (f :< h))
	, Lowering z (Schematic Comonad f h)
	, Lowering f h
	) => Adaptable (t :< u :< v :< w :< x :< y :< z :< f :< h) h where
	adapt = lower . lower . lower . lower . lower . lower . lower . lower

instance
	( Covariant (t :< u :< v :< w :< x :< y :< z :< f :< h)
	, Lowering t (Schematic Comonad u (v :< w :< x :< y :< z :< f :< h))
	, Lowering u (Schematic Comonad v (w :< x :< y :< z :< f :< h))
	, Lowering v (Schematic Comonad w (x :< y :< z :< f :< h))
	, Lowering w (Schematic Comonad x (y :< z :< f :< h))
	, Lowering x (Schematic Comonad y (z :< f :< h))
	, Lowering y (Schematic Comonad z (f :< h))
	, Lowering z (Schematic Comonad f h)
	, Bringable f h
	) => Adaptable (t :< u :< v :< w :< x :< y :< z :< f :< h) f where
	adapt = bring . lower . lower . lower . lower . lower . lower . lower

instance (Covariant u, Hoistable ((:>) t), Adaptable u u') => Adaptable (t :> u) (t :> u') where
	adapt = hoist adapt
