---
name: rustybam
description: rustybam is a specialized toolkit for the rapid manipulation and transformation of genomic alignment formats like BAM and PAF. Use when user asks to calculate alignment statistics, filter sequences by length, trim PAF overlaps, break alignments at indels, invert query and target relationships, or perform coordinate liftovers between assemblies.
homepage: https://github.com/mrvollger/rustybam
metadata:
  docker_image: "quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0"
---

# rustybam

## Overview
`rustybam` (invoked as `rb`) is a specialized Rust-based toolkit designed for the rapid manipulation of genomic data formats. Unlike general-purpose tools, it excels at complex alignment transformations, such as breaking alignments at large indels, inverting query/target relationships in PAF files, and performing coordinate liftovers. It is built to be pipe-friendly, allowing multiple subcommands to be chained together for complex genomic workflows without intermediate file writing.

## Core CLI Patterns

### Alignment Statistics and Filtering
Use these commands to evaluate the quality of your alignments or subset them based on specific criteria.
*   **Calculate Identity:** `rb stats --paf input.paf` or `rb stats input.bam` to get percent identity statistics.
*   **Filter by Length:** `rb filter --paired-len 10000 input.paf` filters for query sequences with at least 10kb aligned to a target.
*   **BED Length:** `rb bed-length input.bed` (aliases: `bl`, `bedlen`) to count total bases in an annotation file.

### PAF Manipulation
PAF (Pairwise Mapping Format) files often require cleaning before downstream analysis.
*   **Trim Overlaps:** `rb trim-paf input.paf` removes segments where the same query sequence aligns to multiple locations, preventing over-representation.
*   **Break at Indels:** `rb break-paf --max-size 100 input.paf` splits a single alignment record into multiple records at any insertion or deletion larger than 100bp.
*   **Orient Contigs:** `rb orient input.paf` ensures contigs are oriented so the majority of bases are in the forward direction relative to the target.
*   **Invert Alignments:** `rb invert input.paf` swaps the target and query fields while correctly transforming the CIGAR string.

### Coordinate Liftover
One of the most powerful features is the ability to move coordinates between assemblies using an alignment file.
*   **Basic Liftover:** `rb liftover --bed regions.bed alignment.paf`
*   **Inline Liftover:** Use process substitution for quick lookups:
    `rb liftover --bed <(printf "chr22\t12000000\t13000000\n") input.paf`

## Expert Tips & Best Practices
*   **Chaining Subcommands:** Always prefer piping (`|`) between `rb` subcommands to minimize I/O overhead. Most subcommands read from stdin and write to stdout by default.
*   **CIGAR Awareness:** When working with PAF files, ensure they contain CIGAR strings (usually in the `cg:Z:` tag) if you are performing operations like `break-paf` or `liftover`, as `rustybam` uses this for base-level precision.
*   **Memory Efficiency:** `rustybam` is designed for speed; however, when processing extremely large BAM files for `stats`, ensure you have indexed the BAM file if you intend to perform region-specific queries.
*   **Alias Usage:** Use the shortened binary name `rb` instead of `rustybam` to keep command-line invocations concise.



## Subcommands

| Command | Description |
|---------|-------------|
| rustybam | A tool for manipulating BAM files. |
| rustybam | A Rust library for reading and writing BAM files. |
| rustybam | A Rust library for working with BAM files. |
| rustybam | A command-line tool for manipulating BAM files. |
| rustybam | A tool for manipulating BAM files. |
| rustybam | A tool for manipulating BAM files. |
| rustybam | A tool for working with BAM files. |
| rustybam | A tool for manipulating BAM files. |
| rustybam | A tool for manipulating BAM files. |
| rustybam | A command-line tool for manipulating BAM files. |
| rustybam | A tool for working with BAM files. |
| rustybam | A tool for manipulating BAM files. |
| rustybam | A tool for processing BAM files. |
| rustybam add-rg | Add RG lines from a source BAM file to the BAM from stdin to the BAM going to stdout |
| rustybam break-paf | Break PAF records with large indels into multiple records (useful for SafFire) |
| rustybam fastx-split | Splits fastx from stdin into multiple files. |
| rustybam filter | Filter PAF records in various ways |
| rustybam get-fasta | Mimic bedtools getfasta but allow for bgzip in both bed and fasta inputs |
| rustybam invert | Invert the target and query sequences in a PAF along with the CIGAR string |
| rustybam liftover | Liftover target sequence coordinates onto query sequence using a PAF. |
| rustybam nucfreq | Get the frequencies of each bp at each position |
| rustybam orient | Orient paf records so that most of the bases are in the forward direction. |
| rustybam paf-to-sam | Convert a PAF file into a SAM file. Warning, all alignments will be marked as primary! |
| rustybam repeat | Report the longest exact repeat length at every position in a fasta |
| rustybam seq-stats | Calculate summary statistics from fasta/q, sam, bam, or bed files. e.g. N50, mean, quantiles |
| rustybam stats | Get percent identity stats from a sam/bam/cram or PAF. Requires =/X operations in the CIGAR string! |
| rustybam suns | Extract the intervals in a genome (fasta) that are made up of SUNs |
| rustybam trim-paf | Trim PAF records that overlap in query sequence to find and optimal splitting point using dynamic programing. |
| rustybam_bed-length | Count the number of bases in a bed file |

## Reference documentation
- [rustybam GitHub README](./references/github_com_vollgerlab_rustybam_blob_main_README.md)
- [rustybam Project Overview](./references/github_com_vollgerlab_rustybam.md)
- [rustybam Metadata](./references/github_com_vollgerlab_rustybam_blob_main_CITATION.cff.md)