---
name: centroid_rna_package
description: The centroid_rna_package predicts RNA secondary structures using the gamma-centroid estimator for single sequences and multiple sequence alignments. Use when user asks to predict RNA secondary structures, find consensus structures from alignments, or use the gamma-centroid estimator to balance prediction sensitivity and specificity.
homepage: https://github.com/satoken/centroid-rna-package
metadata:
  docker_image: "quay.io/biocontainers/centroid_rna_package:0.0.16--0"
---

# centroid_rna_package

## Overview
The `centroid_rna_package` provides a suite of tools—primarily `centroid_fold` and `centroid_alifold`—designed for RNA secondary structure prediction. Unlike traditional Minimum Free Energy (MFE) methods, these tools utilize the gamma-centroid estimator, which often yields higher accuracy by balancing precision and recall. It supports multiple underlying probability distributions (engines) and allows for the prediction of both single-sequence structures and consensus structures for multiple sequence alignments (MSA).

## Core CLI Usage

### Single Sequence Prediction
Use `centroid_fold` for individual FASTA sequences.

```bash
# Basic prediction using the default McCaskill engine
centroid_fold sequence.fa

# Prediction using a specific weight (gamma) for base pairs
# Higher gamma increases sensitivity (more base pairs)
centroid_fold -g 4.0 sequence.fa

# Using the CONTRAfold engine for inference
centroid_fold -e CONTRAfold sequence.fa
```

### Multiple Alignment Prediction
Use `centroid_alifold` for RNA alignments in CLUSTAL format.

```bash
# Predict common secondary structure from an alignment
centroid_alifold alignment.aln

# Adjusting gamma for alignment-based prediction
centroid_alifold -g 2.0 alignment.aln
```

## Command Options and Best Practices

### Inference Engines (`-e` / `--engine`)
The package supports several engines. Choosing the right one depends on your accuracy requirements and available data:
*   **McCaskill**: (Default) Uses the Vienna RNA package implementation. Highly recommended when using Boltzmann likelihood parameters.
*   **CONTRAfold**: Uses a discriminative model; often effective for sequences where thermodynamic parameters might be less accurate.
*   **pfold**: Available if the pfold package is installed; uses a stochastic context-free grammar.
*   **RNAalifold**: Used within `centroid_alifold` for alignment-based predictions.

### Parameter Tuning
*   **Gamma (`-g`)**: This is the most critical parameter. It represents the weight of base pairs. 
    *   `gamma = 1.0`: Equivalent to the Maximum Expected Accuracy (MEA) estimator.
    *   `gamma > 1.0`: Favors sensitivity (predicts more base pairs).
    *   `gamma < 1.0`: Favors specificity (predicts fewer, more certain base pairs).
*   **Non-canonical pairs**: Use the `--noncanonical` flag if you wish to allow base pairs other than AU, GC, and GU.

### Expert Tips
*   **Accuracy**: For the highest accuracy on single sequences, use the McCaskill engine with Boltzmann likelihood parameters (Andronescue et al., 2010).
*   **Input Formats**: Ensure single sequences are in FASTA format and alignments are in CLUSTAL format.
*   **Docker Execution**: If the local environment lacks dependencies (Boost, Vienna RNA), use the provided Docker container:
    `docker run --rm -it -v $(pwd):/workspaces centroid_fold centroid_fold [options] input.fa`



## Subcommands

| Command | Description |
|---------|-------------|
| centroid_alifold | CentroidAlifold v0.0.16 for predicting common RNA secondary structures |
| centroid_fold | CentroidFold v0.0.16 for predicting RNA secondary structures |

## Reference documentation
- [CentroidFold README](./references/github_com_satoken_centroid-rna-package_blob_master_README.md)
- [Dockerfile for CentroidFold](./references/github_com_satoken_centroid-rna-package_blob_master_Dockerfile.md)