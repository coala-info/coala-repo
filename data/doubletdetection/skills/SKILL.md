---
name: doubletdetection
description: DoubletDetection is a Python-based tool designed to identify and enable the removal of doublets from scRNA-seq data.
homepage: https://github.com/JonathanShor/DoubletDetection
---

# doubletdetection

## Overview
DoubletDetection is a Python-based tool designed to identify and enable the removal of doublets from scRNA-seq data. It functions by creating synthetic doublets from the provided count matrix and training a classifier to distinguish these artifacts from real single cells. This process is essential for ensuring the biological integrity of downstream analyses, such as clustering and differential expression, which can be skewed by the presence of hybrid transcriptomes.

## Installation
The package can be installed via Conda (Bioconda channel) or PyPI:

```bash
# Using Conda
conda install bioconda::doubletdetection

# Using pip
pip install doubletdetection
```

## Basic Usage
DoubletDetection is primarily used as a Python library. The core interface is the `BoostClassifier`.

```python
import doubletdetection

# raw_counts should be a cells-by-genes count matrix (array-like or sparse)
clf = doubletdetection.BoostClassifier()

# Fit the model and predict doublet labels
# labels: 1 = doublet, 0 = singlet, np.nan = ambiguous
labels = clf.fit(raw_counts).predict()

# Retrieve likelihood scores
# Higher scores indicate a higher probability of being a doublet
scores = clf.doublet_score()
```

## Best Practices and Expert Tips
*   **Input Requirements**: The input `raw_counts` must be a raw count matrix where rows represent cells and columns represent genes.
*   **Batch Processing**: Always apply DoubletDetection individually to each library or "run" before aggregating data. Applying it to a merged dataset containing multiple batches can lead to inaccurate results due to batch-specific doublet characteristics.
*   **Cell Type Diversity**: The algorithm performs most effectively when the dataset contains several distinct cell types, as this provides more contrast for identifying synthetic doublets.
*   **Clustering Methods**: While Phenograph is the traditional clustering method used by the tool, version 2.5+ introduced an experimental Scanpy-based Louvain clustering method which is significantly faster for large datasets.
*   **Memory Management**: For very large matrices, ensure the input is in a sparse format (like `scipy.sparse.csr_matrix`) to reduce the memory footprint during the synthetic doublet generation phase.
*   **Interpreting Labels**:
    *   `1`: High-confidence doublet.
    *   `0`: High-confidence singlet.
    *   `np.nan`: Ambiguous cell that does not clearly fall into either category based on the classifier's threshold.

## Reference documentation
- [github_com_JonathanShor_DoubletDetection.md](./references/github_com_JonathanShor_DoubletDetection.md)
- [anaconda_org_channels_bioconda_packages_doubletdetection_overview.md](./references/anaconda_org_channels_bioconda_packages_doubletdetection_overview.md)