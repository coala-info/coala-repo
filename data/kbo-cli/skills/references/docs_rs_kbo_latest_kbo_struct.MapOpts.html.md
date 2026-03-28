[Docs.rs](/)

* kbo-0.5.1

  + kbo 0.5.1
  + [Permalink](/kbo/0.5.1/kbo/struct.MapOpts.html "Get a link to this specific version")
  + [Docs.rs crate page](/crate/kbo/latest "See kbo in docs.rs")
  + [MIT](https://spdx.org/licenses/MIT) OR [Apache-2.0](https://spdx.org/licenses/Apache-2.0)

  + Links
  + [Homepage](https://github.com/tmaklin/kbo)
  + [Repository](https://github.com/tmaklin/kbo)
  + [crates.io](https://crates.io/crates/kbo "See kbo in crates.io")
  + [Source](/crate/kbo/latest/source/ "Browse source of kbo-0.5.1")

  + Owners
  + [tmaklin](https://crates.io/users/tmaklin)

  + Dependencies
  + - [embed-doc-image ^0.1.4
      *normal*](/embed-doc-image/%5E0.1.4/)
    - [sbwt ^0.3.4
      *normal*](/sbwt/%5E0.3.4/)
    - [assert\_approx\_eq ^1
      *dev*](/assert_approx_eq/%5E1/)
    - [random ^0.14.0
      *dev*](/random/%5E0.14.0/)

  + Versions

  + [**100%**
    of the crate is documented](/crate/kbo/latest)
* Platform
  + [aarch64-apple-darwin](/crate/kbo/latest/target-redirect/aarch64-apple-darwin/kbo/struct.MapOpts.html)
  + [aarch64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/aarch64-unknown-linux-gnu/kbo/struct.MapOpts.html)
  + [x86\_64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/kbo/struct.MapOpts.html)
* [Feature flags](/crate/kbo/latest/features "Browse available feature flags of kbo-0.5.1")

* docs.rs
  + [About docs.rs](/about)
  + [Badges](/about/badges)
  + [Builds](/about/builds)
  + [Metadata](/about/metadata)
  + [Shorthand URLs](/about/redirections)
  + [Download](/about/download)
  + [Rustdoc JSON](/about/rustdoc-json)
  + [Build queue](/releases/queue)
  + [Privacy policy](https://foundation.rust-lang.org/policies/privacy-policy/#docs.rs)

* Rust
  + [Rust website](https://www.rust-lang.org/)
  + [The Book](https://doc.rust-lang.org/book/)
  + [Standard Library API Reference](https://doc.rust-lang.org/std/)
  + [Rust by Example](https://doc.rust-lang.org/rust-by-example/)
  + [The Cargo Guide](https://doc.rust-lang.org/cargo/guide/)
  + [Clippy Documentation](https://doc.rust-lang.org/nightly/clippy)

## MapOpts

## [kbo](../kbo/index.html)0.5.1

## MapOpts

### [Fields](#fields)

* [call\_variants](#structfield.call_variants "call_variants")
* [fill\_gaps](#structfield.fill_gaps "fill_gaps")
* [format](#structfield.format "format")
* [max\_error\_prob](#structfield.max_error_prob "max_error_prob")
* [sbwt\_build\_opts](#structfield.sbwt_build_opts "sbwt_build_opts")

### [Trait Implementations](#trait-implementations)

* [Clone](#impl-Clone-for-MapOpts "Clone")
* [Debug](#impl-Debug-for-MapOpts "Debug")
* [Default](#impl-Default-for-MapOpts "Default")
* [PartialEq](#impl-PartialEq-for-MapOpts "PartialEq")
* [StructuralPartialEq](#impl-StructuralPartialEq-for-MapOpts "StructuralPartialEq")

### [Auto Trait Implementations](#synthetic-implementations)

* [Freeze](#impl-Freeze-for-MapOpts "Freeze")
* [RefUnwindSafe](#impl-RefUnwindSafe-for-MapOpts "RefUnwindSafe")
* [Send](#impl-Send-for-MapOpts "Send")
* [Sync](#impl-Sync-for-MapOpts "Sync")
* [Unpin](#impl-Unpin-for-MapOpts "Unpin")
* [UnwindSafe](#impl-UnwindSafe-for-MapOpts "UnwindSafe")

### [Blanket Implementations](#blanket-implementations)

* [Any](#impl-Any-for-T "Any")
* [Borrow<T>](#impl-Borrow%3CT%3E-for-T "Borrow<T>")
* [BorrowMut<T>](#impl-BorrowMut%3CT%3E-for-T "BorrowMut<T>")
* [CloneToUninit](#impl-CloneToUninit-for-T "CloneToUninit")
* [Conv](#impl-Conv-for-T "Conv")
* [Erased](#impl-Erased-for-T "Erased")
* [FmtForward](#impl-FmtForward-for-T "FmtForward")
* [From<T>](#impl-From%3CT%3E-for-T "From<T>")
* [Into<U>](#impl-Into%3CU%3E-for-T "Into<U>")
* [IntoEither](#impl-IntoEither-for-T "IntoEither")
* [Pipe](#impl-Pipe-for-T "Pipe")
* [Pointable](#impl-Pointable-for-T "Pointable")
* [Tap](#impl-Tap-for-T "Tap")
* [ToOwned](#impl-ToOwned-for-T "ToOwned")
* [TryConv](#impl-TryConv-for-T "TryConv")
* [TryFrom<U>](#impl-TryFrom%3CU%3E-for-T "TryFrom<U>")
* [TryInto<U>](#impl-TryInto%3CU%3E-for-T "TryInto<U>")
* [VZip<V>](#impl-VZip%3CV%3E-for-T "VZip<V>")

## [In crate kbo](index.html)

[kbo](index.html)

# Struct MapOpts Copy item path

[Source](../src/kbo/lib.rs.html#412-432)

```
#[non_exhaustive]

pub struct MapOpts {
    pub max_error_prob: f64,
    pub fill_gaps: bool,
    pub call_variants: bool,
    pub format: bool,
    pub sbwt_build_opts: BuildOpts,
}
```

Expand description

Options and parameters for [map](fn.map.html "fn kbo::map")

## Fields (Non-exhaustive)[§](#fields)

This struct is marked as non-exhaustive

Non-exhaustive structs could have additional fields added in future. Therefore, non-exhaustive structs cannot be constructed in external crates using the traditional `Struct { .. }` syntax; cannot be matched against without a wildcard `..`; and struct update syntax will not work.

[§](#structfield.max_error_prob)`max_error_prob: [f64](https://doc.rust-lang.org/nightly/std/primitive.f64.html)`

Prefix match lengths with probability higher than `max_error_prob` to
happen at random are considered noise.

[§](#structfield.fill_gaps)`fill_gaps: [bool](https://doc.rust-lang.org/nightly/std/primitive.bool.html)`

Attempt to resolve gaps in the alignment with [gap
filling](gap_filling/fn.fill_gaps.html "fn kbo::gap_filling::fill_gaps").

[§](#structfield.call_variants)`call_variants: [bool](https://doc.rust-lang.org/nightly/std/primitive.bool.html)`

Resolve substitutions, insertions, and deletions with [variant
calling](fn.call.html "fn kbo::call").

[§](#structfield.format)`format: [bool](https://doc.rust-lang.org/nightly/std/primitive.bool.html)`

Replace characters used by the internal representation of [translate](translate/index.html "mod kbo::translate")
with nucleotide codes and gaps.

[§](#structfield.sbwt_build_opts)`sbwt_build_opts: [BuildOpts](struct.BuildOpts.html "struct kbo::BuildOpts")`

[Build options](struct.BuildOpts.html "struct kbo::BuildOpts") for SBWT, used if variant calling is
requested. `k` must match the *k*-mer size used in indexing the query.

## Trait Implementations[§](#trait-implementations)

[Source](../src/kbo/lib.rs.html#411)[§](#impl-Clone-for-MapOpts)

### impl [Clone](https://doc.rust-lang.org/nightly/core/clone/trait.Clone.html "trait core::clone::Clone") for [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

[Source](../src/kbo/lib.rs.html#411)[§](#method.clone)

#### fn [clone](https://doc.rust-lang.org/nightly/core/clone/trait.Clone.html#tymethod.clone)(&self) -> [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

Returns a duplicate of the value. [Read more](https://doc.rust-lang.org/nightly/core/clone/trait.Clone.html#tymethod.clone)

1.0.0 · [Source](https://doc.rust-lang.org/nightly/src/core/clone.rs.html#245-247)[§](#method.clone_from)

#### fn [clone\_from](https://doc.rust-lang.org/nightly/core/clone/trait.Clone.html#method.clone_from)(&mut self, source: &Self)

Performs copy-assignment from `source`. [Read more](https://doc.rust-lang.org/nightly/core/clone/trait.Clone.html#method.clone_from)

[Source](../src/kbo/lib.rs.html#411)[§](#impl-Debug-for-MapOpts)

### impl [Debug](https://doc.rust-lang.org/nightly/core/fmt/trait.Debug.html "trait core::fmt::Debug") for [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

[Source](../src/kbo/lib.rs.html#411)[§](#method.fmt)

#### fn [fmt](https://doc.rust-lang.org/nightly/core/fmt/trait.Debug.html#tymethod.fmt)(&self, f: &mut [Formatter](https://doc.rust-lang.org/nightly/core/fmt/struct.Formatter.html "struct core::fmt::Formatter")<'\_>) -> [Result](https://doc.rust-lang.org/nightly/core/fmt/type.Result.html "type core::fmt::Result")

Formats the value using the given formatter. [Read more](https://doc.rust-lang.org/nightly/core/fmt/trait.Debug.html#tymethod.fmt)

[Source](../src/kbo/lib.rs.html#434-466)[§](#impl-Default-for-MapOpts)

### impl [Default](https://doc.rust-lang.org/nightly/core/default/trait.Default.html "trait core::default::Default") for [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

[Source](../src/kbo/lib.rs.html#457-465)[§](#method.default)

#### fn [default](https://doc.rust-lang.org/nightly/core/default/trait.Default.html#tymethod.default)() -> [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

Default to these values:

```
let mut opts = kbo::MapOpts::default();
opts.max_error_prob = 0.0000001;
opts.fill_gaps = true;
opts.call_variants = true;
opts.format = true;
```

[Source](../src/kbo/lib.rs.html#411)[§](#impl-PartialEq-for-MapOpts)

### impl [PartialEq](https://doc.rust-lang.org/nightly/core/cmp/trait.PartialEq.html "trait core::cmp::PartialEq") for [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

[Source](../src/kbo/lib.rs.html#411)[§](#method.eq)

#### fn [eq](https://doc.rust-lang.org/nightly/core/cmp/trait.PartialEq.html#tymethod.eq)(&self, other: &[MapOpts](struct.MapOpts.html "struct kbo::MapOpts")) -> [bool](https://doc.rust-lang.org/nightly/std/primitive.bool.html)

Tests for `self` and `other` values to be equal, and is used by `==`.

1.0.0 · [Source](https://doc.rust-lang.org/nightly/src/core/cmp.rs.html#264)[§](#method.ne)

#### fn [ne](https://doc.rust-lang.org/nightly/core/cmp/trait.PartialEq.html#method.ne)(&self, other: [&Rhs](https://doc.rust-lang.org/nightly/std/primitive.reference.html)) -> [bool](https://doc.rust-lang.org/nightly/std/primitive.bool.html)

Tests for `!=`. The default implementation is almost always sufficient,
and should not be overridden without very good reason.

[Source](../src/kbo/lib.rs.html#411)[§](#impl-StructuralPartialEq-for-MapOpts)

### impl [StructuralPartialEq](https://doc.rust-lang.org/nightly/core/marker/trait.StructuralPartialEq.html "trait core::marker::StructuralPartialEq") for [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

## Auto Trait Implementations[§](#synthetic-implementations)

[§](#impl-Freeze-for-MapOpts)

### impl [Freeze](https://doc.rust-lang.org/nightly/core/marker/trait.Freeze.html "trait core::marker::Freeze") for [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

[§](#impl-RefUnwindSafe-for-MapOpts)

### impl [RefUnwindSafe](https://doc.rust-lang.org/nightly/core/panic/unwind_safe/trait.RefUnwindSafe.html "trait core::panic::unwind_safe::RefUnwindSafe") for [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

[§](#impl-Send-for-MapOpts)

### impl [Send](https://doc.rust-lang.org/nightly/core/marker/trait.Send.html "trait core::marker::Send") for [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

[§](#impl-Sync-for-MapOpts)

### impl [Sync](https://doc.rust-lang.org/nightly/core/marker/trait.Sync.html "trait core::marker::Sync") for [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

[§](#impl-Unpin-for-MapOpts)

### impl [Unpin](https://doc.rust-lang.org/nightly/core/marker/trait.Unpin.html "trait core::marker::Unpin") for [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

[§](#impl-UnwindSafe-for-MapOpts)

### impl [UnwindSafe](https://doc.rust-lang.org/nightly/core/panic/unwind_safe/trait.UnwindSafe.html "trait core::panic::unwind_safe::UnwindSafe") for [MapOpts](struct.MapOpts.html "struct kbo::MapOpts")

## Blanket Implementations[§](#blanket-implementations)

[Source](https://doc.rust-lang.org/nightly/src/core/any.rs.html#138)[§](#impl-Any-for-T)

### impl<T> [Any](https://doc.rust-lang.org/nightly/core/any/trait.Any.html "trait core::any::Any") for T where T: 'static + ?[Sized](https://doc.rust-lang.org/nightly/core/marker/trait.Sized.html "trait core::marker::Sized"),

[Source](https://doc.rust-lang.org/nightly/src/core/any.rs.html#139)[§](#method.type_id)

#### fn [type\_id](https://doc.rust-lang.org/nightly/core/any/trait.Any.html#tymethod.type_id)(&self) -> [TypeId](https://doc.rust-lang.org/nightly/core/any/struct.TypeId.html "struct core::any::TypeId")

Gets the `TypeId` of `self`. [Read more](https://doc.rust-lang.org/nightly/core/any/trait.Any.html#tymethod.type_id)

[Source](https://doc.rust-lang.org/nightly/src/core/borrow.rs.html#212)[§](#impl-Borrow%3CT%3E-for-T)

### impl<T> [Borrow](https://doc.rust-lang.org/nightly/core/borrow/trait.Borrow.html "trait core::borrow::Borrow")<T> for T where T: ?[Sized](https://doc.rust-lang.org/nightly/core/marker/trait.Sized.html "trait core::marker::Sized"),

[Source](https://doc.rust-lang.org/nightly/src/core/borrow.rs.html#214)[§](#method.borrow)

#### fn [borrow](https://doc.rust-lang.org/nightly/core/borrow/trait.Borrow.html#tymethod.borrow)(&self) -> [&T](https://doc.rust-lang.org/nightly/std/primitive.reference.html)

Immutably borrows from an owned value. [Read more](https://doc.rust-lang.org/nightly/core/borrow/trait.Borrow.html#tymethod.borrow)

[Source](https://doc.rust-lang.org/nightly/src/core/borrow.rs.html#221)[§](#impl-BorrowMut%3CT%3E-for-T)

### impl<T> [BorrowMut](https://doc.rust-lang.org/nightly/core/borrow/trait.BorrowMut.html "trait core::borrow::BorrowMut")<T> for T where T: ?[Sized](https://doc.rust-lang.org/nightly/core/marker/trait.Sized.html "trait core::marker::Sized"),

[Source](https://doc.rust-lang.org/nightly/src/core/borrow.rs.html#222)[§](#method.borrow_mut)

#### fn [borrow\_mut](https://doc.rust-lang.org/nightly/core/borrow/trait.BorrowMut.html#tymethod.borrow_mut)(&mut self) -> [&mut T](https://doc.rust-lang.org/nightly/std/primitive.reference.html)

Mutably borrows from an owned value. [Read more](https://doc.rust-lang.org/nightly/core/borrow/trait.BorrowMut.html#tymethod.borrow_mut)

[Source](https://doc.rust-lang.org/nightly/src/core/clone.rs.html#547)[§](#impl-CloneToUninit-for-T)

### impl<T> [CloneToUninit](https://doc.rust-lang.org/nightly/core/clone/trait.CloneToUninit.html "trait core::clone::CloneToUninit") for T where T: [Clone](https://doc.rust-lang.org/nightly/core/clone/trait.Clone.html "trait core::clone::Clone"),

[Source](https://doc.rust-lang.org/nightly/src/core/clone.rs.html#549)[§](#method.clone_to_uninit)

#### unsafe fn [clone\_to\_uninit](https://doc.rust-lang.org/nightly/core/clone/trait.CloneToUninit.html#tymethod.clone_to_uninit)(&self, dest: [\*mut](https://doc.rust-lang.org/nightly/std/primitive.pointer.html) [u8](https://doc.rust-lang.org/nightly/std/primitive.u8.html))

🔬This is a nightly-only experimental API. (`clone_to_uninit`)

Performs copy-assignment from `self` to `dest`. [Read more](https://doc.rust-lang.org/nightly/core/clone/trait.CloneToUninit.html#tymethod.clone_to_uninit)

[Source](https://docs.rs/tap/1.0.1/x86_64-unknown-linux-gnu/src/tap/conv.rs.html#58)[§](#impl-Conv-for-T)

### impl<T> [Conv](https://docs.rs/tap/1.0.1/x86_64-unknown-linux-gnu/tap/conv/trait.Conv.html "trait tap::conv::Conv") for T

[Source](https://docs.rs/tap/1.0.1/x86_64-unknown-linux-gnu/src/tap/conv.rs.html#49-52)[§](#method.conv)

#### fn [conv](https://docs.rs/tap/1.0.1/x86_64-unknown-linux-gnu/tap/conv/trait.Conv.html#method.conv)<T>(self) -> T where Self: [Into](https://doc.rust-lang.org/nightly/core/convert/trait.Into.html "trait core::convert::Into")<T>,

Converts `self` into `T` using `Into<T>`. [Read more](https://docs.rs/tap/1.0.1/x86_64-u