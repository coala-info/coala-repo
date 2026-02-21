---
name: phip-stat
description: The `phip-stat` toolset is a specialized suite for processing PhIP-seq experimental data.
homepage: https://github.com/lasersonlab/phip-stat
---

# phip-stat

## Overview

The `phip-stat` toolset is a specialized suite for processing PhIP-seq experimental data. It manages the transition from raw FASTQ files to analysis-ready enrichment scores through a three-stage pipeline: alignment (counting reads per library member), merging (combining samples into a single matrix), and modeling (normalizing and calling hits). While the project is in maintenance mode, it remains a standard for implementing the Gamma-Poisson model and low-rank matrix factorization for PhIP-seq datasets.

## Installation and Setup

Install via bioconda or pip:

```bash
conda install bioconda::phip-stat
# OR
pip install phip-stat
```

Note: The `clipped-factorization-model` requires `tensorflow` to be installed in the environment.

## Core Workflows

### 1. Recommended: Kallisto + Gamma-Poisson
This is the most efficient pipeline for modern PhIP-seq analysis, using pseudoalignment for speed and the Gamma-Poisson model for robust statistical scoring.

**Step 1: Align (per sample)**
```bash
kallisto quant --single --plaintext --fr-stranded -l 75 -s 0.1 -t 4 \
  -i reference.idx -o sample_counts/sample1 sample1.fastq.gz
```

**Step 2: Merge**
```bash
phip merge-kallisto-tpm -i sample_counts -o cpm.tsv
```

**Step 3: Model**
```bash
phip gamma-poisson-model -t 99.9 -i cpm.tsv -o gamma-poisson_results
```

### 2. Exact Matching + Matrix Factorization
Use this workflow when you require exact sequence matches and want to use residuals from a low-rank approximation to identify enrichment.

**Step 1: Align**
```bash
phip count-exact-matches -r reference.fasta -l 75 -o sample_counts/sample1.counts.tsv sample1.fastq.gz
```

**Step 2: Merge**
```bash
phip merge-columns -m iter -i sample_counts -o counts.tsv
```

**Step 3: Model and Call Hits**
```bash
phip clipped-factorization-model --rank 2 -i counts.tsv -o residuals.tsv
phip call-hits -i residuals.tsv -o hits.tsv --beads-regex ".*BEADS_ONLY.*"
```

### 3. Bowtie2 + Normalization
Use this for maximum sensitivity at the cost of processing time.

**Step 1: Merge with Outer Join**
If samples have different sets of clones, use the outer join method:
```bash
phip merge-columns -m outer -i sample_counts -o counts.tsv
```

**Step 2: Normalize**
```bash
phip normalize-counts -m size-factors -i counts.tsv -o normalized_counts.tsv
```

## Command Reference and Tips

- **Help Access**: Every subcommand supports the `-h` flag. Use `phip <command> -h` to see specific parameters like thresholds (`-t`) or input/output paths.
- **Model Selection**: The `gamma-poisson-model` is generally preferred over the older `generalized-poisson-model` (Larman et al. original) for better handling of overdispersion.
- **Hit Calling**: When using `call-hits`, ensure your `--beads-regex` correctly identifies your negative control/beads-only samples to establish a proper baseline for residuals.
- **Large Datasets**: For NextSeq runs (e.g., 500M reads), prefer `kallisto` or `count-exact-matches` over `bowtie2` to keep processing times under 30 minutes on standard hardware.

## Reference documentation
- [phip-stat GitHub Repository](./references/github_com_lasersonlab_phip-stat.md)
- [Bioconda phip-stat Overview](./references/anaconda_org_channels_bioconda_packages_phip-stat_overview.md)