[Docs.rs](/)

* kbo-0.5.1

  + kbo 0.5.1
  + [Permalink](/kbo/0.5.1/kbo/fn.build.html "Get a link to this specific version")
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
  + [aarch64-apple-darwin](/crate/kbo/latest/target-redirect/aarch64-apple-darwin/kbo/fn.build.html)
  + [aarch64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/aarch64-unknown-linux-gnu/kbo/fn.build.html)
  + [x86\_64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/kbo/fn.build.html)
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

## build

## [kbo](../kbo/index.html)0.5.1

## build

### Sections

* [Examples](#examples "Examples")

## [In crate kbo](index.html)

[kbo](index.html)

# Function build Copy item path

[Source](../src/kbo/lib.rs.html#501-506)

```
pub fn build(
    seq_data: &[Vec<u8>],
    build_opts: BuildOpts,
) -> (SbwtIndexVariant, LcsArray)
```

Expand description

Builds an SBWT index from some fasta or fastq files.

Reads all sequence data in `seq_files` and builds an SBWT index
with the parameters and resources specified in `build_opts` (see
[BuildOpts](struct.BuildOpts.html "struct kbo::BuildOpts") for details).

Prebuilt indexes can currently only be used with kbo find.

All files and sequence data in `seq_files` are merged into the
same index. It is not possible extract the individual sequences
from the index after it has been built; run `kbo map -r <query_file> <seq_files>` if you need to know which reference
sequences the alignments are for.

Returns a tuple containing the built
[SbwtIndexVariant](https://docs.rs/sbwt/latest/sbwt/enum.SbwtIndexVariant.html)
and
[sbwt::LcsArray](https://docs.rs/sbwt/latest/sbwt/struct.LcsArray.html).

Panics if a file in `seq_files` is not readable or a valid FASTX
file.

## [§](#examples)Examples

```
use kbo::build;
use kbo::BuildOpts;

let inputs: Vec<Vec<u8>> = vec![vec![b'A',b'A',b'A',b'G',b'A',b'A',b'C',b'C',b'A',b'-',b'T',b'C',b'A',b'G',b'G',b'G',b'C',b'G']];

let opts = BuildOpts::default();
let (sbwt_index, lcs_array) = build(&inputs, opts);
```