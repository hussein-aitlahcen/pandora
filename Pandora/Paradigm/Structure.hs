module Pandora.Paradigm.Structure (Nonempty, module Exports) where

import Pandora.Paradigm.Structure.Stack as Exports

import Pandora.Paradigm.Basis.Cofree (Cofree)
import Pandora.Paradigm.Junction.Transformer (type (:>:))

type family Nonempty structure a :: * where
	Nonempty (Cofree :>: t) a = Cofree t a
