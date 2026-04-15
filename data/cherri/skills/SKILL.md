---
name: cherri
description: CheRRI evaluates and filters RNA-RNA interaction datasets to identify biologically relevant functional sites and reduce false positives. Use when user asks to identify trusted interaction sites, train custom classification models, or score and filter RNA-RNA interactions based on biological relevance.
homepage: https://github.com/BackofenLab/Cherri
metadata:
  docker_image: "quay.io/biocontainers/cherri:0.8--pyh7cba7a3_0"
---

# cherri

## Overview

CheRRI (Computational Help Evaluating RNA-RNA interactions) is a specialized tool designed to improve the quality of RNA-RNA interaction datasets. It addresses the high rate of false positives often found in both experimental interactome data and computational RRI predictions. By evaluating the likelihood that an interaction site occurs in nature, CheRRI helps researchers focus on biologically relevant functional sites.

The tool operates in two primary modes:
1.  **Train Mode**: Generates a new classification model by identifying "trusted" RRIs—sites consistently found across multiple replicates—and extracting a comprehensive feature set.
2.  **Eval Mode**: Uses a model to score and filter a provided set of RRI sites based on their biological relevance.

## Core Workflow and CLI Usage

CheRRI is typically installed via Conda and provides several executable binaries. The main entry point is `cherri`, supported by utility scripts for specific pipeline stages.

### 1. Identifying Trusted Interactions
Before training, use replicate data to establish a ground truth. CheRRI considers an RRI site "trusted" if it appears in all replicates within a defined overlap threshold.

*   **Tool**: `find_trusted_RRI.py`
*   **Logic**: Input your interactome datasets (replicates). The script outputs the consensus sites used for model training.

### 2. Feature Generation
Both training and evaluation require a feature set. CheRRI integrates structural and energetic features, often leveraging `IntaRNA` parameters.

*   **Tool**: `get_features.py`
*   **Key Features**: Includes sequence context, hybridization energy, and structural accessibility.

### 3. Model Training (Train Mode)
Use this mode when you have a specific organism or experimental setup and want to build a custom classifier.

*   **Command**: `cherri train [options]`
*   **Process**: 
    1.  Provide the trusted RRI set.
    2.  The tool generates positive and negative training instances (often using `generate_pos_neg_with_context.py`).
    3.  It trains a model (typically using `xgboost` or `scikit-learn` backends).

### 4. Interaction Evaluation (Eval Mode)
Use this mode to filter your candidate RRI sites.

*   **Command**: `cherri eval --model <model_file> --input <rri_sites>`
*   **Output**: A scored list of interactions where higher scores indicate a higher probability of being a functional, biologically relevant site.

## Expert Tips and Best Practices

*   **Replicate Thresholds**: When using `find_trusted_RRI.py`, the overlap threshold is critical. Too strict a threshold may reduce your training set size significantly, while too loose a threshold may introduce noise into the "trusted" set.
*   **Context Windows**: Ensure that the genomic or transcriptomic context provided to `generate_pos_neg_with_context.py` is sufficient for `IntaRNA` to calculate accurate accessibility and hybridization energies.
*   **Dependency Alignment**: CheRRI relies on specific versions of `IntaRNA` (v3.2.0) and `ushuffle`. Ensure these are in your PATH to avoid feature extraction errors.
*   **Occupied Regions**: Use `find_occupied_regions.py` to map out where interactions are clustered, which can be useful for visualizing the density of the interactome before running the full evaluation.



## Subcommands

| Command | Description |
|---------|-------------|
| cherri eval | Evaluate RRIs using a trained model. |
| cherri train | Train a Cherri model. |

## Reference documentation
- [CheRRI GitHub Repository Overview](./references/github_com_BackofenLab_Cherri.md)
- [CheRRI README and Workflow](./references/github_com_BackofenLab_Cherri_blob_master_README.md)
- [Installation and Requirements](./references/github_com_BackofenLab_Cherri_blob_master_requirements.txt.md)
- [Package Metadata and Scripts](./references/github_com_BackofenLab_Cherri_blob_master_setup.py.md)