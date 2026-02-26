---
name: libssw
description: libssw is a high-performance implementation of the Smith-Waterman algorithm that uses SIMD instructions to accelerate local sequence alignment. Use when user asks to perform local alignment of DNA or protein sequences, map reads to a reference, or generate SAM output for genomic data.
homepage: https://github.com/mengyao/Complete-Striped-Smith-Waterman-Library
---


# libssw

## Overview
libssw is a high-performance implementation of the Smith-Waterman algorithm that leverages Single-Instruction Multiple-Data (SIMD) instructions to parallelize sequence alignment at the instruction level. It is approximately 50 times faster than standard implementations and is ideal for genomic applications requiring local alignment, such as read mapping, variant detection, or protein homology searches. This skill provides guidance on using the `ssw_test` command-line utility and integrating the library into various programming environments.

## Installation
The easiest way to install libssw is via Bioconda:
```bash
conda install bioconda::libssw
```
Alternatively, build from source:
```bash
git clone https://github.com/mengyao/Complete-Striped-Smith-Waterman-Library.git
cd Complete-Striped-Smith-Waterman-Library/src
make
```

## CLI Usage Patterns
The primary executable is `ssw_test`. It accepts a target (reference) file and a query (reads) file in FASTA or FASTQ format.

### Basic DNA Alignment
To perform a standard local alignment and output the alignment path (CIGAR):
```bash
ssw_test -c <target.fasta> <query.fasta>
```

### Protein Alignment
When aligning amino acid sequences, use the `-p` flag and optionally specify a scoring matrix:
```bash
ssw_test -p -a Blosum62 <target.fasta> <query.fasta>
```

### Generating SAM Output
For integration with downstream bioinformatics pipelines (like samtools), use the `-s` flag. To include the header, add `-h`:
```bash
ssw_test -s -h <target.fasta> <query.fasta> > alignment.sam
```

### Reverse Complement Alignment
For DNA reads where the orientation is unknown, use `-r` to check both the original and reverse complement:
```bash
ssw_test -r <target.fasta> <query.fastq>
```

## Expert Tips and Best Practices
- **Penalty Selection**: Small integer penalties are recommended for faster execution. Common settings: match: 2, mismatch: 2, gap open: 3, gap extension: 1.
- **Gap Penalties**: Note that libssw applies the gap open penalty alone when a gap is first opened (it does not automatically add the extension penalty to the first gap base).
- **Score Thresholding**: Use the `-f N` option to filter out low-quality alignments where the Smith-Waterman score is less than N, reducing output noise and processing time.
- **Sub-optimal Alignments**: The tool provides a "ZS" tag in SAM output or a `sub-optimal_alignment_score` in BLAST-like output. This is calculated heuristically and is useful for identifying repetitive regions or alternative mapping locations.
- **Memory Efficiency**: The library is highly memory-efficient (e.g., ~40MB for E. coli genome alignment), making it suitable for large-scale parallel processing on standard hardware.

## Programming Interface (API)
- **C/C++**: Include `ssw.h` and `ssw.c` in your project. For C++, use the `ssw_cpp.h` wrapper for a more idiomatic interface.
- **Python**: Use the provided `ssw_lib.py` or `pyssw.py` wrappers to call the C functions via `ctypes`.
- **Java/R**: Use the respective wrappers in the `java` or `R` directories of the source repository.

## Reference documentation
- [libssw Overview](./references/anaconda_org_channels_bioconda_packages_libssw_overview.md)
- [Complete Striped Smith-Waterman Library README](./references/github_com_mengyao_Complete-Striped-Smith-Waterman-Library.md)