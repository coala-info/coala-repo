[Docs.rs](/)

* kbo-0.5.1

  + kbo 0.5.1
  + [Permalink](/kbo/0.5.1/kbo/fn.map.html "Get a link to this specific version")
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
  + [aarch64-apple-darwin](/crate/kbo/latest/target-redirect/aarch64-apple-darwin/kbo/fn.map.html)
  + [aarch64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/aarch64-unknown-linux-gnu/kbo/fn.map.html)
  + [x86\_64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/kbo/fn.map.html)
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

## map

## [kbo](../kbo/index.html)0.5.1

## map

### Sections

* [Examples](#examples "Examples")

## [In crate kbo](index.html)

[kbo](index.html)

# Function map Copy item path

[Source](../src/kbo/lib.rs.html#720-761)

```
pub fn map(
    ref_seq: &[u8],
    query_sbwt: &SbwtIndexVariant,
    query_lcs: &LcsArray,
    map_opts: MapOpts,
) -> Vec<u8> ⓘ
```

Expand description

Maps a query sequence against a reference sequence.

Maps the sequence data in `ref_seq` against the SBWT index
`query_sbwt` and `query_lcs` and converts the alignment to a
mapping relative to `ref_seq`.

Return the reference sequence with characters that are not present
in the query masked with a ‘-’.

## [§](#examples)Examples

Run the full algorithm

```
use kbo::build;
use kbo::map;
use kbo::BuildOpts;
use kbo::MapOpts;

let query: Vec<Vec<u8>> = vec![vec![b'A',b'A',b'A',b'G',b'A',b'A',b'C',b'C',b'A',b'-',b'T',b'C',b'A',b'G',b'G',b'G',b'C',b'G']];
let mut opts = BuildOpts::default();
opts.k = 3;
opts.build_select = true;
let (sbwt_query, lcs_query) = build(&query, opts.clone());

let mut map_opts = MapOpts::default();
map_opts.sbwt_build_opts = opts;

let reference = vec![b'G',b'T',b'G',b'A',b'C',b'T',b'A',b'T',b'G',b'A',b'G',b'G',b'A',b'T'];

let alignment = map(&reference, &sbwt_query, &lcs_query, map_opts);
// `ms_vectors` has [45,45,45,45,45,45,45,45,45,65,71,71,45,45]
```

Skip gap filling and variant calling, outputting ’-’s instead.

```
use kbo::build;
use kbo::map;
use kbo::BuildOpts;
use kbo::MapOpts;

let reference = b"CGTTGACTCTAGGTGCCTGGGTTCTCAGAGCTGGGC".to_vec();
let query =     b"CGTTGACTGGTGCCTGGGTTCTCAGAGCTGGGC".to_vec();
let expected =  b"CGTTGACT---GGTGCCTGGGTTCTCAGAGCTGGGC".to_vec();

let mut opts = BuildOpts::default();
opts.k = 7;
opts.build_select = true;

let mut map_opts = MapOpts::default();
map_opts.fill_gaps = false;
map_opts.call_variants = false;
map_opts.max_error_prob = 0.1;
map_opts.sbwt_build_opts = opts.clone();

let (sbwt_query, lcs_query) = build(&[query], opts);

let alignment = map(&reference, &sbwt_query, &lcs_query, map_opts);
// `alignment` has CGTTGACT---GGTGCCTGGGTTCTCAGAGCTGGGC
```

Output the internal representation of [translate](translate/index.html "mod kbo::translate")

```
use kbo::build;
use kbo::map;
use kbo::BuildOpts;
use kbo::MapOpts;

let reference = b"CGTTGACTCTAGGTGCCTGGGTTCTCAGAGCTGGGC".to_vec();
let query =     b"CGTTGACTGGTGCCTGGGTTCTCAGAGCTGGGC".to_vec();
let expected =  b"MMMMMMMM---MMMMMMMMMMMMMMMMMMMMMMMMM".to_vec();

let mut opts = BuildOpts::default();
opts.k = 7;
opts.build_select = true;

let mut map_opts = MapOpts::default();
map_opts.fill_gaps = false;
map_opts.call_variants = false;
map_opts.format = false;
map_opts.max_error_prob = 0.1;
map_opts.sbwt_build_opts = opts.clone();

let (sbwt_query, lcs_query) = build(&[query], opts);

let alignment = map(&reference, &sbwt_query, &lcs_query, map_opts);
// `alignment` has MMMMMMMM---MMMMMMMMMMMMMMMMMMMMMMMMM
```