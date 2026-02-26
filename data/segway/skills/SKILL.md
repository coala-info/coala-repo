---
name: segway
description: Segway performs unsupervised segmentation and annotation of multi-track functional genomics data using Dynamic Bayesian Networks at 1-bp resolution. Use when user asks to initialize models from Genomedata, train parameters on epigenomic tracks, or identify genomic states to generate segmentation BED files.
homepage: http://segway.hoffmanlab.org/
---


# segway

## Overview

Segway is a specialized tool for the unsupervised segmentation and annotation of multi-track functional genomics data. Unlike many other segmenters, it operates at 1-bp resolution and utilizes Dynamic Bayesian Networks (DBNs) to handle heterogeneous patterns of missing data across different experiments. This skill provides the necessary command-line patterns and procedural knowledge to initialize, train, and identify genomic states using the Segway workflow.

## Core Workflow and CLI Patterns

The Segway workflow typically follows a three-stage process: initialization, training, and identification (segmentation).

### 1. Initialization
Before training, you must generate the model files and world files based on your input data.

```bash
segway init genomedata-dir/ output-dir/
```
*   **Tip**: Ensure your input data is in `Genomedata` format. If you have BigWig or BED files, they must be converted using the `genomedata-load` tool first.

### 2. Training
Training optimizes the DBN parameters to fit your specific epigenomic tracks.

```bash
segway train genomedata-dir/ output-dir/
```
*   **Minibatch Training**: For large genomes or many tracks, use minibatch training (available in version 2.0+) to significantly reduce memory overhead and time.
*   **Layer Control**: You can specify the number of labels (states) to discover using the `--num-labels` flag (default is often 25, but 10-15 is common for simpler interpretations).

### 3. Identification (Segmentation)
Once the model is trained, use it to generate the actual BED files representing the genomic segments.

```bash
segway identify genomedata-dir/ training-dir/ identification-dir/
```
*   **Output**: The primary output is a `segway.bed.gz` file, which contains the coordinates and assigned labels for the entire genome.

## Expert Tips and Best Practices

*   **Resolution**: Segway's strength is 1-bp resolution. Avoid downsampling your data unless computational resources are extremely limited, as Segway is designed to handle the maximum resolution of ChIP-seq data.
*   **Missing Data**: Segway natively handles missing data tracks. You do not need to impute missing values before running the tool; the DBN model accounts for these gaps during inference.
*   **Cluster Integration**: Segway is designed to run on high-performance computing (HPC) clusters. It supports Sun Grid Engine (SGE), Oracle Grid Engine, and Platform LSF. Use the `--cluster-opt` flags to pass specific resource requirements to your scheduler.
*   **Mnemonic Assignment**: After identification, the labels (e.g., 0, 1, 2) are arbitrary. You must perform functional enrichment analysis (e.g., looking for H3K4me3 at promoters) to assign biological mnemonics like "Promoter" or "Enhancer" to the numeric labels.

## Reference documentation

- [Segway Home and Documentation Overview](./references/segway_hoffmanlab_org_index.md)
- [Bioconda Segway Package Details](./references/anaconda_org_channels_bioconda_packages_segway_overview.md)