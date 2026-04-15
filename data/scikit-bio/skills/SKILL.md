---
name: scikit-bio
description: scikit-bio is a Python library that provides data structures, algorithms, and statistical methods for bioinformatics and ecological diversity analysis. Use when user asks to calculate alpha or beta diversity metrics, perform ordination like PCoA, manipulate phylogenetic trees, or process biological sequence data.
homepage: https://github.com/scikit-bio/scikit-bio
metadata:
  docker_image: "quay.io/biocontainers/scikit-bio:0.4.2--np112py27_0"
---

# scikit-bio

## Overview
scikit-bio is a specialized Python library designed for bioinformatics that provides a robust framework for biological data structures and algorithms. It is particularly useful for researchers and developers who need to perform ecological diversity analyses, manipulate phylogenetic trees, or process large-scale sequence data. This skill focuses on the library's core modules for sequence analysis, statistics, and data visualization, emphasizing the modern API (v0.6.0+) and efficient data handling.

## Core Workflows and Best Practices

### 1. Installation and Environment
Always ensure you are using a modern version (0.6.0 or higher) as the library has undergone significant revitalization.
- **Conda (Preferred):** `conda install -c conda-forge scikit-bio`
- **Pip:** `pip install scikit-bio`
- **Compatibility:** Requires Python 3.10 or above.

### 2. Biological Data I/O (`skbio.io`)
Use the unified I/O registry to read and write various formats.
- **Reading Sequences:** Use `skbio.io.read()` or the specific class methods like `DNA.read()`, `RNA.read()`, or `Protein.read()`.
- **Multiple Sequence Alignment:** Use `TabularMSA.read()`. Note that when reading large files, ensure you specify the correct constructor parameters to handle metadata appropriately.
- **Distance Matrices:** Use `DistanceMatrix.read()` for beta diversity results or pre-calculated distance files.

### 3. Community Ecology and Diversity
scikit-bio is a standard for calculating ecological metrics.
- **Alpha Diversity:** Use `skbio.stats.diversity.alpha` for within-sample diversity (e.g., Shannon, Simpson, Observed OTUs/Richness).
- **Beta Diversity:** Use `skbio.stats.diversity.beta` for between-sample comparisons. Common metrics include Bray-Curtis and UniFrac.
- **Statistical Testing:** 
    - Use `skbio.stats.distance.permanova` or `anosim` for testing differences between groups in a distance matrix.
    - Use `permdisp` to test for homogeneity of multivariate dispersions.

### 4. Ordination and Visualization
- **PCoA:** Use `skbio.stats.ordination.pcoa` for Principal Coordinates Analysis.
- **Biplots:** When interpreting ordination, generate PCoA biplots to visualize the contribution of specific features (taxa) to the sample clustering.
- **Transformations:** For compositional data (like microbiome counts), consider using the `rclr` (Robust Centered Log-Ratio) transformation before performing ordination to account for sparsity and compositionality.

### 5. Phylogenetics and Trees
- **Tree Manipulation:** Use `skbio.TreeNode` for reading (Newick format), traversing, and manipulating phylogenetic trees.
- **Tip Names:** Be aware that some functions may replace underscores with spaces or vice versa depending on the format; always verify tip name consistency when mapping metadata to trees.

## Expert Tips
- **Compositional Data:** When working with abundance data that contains floats (percentages) rather than integers (counts), ensure your chosen diversity metric is appropriate, as some (like Fisher's Alpha) strictly require integer counts.
- **Missing Values:** In the latest versions (0.7.0+), pay close attention to how metadata modules handle missing values, as refactoring has improved mask handling for incomplete datasets.
- **Performance:** For large-scale distance calculations or LME (Linear Mixed Effects) models like `dirmult_lme`, be aware of potential numerical inconsistencies across different CPU architectures (e.g., Intel vs. ARM/Apple Silicon).

## Reference documentation
- [scikit-bio README](./references/github_com_scikit-bio_scikit-bio.md)
- [scikit-bio Discussions](./references/github_com_scikit-bio_scikit-bio_discussions.md)
- [scikit-bio Issues](./references/github_com_scikit-bio_scikit-bio_issues.md)