---
name: pathogen-embed
description: pathogen-embed is a specialized toolkit designed to transform high-dimensional pathogen sequence alignments into interpretable 2D or 3D visualizations.
homepage: https://github.com/blab/pathogen-embed
---

# pathogen-embed

## Overview
pathogen-embed is a specialized toolkit designed to transform high-dimensional pathogen sequence alignments into interpretable 2D or 3D visualizations. It streamlines the bioinformatic workflow from raw FASTA alignments to clustered embeddings, allowing researchers to identify reassortment groups, evolutionary lineages, and genetic diversity patterns. Use this tool to perform PCA, MDS, t-SNE, or UMAP on viral populations and to programmatically identify clusters within those embeddings.

## Installation
Install the package via Bioconda or pip:
```bash
conda install -c conda-forge -c bioconda pathogen-embed
# OR
pip install pathogen-embed
```

## Core Workflow Patterns

### 1. Calculate Genetic Distances
The first step requires a distance matrix. Use the native command or an external tool for speed.

**Native calculation:**
```bash
pathogen-distance \
  --alignment alignment.fasta \
  --output distances.csv
```

**High-performance alternative (SNPs only):**
For large datasets where indels can be ignored, use `snp-dists` and convert the output to the expected CSV format:
```bash
snp-dists -c -b alignment.fasta > distances.csv
```

### 2. Generate Embeddings
Create a reduced-dimension representation (e.g., t-SNE). Note that the embedding command requires both the original alignment and the distance matrix.

**Standard t-SNE:**
```bash
pathogen-embed \
  --alignment alignment.fasta \
  --distance-matrix distances.csv \
  --output-dataframe tsne.csv \
  --output-figure tsne.pdf \
  t-sne --perplexity 45.0
```
*Tip: Ensure the `--perplexity` value is less than or equal to the total number of samples in your input.*

### 3. Identify Clusters
Identify groups within the embedding using HDBSCAN.

```bash
pathogen-cluster \
  --embedding tsne.csv \
  --label-attribute tsne_label \
  --output-dataframe clusters.csv \
  --output-figure clusters.pdf
```
*Note: Samples that cannot be reliably assigned to a cluster receive a label of "-1".*

## Advanced Usage: Segmented Genomes
To identify reassortment groups (e.g., for Influenza HA and NA), calculate distances for each segment separately and pass them as a list.

**Requirements:**
- Alignments must have identical sequence names in the same order.
- Use `seqkit sort -n` if alignments are not ordered.

**Execution:**
```bash
pathogen-embed \
  --alignment segment1.fasta segment2.fasta \
  --distance-matrix dist1.csv dist2.csv \
  --output-dataframe multi_segment_tsne.csv \
  t-sne --perplexity 30.0
```

## Expert Tips and Best Practices
- **Alignment Sorting**: Always verify that your FASTA headers match exactly across different segments when performing multi-gene analysis.
- **PCA Initialization**: By default, t-SNE embeddings are initialized by a PCA embedding of the alignments to improve consistency.
- **Distance Thresholds**: Use the `pathogen-embed` pairwise distance figure output to determine the relationship between genetic distance and Euclidean distance. This helps in setting a meaningful `--distance-threshold` for `pathogen-cluster`.
- **Memory Management**: For extremely large alignments, consider using the `simplex` encoding (default in v3.0+) for PCA to reduce memory overhead.

## Reference documentation
- [pathogen-embed GitHub Repository](./references/github_com_blab_pathogen-embed.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pathogen-embed_overview.md)