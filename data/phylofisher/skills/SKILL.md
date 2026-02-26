---
name: phylofisher
description: PhyloFisher is a Python-based toolkit that automates the construction and analysis of phylogenomic datasets from eukaryotic protein sequences. Use when user asks to construct single-gene trees, build phylogenomic matrices, identify orthologs, or filter contaminants and paralogs.
homepage: https://github.com/TheBrownLab/PhyloFisher
---


# phylofisher

## Overview
PhyloFisher is a specialized Python3-based toolkit designed for eukaryotic phylogenomics. It automates the complex workflow of transforming protein sequences into phylogenomic datasets, handling tasks such as ortholog identification, paralog detection, and matrix construction. It is particularly effective for researchers working with eukaryotic protein sequences who need to build robust phylogenies while managing common issues like contamination and heterotachy.

## Core Workflow and CLI Patterns

### Installation
Install the package via Bioconda to ensure all dependencies are correctly resolved:
```bash
conda install bioconda::phylofisher
```

### Dataset Preparation and Construction
The primary workflow involves constructing single-gene trees (SGTs) and then concatenating them into a matrix.

*   **SGT Construction**: Use `sgt_constructor.py` to generate single-gene trees. 
    *   *Tip*: This process is computationally intensive. Ensure your environment has sufficient resources and that the environment location is correctly resolved.
*   **Matrix Construction**: Use `matrix_constructor.py` to build the final phylogenomic matrix.
    *   Supports `trimal` parameters (e.g., `-gt` for gap thresholding).
    *   Use `nucl_matrix_constructor.py` if working with nucleotide data.
*   **Ortholog Selection**: Use `select_ortholog.py` to refine the set of genes included in your analysis.

### Data Visualization and Filtering
*   **Forest**: Use `forest.py` for the visualization of trees and to identify/filter out potential contaminants.
*   **Taxon Management**: 
    *   `select_taxa.py`: Used to subset your dataset. Note that this script typically recognizes short names for taxa.
    *   `taxon_collapser.py`: Useful for merging or collapsing specific taxonomic groups.
    *   `leaf_rename_utility`: Use this to clean up or standardize leaf names in your trees.

### Advanced Analysis and Utilities
*   **Recoding**: Use `aa_recoder.py` or `SR4_class_recoder.py` for amino acid recoding to mitigate the effects of compositional bias.
*   **Heterotachy**: Use `heterotachy.py` to analyze or account for site-specific rate variations over time.
*   **Database Management**: Use `apply_to_db.py` to update or modify the underlying PhyloFisher database with new information.

## Expert Tips and Best Practices
*   **Name Lengths**: When using `select_taxa.py`, ensure your taxon names follow the expected short-name format to avoid recognition errors.
*   **Collision Prevention**: Recent versions (v1.2.14+) include file locking mechanisms to prevent writing collisions during parallel processing.
*   **Matrix Completeness**: Use `plot_matrix_completeness.py` to visualize the occupancy of your final matrix and identify taxa or genes with excessive missing data.
*   **Informant Script**: When using the `informant` utility, the `sht_include` option can be used to include specific sequences in the analysis.

## Reference documentation
- [PhyloFisher GitHub Repository](./references/github_com_TheBrownLab_PhyloFisher.md)
- [PhyloFisher Discussions](./references/github_com_TheBrownLab_PhyloFisher_discussions.md)
- [PhyloFisher Issues](./references/github_com_TheBrownLab_PhyloFisher_issues.md)
- [Bioconda PhyloFisher Overview](./references/anaconda_org_channels_bioconda_packages_phylofisher_overview.md)