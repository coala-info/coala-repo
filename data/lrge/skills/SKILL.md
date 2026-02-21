---
name: lrge
description: LRGE (Long Read-based Genome size Estimation) is a specialized tool designed to calculate genome size by analyzing overlaps between long reads.
homepage: https://github.com/mbhall88/lrge
---

# lrge

## Overview

LRGE (Long Read-based Genome size Estimation) is a specialized tool designed to calculate genome size by analyzing overlaps between long reads. Unlike traditional k-mer based estimation methods, which can be sensitive to the high error rates and GC-bias often found in long-read data, LRGE utilizes the structural information of read overlaps to provide a robust estimate. It supports both Oxford Nanopore (ONT) and PacBio (PB) platforms and offers two distinct estimation strategies: a "two-set" sampling approach for efficiency and an "all-vs-all" approach for smaller datasets.

## Usage Instructions

### Basic Estimation
The simplest usage requires only a FASTQ file. By default, LRGE uses the two-set strategy calibrated for bacterial genomes.
```bash
lrge reads.fq.gz
```

### Platform Specification
Always specify the sequencing platform if using PacBio, as the default is set to Oxford Nanopore (`ont`).
```bash
# For PacBio reads
lrge -P pb reads.fq.gz
```

### Scaling for Large Genomes
The default parameters (`-T 10000` target reads and `-Q 5000` query reads) are optimized for bacteria (~5 Mbp). For larger genomes, you must scale the number of reads to ensure sufficient overlaps are found.
- **Small Eukaryotes (e.g., Yeast ~12 Mbp):** Use `-Q 10000 -T 20000`
- **Medium Eukaryotes (e.g., Arabidopsis ~125 Mbp):** Use `-Q 50000 -T 100000`
- **Large Genomes (e.g., Human ~3 Gbp):** Use `-Q 100000 -T 2000000`

### Strategy Selection
- **Two-set (Default):** Best for large datasets. It compares a set of "query" reads against a set of "target" reads.
- **All-vs-all:** Best for very low coverage or small datasets where every read is needed for a stable estimate.
```bash
# Use all-vs-all with 10,000 reads
lrge -n 10000 reads.fq.gz
```

### Reproducibility and Output
For scientific reporting, use a fixed seed and save the output to a file.
```bash
lrge -s 42 -t 8 reads.fq.gz -o genome_size.txt
```

## Expert Tips

- **Memory and Speed:** Use the `-t` flag to increase threads. LRGE is written in Rust and scales well with multi-threading.
- **Confidence Intervals:** By default, LRGE provides an Interquartile Range (IQR). You can customize the percentiles for confidence intervals using `--q1` and `--q2`.
- **Internal Matches:** If your library has a high proportion of contained reads (reads entirely within another read), use the `-F` or `--filter-contained` flag to exclude these overlaps and potentially improve accuracy.
- **Intermediate Files:** If the estimation fails or you want to inspect the overlaps, use `-C` to keep temporary files and `-D` to specify a custom temporary directory.
- **Precision:** If you require the raw floating-point estimate instead of an integer, use the `--float-my-boat` flag.

## Reference documentation
- [LRGE GitHub Repository](./references/github_com_mbhall88_lrge.md)
- [Bioconda LRGE Overview](./references/anaconda_org_channels_bioconda_packages_lrge_overview.md)