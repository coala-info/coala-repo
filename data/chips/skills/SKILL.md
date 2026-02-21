---
name: chips
description: ChIPs is a specialized toolkit designed for the simulation of ChIP-sequencing and other enrichment-based sequencing experiments.
homepage: https://github.com/gymreklab/chips
---

# chips

## Overview

ChIPs is a specialized toolkit designed for the simulation of ChIP-sequencing and other enrichment-based sequencing experiments. It allows researchers to bridge the gap between theoretical binding sites and raw sequencing data. The tool operates through two primary modules: `learn`, which extracts empirical parameters from existing datasets to ensure simulations are realistic, and `simreads`, which generates synthetic FASTQ files based on those parameters. This skill is essential for benchmarking bioinformatics pipelines, testing peak callers, or generating synthetic control data (WCE).

## Installation

The most efficient way to install ChIPs is via Bioconda:

```bash
conda install bioconda::chips
```

## Core Workflows

### 1. Learning Parameters from Real Data
Use the `learn` module to create a model based on an existing experiment. This produces a `.json` file containing learned parameters.

**Basic Command:**
```bash
chips learn -b <reads.bam> -p <peaks.bed> -t bed -c 5 -o <output_prefix>
```

**Key Parameters & Best Practices:**
- **Input BAM:** Ensure the BAM file is sorted and indexed. To accurately estimate PCR duplicate rates, duplicates should be flagged (e.g., using Picard).
- **Peak Scoring:** Use `-c` to specify the column in your BED/Homer file that contains the peak score (e.g., column 5 for standard BED).
- **Outlier Handling:** Use `--scale-outliers` when working with real data to set peaks with scores >3x the median to a binding probability of 1.
- **Fragment Length:** For single-end data, use `--est <int>` to provide a rough upper-bound guess for fragment length to guide the inference.

### 2. Simulating ChIP-seq Reads
Use the `simreads` module to generate raw FASTQ files.

**Basic Command:**
```bash
chips simreads -p <peaks.bed> -f <ref.fa> -t bed -o <output_prefix> --model <learned_model.json>
```

**Simulation Controls:**
- **Read Depth:** Control the output volume using `--numreads <int>` (default is 1,000,000).
- **Library Type:** Use `--paired` to generate paired-end FASTQ files (`_1.fastq` and `_2.fastq`).
- **Genome Copies:** Use `--numcopies <int>` to set the number of simulation rounds (default 100).

### 3. Simulating Whole Cell Extract (WCE)
To simulate a control/input sample without specific enrichment:
```bash
chips simreads -t wce -f <ref.fa> -o <output_prefix> --numreads 1000000
```

## Expert Tips

- **Model Overrides:** You can provide a learned JSON model via `--model` but override specific parameters manually on the CLI (e.g., adding `--spot 0.25` to increase the fraction of reads in peaks).
- **Recomputing Fraction Bound:** When using a model learned on a different peak set, always use `--recomputeF`. This ensures the `--frac` parameter (fraction of genome bound) is updated based on your current input peaks.
- **Regional Simulation:** If you only need to simulate or learn from a specific genomic area, use the `--region chrom:start-end` flag to save time and computational resources.
- **Binding Probabilities:** If your input BED file already contains pre-calculated binding probabilities (0 to 1) rather than raw scores, use the `--noscale` flag.

## Reference documentation
- [ChIPs Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_chips_overview.md)
- [ChIPs GitHub Repository](./references/github_com_gymreklab_chips.md)