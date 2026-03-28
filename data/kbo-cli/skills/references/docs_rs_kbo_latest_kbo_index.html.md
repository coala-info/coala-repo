[Docs.rs](/)

* kbo-0.5.1

  + kbo 0.5.1
  + [Permalink](/kbo/0.5.1/kbo/ "Get a link to this specific version")
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
  + [aarch64-apple-darwin](/crate/kbo/latest/target-redirect/aarch64-apple-darwin/kbo/)
  + [aarch64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/aarch64-unknown-linux-gnu/kbo/)
  + [x86\_64-unknown-linux-gnu](/crate/kbo/latest/target-redirect/kbo/)
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

## Crate kbo

## [kbo](../kbo/index.html)0.5.1

* [All Items](all.html)

### Sections

* [Installing kbo](#installing-kbo "Installing kbo")
* [Usage](#usage "Usage")
  + [kbo call](#kbo-call "kbo call")
  + [kbo find](#kbo-find "kbo find")
  + [kbo map](#kbo-map "kbo map")

### [Crate Items](#modules)

* [Modules](#modules "Modules")
* [Structs](#structs "Structs")
* [Functions](#functions "Functions")

# Crate kbo Copy item path

[Source](../src/kbo/lib.rs.html#15-821)

Expand description

kbo is an approximate local aligner based on converting [*k*-bounded matching
statistics](https://www.biorxiv.org/content/10.1101/2024.02.19.580943v1)
into a character representation of the underlying alignment sequence.

Currently, kbo supports three main operations:

* `kbo call` [calls](fn.call.html "fn kbo::call") single and multi base substitutions,
  insertions, and deletions in a query sequence against a reference and
  reports their positions and sequences. Call is useful for problems that
  require [.vcf files](https://samtools.github.io/hts-specs/VCFv4.2.pdf).
* `kbo find` [matches](fn.matches.html "fn kbo::matches") the *k*-mers in a query sequence with the
  reference and reports the local alignment segments found within the
  reference. Find is useful for problems that can be solved with
  [blast](https://blast.ncbi.nlm.nih.gov/Blast.cgi).
* `kbo map` [maps](fn.map.html "fn kbo::map") the query sequence against a reference
  sequence, and reports the nucleotide sequence of the alignment relative to
  the reference. Map solves the same problem as
  [snippy](https://github.com/tseemann/snippy) and [ska
  map](https://docs.rs/ska/latest/ska/#ska-map).

kbo uses the [Spectral Burrows-Wheeler
Transform](https://docs.rs/sbwt/latest/sbwt/) data structure that allows
efficient *k*-mer matching between a target and a query sequence and
fast retrieval of the *k*-bounded matching statistic for each *k*-mer match.

## [§](#installing-kbo)Installing kbo

* Command line usage: see instructions at [kbo-cli](https://github.com/tmaklin/kbo-cli).
* Browser usage: try it at <https://maklin.fi/kbo>.
* Deploying on web: see instructions at [kbo-gui](https://github.com/tmaklin/kbo-gui).

## [§](#usage)Usage

kbo can be run directly on fasta files without an initial indexing step.
Prebuilt indexes are supported via `kbo build` but are only
relevant in `kbo find` analyses where the reference *k*-mers can be
concatenated into a single contig.

kbo can read inputs compressed in the DEFLATE format (gzip, zlib, etc.).
bzip2 and xz support can be enabled by adding the “bzip2” and “xz” feature
flags to [needletail](https://docs.rs/needletail) in the kbo Cargo.toml.

### [§](#kbo-call)kbo call

Set up the example by downloading the fasta file for the [*Streptococcus
pneumoniae*
Spn23F](https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_000026665.1/)
genome from the NCBI and the [*S. pneumoniae*
6952\_7#3](https://www.ebi.ac.uk/ena/browser/view/GCA_001156685.2) assembly
from the ENA.

#### [§](#calling-variants-in-a-reference-genome)Calling variants in a reference genome

In the directory with the downloaded files, run

```
kbo call --reference GCF_000026665.1_ASM2666v1_genomic.fna GCA_001156685.2.fasta.gz > variants.vcf
```

This will write the variants in the [vcf v4.4](https://samtools.github.io/hts-specs/VCFv4.4.pdf) format

(click to view the first 20 lines)

```
##fileformat=VCFv4.4
##contig=<ID=NC_011900.1,length=2221315>
##fileDate=20250324
##source=kbo-cli v0.1.1
##reference=GCF_000026665.1_ASM2666v1_genomic.fna
##phasing=none
#CHROM          POS     ID  REF  ALT  QUAL  FILTER  INFO   FORMAT  unknown
NC_011900.1     83      .   G    A    .     .       .      GT      1
NC_011900.1     845     .   A    C    .     .       .      GT      1
NC_011900.1     1064    .   G    A    .     .       .      GT      1
NC_011900.1     1981    .   G    A    .     .       .      GT      1
NC_011900.1     2392    .   C    T    .     .       .      GT      1
NC_011900.1     2746    .   C    T    .     .       .      GT      1
NC_011900.1     3236    .   T    C    .     .       .      GT      1
NC_011900.1     3397    .   A    G    .     .       .      GT      1
NC_011900.1     3993    .   C    T    .     .       .      GT      1
NC_011900.1     4335    .   AA   A    .     .       INDEL  GT      1
NC_011900.1     4504    .   C    A    .     .       .      GT      1
NC_011900.1     4861    .   A    G    .     .       .      GT      1
NC_011900.1     5007    .   A    T    .     .       .      GT      1
```

### [§](#kbo-find)kbo find

First download the fasta sequence of the [*Escherichia
coli* Nissle
1917](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000714595.1/) genome
from the NCBI and the [pks
island](https://raw.githubusercontent.com/tmaklin/clbtype/021e09f07ba43f79cc9c2f365be4058cebbcd7ce/db/IHE3034_pks_island_genes.fasta)
gene sequences from GitHub. Example output was generated with versions
ASM71459v1 and rev 021e09f.

#### [§](#find-gene-sequence-locations)Find gene sequence locations

In the directory containing the input files, run

```
kbo find --max-gap-len 100 --reference IHE3034_pks_island_genes.fasta GCF_000714595.1_ASM71459v1_genomic.fna
```

This will produce the output (click to expand)

| query | ref | q.start | q.end | strand | length | mismatches | gap\_bases | gap\_opens | identity | coverage | query.contig | ref.contig |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2289596 | 2290543 | + | 948 | 0 | 0 | 0 | 100.00 | 1.90 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | IHE3034\_pks\_island\_genes.fasta |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2239798 | 2289162 | - | 49365 | 7 | 367 | 12 | 99.24 | 98.06 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | IHE3034\_pks\_island\_genes.fasta |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 5145962 | 5149449 | + | 3488 | 0 | 61 | 1 | 98.25 | 6.86 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | IHE3034\_pks\_island\_genes.fasta |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 5354674 | 5356713 | + | 2040 | 1 | 0 | 0 | 99.95 | 4.08 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | IHE3034\_pks\_island\_genes.fasta |

#### [§](#find-gene-sequence-locations-with-names)Find gene sequence locations with names

If you need to know which gene in db.fasta the matches are for, add the `--detailed` toggle:

```
kbo find --detailed --reference IHE3034_pks_island_genes.fasta GCF_000714595.1_ASM71459v1_genomic.fna
```

This replaces the query.contig column with the name of the contig (click to expand)

| query | ref | q.start | q.end | strand | length | mismatches | gap\_bases | gap\_opens | identity | coverage | query.contig | ref.contig |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2289596 | 2289808 | + | 213 | 0 | 0 | 0 | 100.00 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbR|locus\_tag=ECOK1\_RS11410|product=“colibactin biosynthesis LuxR family transcriptional regulator ClbR”|protein\_id=WP\_000357141.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2289809 | 2290543 | + | 735 | 0 | 0 | 0 | 100.00 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbA|locus\_tag=ECOK1\_RS11415|product=“colibactin biosynthesis phosphopantetheinyl transferase ClbA”|protein\_id=WP\_001217110.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2279541 | 2289162 | - | 9622 | 1 | 0 | 0 | 99.99 | 100.01 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbB|locus\_tag=ECOK1\_RS11405|product=“colibactin hybrid non-ribosomal peptide synthetase/type I polyketide synthase ClbB”|protein\_id=WP\_001518711.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2276900 | 2279500 | - | 2601 | 0 | 0 | 0 | 100.00 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbC|locus\_tag=ECOK1\_RS11400|product=“colibactin polyketide synthase ClbC”|protein\_id=WP\_001297908.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2276021 | 2276890 | - | 870 | 0 | 0 | 0 | 100.00 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbD|locus\_tag=ECOK1\_RS11395|product=“colibactin biosynthesis dehydrogenase ClbD”|protein\_id=WP\_000982270.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2275743 | 2275991 | - | 249 | 0 | 0 | 0 | 100.00 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbE|locus\_tag=ECOK1\_RS11390|product=“colibactin biosynthesis aminomalonyl-acyl carrier protein ClbE”|protein\_id=WP\_001297917.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2274609 | 2275739 | - | 1131 | 0 | 0 | 0 | 100.00 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbF|locus\_tag=ECOK1\_RS11385|product=“colibactin biosynthesis dehydrogenase ClbF”|protein\_id=WP\_000337350.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2273344 | 2274612 | - | 1269 | 1 | 0 | 0 | 99.92 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbG|locus\_tag=ECOK1\_RS11380|product=“colibactin biosynthesis acyltransferase ClbG”|protein\_id=WP\_000159201.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2268500 | 2273296 | - | 4797 | 2 | 0 | 0 | 99.96 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbH|locus\_tag=ECOK1\_RS11375|product=“colibactin non-ribosomal peptide synthetase ClbH”|protein\_id=WP\_001304254.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2265418 | 2268450 | - | 3033 | 0 | 0 | 0 | 100.00 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbI|locus\_tag=ECOK1\_RS11370|product=“colibactin polyketide synthase ClbI”|protein\_id=WP\_000829570.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2258874 | 2265374 | - | 6501 | 0 | 0 | 0 | 100.00 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbJ|locus\_tag=ECOK1\_RS11365|product=“colibactin non-ribosomal peptide synthetase ClbJ”|protein\_id=WP\_001468003.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2259498 | 2260784 | - | 1287 | 2 | 0 | 0 | 99.84 | 19.91 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbK|locus\_tag=ECOK1\_RS11360|product=“colibactin hybrid non-ribosomal peptide synthetase/type I polyketide synthase ClbK”|protein\_id=WP\_000222467.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2252399 | 2258863 | - | 6465 | 2 | 0 | 0 | 99.97 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbK|locus\_tag=ECOK1\_RS11360|product=“colibactin hybrid non-ribosomal peptide synthetase/type I polyketide synthase ClbK”|protein\_id=WP\_000222467.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2253845 | 2255131 | - | 1287 | 1 | 0 | 0 | 99.92 | 19.80 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbJ|locus\_tag=ECOK1\_RS11365|product=“colibactin non-ribosomal peptide synthetase ClbJ”|protein\_id=WP\_001468003.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2250943 | 2252406 | - | 1464 | 0 | 0 | 0 | 100.00 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbL|locus\_tag=ECOK1\_RS11355|product=“colibactin biosynthesis amidase ClbL”|protein\_id=WP\_001297937.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2249442 | 2250881 | - | 1440 | 0 | 0 | 0 | 100.00 | 100.00 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbM|locus\_tag=ECOK1\_RS11350|product=“precolibactin export MATE transporter ClbM”|protein\_id=WP\_000217768.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2245077 | 2249445 | - | 4369 | 1 | 0 | 0 | 99.98 | 100.02 | NZ\_CP007799.1 Escherichia coli Nissle 1917 chromosome, complete genome | clbN|locus\_tag=ECOK1\_RS11345|product=“colibactin non-ribosomal peptide synthetase ClbN”|protein\_id=WP\_001327259.1 |
| GCF\_000714595.1\_ASM71459v1\_genomic.fna | IHE3034\_pks\_island\_genes.fasta | 2242587