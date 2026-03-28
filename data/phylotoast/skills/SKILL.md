---
name: phylotoast
description: PhyloToAST is a suite of Python scripts that augments the QIIME workflow for high-resolution species-level microbial analysis and visualization. Use when user asks to generate PCoA plots, perform LDA analysis, format data for iTol, filter representative sequences, transform BIOM files, or map OTUs to taxonomy.
homepage: https://github.com/smdabdoub/phylotoast
---


# phylotoast

## Overview
PhyloToAST (Phylogenetic Tools for Analysis, Species-level, and Taxonomy) is a specialized suite of Python scripts designed to augment the QIIME bioinformatics workflow. While QIIME provides a general framework for microbial community analysis, PhyloToAST provides the "glue" and specialized tools needed for high-resolution species-specific analysis and publication-quality visualizations. It is particularly effective for researchers working with complex microbial datasets who need to move beyond standard genus-level summaries into detailed species-level insights and high-performance computing environments.

## Core CLI Tools and Usage Patterns

### Visualization and Ordination
PhyloToAST provides enhanced plotting capabilities compared to standard QIIME outputs.

*   **PCoA Plotting (`PCOA.py`)**: Used to generate 2D or 3D Principal Coordinates Analysis plots.
    *   Supports custom legend placement and the option to disable legends for cleaner publication figures.
    *   Can handle various coordinate input formats derived from beta diversity calculations.
*   **LDA Analysis (`LDA.py`)**: Used for Linear Discriminant Analysis to identify features (taxa) that characterize the differences between groups.
    *   Includes parameters for adjusting point sizes and formatting for specific aesthetic requirements.
*   **iTol Integration**: Several scripts support outputting data formatted specifically for the Interactive Tree of Life (iTol), allowing for the mapping of abundance data onto phylogenetic trees. Use the option to retain OTU IDs if specific sequence tracking is required.

### Data Manipulation and Filtering
These tools help refine the dataset after initial QIIME processing.

*   **Representative Set Filtering (`restrict_repset.py`)**: After filtering a BIOM table (e.g., removing low-abundance OTUs), use this script to create a new FASTA file containing only the representative sequences that remain in the filtered table.
*   **BIOM Transformation (`transform_biom.py`)**: A utility for modifying BIOM file structures or converting between formats.
*   **Taxonomy Mapping (`otu_to_tax.py` and `otu_to_tax_name.py`)**: Converts OTU identifiers to human-readable taxonomic strings. This is essential for interpreting results after species-level assignments.

### Species-Level Analysis
*   **Core OTU Identification**: Use the `--table_fp` option in relevant scripts to output lists of core OTUs (taxa present across a specific percentage of samples) as TSV files for easy import into spreadsheet software.
*   **Primer Bias Mitigation**: PhyloToAST includes logic to handle data generated from multiple primer sets, allowing for a more integrated view of the community that isn't skewed by the bias of a single 16S rRNA gene target region.

## Expert Tips for Workflow Integration

1.  **Dependency Management**: PhyloToAST does not automatically install its dependencies. If a script fails, check for missing libraries such as `scikit-bio`, `biom-format`, or `palettable`.
2.  **BIOM v2.x Support**: For parsing HDF5-based BIOM files (v2.x), ensure `h5py` is installed in your environment.
3.  **HPC Execution**: The toolset is designed with cluster-computing in mind. Scripts are optimized to be wrapped in PBS or SLURM submission scripts for parallel processing of large-scale microbiome datasets.
4.  **Short OTU Names**: When working with taxonomy scripts, be aware that the tool handles cases where higher taxonomic ranks (like Genus) might be missing but Species-level data is present, preventing "empty" labels in your visualizations.



## Subcommands

| Command | Description |
|---------|-------------|
| otu_to_tax_name.py | Convert a list of OTU IDs to a list of OTU IDs paired with Genus_Species identifiers and perform reverse lookup, if needed. |
| phylotoast_LDA.py | Performs Latent Dirichlet Allocation (LDA) analysis on phylogenetic data. |
| restrict_repset.py | Take a subset BIOM table (e.g. from a core calculation) and a representative set (repset) FASTA file and create a new repset restricted to the OTUs in the BIOM table. |
| transform_biom.py | This script applies varioustransforms to the data in a given BIOM-format table and outputs a newBIOM table with the transformed data. |

## Reference documentation
- [PhyloToAST Main Repository](./references/github_com_smdabdoub_phylotoast.md)
- [Version History and Script Updates](./references/github_com_smdabdoub_phylotoast_tags.md)
- [Recent Feature Commits](./references/github_com_smdabdoub_phylotoast_commits_master.md)