---
name: fmlrc
description: fmlrc corrects errors in long-read sequencing data by using a BWT and FM-index built from short-read data. Use when user asks to correct long reads, perform hybrid error correction, or resolve low-complexity regions in sequencing data using a short-read FM-index.
homepage: https://github.com/holtjma/fmlrc
---


# fmlrc

## Overview

fmlrc (FM-index Long Read Corrector) is a hybrid assembly tool that corrects errors in long-read sequencing data by using the Burrows-Wheeler Transform (BWT) and FM-index of short-read data. It functions by treating the short-read FM-index as an implicit de Bruijn graph. Unlike many other correctors, fmlrc uses a two-pass method with both a short "k-mer" and a longer "K-mer," allowing it to resolve low-complexity regions that typically exhaust short k-mer approaches.

## Installation

The tool is available via Bioconda:

```bash
conda install -c bioconda fmlrc
```

## Core Workflow

### 1. Pre-requisite: Building the Short-Read BWT
Before running fmlrc, you must construct a BWT of your short-read data in the Run-Length Encoded (RLE) format used by the `msbwt` package. The recommended approach is using `ropebwt2`.

### 2. Running Correction
The basic command structure requires the BWT file, the raw long reads, and the desired output path.

```bash
fmlrc [options] <comp_msbwt.npy> <long_reads.fa> <corrected_reads.fa>
```

## Common CLI Patterns

### Multi-threaded Execution
By default, fmlrc runs on a single thread. For production datasets, always increase the thread count.
```bash
fmlrc -p 16 short_reads.npy long_reads.fq corrected_reads.fa
```

### Adjusting K-mer Sizes
The two-pass system uses a short k-mer (default 21) and a long K-mer (default 59).
- Use a smaller `-k` if short-read coverage is low.
- Use a larger `-K` to improve resolution in highly repetitive regions.
```bash
fmlrc -k 19 -K 65 short_reads.npy long_reads.fa corrected_output.fa
```

## Expert Tips and Best Practices

- **Input Formats**: While the output is typically FASTA, fmlrc supports both FASTA and FASTQ for the input long reads.
- **Memory Management**: fmlrc offers two internal implementations. The default is optimized for CPU speed but requires more RAM due to a higher sampled FM-index. If you are hitting memory limits on a server, check the specific version documentation for memory-reduced sampling options (though this increases runtime).
- **BWT Compatibility**: Ensure your BWT is specifically in the `.npy` format. If you have raw FASTQ short reads, you must convert them using `ropebwt2` or the `msbwt` python package first.
- **Successor Tool**: Note that `fmlrc2` (implemented in Rust) is the successor to this tool. If performance is a bottleneck, consider switching to `fmlrc2` for near-identical results with significantly reduced runtimes.

## Reference documentation
- [github_com_holtjma_fmlrc.md](./references/github_com_holtjma_fmlrc.md)
- [anaconda_org_channels_bioconda_packages_fmlrc_overview.md](./references/anaconda_org_channels_bioconda_packages_fmlrc_overview.md)