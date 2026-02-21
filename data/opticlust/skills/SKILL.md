---
name: opticlust
description: opticlust is a Python-based utility designed to streamline the often-arbitrary process of selecting clustering resolutions in single-cell genomics.
homepage: https://github.com/siebrenf/opticlust
---

# opticlust

## Overview
opticlust is a Python-based utility designed to streamline the often-arbitrary process of selecting clustering resolutions in single-cell genomics. It extends the standard Scanpy workflow by providing a systematic framework to score different resolutions and visualize how clusters split or merge using cluster trees. By automating the comparison of metrics and providing recolored UMAPs, it ensures that researchers can identify biologically relevant sub-populations with higher confidence and less manual iteration.

## Installation
Install opticlust via Conda or Pip:
```bash
# Via Bioconda
conda install -c bioconda opticlust

# Via PyPI
pip install opticlust
```

## Core Workflow
The typical opticlust workflow involves generating a range of clusterings and then evaluating them.

### 1. Generate Multi-Resolution Clustering
Use opticlust to run clustering (Leiden or Louvain) across a spectrum of resolutions.
```python
import opticlust as oc
import scanpy as sc

# Assuming 'adata' is pre-processed (neighbors calculated)
# This adds multiple clustering columns to adata.obs
oc.score_resolutions(adata, resolutions=[0.1, 0.2, 0.4, 0.8, 1.2])
```

### 2. Visualize Cluster Evolution
The `clustree` function is essential for seeing how cells move between clusters as resolution increases.
```python
# Generate a cluster tree plot
oc.clustree(adata)

# To maintain cluster identity tracking without automatic renaming:
oc.clustree(adata, rename_cluster=False)
```

### 3. Get Recommendations
Opticlust can suggest the best resolutions based on internal scoring metrics.
```python
# Returns recommendations for low, medium, and high granularity
recommendations = oc.recommend_resolutions(adata)
print(recommendations)
```

### 4. Comparative Visualization
Use `clustering_plot` to view UMAPs side-by-side with their respective scores.
```python
oc.clustering_plot(adata)
```

## Tool-Specific Best Practices
- **Cluster Stability**: Use the `clustree` output to look for "stable" branches. If a cluster frequently swaps members or disappears/reappears across small resolution increments, it may not be a robust biological population.
- **Automatic Recoloring**: One of opticlust's primary advantages is automatic cluster recoloring. This ensures that "Cluster 1" at resolution 0.4 is the same color as its primary descendant at resolution 0.5, making UMAP comparisons visually intuitive.
- **Performance with Large Datasets**: For very large cell populations, the Silhouette score calculation can be slow. Recent versions (v0.4.3+) automatically subset large populations to improve performance.
- **Integration with Scanpy**: Opticlust is designed to work directly on `AnnData` objects. Ensure you have run `sc.pp.neighbors(adata)` before calling opticlust functions, as they rely on the neighbor graph.
- **Layout Optimization**: If the cluster tree layout looks cluttered, ensure `pygraphviz` is installed, as opticlust uses it to improve node positioning.

## Reference documentation
- [opticlust GitHub Repository](./references/github_com_siebrenf_opticlust.md)
- [opticlust Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_opticlust_overview.md)
- [opticlust Version Tags and Release Notes](./references/github_com_siebrenf_opticlust_tags.md)