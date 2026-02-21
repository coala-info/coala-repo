---
name: vsclust
description: vsclust provides a specialized framework for analyzing quantitative biological datasets.
homepage: https://bitbucket.org/veitveit/vsclust/src/master/
---

# vsclust

## Overview
vsclust provides a specialized framework for analyzing quantitative biological datasets. Unlike standard clustering algorithms that treat all data points equally, vsclust incorporates the variance between replicates to improve the identification of truly co-regulated features. It is particularly effective for time-course or multi-condition omics experiments where measurement noise can otherwise obscure biological signals.

## CLI Usage and Best Practices

### Core Command Structure
The command-line interface allows for automated processing of expression matrices.
```bash
# Basic execution pattern
vsclust [options] -i <input_file> -o <output_directory>
```

### Input Data Requirements
- **Format**: Tab-separated (TSV) or comma-separated (CSV) files.
- **Structure**: Rows should represent features (e.g., proteins, genes) and columns should represent samples/replicates.
- **Preprocessing**: Ensure data is log-transformed (usually Log2) before running the clustering algorithm for optimal variance estimation.

### Statistical Testing and Clustering
- **Variance Sensitivity**: Always provide replicate information when available. The algorithm uses this to weight the clustering, giving more importance to features with consistent measurements across replicates.
- **Cluster Selection**: Use the built-in estimation tools to determine the optimal number of clusters (k) based on the dataset's complexity.
- **Filtering**: Apply basic filtering to remove features with excessive missing values before processing to improve the stability of the clusters.

### Expert Tips
- **Interactive Exploration**: While the CLI is powerful for batch processing, use the Shiny-based web interface for initial parameter tuning and visual inspection of cluster profiles.
- **Data Browsing**: Use the output files to generate heatmaps and profile plots to validate that the identified clusters represent distinct biological trends.
- **Integration**: The output tables are structured for easy import into downstream functional enrichment analysis tools.

## Reference documentation
- [vsclust Source and Documentation](./references/bitbucket_org_veitveit_vsclust_src_master.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_vsclust_overview.md)