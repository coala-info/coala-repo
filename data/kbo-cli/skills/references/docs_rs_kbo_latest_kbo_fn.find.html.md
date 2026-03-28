[Docs.rs](/)

* kbo-0.5.1

  + kbo 0.5.1
  + [Permalink](/kbo/0.5.1/kbo/fn.find.html "Get a link to this specific version")
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
  + [aarch64-apple-darwin](/crate/kbo/latest/target-redirect/aarch64-apple-darwin/kbo/fn.find.html)
  + [aarch64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/aarch64-unknown-linux-gnu/kbo/fn.find.html)
  + [x86\_64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/kbo/fn.find.html)
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

## find

## [kbo](../kbo/index.html)0.5.1

## find

### Sections

* [Examples](#examples "Examples")

## [In crate kbo](index.html)

[kbo](index.html)

# Function find Copy item path

[Source](../src/kbo/lib.rs.html#808-821)

```
pub fn find(
    query_seq: &[u8],
    sbwt: &SbwtIndexVariant,
    lcs: &LcsArray,
    find_opts: FindOpts,
) -> Vec<RLE>
```

Expand description

Finds the *k*-mers from an SBWT index in a query fasta or fastq file.

Aligns the sequence data in `query_seq` against the SBWT index
`sbwt` and its LCS array `lcs` using [matches](fn.matches.html "fn kbo::matches"). Then uses
[format::run\_lengths](format/fn.run_lengths.html "fn kbo::format::run_lengths") to extract the local alignments from the
matching statistics.

Returns a vector of tuples, where each element represents a local
alignment block and contains the following values:

1. Start of local alignment block in query (1-based indexing).
2. End of local alignment block in query.
3. Number of matches in the block.
4. Number of mismatches and 1-character insertions in the block.

## [§](#examples)Examples

```
use kbo::build;
use kbo::find;
use kbo::FindOpts;
use kbo::BuildOpts;
use kbo::format::RLE;

let gene1: Vec<u8> = b"ATGGCTGTTCCATCATCAAAAGAAGAGTTAATTAAAGCTATTAATAGTAATTTTTCTTTATTAAATAAGAAGCTAGAATCTATTACGCCCCAACTCGCCTTTGAACCTCTATTGGAAGGGCACGCGAAGGGGACTACGATTAGCGTAGCGAATCTGGTTTCCTATCTGATTGGCTGGGGAGAGCTGGTGTTACACTGGCATGACCAAGAGGCAAAAGGAAAAACTATTATTTTTCCTGAGGAAGGATTTAAATGGAATGAATTGGGGCGTTTAGCACAGAAATTCTACCGTGACTATGAGGATATTACAGAGTACGAAGTTTTATTGGCACGGTTAAAGGAAAATAAGCAGCAACTCGTGGCTTTGATTGAACGATTCAGTAACGACGAGCTTTACGGTAAACCTTGGTATAATAAATGGACCCGAGGTCGTATGATTCAATTTAATACCGCCTCGCCTTATAAAAATGCTTCGGGGAGGTTAAATAAACTGCAGAAATGTCTTGCAGAATAG".to_vec();
let gene2_rc: Vec<u8> = b"CTACCCTACTATTTCGAGTGATTCAATCGTCTGGTTCACATAACCTACCACCTGTTCAAAATGCTTATCGACAAAAAAATGATCGGCAGCAGGAAATATAATAGTCCGCGTCTTTCGTGTGGTGAATTTTTCCCATGCAAGTAATTCATCCTGCATTACCAGATTGTCAGCATCGCCATGAAATAGCACGATCGGACAGGTTAATGTGCGCGCCTTGGCCTGAAATACATACTGCTCATAGAGCCGATAATCGTTTTTAATGATGGGGGTGAAAATTGTCATTAACTCTTTATTACGAAAGACATCAACCGGAGTTCCGCCCAGCTTGACGATCTCTTCCATAAACGCCTGATCGGGCAAGGTATGCAGTATTACTTCATGAGAGGCCCGATCGGGTGGGCGACAGCCGGAAAAAAACAGCGCGCATGGCATGTCATGTCCATGATCGAGAATATAATGCACCAGTTCGAAGGCCATGATCCCTCCGAGACTATGCCCAAAAATGGCGTAGTCTCCACCTGTGTAGTGTTTCACAAATTGTTGATAAAGGTCAGCGACGGCATCCACCATCGTAAGACACAGCGGCTGGCGTATTCTAGTTCCCCTCCCCGCAGGTTCTAAAGGCCGCAAAGTAATATTGTCCGACAGCACGCTACGCCATTTATAATACATGGCGGCAGAACCACCTGAATATGGCAAACAATACAAACTGATATTACTCAT".to_vec();
let reference: Vec<Vec<u8>> = vec![gene1, gene2_rc];

let query: Vec<u8> = b"ATGGCTGTTCCATCATCAAAAGAAGAGTTAATTAAAGCTATTAATAGTAATTTTTCTTTATTAAATAAGAAGCTAGACTCTATTACGCCCCAACTCGCCTTTGAACCTCTATTGGAAGGGCACGCGAAGGGGACTACGATTAGCGTAGCGAATCTGGTTTCCTATCTGATTGGCTGGGGAGAGCTGGTGTTACACTGGCATGACCAAGAGGCAAAAGGAAAAACTATTATTTTTCCTGAGGAAGGATTTAAATGGAATGAATTGGGGCGTTTAGCACAGAAATTCTACCGTGACTATGAGGATATTACAGAGTACGAAGTTTTATTGGCACGGTTAAAGGAAAATAAGCAGCAACTCGTGGCTTTGATTGAACGATTCAGTAACGACGAGCTTTACGGTAAACCTTGGTATAATAAATGGACCCGAGGTCGTATGATTCAATTTAATACCGCCTCGCCTTATAAAAATGCTTCGGGGAGGTTAAATAAACTGCAGAAATGTCTTGCAGAATAGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGCTACCCTACTATTTCGAGTGATTCAATCGTCTGGTTCACATAACCTACCACCTGTTCAAAATGCTTATCGACAAAAAAATGATCGGCAGCAGGAAATATAATAGTCCGCGTCTTTCGTGTGGTGAATTTTTCCCATGCAAGTAATTCATCCTGCATTACCAGATTGTCAGCATCGCCATGAAATAGCACGATCGGACAGGTTAATGTGCGCGCCTTGGCCTGAAATACATACTGCTCATAGAGCCGATAATCGTGTGTAATGATGGGGGTGAAAATTGTCATTAACTCTTTATTACGAAAGACATCAACCGGAGTTCCGCCCAGCTTGACGATCTCTTCCATAAACGCCTGATCGGGCAAGGTATGCATTTTTTTTTTTTTTTTTTTTTTTTTTGTATTACTTCATGAGAGGCCCGATCGGGTGGGCGACAGCCGGAAAAAAACAGCGCGCATGGCATGTCATGTCCATGATCGAGAATATAATGCACCAGTTCGAAGGCCATGATCCCTCCGAGACTATGCCCAAAAATGGCGTAGTCTCCACCTGTGTAGTGTTTCACAAATTGTTGATAAAGGTCAGCGACGGCATCCACCATCGTAAGACACAGCGGCTGGCGTATTCTAGTTCCCCTCCCCGCAGGTTCTAAAGGCCGCAAAATAATATTGCGACAGCACGCTACGCCATTTATAATACATGGCGGCAGAACCACCTGAATATGGCAAACAATACAAACTGATATTACTCAT".to_vec();

let mut opts = BuildOpts::default();
opts.k = 31;
let (sbwt, lcs) = build(&reference, opts);

let mut find_opts = FindOpts::default();
find_opts.max_gap_len = 50;

let local_alignments = find(&query, &sbwt, &lcs, find_opts);

// `local_alignments` has:
// - RLE { start: 0, end: 513, matches: 512, mismatches: 1, jumps: 0, gap_bases: 0, gap_opens: 0 },
// - RLE { start: 593, end: 1340, matches: 709, mismatches: 0, jumps: 0, gap_bases: 38, gap_opens: 3 }
```