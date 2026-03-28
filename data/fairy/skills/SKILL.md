---
name: fairy
description: "Fairy provides fast, alignment-free estimation of contig coverage for metagenomic binning using k-mer sketching. Use when user asks to calculate contig coverage, sketch metagenomic reads, or generate coverage profiles for MetaBAT2, MaxBin2, and SemiBin2."
homepage: https://github.com/bluenote-1577/fairy
---


# fairy

## Overview

Fairy is a specialized tool designed to accelerate the metagenomic binning pipeline by providing a fast, alignment-free method for calculating contig coverage. Instead of performing computationally expensive all-to-all read alignments, Fairy uses k-mer based sketching to estimate coverage depth and variance. While the results are approximate, they are highly correlated with traditional aligners and produce comparable binning results in a fraction of the time. It is specifically optimized for multi-sample workflows and supports output formats compatible with major binners like MetaBAT2, MaxBin2, and SemiBin2.

## Installation

The most efficient way to install fairy is via Bioconda:

```bash
mamba install -c bioconda fairy
```

Alternatively, a statically compiled binary is available for x86-64 Linux systems for immediate use without installation.

## Core Workflow

The Fairy workflow consists of two primary steps: sketching the reads and then calculating coverage against the assembled contigs.

### 1. Sketching Reads (Indexing)
Before calculating coverage, you must create sketches (`.bcsp` files) for your read sets.

**For Short Reads (Paired-end):**
```bash
fairy sketch -1 sample1_R1.fastq.gz -2 sample1_R2.fastq.gz -d sketch_dir
```

**For Long Reads (Nanopore):**
```bash
fairy sketch -r long_reads.fq -d sketch_dir
```

**Handling Identical Filenames:**
If read files in different directories have the same name, use the `-S` flag to provide unique sample names:
```bash
fairy sketch -r dir1/reads.fq dir2/reads.fq -S sample1 sample2 -d sketch_dir
```

### 2. Calculating Coverage
Once sketches are generated, calculate the coverage for your assembly.

**Standard MetaBAT2 Format (Default):**
```bash
fairy coverage sketch_dir/*.bcsp contigs.fa -t 10 -o coverage.tsv
```

## Binner-Specific Integrations

Fairy provides specific flags to ensure the output is formatted correctly for different binning tools.

### MetaBAT2
The default output is compatible with MetaBAT2.
- **Command:** `fairy coverage ... -o coverage.tsv`
- **Usage:** `metabat2 -i contigs.fa -a coverage.tsv -o bins/`

### SemiBin2
SemiBin2 requires a specific format and typically expects separate coverage files for each sample rather than a single matrix.
- **Command:** `fairy coverage contigs.fa sample1.bcsp --aemb-format -o cov_sample1.tsv`
- **Usage:** `SemiBin2 single_easy_bin -i contigs.fa cov_sample*.tsv -o results`

### MaxBin2
Use the MaxBin format to remove variance and length columns not used by MaxBin2.
- **Command:** `fairy coverage ... --maxbin-format -o coverage.maxbin`

## Expert Tips and Best Practices

- **Multi-Sample Only:** Do not use Fairy for single-sample binning; the approximation is optimized for the differential coverage patterns found in multi-sample datasets.
- **Read Type Limitations:** 
    - **Short Reads:** Excellent performance, comparable to BWA.
    - **Nanopore:** Comparable to minimap2 for standard simplex reads.
    - **PacBio HiFi:** Avoid using Fairy for strain-resolved HiFi assemblies (>99.9% identity), as traditional aligners perform significantly better in these specific cases.
- **Performance Tuning:** Always specify the number of threads with `-t` during the `coverage` step to maximize the speed advantage.
- **Memory Efficiency:** Fairy is significantly more memory-efficient than traditional aligners, making it suitable for very large metagenomic co-assemblies.



## Subcommands

| Command | Description |
|---------|-------------|
| coverage | Extremely fast species-level coverage calculation by k-mer sketching |
| sketch | Sketch (index) reads. Each sample.fq -> sample.bcsp |

## Reference documentation

- [Fairy GitHub Repository](./references/github_com_bluenote-1577_fairy.md)
- [Introduction to Fairy Wiki](./references/github_com_bluenote-1577_fairy_wiki_Introduction-to-fairy.md)