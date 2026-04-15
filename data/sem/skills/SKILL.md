---
name: sem
description: SEM deconvolves MNase-seq fragment length profiles to characterize and distinguish between different nucleosome subtypes genome-wide. Use when user asks to identify nucleosome types, characterize nucleosome occupancy and fuzziness, or perform automated discovery of nucleosome subtypes using mixture models.
homepage: https://github.com/YenLab/SEM
metadata:
  docker_image: "quay.io/biocontainers/sem:1.2.3--hdfd78af_0"
---

# sem

## Overview

SEM is a specialized bioinformatics tool designed to deconvolve MNase-seq fragment length profiles to characterize nucleosome types genome-wide. Unlike standard nucleosome callers, SEM distinguishes between different nucleosome subtypes (e.g., canonical nucleosomes vs. hexasomes) by assuming each type protects a distinct DNA fragment length. It utilizes Gaussian Mixture Models (GMM) or Dirichlet Process Mixture Models (DPMM) to infer distribution parameters and provides metrics for dyad location, occupancy, fuzziness, and subtype mixture probability.

## Installation and Environment

SEM requires OpenJDK 11. While available on Bioconda, the developers recommend using the latest runnable JAR file for the most up-to-date features.

```bash
# Setup environment
conda create -n sem openjdk==11.0.27
conda activate sem

# Run the JAR
java -Xmx20G -jar sem-v1.3.0.jar [options]
```

## Core CLI Usage

### Required Arguments
- `--expt <file>`: Input experiment file (BAM/BED/SCIDX).
- `--format <SAM/BED/SCIDX>`: Format of the input experiment file.
- `--geninfo <file>`: Genome information file (e.g., `.fa.fai` index).
- `--out <prefix>`: Output directory and file prefix.

### Common Command Pattern
```bash
java -Xmx20G -jar sem.jar --expt data/sample.bam --format SAM --geninfo hg38.fa.fai --out results/sample_run --numClusters 3 --threads 4
```

## Expert Tips and Best Practices

### Memory Management
- **BAM Sorting**: Always sort BAM files by name before running SEM. While it can run on unsorted files, name-sorted files significantly reduce memory consumption.
- **Heap Size**: Use the `-Xmx` flag to allocate sufficient memory (e.g., `-Xmx20G`). If you encounter "Out of Memory" errors during hit loading, increase this value.

### Nucleosome Subtype Detection
- **Pre-analysis**: Run Picard `CollectInsertSizeMetrics` on your data first to visualize the fragment size distribution. This helps determine the appropriate value for `--numClusters`.
- **Parameter Optimization**: Use the `--onlyGMM` flag to run only the subtype characterization. This generates plots in the `intermediate-results` directory, allowing you to verify if the subtype distributions (mean and variance) make sense before committing to a full genome-wide run.
- **Automated Discovery**: If the number of subtypes is unknown, set `--numClusters -1` to use a Dirichlet Process Mixture Model (DPMM) which allows SEM to estimate the number of clusters automatically.
- **Custom Subtypes**: If you have known parameters, provide them via `--providedBindingSubtypes` in a tab-delimited file (format: `mean var weight`).

### Performance and Precision
- **Region Restriction**: To save time and compute resources, use `--providedPotentialRegions <bed_file>` to limit analysis to specific areas (e.g., ENCODE ccREs).
- **Edge Effects**: When using restricted regions, expand your BED regions (e.g., `bedtools slop -b 500`) and merge overlapping ones to prevent imprecise calling at the region boundaries.
- **EM Rounds**: The default is 3 rounds (`--r 3`). Increasing this may improve precision but increases the risk of overfitting.
- **Occupancy Threshold**: Use `--fixedalpha` to set the minimum number of fragments required for a nucleosome to be called (default is 1).

## Reference documentation
- [SEM Main Documentation](./references/github_com_YenLab_SEM.md)
- [Bioconda SEM Overview](./references/anaconda_org_channels_bioconda_packages_sem_overview.md)