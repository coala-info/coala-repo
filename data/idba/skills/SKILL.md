---
name: idba
description: IDBA is an iterative de Bruijn graph assembler designed to assemble short-read sequencing data by iterating through a range of k-mer sizes. Use when user asks to assemble metagenomes, perform single-cell sequencing assembly, or reconstruct transcriptomes from RNA-Seq data.
homepage: https://github.com/loneknightpy/idba
---


# idba

## Overview
IDBA (Iterative de Bruijn Graph Assembler) is a specialized suite of tools for assembling short-read sequencing data (typically ~100bp). Unlike traditional assemblers that use a fixed k-mer length, IDBA iterates through a range of k-mer sizes. This approach allows it to capture better connectivity in low-depth regions while maintaining accuracy in high-depth regions. It is particularly effective for complex samples like metagenomes and single-cell datasets where coverage is highly uneven.

## Tool Selection
Choose the specific assembler based on your data type:
- **IDBA-UD**: The standard choice for genomic data without a reference. Optimized for metagenomics and single-cell sequencing.
- **IDBA-Hybrid**: Use this when you have a similar reference genome available to guide and improve the assembly.
- **IDBA-Tran**: Specifically designed for RNA-Seq/Transcriptome data assembly.
- **IDBA**: The basic version, generally used only for performance comparison.

## Data Preprocessing
IDBA tools require input in FASTA format. If you have FASTQ files, you must convert them using the included `fq2fa` utility.

### Converting and Filtering
To convert a single FASTQ file to FASTA:
```bash
bin/fq2fa read.fq read.fa
```

### Merging Paired-End Reads
IDBA-UD, Hybrid, and Tran require paired-end reads to be interleaved in a single FASTA file where pairs occupy consecutive lines.
```bash
bin/fq2fa --merge --filter read_1.fq read_2.fq paired_interleaved.fa
```

## Common CLI Patterns

### Running IDBA-UD
The most common workflow for metagenomic assembly:
```bash
bin/idba_ud -r input_interleaved.fa -o output_directory
```

### Running IDBA-Hybrid
To use a reference genome:
```bash
bin/idba_hybrid -r input_interleaved.fa --ref reference.fa -o output_directory
```

## Expert Tips and Constraints
- **Read Length Limitation**: The default configuration is optimized for short reads (around 100bp). If your reads are significantly longer, you must modify the `kMaxShortSequence` constant in `src/sequence/short_sequence.h` and recompile the tool.
- **Read Orientation**: The assembler assumes paired-end reads are in standard orientation (`->, <-`). If your library uses a different orientation (e.g., `<-, ->`), you must manually reverse-complement the reads before assembly.
- **Memory Usage**: Iterative k-mer assembly can be memory-intensive. Ensure your environment has sufficient RAM, especially for large metagenomic datasets.
- **Manual Access**: Run any binary without parameters (e.g., `bin/idba_ud`) to view the full list of available parameters and flags.

## Reference documentation
- [IDBA Main Documentation](./references/github_com_loneknightpy_idba.md)