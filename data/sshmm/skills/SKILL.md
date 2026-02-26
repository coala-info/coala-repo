---
name: sshmm
description: ssHMM is a bioinformatics tool that identifies RNA-binding protein motifs by integrating primary sequence data with secondary structure information. Use when user asks to recover motifs from CLIP-Seq data, train sequence-structure hidden Markov models, or visualize RNA motifs as model graphs.
homepage: https://github.molgen.mpg.de/heller/ssHMM
---


# sshmm

## Overview

ssHMM (Sequence-structure Hidden Markov Model) is a specialized bioinformatics tool designed to recover motifs from RNA-binding protein data. While many motif finders focus exclusively on primary nucleotide sequences, ssHMM incorporates secondary structure information, allowing for the identification of motifs that are defined by both sequence composition and structural context (e.g., stem-loops or bulges). The tool is primarily used to process CLIP-Seq datasets, train models on binding sites, and visualize the resulting motifs.

## Installation and Setup

The recommended way to install ssHMM is via Bioconda:

```bash
conda install -c bioconda sshmm
```

## Core Workflow and CLI Patterns

The ssHMM workflow typically consists of three main stages: preprocessing, model training, and visualization.

### 1. Data Preprocessing
The `preprocess_dataset` script prepares raw binding site data for HMM training. It handles sequence extraction and secondary structure prediction.

*   **Skip Dependency Checks**: If you have manually verified your environment (e.g., RNAstructure or RNAshapes are in your PATH), use the `-s` flag to speed up execution.
*   **Elongation Span**: Use the elongation span parameter to specify how much the original binding sites should be extended. This is critical for improving the accuracy of secondary structure predictions, as local folding often depends on flanking nucleotides.
*   **Filtering**: The script automatically filters out binding sites with unknown chromosomes and limits the number of predicted RNAshapes (typically to 10 per sequence) to maintain computational efficiency.

### 2. Model Training
The `train_seqstructhmm` script is the core engine for motif discovery.

*   **Parameter Estimation**: Use the `--baum_welch` option to perform Baum-Welch training for the hidden Markov model. Ensure you are using version 1.0.7 or later, as earlier versions had known issues with this specific parameter logic.
*   **Input**: This script typically consumes the processed datasets generated in the previous step.

### 3. Visualization
Once a model is trained, it is stored in an XML format. To interpret the motif, you must convert this into a visual representation.

*   **Generate Graphs**: Use the `draw_model_graph` script to regenerate a model graph in PNG format from the XML model file.
*   **Interpretation**: The resulting graph illustrates the transitions between states representing different sequence-structure combinations.

## Expert Tips

*   **Dependency Management**: ssHMM relies on external tools for RNA structure prediction (like RNAstructure). If `preprocess_dataset` fails, verify that these dependencies are correctly installed and accessible in your shell environment.
*   **Version Consistency**: Always check that you are running version 1.0.7, especially when using the Baum-Welch training features, to avoid illogical parameter errors found in older releases.
*   **Memory Efficiency**: When working with very large CLIP-Seq datasets, be mindful of the number of predicted RNAshapes per nucleotide, as this significantly impacts the state space of the HMM.

## Reference documentation
- [ssHMM Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sshmm_overview.md)
- [ssHMM GitHub Repository](./references/github_molgen_mpg_de_heller_ssHMM.md)
- [ssHMM Release Notes](./references/github_molgen_mpg_de_heller_ssHMM_releases.md)