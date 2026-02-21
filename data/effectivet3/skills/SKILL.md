---
name: effectivet3
description: EffectiveT3 (v3.0) is a bioinformatics tool designed for the binary classification of proteins to determine if they are secreted by the bacterial Type III secretion system.
homepage: https://github.com/nicolasrnemeth/EffectiveT3
---

# effectivet3

## Overview
EffectiveT3 (v3.0) is a bioinformatics tool designed for the binary classification of proteins to determine if they are secreted by the bacterial Type III secretion system. It utilizes a Light Gradient Boosting Machine (LGBM) model trained on sequence-based and amino acid property-based feature groups. Unlike previous methods that rely heavily on position-specific scoring matrices (PSSMs), EffectiveT3 focuses on N-terminal protein sequence information, allowing for faster computation and better identification of evolutionary distinct effectors.

## Command Line Usage

### Prediction
The primary command for identifying T3SS effectors in unknown protein sequences:
`effectivet3 [options]`

*   **Help**: Run `effectivet3 --help` to see all available arguments for input files, output directories, and model selection.
*   **Input**: Ensure protein sequences are provided in a standard format (such as FASTA) containing the N-terminal region.

### Training
To train a new model using custom datasets:
`effectiveTrain [options]`

*   **Help**: Run `effectiveTrain --help` to view parameters for training data paths and evaluation metrics.
*   **Configuration**: Training parameters are defined in a configuration file named `training_config.yaml`. If this file is not found or contains errors, the tool will automatically fall back to the default parameters used for the official Version 3.0 model.

## Best Practices and Expert Tips

- **N-Terminal Priority**: The model is specifically optimized for N-terminal sequence information. When preparing data, ensure the N-terminus is intact, as this is where the secretion signal for T3SS is typically located.
- **Handling Imbalanced Data**: EffectiveT3 is specifically designed to perform well on imbalanced datasets (where non-effectors far outnumber effectors). It uses evaluation metrics more suitable for this scenario than standard ROC-AUC.
- **Training Data Quality**: For custom training, use a negative dataset consisting of sequences from bacterial species that are known to have T3SS effectors. This improves the model's ability to distinguish between secreted and non-secreted proteins within the same cellular context.
- **Redundancy Reduction**: When building training sets, apply strict redundancy reduction to your sequences to prevent the model from over-fitting on closely related protein families.
- **Performance**: EffectiveT3 is significantly faster than PSSM-based tools like Bastion3, making it suitable for large-scale genomic or proteomic screenings.

## Reference documentation
- [EffectiveT3 Repository Overview](./references/github_com_nicolasrnemeth_EffectiveT3.md)