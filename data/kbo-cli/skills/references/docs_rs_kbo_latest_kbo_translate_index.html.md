[Docs.rs](/)

* kbo-0.5.1

  + kbo 0.5.1
  + [Permalink](/kbo/0.5.1/kbo/translate/ "Get a link to this specific version")
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
  + [aarch64-apple-darwin](/crate/kbo/latest/target-redirect/aarch64-apple-darwin/kbo/translate/)
  + [aarch64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/aarch64-unknown-linux-gnu/kbo/translate/)
  + [x86\_64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/kbo/translate/)
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

## Module translate

## [kbo](../../kbo/index.html)0.5.1

## Module translate

### [Module Items](#functions)

* [Functions](#functions "Functions")

## [In crate kbo](../index.html)

[kbo](../index.html)

# Module translate Copy item path

[Source](../../src/kbo/translate.rs.html#14-677)

Expand description

Translating deterministic *k*-bounded matching statistics into alignments.

The translated alignment is encoded using the following characters:

* **M** : Match between query and reference.
* **-** : Characters in the query that are not found in the reference.
* **X** : Single character mismatch or insertion into the query.
* **I** : Single or multiple base insertion into the query.
* **D** : Deletion in the query.
* **R** : Two consecutive ’R’s signify a discontinuity in the alignment.
  The right ‘R’ is at the start of a *k*-mer that is not adjacent
  to the last character in the *k*-mer corresponding to the left
  ‘R’. This implies either a deletion of unknown length in the query,
  or insertion of *k*-mers from elsewhere in the reference into the query.

‘I’ and ‘D’ are only used if [add\_variants](fn.add_variants.html "fn kbo::translate::add_variants") was called.

## Functions[§](#functions)

[add\_variants](fn.add_variants.html "fn kbo::translate::add_variants")
:   Add variant calling results to a translated alignment.

[translate\_ms\_val](fn.translate_ms_val.html "fn kbo::translate::translate_ms_val")
:   Translates a single derandomized *k*-bounded matching statistic.

[translate\_ms\_vec](fn.translate_ms_vec.html "fn kbo::translate::translate_ms_vec")
:   Translates a sequence of derandomized *k*-bounded matching statistics.