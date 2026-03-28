[Docs.rs](/)

* kbo-0.5.1

  + kbo 0.5.1
  + [Permalink](/kbo/0.5.1/kbo/fn.call.html "Get a link to this specific version")
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
  + [aarch64-apple-darwin](/crate/kbo/latest/target-redirect/aarch64-apple-darwin/kbo/fn.call.html)
  + [aarch64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/aarch64-unknown-linux-gnu/kbo/fn.call.html)
  + [x86\_64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/kbo/fn.call.html)
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

## call

## [kbo](../kbo/index.html)0.5.1

## call

### Sections

* [Examples](#examples "Examples")

## [In crate kbo](index.html)

[kbo](index.html)

# Function call Copy item path

[Source](../src/kbo/lib.rs.html#547-573)

```
pub fn call(
    sbwt_query: &SbwtIndexVariant,
    lcs_query: &LcsArray,
    ref_seq: &[u8],
    call_opts: CallOpts,
) -> Vec<Variant>
```

Expand description

Calls variants between a query and a reference sequence.

Builds an SBWT index from `ref_seq` with parameters and resources from
`call_opts.sbwt_build_opts` and compares the index against `sbwt_query` and
`lcs_query` to determine substitutions, insertions, and deletions in the
query. This function also requires the `call_opts.max_error_prob` option to
[derandomize](derandomize/index.html "mod kbo::derandomize") the matching statistics vectors.

Returns a vector containing the identified [variants](variant_calling/struct.Variant.html "struct kbo::variant_calling::Variant").

## [§](#examples)Examples

```
use kbo::call;
use kbo::build;
use kbo::BuildOpts;
use kbo::CallOpts;
use kbo::variant_calling::Variant;

let reference = b"TCGTGGATCGATACACGCTAGCAGGCTGACTCGATGGGATACTATGTGTTATAGCAATTCGGATCGATCGA";
let query =     b"TCGTGGATCGATACACGCTAGCCTGACTCGATGGGATACCATGTGTTATAGCAATTCCGGATCGATCGA";

let mut call_opts =  CallOpts::default();
call_opts.sbwt_build_opts.k = 20;
call_opts.max_error_prob = 0.001;

let (sbwt_query, lcs_query) = build(&[query.to_vec()], call_opts.sbwt_build_opts.clone());

let variants = call(&sbwt_query, &lcs_query, reference, call_opts);

// `variants` is a vector with elements:
// - Variant { query_pos: 22, query_chars: [65, 71, 71], ref_chars: [] }
// - Variant { query_pos: 42, query_chars: [84], ref_chars: [67] }
// - Variant { query_pos: 60, query_chars: [], ref_chars: [67] }
```