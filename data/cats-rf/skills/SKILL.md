---
name: cats-rf
description: CATS-rf (Comprehensive Assessment of Transcript Sequences - reference-free) is a diagnostic tool for assessing the quality of transcriptomes assembled from short-read RNA-seq data.
homepage: https://github.com/bodulic/CATS-rf
---

# cats-rf

## Overview

CATS-rf (Comprehensive Assessment of Transcript Sequences - reference-free) is a diagnostic tool for assessing the quality of transcriptomes assembled from short-read RNA-seq data. It generates a transcript quality score ($S_t$) by integrating four metrics: coverage (detecting insertions/redundancy), accuracy (sequence fidelity), local fidelity (structural errors), and integrity (fragmentation). Use this skill to execute the evaluation pipeline, interpret assembly metrics, and compare multiple assembly versions to select the highest quality output.

## Installation and Environment

The most reliable way to use CATS-rf is via Bioconda or Docker to ensure all dependencies (R, Bowtie2, Samtools, kallisto, etc.) are correctly configured.

```bash
# Conda installation
conda install -c bioconda cats-rf

# Docker usage pattern
docker run --rm -v "$PWD":/data -w /data bodulic/cats-rf CATS_rf [OPTIONS]
```

## Core Command Line Usage

### Paired-End Assembly Evaluation (Standard)
The default mode for CATS-rf assumes paired-end reads.

```bash
CATS_rf [OPTIONS] <assembly.fasta> <reads_1.fastq.gz> <reads_2.fastq.gz>
```

### Single-End Assembly Evaluation
Single-end mode requires explicit fragment size parameters (`-m` for mean and `-s` for standard deviation).

```bash
CATS_rf -C se -m <mean_fragment_size> -s <sd_fragment_size> [OPTIONS] <assembly.fasta> <reads.fastq.gz>
```

### Comparing Multiple Assemblies
Use `CATS_rf_compare` to generate a comparative report (HTML) for different assembly versions or tools.

```bash
CATS_rf_compare -n <name1,name2> -d <dir1,dir2> -o <output_directory>
```

## Key Options and Best Practices

- **Strandness (`-S`)**: If the library preparation was stranded, specify `fr` (forward-reverse) or `rf` (reverse-forward). Use `-S a` for automatic detection based on the first 100,000 mappings.
- **Thread Allocation (`-t`)**: Increase threads to speed up the mapping and quantification steps.
- **Output Management (`-o`)**: Always specify a dedicated output directory to keep results organized, as CATS-rf generates multiple intermediate files and metrics.
- **Resource Estimation**: For a standard human transcriptome (~20M reads), expect a runtime of approximately 1 hour on typical hardware.

## Interpreting Results

- **Transcript Score ($S_t$)**: A value between 0 and 1. Higher values indicate better mapping evidence and fewer predicted errors.
- **Assembly Score ($S$)**: The mean of all individual transcript scores, providing a global quality metric for the entire assembly.
- **Component Scores**:
    - **Coverage ($S_c$)**: Identifies low-coverage regions suggesting insertions.
    - **Accuracy ($S_a$)**: Highlights regions with high mismatch rates.
    - **Local Fidelity ($S_l$)**: Detects inconsistent pair mapping (deletions/inversions).
    - **Integrity ($S_i$)**: Measures transcript fragmentation.

## Reference documentation
- [CATS-rf GitHub Repository](./references/github_com_bodulic_CATS-rf.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cats-rf_overview.md)