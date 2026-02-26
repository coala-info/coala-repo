---
name: rustybam
description: "rustybam is a high-performance utility for refining, manipulating, and calculating statistics from genomic alignments in BAM or PAF formats. Use when user asks to calculate alignment statistics, liftover coordinates, trim overlapping alignments, break alignments at indels, or manipulate FASTA files."
homepage: https://github.com/mrvollger/rustybam
---


# rustybam

## Overview
`rustybam` (aliased as `rb`) is a high-performance utility designed for the "post-processing" phase of genomic alignments. While tools like `minimap2` generate alignments, `rustybam` provides the surgical tools to refine them—such as breaking alignments at large indels, orienting contigs, and ensuring query sequences are not over-represented in overlapping alignments. It is an essential tool for workflows involving structural variation analysis, assembly evaluation, and comparative genomics.

## Core Workflows and CLI Patterns

### Alignment Statistics
Calculate percent identity and other metrics from BAM or PAF files. For PAF files, ensure they were generated with extended CIGAR strings (`-c --eqx`).
- **BAM stats**: `rb stats input.bam > stats.bed`
- **PAF stats**: `rb stats --paf input.paf > stats.bed`

### Coordinate Liftover and Subsetting
Unlike simple filtering, `rb liftover` trims the CIGAR string to match the new coordinates, making the output valid for downstream statistical analysis.
- **Subset to region**: 
  ```bash
  rb liftover --bed <(printf "chr22\t12000000\t13000000\n") input.paf > subset.paf
  ```
- **Sliding window analysis**: Combine with `bedtools` to calculate identity across a chromosome in windows:
  ```bash
  rb liftover --bed <(bedtools makewindows -w 100000 -g genome.txt) input.paf | rb stats --paf > windows.stats.bed
  ```

### Resolving Overlaps and Indels
Use these commands to "clean" alignments before visualization or final reporting.
- **Remove overlapping query alignments**: `rb trim-paf input.paf > trimmed.paf` (Ensures no query base is aligned more than once).
- **Break at indels**: `rb break-paf --max-size 100 input.paf > broken.paf` (Useful for identifying structural breakpoints).
- **Orient contigs**: `rb orient input.paf > oriented.paf` (Flips query sequences so the majority of bases align in the forward direction).

### Sequence Manipulation
- **Split FASTA/FASTQ**: Distribute sequences across multiple files (supports transparent GZIP compression).
  ```bash
  cat input.fasta | rb fasta-split chunk1.fa.gz chunk2.fa.gz
  ```
- **Fast Extraction**: Mimics `bedtools getfasta` but supports `bgzip` for both the BED and FASTA inputs.
  ```bash
  rb get-fasta --fi genome.fa.gz --bed regions.bed.gz > output.fa
  ```

### Advanced Analysis
- **NucFreq**: Get nucleotide frequencies at every position (useful for finding collapsed repeats or variants).
- **SUNs**: Extract "Symmetric Unique Nucleotides" (intervals in a genome that are unique).
- **Repeat Analysis**: Report the longest exact repeat length at every position in a FASTA file.

## Expert Tips
- **Piping**: `rustybam` is designed for Unix pipes. Most subcommands accept `stdin` and output to `stdout`, allowing complex chains like `rb trim-paf | rb break-paf | rb liftover | rb stats`.
- **CIGAR Requirement**: Many features (like `stats` and `liftover`) require the `--eqx` (extended CIGAR) format. If your PAF lacks this, `rustybam` may not function correctly.
- **Memory Usage**: `rb trim-paf` loads the entire PAF into memory to calculate the optimal split. For extremely large whole-genome alignments, ensure sufficient RAM is available.

## Reference documentation
- [GitHub Repository: rustybam](./references/github_com_vollgerlab_rustybam.md)