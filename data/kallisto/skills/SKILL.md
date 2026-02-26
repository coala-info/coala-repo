---
name: kallisto
description: kallisto is a bioinformatics tool that performs near-optimal quantification of transcript abundances from RNA-Seq reads using a pseudoalignment strategy. Use when user asks to build a transcriptome index, quantify bulk RNA-Seq reads, or process single-cell RNA-Seq data using the BUS workflow.
homepage: https://pachterlab.github.io/kallisto
---


# kallisto

## Overview

kallisto is a specialized bioinformatics tool designed for the near-optimal quantification of transcript abundances from high-throughput sequencing reads. Unlike traditional aligners that map reads base-by-base to a reference genome, kallisto employs a "pseudoalignment" strategy. This method identifies the compatibility of reads with targets (transcripts) by looking at k-mer matches, which significantly accelerates the process—quantifying millions of reads in minutes on standard hardware. It is a core component of modern RNA-Seq pipelines, particularly when paired with downstream tools like sleuth for differential expression analysis.

## Core Workflows

### 1. Building a Transcriptome Index
Before quantification, you must generate a kallisto-specific index from a transcriptome FASTA file.
- **Requirement**: Use a transcriptome FASTA (cDNA), not a whole genome FASTA.
- **Command**:
  ```bash
  kallisto index -i index_filename.idx transcriptome.fasta.gz
  ```
- **Tip**: kallisto can read gzipped FASTA files directly.

### 2. Bulk RNA-Seq Quantification
Quantification produces abundance estimates in TPM (Transcripts Per Million) and estimated counts.

**Paired-end reads (Default):**
```bash
kallisto quant -i index.idx -o output_dir read_1.fastq.gz read_2.fastq.gz
```

**Single-end reads:**
You must provide the estimated average fragment length (`-l`) and standard deviation (`-s`).
```bash
kallisto quant -i index.idx -o output_dir --single -l 200 -s 20 reads.fastq.gz
```

### 3. Single-Cell RNA-Seq (BUS Workflow)
For single-cell data, use the `bus` command to generate Barcode, UMI, and Set (BUS) files.
```bash
kallisto bus -i index.idx -o output_dir -x 10xv2 read_1.fastq.gz read_2.fastq.gz
```
- Use `kallisto bus --list` to see all supported single-cell technologies (e.g., 10xv3, DropSeq, inDrop).

## Expert Tips and Best Practices

- **Bootstrapping for Differential Expression**: If you plan to use **sleuth** for downstream analysis, you must run quantification with bootstrap samples (typically 30–100) to account for technical variance.
  ```bash
  kallisto quant -i index.idx -o output_dir -b 100 read_1.fastq.gz read_2.fastq.gz
  ```
- **Stranded Libraries**: If your library prep was strand-specific, use `--fr-stranded` (first read forward) or `--rf-stranded` (first read reverse) to improve quantification accuracy.
- **Performance Optimization**: On Linux/macOS, you can speed up decompression by piping:
  ```bash
  kallisto quant -i index.idx -o output_dir <(zcat reads_1.fastq.gz) <(zcat reads_2.fastq.gz)
  ```
  This offloads the `gzip` decompression to a separate CPU core.
- **Output Files**:
  - `abundance.tsv`: Plaintext results (Target ID, Length, Effective Length, Est_Counts, TPM).
  - `abundance.h5`: Binary HDF5 file containing all data, including bootstraps (required for sleuth).
  - `run_info.json`: Metadata about the run, useful for reproducibility and QC.
- **Fragment Length**: For paired-end data, kallisto learns the fragment length distribution automatically. For single-end data, `-l` and `-s` refer to the **fragment** (the underlying cDNA molecule), not the **read** length.

## Reference documentation
- [kallisto Manual](./references/pachterlab_github_io_kallisto_manual.md)
- [Getting Started with kallisto](./references/pachterlab_github_io_kallisto_starting.md)
- [kallisto FAQ](./references/pachterlab_github_io_kallisto_faq.md)