---
name: snapatac2
description: SnapATAC2 is a high-performance Python and Rust framework designed for the end-to-end analysis of large-scale single-cell omics data, particularly single-cell ATAC-seq. Use when user asks to import fragment files, perform spectral embedding and clustering, call peaks using MACS3, or integrate multiple single-cell datasets.
homepage: https://github.com/kaizhang/SnapATAC2
metadata:
  docker_image: "quay.io/biocontainers/snapatac2:2.8.0--py310h9e9ef0c_1"
---

# snapatac2

## Overview
SnapATAC2 is a high-performance framework written in Python and Rust designed for the end-to-end analysis of single-cell omics data. It is particularly optimized for single-cell ATAC-seq but extends to RNA-seq, Hi-C, and methylation data. The tool excels in scalability, utilizing matrix-free spectral embedding and fully backed AnnData objects to process millions of cells with minimal memory overhead. Use this skill to guide workflows from raw fragment import to regulatory network inference and multi-sample integration.

## Core Workflow Patterns

### 1. Data Import and Preprocessing
SnapATAC2 uses a "backed" AnnData format, meaning data stays on disk until needed.

```python
import snapatac2 as sa

# Import fragment files and create a backed .h5ad file
data = sa.pp.import_fragments(
    "fragments.tsv.gz",
    output_file="sample.h5ad",
    genome=sa.genome.hg38,
    min_num_fragments=500
)

# Generate a tile matrix (e.g., 500bp bins) for initial embedding
sa.pp.add_tile_matrix(data, bin_size=500)
```

### 2. Dimension Reduction and Clustering
The spectral embedding algorithm is the default for epigenomic data as it handles the sparsity of ATAC-seq effectively.

```python
# Select highly variable features
sa.pp.select_features(data)

# Matrix-free spectral embedding
sa.tl.spectral(data)

# Build KNN graph and cluster using Leiden
sa.pp.knn(data, use_rep="X_spectral")
sa.tl.leiden(data)

# Compute UMAP for visualization
sa.tl.umap(data, use_rep="X_spectral")
```

### 3. Peak Calling and Matrix Generation
After clustering, call peaks on groups of cells to create a cell-by-peak matrix.

```python
# Call peaks using MACS3 for each cluster
sa.tl.macs3(data, groupby="leiden")

# Merge peaks into a consensus set
peaks = sa.tl.merge_peaks(sa.tl.get_peaks(data), sa.genome.hg38)

# Create the peak-count matrix
sa.pp.make_peak_matrix(data, use_peaks=peaks)
```

### 4. Integration and Batch Correction
For multi-sample analysis, use `AnnDataSet` to lazily concatenate multiple files.

```python
# Create an AnnDataSet from multiple backed files
dataset = sa.read_dataset(
    adatas=[("sample1", "s1.h5ad"), ("sample2", "s2.h5ad")],
    output_file="integrated.h5ads"
)

# Harmony or Scanorama can be used for batch correction
sa.pp.harmony(dataset, batch="sample")
```

## Expert Tips and Best Practices
- **Memory Management**: Always use the `output_file` parameter in `import_fragments` to ensure the AnnData object is backed by HDF5. This prevents OOM (Out of Memory) errors on large datasets.
- **Feature Selection**: For ATAC-seq, `sa.pp.select_features` typically filters out the top 1% of bins (often representing promoters or repetitive regions) to focus on informative distal regulatory elements.
- **Genome Objects**: Use the built-in genome objects (e.g., `sa.genome.GRCh38`, `sa.genome.mm10`) to automatically handle chromosome sizes and gene annotations.
- **Visualization**: Use `sa.pl.umap` for standard embeddings and `sa.pl.coverage` to visualize "pseudo-bulk" tracks for specific genomic regions across clusters.

## Reference documentation
- [SnapATAC2 Overview](./references/scverse_org_SnapATAC2_index.html.md)
- [API Reference](./references/scverse_org_SnapATAC2_api_index.html.md)
- [Standard PBMC Pipeline Tutorial](./references/scverse_org_SnapATAC2_tutorials_pbmc.html.md)
- [Multi-sample Integration Guide](./references/scverse_org_SnapATAC2_tutorials_integration.html.md)