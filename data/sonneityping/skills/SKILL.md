---
name: sonneityping
description: sonneityping parses Mykrobe predict outputs to perform hierarchical genotyping and identify antimicrobial resistance mutations in Shigella sonnei. Use when user asks to genotype Shigella sonnei samples, identify gyrA or parC mutations, or transform Mykrobe JSON results into a structured summary report.
homepage: https://github.com/katholt/sonneityping
metadata:
  docker_image: "quay.io/biocontainers/sonneityping:20210201"
---

# sonneityping

## Overview

The sonneityping tool is a specialized parser designed to process output from Mykrobe predict specifically for *Shigella sonnei*. It implements a hierarchical genotyping scheme (Hawkey et al., 2021) and identifies key mutations in the gyrA and parC genes. Use this skill to transform raw bioinformatic predictions into a structured tab-delimited format suitable for epidemiological surveillance and antimicrobial resistance (AMR) profiling.

## Installation and Setup

Install the package via Bioconda:
```bash
conda install bioconda::sonneityping
```

Before running predictions, ensure the Mykrobe panels are up to date:
```bash
mykrobe panels update_metadata
mykrobe panels update_species all
```

## Core Workflow

### 1. Generate Mykrobe Predictions
Run Mykrobe on your raw sequence data (Illumina or Nanopore). You must specify the species as `sonnei` and the output format as `json`.

**Illumina (Paired-end):**
```bash
mykrobe predict --sample <sample_id> --species sonnei --format json --out <sample_id>.json --seq <read1.fastq.gz> <read2.fastq.gz>
```

**Oxford Nanopore:**
```bash
mykrobe predict --sample <sample_id> --species sonnei --format json --out <sample_id>.json --ont --seq <reads.fastq.gz>
```

### 2. Parse Results
Use the `parse_mykrobe_predict.py` script to aggregate multiple JSON outputs into a single report.

```bash
python parse_mykrobe_predict.py --jsons path/to/results/*.json --alleles alleles.txt --prefix sonnei_summary
```

## Expert Tips and Best Practices

- **Allele Mapping**: Always ensure the `alleles.txt` file from the repository is in your working directory or correctly referenced. This file is essential for linking lineage names to human-readable counterparts (e.g., "Global III").
- **Confidence Interpretation**:
    - **Strong**: High-quality calls (quality '1') at all levels of the hierarchy.
    - **Moderate**: Reduced confidence at exactly one node (quality '0.5' but >50% support).
    - **Weak**: Low quality at one or more nodes (quality '0' or <50% support).
- **QRDR Monitoring**: The tool specifically tracks `gyrA` (S83L, S83A, D87G, D87N, D87Y) and `parC` (S80I). The `num QRDR` column provides a quick count of total mutations detected across these regions.
- **Incongruent Markers**: Check the `additional markers` and `max support for additional markers` columns to identify potential contamination or mixed populations where markers from different lineages are detected in the same sample.
- **Version Check**: Verify the genotyping scheme version currently loaded in Mykrobe using `mykrobe panels describe`.

## Reference documentation
- [GitHub - katholt/sonneityping](./references/github_com_katholt_sonneityping.md)
- [sonneityping - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sonneityping_overview.md)