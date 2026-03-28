[Docs.rs](/)

* kbo-0.5.1

  + kbo 0.5.1
  + [Permalink](/kbo/0.5.1/kbo/gap_filling/ "Get a link to this specific version")
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
  + [aarch64-apple-darwin](/crate/kbo/latest/target-redirect/aarch64-apple-darwin/kbo/gap_filling/)
  + [aarch64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/aarch64-unknown-linux-gnu/kbo/gap_filling/)
  + [x86\_64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/kbo/gap_filling/)
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

## Module gap\_filling

## [kbo](../../kbo/index.html)0.5.1

## Module gap\_filling

### [Module Items](#functions)

* [Functions](#functions "Functions")

## [In crate kbo](../index.html)

[kbo](../index.html)

# Module gap\_filling Copy item path

[Source](../../src/kbo/gap_filling.rs.html#14-923)

Expand description

Gap filling using matching statistics and SBWT interval lookups.

## Functions[§](#functions)

[fill\_gaps](fn.fill_gaps.html "fn kbo::gap_filling::fill_gaps")
:   Refines a translated alignment by filling in gaps.

[left\_extend\_kmer](fn.left_extend_kmer.html "fn kbo::gap_filling::left_extend_kmer")
:   Left extends a *k*-mer until the SBWT interval becomes non-unique.

[left\_extend\_over\_gap](fn.left_extend_over_gap.html "fn kbo::gap_filling::left_extend_over_gap")
:   Find and extend a nearest unique context until it overlaps the gap.

[nearest\_unique\_context](fn.nearest_unique_context.html "fn kbo::gap_filling::nearest_unique_context")
:   Find the nearest unique context leftwards of a starting point.