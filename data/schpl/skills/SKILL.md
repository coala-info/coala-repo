---
name: schpl
description: The `schpl` (scHPL) skill provides a workflow for the hierarchical progressive learning of cell identities.
homepage: https://github.com/lcmmichielsen/scHPL
---

# schpl

## Overview
The `schpl` (scHPL) skill provides a workflow for the hierarchical progressive learning of cell identities. It is designed to match cell populations across different single-cell datasets and organize them into a hierarchical tree structure. This approach allows for the identification of known cell types and the detection of previously unknown populations using various classification algorithms like SVMs and kNN.

## Usage Guidelines

### Data Preparation
*   **Pre-alignment Required**: `scHPL` is not a batch correction tool. You must align your datasets before attempting to match cell populations.
*   **Recommended Tools**: Use `scVI` or `scArches` (specifically the `treeArches` framework) for dataset alignment prior to using `scHPL`.

### Training and Classification
*   **Algorithm Selection**:
    *   **Linear SVM**: Good for standard classification tasks with clear boundaries.
    *   **kNN**: Useful for local similarity-based classification.
    *   **One-class SVM**: Essential when you need to detect "unknown" or novel cell populations that were not present in the training data.
*   **Hierarchical Structure**: The tool automatically finds relationships between populations across multiple datasets to build the classification tree.

### Performance Optimization
*   **GPU Acceleration**: For large-scale datasets, utilize FAISS with GPU support to speed up prediction tasks.
*   **Probabilities**: When predicting labels for new datasets, you can enable the option to return classification probabilities for more nuanced analysis.

## Best Practices
*   **Progressive Learning**: Add datasets sequentially to the pipeline to allow the hierarchy to evolve as new populations are discovered.
*   **Reference Atlases**: Use the `treeArches` framework if you are building or updating large-scale reference atlases, as it integrates `scHPL` with `scArches` for automated updates.

## Reference documentation
- [scHPL GitHub Repository](./references/github_com_lcmmichielsen_scHPL.md)
- [scHPL Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_schpl_overview.md)