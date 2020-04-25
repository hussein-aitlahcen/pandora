module Pandora.Paradigm.Structure.Rose (Rose) where

import Pandora.Pattern.Functor.Covariant (Covariant)
import Pandora.Paradigm.Primary.Functor.Maybe (Maybe)
import Pandora.Paradigm.Primary.Transformer.Construction (Construction)
import Pandora.Paradigm.Structure.Stack (Stack)
import Pandora.Paradigm.Controlflow.Joint.Schemes.TU (TU)

type Rose = TU Covariant Covariant Maybe (Construction Stack)
