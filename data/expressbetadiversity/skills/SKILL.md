---
name: expressbetadiversity
description: ExpressBetaDiversity calculates various beta diversity metrics and phylogenetic dissimilarities for large-scale ecological datasets. Use when user asks to calculate taxon-based or phylogeny-aware beta diversity, perform jackknife resampling, or generate UPGMA trees from OTU tables.
homepage: https://github.com/dparks1134/ExpressBetaDiversity
---


# expressbetadiversity

## Overview
The `expressbetadiversity` (EBD) tool is a high-performance C++ command-line utility designed to handle large-scale ecological datasets. It calculates various beta diversity metrics between samples, supporting both simple taxon-based counts and phylogeny-aware measures. Use this skill to format input OTU tables, execute diversity calculations with optional jackknifing, and interpret the resulting dissimilarity matrices and UPGMA trees.

## Core Workflows

### 1. Input Preparation
EBD requires specific file formats that differ from standard QIIME outputs.
- **Tree File (`-t`)**: Must be in Newick format.
- **Sequence Count File (`-s`)**: A tab-delimited table.
    - **Crucial**: The header line (OTU names) MUST start with a leading tab.
    - Rows represent samples; columns represent OTUs/leaf nodes.
    - All leaf nodes in the tree must be present in the table.
- **Format Conversion**: Use the bundled Python script to convert sparse UniFrac/QIIME OTU tables:
  `python convertToEBD.py <input_sparse_file> <output_ebd_file>`

### 2. Common CLI Patterns

**Basic Taxon-based Dissimilarity**
Calculates Bray-Curtis dissimilarity using abundance data:
`ExpressBetaDiversity -s seq.txt -p output_prefix -c Bray-Curtis -w`

**Phylogenetic Beta Diversity**
Incorporates tree topology into the calculation:
`ExpressBetaDiversity -t input.tre -s seq.txt -p phylo_output -c Bray-Curtis -w`

**Jackknife Resampling**
To assess the robustness of clusters, use `-j` (replicates) and `-d` (subsampling depth):
`ExpressBetaDiversity -t input.tre -s seq.txt -p jackknife_results -c Bray-Curtis -w -j 100 -d 500`

**Batch Calculator Analysis**
To run all supported calculators and cluster them by correlation (useful for determining metric redundancy):
`ExpressBetaDiversity -t input.tre -s seq.txt -a -b 0.9 -o clusters.txt`

### 3. Expert Tips & Constraints
- **Memory Management**: If working with extremely large datasets, use `-x` to limit the number of profiles held in memory (default is 1000).
- **Verification**: Always run `ExpressBetaDiversity -u` after installation to ensure unit tests pass on your specific architecture.
- **Output Interpretation**: 
    - `.diss` files: Lower-triangular dissimilarity matrices. Use `convertToFullMatrix.py` if your downstream tool requires a square matrix.
    - `.tre` files: Newick format hierarchical clustering (default is UPGMA).
- **MRCA Weighting**: The `-m` (MRCA weightings) and `-r` (strict MRCA) flags are experimental features for specific phylogenetic weighting schemes.

## Reference documentation
- [ExpressBetaDiversity GitHub Repository](./references/github_com_donovan-h-parks_ExpressBetaDiversity.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_expressbetadiversity_overview.md)