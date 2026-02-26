---
name: khmer-common
description: khmer-common provides a toolkit for memory-efficient analysis and transformation of nucleotide sequence data using k-mer based probabilistic data structures. Use when user asks to perform digital normalization, count k-mer abundances, filter low-abundance reads, or manipulate FASTQ files for assembly preparation.
homepage: https://khmer.readthedocs.io/
---


# khmer-common

## Overview

khmer is a specialized toolkit designed for the analysis and transformation of nucleotide sequence data using k-mer based methods. It is built around probabilistic data structures, specifically Bloom filters and Count-Min Sketches, which allow for memory-efficient processing of massive datasets. This skill provides guidance on using khmer's command-line interface to perform tasks such as "digital normalization" (reducing data redundancy), k-mer abundance filtering, and read manipulation. It is an essential tool for researchers working with metagenomes, transcriptomes, and single-cell sequencing where data volume often exceeds available assembly memory.

## Core CLI Patterns and Best Practices

### Memory Management
Memory is the most critical parameter in khmer. Most scripts use the `-M` (or `--max-memory-usage`) flag.
- **Rule of Thumb**: Set `-M` as high as your hardware allows. The effectiveness of the underlying Bloom filter depends on having enough memory to minimize false-positive collisions.
- **Calculation**: If you know the approximate number of unique k-mers ($U$), memory usage is roughly $1.15 \times U$.

### K-mer Counting and Abundance
To analyze the k-mer profile of a dataset:
1. **Build a countgraph**:
   `load-into-counting.py -k 32 -M 10e9 output.ct input.fastq`
   - Use `-b` (no-bigcount) to limit counts to 255 and save memory if exact high-frequency counts aren't needed.
   - Use `-T` to specify threads for faster processing.
2. **Calculate distribution**:
   `abundance-dist.py output.ct input.fastq histogram.txt`

### Digital Normalization
This is the primary workflow for reducing dataset size before assembly without losing low-abundance information.
- **Standard Command**:
  `normalize-by-median.py -k 20 -C 20 -M 10e9 -o normalized.fastq input.fastq`
  - `-C 20`: Keeps reads that contribute k-mers with a median abundance of 20 or less.
  - For paired-end data, ensure reads are interleaved first to prevent "orphaning" pairs.

### Abundance Filtering and Error Trimming
Remove low-abundance k-mers which often represent sequencing errors:
- **Trim low-abundance**:
  `trim-low-abund.py -M 10e9 -C 3 countgraph.ct input.fastq`
- **Variable Coverage**: For RNA-seq or metagenomes where coverage naturally varies, use the `-V` flag in `filter-abund.py` to avoid over-trimming biologically relevant low-coverage sequences.

### Read Handling Utilities
khmer includes several high-utility scripts for preparing FASTQ files:
- **Interleave**: `interleave-reads.py forward.fq reverse.fq > interleaved.fq`
- **Split**: `split-paired-reads.py interleaved.fq`
- **Convert**: `fastq-to-fasta.py input.fastq -o output.fasta`

## Expert Tips
- **K-size Selection**: While khmer supports arbitrary k-sizes, graph-based operations (like partitioning) are generally limited to $k \le 32$. For most assemblies, $k=20$ to $k=32$ is the standard range.
- **Compressed Files**: khmer automatically detects `.gz` and `.bz2` files. You can output compressed files using the `--gzip` or `--bzip` flags.
- **Paired-End Integrity**: Always use interleaved files for normalization and filtering to ensure that if one read in a pair is kept, the other is also evaluated correctly, maintaining the pair structure for the assembler.

## Reference documentation
- [khmer's command-line interface](./references/khmer_readthedocs_io_en_latest_user_scripts.html.md)
- [Introduction to khmer](./references/khmer_readthedocs_io_en_latest_introduction.html.md)
- [Installing and running khmer](./references/khmer_readthedocs_io_en_latest_user_install.html.md)