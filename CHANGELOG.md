# 0.1.1
* Define `attached` destructor for `Product` datatype
* Define `empty` destructor for `Stack` structure
* Replace `flip` on `?` type operator
* Remove type parameter from `Stack` type synonymous
* Split `structure` and `value` in `Nonempty` type family
* Define `Invariant` instance for `Constant` datatype
* Remove all `Invariant` methods except `invmap`
* Extract `Junction` module from `Basis`

# 0.1.2
* Define `Pipeline` control flow paradigm
* Split `Structure` modules on `Property` and `Concrete`
* Define `Hollow` type class for handling empty structures
* Extract `Nonempty` into a separated module
* Define `Graph` concrete structure
* Define infix `:-.` type operator for `Lens`
* Define `Object` instances for `Product` datatype

# 0.1.3
* Define `Object` instances for `Cofree` datatype
* Define all `Object` pattern instances for `Constant` datatype
* Define `reset` and `shift` methods for `Continuation` datatype
* Define `Endo` datatype in `Basis` module
* Define `Object` instances for transformer schemes
* Define `Binary` tree concrete structure
* Define some `Object` instances for `Jack` datatype
* Remove `Hollow` ad-hoc typeclass
* Merge `Property` and `Concrete` modules back

# 0.1.4
* Define `Jet` datatype in `Basis` module
* Add `fail` method for `Conclusion` datatype
* Define `find` method in terms of stateful traversing
* Define `filter` method for `Stack` datastructure
* Define `loeb` method for `Covariant` type class
* Define `Variation` datatype in `Basis` module
* Define infix versions of `comap` with various nesting levels
* Define infix versions of `contramap` with various nesting levels
* Rename `Product` constructor from `:*` to `:*:`
* Define `Has` and `Injective` type families for `Product` proofs

# 0.1.5
* Add `<&>` and `>&<` methods for `Covariant` and `Contravariant` functors accordingly
* Define `Traversable` instance for `Product` datatype
* Rename `Cofree` to `Twister` datatype (we will use the first name later)
* Define fixity for `Jet`'s and `Twister`'s constructors
* Rename `Exclusive` to `Avoidable` typeclass and `exclusive` to `idle` method
* Define `Tagged` datatype for attaching type information to the value
* Define `Proxy` datatype for holding no data, but having a phantom parameter
* Define `Validation` datatype (similar to `Conclusion`, but can collect errors)

# 0.1.6
* Define `->>>`, `->>>>`, `->>>>>` methods for `Traversable` to compact expressions
* Move `Natural` transformation from `Functor` to `Transformation` module
* Define infix and infix flipped versions of methods of `Functor` typeclasses
* Define `>>>-`, `>>>>-`, `>>>>>-` methods for `Distributive` to compact expressions
* Rename `<>` method of `Semigroup` typeclass to `+`
* Rename `><` method of `Ringoid` typeclass to `*`
* Rename `unit` to `zero` method of `Monoid` typeclass
* Define `Quasiring` typeclass

# 0.1.7
* Define `ifelse` function for `Boolean` values
* Change `Stack` and `Nonempty` definitions, temporarily remove `filter`
* Define `<**>`, `<***>`, `<****>` methods for `Applicative` to compact expressions
* Change `Graph` definition
* Rename `ask` to `env` method of `Environmental` datatype
* Introduce `><` type operator to separate functors from its arguments
* Define `Determinable` typeclass and define its instance for `Predicate`
* Flip arguments of `statefully` method of `Stateful` datatype
* Exclude inner effects from `Environmental`, `Storage` and `Stateful` datatypes

# 0.1.8
* Rename `T` junction scheme to `UT` and move it to `Schemes` submodule and remove `up` method
* Rename `Y` junction scheme to `UTU` and move it to `Schemes` submodule and remove `:>:` type operator
* Add variance type arguments to `UT`, `UTU` and `TUT` schemes
* Rename `U` to `TU`, `UU` to `TUV`, `UUU` to `TUVW` and put them into `Schemes` module
* Define `Composition` typeclass and define its instances for `TU`, `TUV`, `TUVW`, `UT` and `UTU`
* Define `Transformer` typeclass and define its instance for `Stateful` datatype
* Replace `transform` on `lay` and add `equip` method in `Transformer` typeclass
* Define `Covariant`, `Applicative`, `Pointable`, `Bindable` and `Monad` instances for `Stateful` transformer
* Remove `:!:` type operator
* Define `Composition` and `Transformer` instances for `Maybe` and `Conclusion`
* Define `Core`, `Paradigm` and `Pattern` umbrella modules

# 0.1.9
* Change `Stack` definition: from type synonymous to newtype, change operations accordingly
* Define `.:.` composition: the same thing but with reverse order
* Change `Nonempty` type family, family instances should be defined for each data structure
* Define `:>` type operator for transformers
* Define `Distributive` instance for `->` datatype
* Rename `idle` method of `Avoidable` typeclass to `empty`
* Remove `a` parameter from `Layout` to be able to use natural transformations in methods
* Return `filter` method to `Stack` data structure
* Rename `unwrap` to `untwist` method in `Twister` module
* Rename `composition` to `unwrap` and `Outline` to `Primary` in `Composition` type class
* Rename `equip` to `wrap` and `Layout` to `Schema` in `Transformer` typeclass
* Make `Composition` a superclass for `Transformer` typeclass
* Move all `Junction` modules to `Pattern` submodule except `Kan`

# 0.2.0
* Define `Representable` functor typeclass
* Define `Pointable`, `Applicative`, `Bindable` and `Representable` instances for `->`
* Define infix `Adjoint` operators - `-|` and `|-`
* Define `Adjoint` instance for `Stateful` and `Storage` datatypes
* Change `Graph` definition: from type synonymous to newtype
* Rename `><` to `>`, `:.:` to `.:`, `.:.` to `:.`
* Remove all instances for `Junction` schemes
* Define type operators for profunctorish types: `::|:.`, `::|.:` and `::|::`
* Define `Divariant` (also known as `Profunctor`) `Functor` typeclass

# 0.2.1
* Generalize `$` up to a method of `Divariant` typeclass
* Put concrete data structures to `Specific` submodule
* Move `Nonempty` type family to separated module
* Define `Cartesian` type class
* Rename `?` to `%` to use `?` as boolean multi-if
* Replace `ifelse` method from `Setoid` module
* Convert `:>` to a newtype
* Rename `Composition` class to `Interpreted`
* Rename `Junction` machinery to `Joint` and move it to `Controlflow` module
* Rename `>` type operator to `:=`
* Create `:#` type synonymous for `Tagged` datatype
* Remove `untag` in favor of `extract` method
* Rename `Tagged` constructor of `Tagged` to `Tag`

# 0.2.2
* Change types of `lay` and `wrap` methods of `Transformer` class
* Define `Adaptable` type class for fitting effects in schemas
* Define `Failable` and `failure` for adaptable `Conclusion`
* Define `Optional` and `nothing` for adaptable `Maybe`
* Rename `Stateful` to `State`, `get` to `current`, `put` to `replace`
* Define `Stateful` adaptable constraint and adapt `get`, `modify` and `put`
* Rename `Environmental` to `Environment`
* Make `env` adaptable effect and remove `local`
* Define `Accumulator` effect and it's adaptable `gather` method
* Define `|->` (Coalgebra) and `<-|` (Algebra) type synonyms
* Remove `oblige` in favor of `Liftable` instance of `Continuation`
* Remove `environmentally` in favor of `Interpreted` instance for `Environment`
* Remove `statefully` in favor of `Interpreted` instance for `State`

# 0.2.3
* Define `Category` type class with `identity` and `.` methods
* Change `>->` signature: `a -> b` to `v a d` and `c -> d` to `v c d`
* Extract `Schema` from `Transformer` type class as `Schematic` type family
* Rename `Transformer` type class to `Monadic`
* Define `Comonadic` type class for comonad transformers
* Define `Transformer` umbrella module and type family
* Rename `:<` data constructor to `Twister` to not confuse it with comonad transformer type operator
* Use `UT` joint scheme for `Stack` and `Graph` data structures
* Remove `Variant` type in favor of `Covariant` and `Contravariant` constraints in joint schemes
* Add `Covariant` constraint on schema parameter in `Adaptable` type class
* Rename `Storage` type to `Store`
* Define `Interpreted`, `Schematic` and `Comonadic` instances for `Store` type

# 0.2.4
* Remove `Pandora.Core.Transformation` module and move `~>` to `Functor` module
* Define `Adaptable` instances for comonad transformer schemes
* Make `position` and `access` methods of `Store` adaptable
* Rename `unwrap` method of `Interpreted` type class to `run`
* Define `Bivariant` functor type class
* Define `zoom` optical operator - apply lens within some part of `State`
* Make `top` method of `Stack` data structure a lens
* Make `zoom` method of `Optics` adaptable for bigger state
* Define `Traced` for adaptable `Environment` comonad
* Define `cata`, `ana` and `hylo` methods of `Fix`
* Define `Equipment` datatype to use `Comonad` `Product` transformer
* Define adaptable `retrieve` method of `Equipment`
* Extract `Imprint` from `Environment` module

# 0.2.5
* Define `Semiring` typeclass
* Define `Stream` module and type
* Move `Liftable` and `Lowerable` modules from `Functor` to `Transformer` submodule
* Define `Hoistable` module and typeclass
* Rename `TUV` joint schema to `TUT`
* Modify `UTU` joint schema internals
* Remove `&&` and `||` `Boolean` operators (use `*` and `+` instead)
* Define precedence for `*` and `+`
* Change superclass of `Group` class - `Quasiring` instead of `Monoid`
* Rename `Jet`'s constructor to `Jet` (previously - `:-`)
* Rename `Group`'s method from `inverse` to `invert`
* Remove `not` method of `Boolean`, (use `invert` instead)
* Remove `Injective` and `Has` type families
* Change superclasses for `Liftable` and `Lowerable` classes to provide a law

# 0.2.6
* Change order of arguments for `TUT` joint schema
* `Binary` trees can be empty
* Define `left_sub_tree` and `right_sub_tree` lenses of `Binary` tree
* Fix `insert` function: `Binary` tree should not contain duplicate values
* Remove `Cartesian` type class
* Move `Nonempty` module to `Variation` submodule
* Remove `Specific` module
* Add functional dependency to `Nonempty` type family and distribute instances
* Define `left` and `right` natural transformations from `Wye` to `Maybe`
* Define experimental `Substructure` type class
* Remove `left_sub_tree` and `right_sub_tree` lenses of `Binary` tree
* Define `this` and `that` methods from `Variation` to `Maybe`
* Define `Backwards` type to run `Applicative` actions in reverse order

# 0.2.7
* Replace `Lan` and `Ran` with `Kan` data family
* Rename `Free` to `Instruction` and its constructors: `Pure` to `Enter` and `Impure` to `Instruct`
* Define `Ring` typeclass with `Group` superclass
* Define `Weighted` type family and define instance for `Graph`
* Add `Leap` to `Edges` to indicate a connection with only the first vertex
* Remove `Graph` structure and `Weighted` type family
* Define `Reverse` type to run `Traversable` in reverse order with `Backwards`
* Rename `Twister` to `Construction` (in contrast of `Instruction`)
* Split `Basis` on `Functor` and `Transformer` modules in `Primary`
* Rename `untwist` to `deconstruct` in `Construction`
* Define `Rose` tree structure
* Replace `UT` joint scheme with `TU` in data structures
* Change `sub` method of `Substructure` - it always returns `Tagged` value
* Rename `Construction` constructor of `Construction` to `Construct`

# 0.2.8
* Define `Outline` free applicative transformer
* Define `Delta` datatype
* Define `Wedge` datatype
* Rename `Variation` to `These`
* Define experimental methods in `Bindable` class - `$>>=` and `>>=$`
* Define `here` and `there` methods from `Wedge` to `Maybe`
* Move `Boolean` definition to its own module
* Move `Ordering` definition to its own module
* Rename `Variation` submodule to `Ability` and create umbrella-module
* Define `Focusable` typeclass for getting root and creating singleton
* Replace `top` method of `Stack` structure with `Focusable` instance
* Add `Covariant` constraint on `natural transformation` in `Hoistable` typeclass

# 0.2.9
* Define `Zipper` type family to walk datastructures with context
* Define `Tap` datatype for context dependent values
* Define type synonyms for `TU`, `UT`, `TUT` and `UTU` joint schemes
* Move `Schemes` module to `Paradigm` submodule
* Move `$` definition from `Divariant` to `Category`
* Define generalized point free combinators in `Covariant` module
* Rename `Joint` module To `Effect`
* Define left and right `zig`, `zig-zig` and `zig-zag` `Splay` rotations for `Binary` tree
* Define experimental methods in `Extendable` class - `$=>>` and `<<=$`
* Define `Rotatable` typeclass to rotate trees
* Rename `sub` method of `Substructure` typeclass to `substructure`
* Define `sub` method which doesn't involve `Tagged`
* Change `Focusable` typeclass - now it's possible to point not only top/root

# 0.3.0
* Rename `Root` datatype to `Location` with `Head` (stack) and `Root` (tree) constructors
* Define `represent` as lens in `Representable` containers
* Define `Equivalence` datatype and define `Contravariant` instance for it
* Define `swop` for `Wye` (useful if you want to invert binary tree with `hoist swap`)
* Add experimental `Monotonic` typeclass
* Implement delete method for Stack
* Define `Comprehension` wrapper for data structures that can behave like list comprehensions
* Define experimental `Insertable` typeclass
* Define `Day convolution` datatype in `Transformer` module
* Define experimental methods: `<*+>`, `<**+>`, `<***+>`
* Rename Bindable method `>>=$` to `<>>=`
* Move `Comprehension` wrapper from `Construction` to `Structure.Ability` module

# 0.3.1
* Define `Set` interface for data structures with `member` method
* Move `zoom` function to `Inventory` module
* Move `Adjoint` instance for `(:*:)` and `(->)` to `Paradigm.Primary.Functor` module
* Remove `Schematic` module and move `Schematic` type family to `Interpreted` module
* Change arity of `Schematic` type family
* Remove `lay` method of `Monadic` type class, use `lift` instead
* Remove `flick` method of `Comonadic` type class, use `lower` instead
* Change `lift` constraint: from `Covariant` to `Traversable`

# 0.3.2
* Define experimental methods: `->>=`, `>>=-`, `-=<<`, `=<<-`
* Define `interruptable` method for `Continuation`
* Define `Catchable` typeclass to catch errors from `Conclusion`
* Define `repeat` method of `Stream` datatype
* Define `subset` method of `Set` interface
* Define `satisfy` method in `Predicate` module
* Make `fold` and `find` stateful expressions
* Define `equate` method of `Predicate` dataype
* Define `Zipper` instance of `Nonempty Stack`
* Define `forward'` and `backward'` methods for `Zipper` of `Nonempty Stack`
* Rename `iterate` method of `Monotonic` typeclass to `bypass`
* Rename `coiterate` method of `Construction` datatype to `iterate`

# 0.3.3
* Define inductive `Natural` number datatype in `Object` module
* Add `cardinality` method to `Set` interface
* Define new functor schemes: `T_`, `T_U`, `U_T`
* Define `Zipper` instance for `Nonempty Binary`
* Replace `forward`, `forward'`, `backward`, `backward'` methods with `Rotatable` instances
* Add `>-<` operator to `Invariant` typeclass
* Add `:~.` type synonymous for polymorphic lens
* Replace `maybe` with more generic `bypass`
* Rename `bypass` method of `Monotonic` to `reduce`
* Add `resolve` method of `Monotonic` typeclass
* Rename `iterate` method of `Construction` to `.-+`
* Define `via` method to use transformer as wrappers

# 0.3.4
* Define `branches` to create `Wye a` from two `Maybe a`
