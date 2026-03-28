---
name: basenji
description: Basenji is a deep learning framework that predicts quantitative genomic signals and regulatory activity from chromosome-scale DNA sequences. Use when user asks to predict gene expression from sequence, score the impact of variants using SNP activity difference, perform in silico mutagenesis, or train models on functional genomics data.
homepage: https://github.com/calico/basenji
---

# basenji

## Overview

Basenji is a deep learning framework designed for functional genomics, specifically for predicting regulatory activity along chromosome-scale DNA sequences. Unlike its predecessor Basset, which focused on binary peak classification, Basenji utilizes regression loss functions to predict quantitative signals (such as CAGE, ChIP-seq, or DNase-seq) in bins across long sequences. It is a critical tool for researchers aiming to understand the "grammar" of the non-coding genome, allowing for the scoring of variants based on their predicted influence on gene expression and the annotation of distal regulatory elements.

## Environment Setup

Before running Basenji tools, ensure your environment variables are configured to point to the installation directory:

```bash
export BASENJIDIR=~/code/Basenji
export PATH=$BASENJIDIR/bin:$PATH
export PYTHONPATH=$BASENJIDIR/bin:$PYTHONPATH
```

## Core Workflows and CLI Usage

### 1. Data Preprocessing
The goal of preprocessing is to transform raw alignments into a format suitable for deep learning (HDF5).

*   **Generate Coverage Tracks**: Use `bam_cov.py` to convert BAM/CRAM alignments into normalized BigWig or HDF5 tracks.
    *   `bam_cov.py <bam_file> <output_file>` (Use `.bw` suffix for BigWig).
*   **Aggregate Samples**: Combine multiple coverage tracks into a single HDF5 file for training.
    *   **Single Machine**: `basenji_hdf5_single.py <fasta_file> <sample_wigs_file> <output_hdf5_file>`
    *   **SLURM Cluster**: `basenji_hdf5_cluster.py <fasta_file> <sample_wigs_file> <output_hdf5_file>`
*   **Gene-Centric Tiling**: To focus on specific genes, use `basenji_hdf5_genes.py` to tile gene sequences.
    *   `basenji_hdf5_genes.py <fasta_file> <gtf_file> <output_hdf5_file>`

### 2. Model Training
Training should always be performed on a GPU for viable performance.

*   **Execute Training**: `basenji_train.py <params_file> <data_file>`
*   **Expert Tip**: Use the `--log_device_placement` flag to verify that TensorFlow is correctly utilizing the GPU (`gpu:0`). If the output shows `cpu:0` for CNN operations, check your CUDA/cuDNN installation.

### 3. Evaluation and Accuracy
*   **Standard Test**: `basenji_test.py <params_file> <model_file> <data_file>`
*   **Gene-Specific Accuracy**: `basenji_test_genes.py <params_file> <model_file> <data_file>`

### 4. Variant and Regulatory Analysis
Basenji provides specialized tools for interpreting how DNA sequence changes affect function.

*   **SNP Activity Difference (SAD)**: Predict the impact of SNPs on regulatory activity.
    *   `basenji_sad.py [options] <model_file> <vcf_file>`
*   **Expression Difference (SED)**: Specifically score variants for their influence on gene expression.
    *   `basenji_sed.py [options] <model_file> <vcf_file>`
*   **In Silico Mutagenesis**: Use `basenji_sat.py` or `basenji_sat_vcf.py` to perform saturated mutagenesis, identifying every nucleotide's contribution to a regulatory element's function.

## Best Practices

*   **Binning Strategy**: Basenji makes predictions in bins. If you need to replicate Basset-style peak classification, provide smaller sequences and bin the target for the entire sequence.
*   **Memory Management**: When processing chromosome-scale sequences, use the cluster-parallelized scripts (`_cluster.py`) if available to avoid OOM (Out of Memory) errors on single nodes.
*   **Regression vs. Classification**: Always prefer regression loss functions for quantitative signals to capture the full dynamic range of genomic data.



## Subcommands

| Command | Description |
|---------|-------------|
| basenji_motifs.py | Analyze and visualize motifs identified by a trained Basenji model. |
| basenji_sat.py | Compute saturation mutagenesis scores for sequences in an HDF5 file using a trained Basenji model. |

## Reference documentation
- [Basenji Main README](./references/github_com_calico_basenji_blob_master_README.md)
- [Preprocessing Documentation](./references/github_com_calico_basenji_blob_master_docs_preprocess.md)
- [Training Documentation](./references/github_com_calico_basenji_blob_master_docs_train.md)