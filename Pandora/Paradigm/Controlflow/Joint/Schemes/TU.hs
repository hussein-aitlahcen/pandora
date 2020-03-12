module Pandora.Paradigm.Controlflow.Joint.Schemes.TU (TU (..)) where

import Pandora.Core.Functor (type (:.), type (:=))
import Pandora.Paradigm.Controlflow.Joint.Interpreted (Interpreted (Primary, run))

newtype TU ct cu t u a = TU (t :. u := a)

instance Interpreted (TU ct cu t u) where
	type Primary (TU ct cu t u) a = t :. u := a
	run (TU x) = x
