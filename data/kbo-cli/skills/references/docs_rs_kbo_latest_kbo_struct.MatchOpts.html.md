[Docs.rs](/)

* kbo-0.5.1

  + kbo 0.5.1
  + [Permalink](/kbo/0.5.1/kbo/struct.MatchOpts.html "Get a link to this specific version")
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
  + [aarch64-apple-darwin](/crate/kbo/latest/target-redirect/aarch64-apple-darwin/kbo/struct.MatchOpts.html)
  + [aarch64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/aarch64-unknown-linux-gnu/kbo/struct.MatchOpts.html)
  + [x86\_64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/kbo/struct.MatchOpts.html)
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

## MatchOpts

## [kbo](../kbo/index.html)0.5.1

## MatchOpts

### [Fields](#fields)

* [max\_error\_prob](#structfield.max_error_prob "max_error_prob")

### [Trait Implementations](#trait-implementations)

* [Clone](#impl-Clone-for-MatchOpts "Clone")
* [Copy](#impl-Copy-for-MatchOpts "Copy")
* [Debug](#impl-Debug-for-MatchOpts "Debug")
* [Default](#impl-Default-for-MatchOpts "Default")
* [PartialEq](#impl-PartialEq-for-MatchOpts "PartialEq")
* [StructuralPartialEq](#impl-StructuralPartialEq-for-MatchOpts "StructuralPartialEq")

### [Auto Trait Implementations](#synthetic-implementations)

* [Freeze](#impl-Freeze-for-MatchOpts "Freeze")
* [RefUnwindSafe](#impl-RefUnwindSafe-for-MatchOpts "RefUnwindSafe")
* [Send](#impl-Send-for-MatchOpts "Send")
* [Sync](#impl-Sync-for-MatchOpts "Sync")
* [Unpin](#impl-Unpin-for-MatchOpts "Unpin")
* [UnwindSafe](#impl-UnwindSafe-for-MatchOpts "UnwindSafe")

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

# Struct MatchOpts Copy item path

[Source](../src/kbo/lib.rs.html#387-391)

```
#[non_exhaustive]

pub struct MatchOpts {
    pub max_error_prob: f64,
}
```

Expand description

Options and parameters for [matches](fn.matches.html "fn kbo::matches")

## Fields (Non-exhaustive)[§](#fields)

This struct is marked as non-exhaustive

Non-exhaustive structs could have additional fields added in future. Therefore, non-exhaustive structs cannot be constructed in external crates using the traditional `Struct { .. }` syntax; cannot be matched against without a wildcard `..`; and struct update syntax will not work.

[§](#structfield.max_error_prob)`max_error_prob: [f64](https://doc.rust-lang.org/nightly/std/primitive.f64.html)`

Prefix match lengths with probability higher than `max_error_prob` to
happen at random are considered noise.

## Trait Implementations[§](#trait-implementations)

[Source](../src/kbo/lib.rs.html#386)[§](#impl-Clone-for-MatchOpts)

### impl [Clone](https://doc.rust-lang.org/nightly/core/clone/trait.Clone.html "trait core::clone::Clone") for [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

[Source](../src/kbo/lib.rs.html#386)[§](#method.clone)

#### fn [clone](https://doc.rust-lang.org/nightly/core/clone/trait.Clone.html#tymethod.clone)(&self) -> [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

Returns a duplicate of the value. [Read more](https://doc.rust-lang.org/nightly/core/clone/trait.Clone.html#tymethod.clone)

1.0.0 · [Source](https://doc.rust-lang.org/nightly/src/core/clone.rs.html#245-247)[§](#method.clone_from)

#### fn [clone\_from](https://doc.rust-lang.org/nightly/core/clone/trait.Clone.html#method.clone_from)(&mut self, source: &Self)

Performs copy-assignment from `source`. [Read more](https://doc.rust-lang.org/nightly/core/clone/trait.Clone.html#method.clone_from)

[Source](../src/kbo/lib.rs.html#386)[§](#impl-Debug-for-MatchOpts)

### impl [Debug](https://doc.rust-lang.org/nightly/core/fmt/trait.Debug.html "trait core::fmt::Debug") for [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

[Source](../src/kbo/lib.rs.html#386)[§](#method.fmt)

#### fn [fmt](https://doc.rust-lang.org/nightly/core/fmt/trait.Debug.html#tymethod.fmt)(&self, f: &mut [Formatter](https://doc.rust-lang.org/nightly/core/fmt/struct.Formatter.html "struct core::fmt::Formatter")<'\_>) -> [Result](https://doc.rust-lang.org/nightly/core/fmt/type.Result.html "type core::fmt::Result")

Formats the value using the given formatter. [Read more](https://doc.rust-lang.org/nightly/core/fmt/trait.Debug.html#tymethod.fmt)

[Source](../src/kbo/lib.rs.html#393-407)[§](#impl-Default-for-MatchOpts)

### impl [Default](https://doc.rust-lang.org/nightly/core/default/trait.Default.html "trait core::default::Default") for [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

[Source](../src/kbo/lib.rs.html#402-406)[§](#method.default)

#### fn [default](https://doc.rust-lang.org/nightly/core/default/trait.Default.html#tymethod.default)() -> [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

Default to these values:

```
let mut opts = kbo::MatchOpts::default();
opts.max_error_prob = 0.0000001;
```

[Source](../src/kbo/lib.rs.html#386)[§](#impl-PartialEq-for-MatchOpts)

### impl [PartialEq](https://doc.rust-lang.org/nightly/core/cmp/trait.PartialEq.html "trait core::cmp::PartialEq") for [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

[Source](../src/kbo/lib.rs.html#386)[§](#method.eq)

#### fn [eq](https://doc.rust-lang.org/nightly/core/cmp/trait.PartialEq.html#tymethod.eq)(&self, other: &[MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")) -> [bool](https://doc.rust-lang.org/nightly/std/primitive.bool.html)

Tests for `self` and `other` values to be equal, and is used by `==`.

1.0.0 · [Source](https://doc.rust-lang.org/nightly/src/core/cmp.rs.html#264)[§](#method.ne)

#### fn [ne](https://doc.rust-lang.org/nightly/core/cmp/trait.PartialEq.html#method.ne)(&self, other: [&Rhs](https://doc.rust-lang.org/nightly/std/primitive.reference.html)) -> [bool](https://doc.rust-lang.org/nightly/std/primitive.bool.html)

Tests for `!=`. The default implementation is almost always sufficient,
and should not be overridden without very good reason.

[Source](../src/kbo/lib.rs.html#386)[§](#impl-Copy-for-MatchOpts)

### impl [Copy](https://doc.rust-lang.org/nightly/core/marker/trait.Copy.html "trait core::marker::Copy") for [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

[Source](../src/kbo/lib.rs.html#386)[§](#impl-StructuralPartialEq-for-MatchOpts)

### impl [StructuralPartialEq](https://doc.rust-lang.org/nightly/core/marker/trait.StructuralPartialEq.html "trait core::marker::StructuralPartialEq") for [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

## Auto Trait Implementations[§](#synthetic-implementations)

[§](#impl-Freeze-for-MatchOpts)

### impl [Freeze](https://doc.rust-lang.org/nightly/core/marker/trait.Freeze.html "trait core::marker::Freeze") for [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

[§](#impl-RefUnwindSafe-for-MatchOpts)

### impl [RefUnwindSafe](https://doc.rust-lang.org/nightly/core/panic/unwind_safe/trait.RefUnwindSafe.html "trait core::panic::unwind_safe::RefUnwindSafe") for [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

[§](#impl-Send-for-MatchOpts)

### impl [Send](https://doc.rust-lang.org/nightly/core/marker/trait.Send.html "trait core::marker::Send") for [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

[§](#impl-Sync-for-MatchOpts)

### impl [Sync](https://doc.rust-lang.org/nightly/core/marker/trait.Sync.html "trait core::marker::Sync") for [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

[§](#impl-Unpin-for-MatchOpts)

### impl [Unpin](https://doc.rust-lang.org/nightly/core/marker/trait.Unpin.html "trait core::marker::Unpin") for [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

[§](#impl-UnwindSafe-for-MatchOpts)

### impl [UnwindSafe](https://doc.rust-lang.org/nightly/core/panic/unwind_safe/trait.UnwindSafe.html "trait core::panic::unwind_safe::UnwindSafe") for [MatchOpts](struct.MatchOpts.html "struct kbo::MatchOpts")

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

Converts `self` into `T` using `Into<T>`. [Read more](https://docs.rs/tap/1.0.1/x86_64-unknown-linux-gnu/tap/conv/trait.Conv.html#method.conv)

[Source](https://docs.rs/wyz/0.5.1/x86_64-unknown-linux-gnu/src/wyz/fmt.rs.html#114)[§](#impl-FmtForward-for-T)

### impl<T> [FmtForward](https://docs.rs/wyz/0.5.1/x86_64-unknown-linux-gnu/wyz/fmt/trait.FmtForward.html "trait wyz::fmt::FmtForward") for T

[Source](https://docs.rs/wyz/0.5.1/x86_64-unknown-linux-gnu/src/wyz/fmt.rs.html#41-42)[§](#method.fmt_binary)

#### fn [fmt\_binary](https://docs.rs/wyz/0.5.1/x86_64-unknown-linux-gnu/wyz/fmt/trait.FmtForward.html#method.fmt_binary)(self) -> [FmtBinary](https://docs.rs/wyz/0.5.1/x86_64-unknown-linux-gnu/wyz/fmt/struct.FmtBinary.html "struct wyz::fmt::FmtBinary")<Self> where Self: [Binary](https://doc.rust-lang.org/nightly/core/fmt/trait.Binary.html "trait core::fmt::Binary"),

Causes `self` to use its `Binary` implementation when `Debug`-formatted.

[Source](https://docs.rs/wyz/0.5.1/x86_64-unknown-linux-gnu/src/wyz/fmt.rs.html#49-5