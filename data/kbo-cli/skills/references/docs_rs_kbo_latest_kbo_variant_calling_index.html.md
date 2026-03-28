[Docs.rs](/)

* kbo-0.5.1

  + kbo 0.5.1
  + [Permalink](/kbo/0.5.1/kbo/variant_calling/ "Get a link to this specific version")
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
  + [aarch64-apple-darwin](/crate/kbo/latest/target-redirect/aarch64-apple-darwin/kbo/variant_calling/)
  + [aarch64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/aarch64-unknown-linux-gnu/kbo/variant_calling/)
  + [x86\_64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/kbo/variant_calling/)
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

## Module variant\_calling

## [kbo](../../kbo/index.html)0.5.1

## Module variant\_calling

### [Module Items](#structs)

* [Structs](#structs "Structs")
* [Functions](#functions "Functions")

## [In crate kbo](../index.html)

[kbo](../index.html)

# Module variant\_calling Copy item path

[Source](../../src/kbo/variant_calling.rs.html#1-555)

Expand description

Call all variants between a query and a reference.

## Structs[§](#structs)

[ResolveVariantErr](struct.ResolveVariantErr.html "struct kbo::variant_calling::ResolveVariantErr")
:   Returned from [resolve\_variant](fn.resolve_variant.html "fn kbo::variant_calling::resolve_variant") if the variant can’t be resolved.

[Variant](struct.Variant.html "struct kbo::variant_calling::Variant")
:   Describes a variant between the query and the reference.

## Functions[§](#functions)

[call\_variants](fn.call_variants.html "fn kbo::variant_calling::call_variants")
:   Call variants between a query and a reference sequence.

[resolve\_variant](fn.resolve_variant.html "fn kbo::variant_calling::resolve_variant")
:   Resolve variation between a query *k*-mer and a reference *k*-mer.