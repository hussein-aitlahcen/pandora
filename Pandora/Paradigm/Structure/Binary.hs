{-# OPTIONS_GHC -fno-warn-orphans #-}

module Pandora.Paradigm.Structure.Binary (Binary, insert) where

import Pandora.Core.Morphism ((&), (%), (!))
import Pandora.Pattern.Category ((.))
import Pandora.Pattern.Functor.Covariant (Covariant (comap, (<$>), (<$$>)))
import Pandora.Pattern.Functor.Pointable (Pointable (point))
import Pandora.Pattern.Functor.Traversable (Traversable ((->>), (->>>)))
import Pandora.Pattern.Functor.Extractable (extract)
import Pandora.Pattern.Functor.Divariant (($))
import Pandora.Pattern.Object.Chain (Chain ((<=>)), order)
import Pandora.Paradigm.Basis.Maybe (Maybe (Just, Nothing), maybe)
import Pandora.Paradigm.Basis.Product (Product ((:*:)))
import Pandora.Paradigm.Basis.Wye (Wye (End, Left, Right, Both))
import Pandora.Paradigm.Basis.Twister (Twister (Twister))
import Pandora.Paradigm.Basis.Tagged (Tagged (Tag), type (:#))
import Pandora.Paradigm.Controlflow.Joint.Schemes.UT (UT (UT))
import Pandora.Paradigm.Controlflow.Joint.Interpreted (run)
import Pandora.Paradigm.Inventory.Store (Store (Store))
import Pandora.Paradigm.Inventory.Optics (type (:-.), (%~))
import Pandora.Paradigm.Structure.Variation.Nonempty (Nonempty)
import Pandora.Paradigm.Structure.Variation.Substructure (Substructure (Output, sub))

type Binary = UT Covariant Covariant (Twister Wye) Maybe

type instance Nonempty Binary = Twister Wye

instance Covariant Binary where
	f <$> UT g = UT $ f <$$> g

instance Pointable Binary where
	point x = UT . Just . Twister x $ End

instance Traversable Binary where
	UT g ->> f = UT <$> g ->>> f

insert :: Chain a => a -> Binary a -> Binary a
insert x (UT Nothing) = point x
insert x tree@(UT (Just (Twister y _))) = x <=> y & order
	(sub @'Left %~ comap (insert x) $ tree) tree
	(sub @'Right %~ comap (insert x) $ tree)

instance Substructure 'Left Binary where
	type Output 'Left Binary a = 'Left :# Binary a
	sub (UT Nothing) = Store $ (:*:) (Tag $ UT Nothing) $ (UT Nothing !)
	sub  t@(UT (Just (Twister x End))) = Store $ (:*:) (Tag $ UT Nothing) $
		maybe t (UT . Just . Twister x . Left) . run . extract
	sub (UT (Just (Twister x (Left lst)))) = Store $ (:*:) (Tag . UT . Just $ lst) $
		maybe (point x) (UT . Just . Twister x . Left) . run . extract
	sub t@(UT (Just (Twister x (Right rst)))) = Store $ (:*:) (Tag $ UT Nothing) $
		maybe t (UT . Just . Twister x . Both % rst) . run . extract
	sub  (UT (Just (Twister x (Both lst rst)))) = Store $ (:*:) (Tag . UT . Just $ lst) $
		maybe (UT (Just (Twister x (Right rst)))) (UT . Just . Twister x . Both % rst) . run . extract

instance Substructure 'Right Binary where
	type Output 'Right Binary a = 'Right :# Binary a
	sub (UT Nothing) = Store $ Tag (UT Nothing) :*: (!) (UT Nothing)
	sub t@(UT (Just (Twister x End))) = Store $ (:*:) (Tag $ UT Nothing) $
		maybe t (UT . Just . Twister x . Right) . run . extract
	sub t@(UT (Just (Twister x (Left lst)))) = Store $ (:*:) (Tag $ UT Nothing) $
		maybe t (UT . Just . Twister x . Both lst) . run . extract
	sub (UT (Just (Twister x (Right rst)))) = Store $ (:*:) (Tag . UT . Just $ rst) $
		maybe (point x) (UT . Just . Twister x . Right) . run . extract
	sub (UT (Just (Twister x (Both lst rst)))) = Store $ (:*:) (Tag . UT . Just $ rst) $
		maybe (UT (Just (Twister x (Left lst)))) (UT . Just . Twister x . Both lst) . run . extract
