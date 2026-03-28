[Docs.rs](/)

* kbo-0.5.1

  + kbo 0.5.1
  + [Permalink](/kbo/0.5.1/kbo/index/ "Get a link to this specific version")
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
  + [aarch64-apple-darwin](/crate/kbo/latest/target-redirect/aarch64-apple-darwin/kbo/index/)
  + [aarch64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/aarch64-unknown-linux-gnu/kbo/index/)
  + [x86\_64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/kbo/index/)
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

## Module index

## [kbo](../../kbo/index.html)0.5.1

## Module index

### [Module Items](#functions)

* [Functions](#functions "Functions")

## [In crate kbo](../index.html)

[kbo](../index.html)

# Module index Copy item path

[Source](../../src/kbo/index.rs.html#14-297)

Expand description

Wrapper for using the [sbwt](https://docs.rs/sbwt) API to build and query SBWT indexes.

## Functions[§](#functions)

[build\_sbwt\_from\_vecs](fn.build_sbwt_from_vecs.html "fn kbo::index::build_sbwt_from_vecs")
:   Builds an SBWT index and its LCS array from sequences in memory.

[load\_sbwt](fn.load_sbwt.html "fn kbo::index::load_sbwt")
:   Loads a prebuilt SBWT index and its LCS array from disk.

[query\_sbwt](fn.query_sbwt.html "fn kbo::index::query_sbwt")
:   Queries an SBWT index for the *k*-bounded matching statistics.

[serialize\_sbwt](fn.serialize_sbwt.html "fn kbo::index::serialize_sbwt")
:   Writes an SBWT index and its LCS array to disk.