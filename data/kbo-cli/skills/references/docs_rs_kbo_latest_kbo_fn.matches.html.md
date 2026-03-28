[Docs.rs](/)

* kbo-0.5.1

  + kbo 0.5.1
  + [Permalink](/kbo/0.5.1/kbo/fn.matches.html "Get a link to this specific version")
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
  + [aarch64-apple-darwin](/crate/kbo/latest/target-redirect/aarch64-apple-darwin/kbo/fn.matches.html)
  + [aarch64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/aarch64-unknown-linux-gnu/kbo/fn.matches.html)
  + [x86\_64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/kbo/fn.matches.html)
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

## matches

## [kbo](../kbo/index.html)0.5.1

## matches

### Sections

* [Output format](#output-format "Output format")
* [Example](#example "Example")

## [In crate kbo](index.html)

[kbo](index.html)

# Function matches Copy item path

[Source](../src/kbo/lib.rs.html#612-628)

```
pub fn matches(
    query_seq: &[u8],
    sbwt: &SbwtIndexVariant,
    lcs: &LcsArray,
    match_opts: MatchOpts,
) -> Vec<char>
```

Expand description

Matches a query fasta or fastq file against an SBWT index.

Queries the sequence data in `query_seq` against the SBWT index
`sbwt` and its LCS array `lcs` using [index::query\_sbwt](index/fn.query_sbwt.html "fn kbo::index::query_sbwt"). Then,
derandomizes the resulting *k*-bounded matching statistics vector
using [derandomize::derandomize\_ms\_vec](derandomize/fn.derandomize_ms_vec.html "fn kbo::derandomize::derandomize_ms_vec") and translates the
matching statistics to a character representation of the alignment
using [translate::translate\_ms\_vec](translate/fn.translate_ms_vec.html "fn kbo::translate::translate_ms_vec").

Returns a vector containing the character representation of the
alignment.

Panics if the query file is not readable or if it’s not a valid
FASTX file.

## [§](#output-format)Output format

See the documentation for [translate](translate/index.html "mod kbo::translate").

## [§](#example)Example

```
use kbo::build;
use kbo::matches;
use kbo::BuildOpts;
use kbo::MatchOpts;

let reference: Vec<Vec<u8>> = vec![vec![b'A',b'A',b'A',b'G',b'A',b'A',b'C',b'C',b'A',b'-',b'T',b'C',b'A',b'G',b'G',b'G',b'C',b'G']];
let mut opts = BuildOpts::default();
opts.k = 3;
let (sbwt, lcs) = build(&reference, opts);

let query = vec![b'G',b'T',b'G',b'A',b'C',b'T',b'A',b'T',b'G',b'A',b'G',b'G',b'A',b'T'];

let ms_vectors = matches(&query, &sbwt, &lcs, MatchOpts::default());
// `ms_vectors` has ['-','-','-','-','-','-','-','-','-','M','M','M','-','-']
```