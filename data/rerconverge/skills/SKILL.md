---
name: rerconverge
description: RERconverge identifies genes whose evolutionary rates correlate with the convergent evolution of specific traits across a phylogeny. Use when user asks to calculate relative evolutionary rates, associate genomic changes with binary or continuous phenotypes, or identify the molecular basis of convergent evolution.
homepage: https://github.com/nclark-lab/RERconverge
---


# rerconverge

## Overview
RERconverge is a specialized R-based framework for comparative genomics. It identifies genes whose evolutionary rates change in association with the independent evolution of specific traits (convergence). By comparing the relative evolutionary rates (RERs) of genes across a phylogeny against a trait of interest, it helps pinpoint the molecular basis of complex phenotypes that have appeared multiple times in different lineages.

## Usage Guide

### Installation
RERconverge can be installed via Conda or directly from GitHub within an R environment:

```r
# Via Devtools
library(devtools)
install_github("nclark-lab/RERconverge")

# Via Conda (Terminal)
# conda install bioconda::rerconverge
```

### Data Requirements
To perform an analysis, you must prepare two primary inputs:
1.  **Trees File**: A tab-delimited file containing gene names and their corresponding Newick format trees. 
    *   **Constraint**: All gene trees must have the same topology.
    *   **Constraint**: At least one tree must contain all species present in the dataset.
2.  **Phenotype Data**:
    *   **Binary Traits**: A vector of species names representing the "foreground" (those with the trait) or a tree object where branches are non-zero only for foreground lineages.
    *   **Continuous Traits**: A named vector of quantitative values where names match the species in the phylogeny.

### Core Workflow
The standard analysis follows these procedural steps:

1.  **Load Data**: Use `readTrees()` to import the gene trees.
2.  **Calculate RERs**: Compute the relative evolutionary rates for all genes across all branches.
3.  **Define Phenotype**: Specify the foreground species or continuous values.
4.  **Correlation Analysis**: Run the correlation function to associate RERs with the trait.
5.  **Multiple Testing Correction**: Apply FDR (False Discovery Rate) to the resulting p-values.

### Best Practices and Expert Tips
*   **Topology Consistency**: Ensure your gene trees are "fixed" to a master topology. RERconverge relies on comparing branch lengths across the same positions in the tree; inconsistent topologies will lead to errors in branch mapping.
*   **Foreground Selection**: For binary traits, use the interactive selection tools if the trait evolved multiple times on internal branches to ensure all convergent lineages are correctly captured.
*   **Relative Rates**: Remember that RERs are residuals from a regression of gene-specific branch lengths against total branch lengths. This normalization is critical to account for the overall divergence of species.
*   **Visualization**: Use the built-in plotting functions to visualize the difference in RERs between foreground and background branches for top-ranked genes to validate the signal.

## Reference documentation
- [RERconverge Main Repository](./references/github_com_nclark-lab_RERconverge.md)
- [RERconverge Wiki and Getting Started](./references/github_com_nclark-lab_RERconverge_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_rerconverge_overview.md)