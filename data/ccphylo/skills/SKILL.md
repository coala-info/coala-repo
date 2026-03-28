---
name: ccphylo
description: ccphylo is a high-performance tool for rapid phylogenetic inference and distance matrix calculation from VCF or FASTA files. Use when user asks to calculate distance matrices, reconstruct phylogenetic trees using Neighbor-Joining or UPGMA, or process large genomic datasets for outbreak investigations.
homepage: https://bitbucket.org/genomicepidemiology/ccphylo
---


# ccphylo

## Overview
ccphylo is a high-performance C++ tool designed for rapid phylogenetic inference. It excels at processing large multi-sample VCF files or aligned FASTA sequences to generate distance matrices and phylogenetic trees. Use this tool when standard methods are too slow for large datasets, particularly in bacterial or viral outbreak investigations where speed and memory efficiency are critical.

## Core Commands and Usage

### 1. Distance Matrix Calculation
The primary function of ccphylo is calculating distances between sequences.

*   **From VCF:**
    `ccphylo dist -f input.vcf -o output.dist`
*   **From FASTA:**
    `ccphylo dist -f input.fasta -o output.dist`
*   **Key Options:**
    *   `-m [model]`: Specify the substitution model (e.g., `hamming` for SNP distance).
    *   `-t [threads]`: Enable multi-threading for faster computation.

### 2. Tree Reconstruction
ccphylo can build trees directly from sequences or from a pre-calculated distance matrix.

*   **Neighbor-Joining (NJ):**
    `ccphylo tree -f input.dist -m nj -o output.newick`
*   **UPGMA:**
    `ccphylo tree -f input.dist -m upgma -o output.newick`

### 3. Combined Workflow (Direct Tree Building)
You can pipe commands or use the `tree` command directly on sequence files to skip the intermediate distance matrix file:
`ccphylo tree -f input.vcf -m nj -o output.newick`

## Expert Tips and Best Practices
*   **Memory Management:** For extremely large VCFs, ensure the VCF is indexed. ccphylo is optimized for memory, but very high sample counts (10,000+) benefit from increased system RAM.
*   **Missing Data:** When working with VCFs from mapping pipelines, ensure consistent handling of missing positions. Use the `-r` flag if a reference genome is required for coordinate mapping.
*   **Output Formats:** The distance matrix is typically output in a square/tab-delimited format compatible with other downstream phylogenetic tools. Trees are output in standard Newick format.
*   **Performance:** Always specify the number of threads (`-t`) matching your CPU cores to maximize the speed of the distance matrix calculation phase.



## Subcommands

| Command | Description |
|---------|-------------|
| ccphylo_dbscan | make a DBSCAN given a set of phylip distance matrices. |
| ccphylo_dist | calculates distances between samples based on overlaps between nucleotide count matrices created by e.g. KMA. |
| ccphylo_fullphy | forms tree(s) in newick format given a set of phylip distance matrices. |
| ccphylo_makespan | make a DBSCAN given a set of phylip distance matrices. |
| ccphylo_merge | Merges matrices from a multi Phylip file into one matrix |
| ccphylo_nwck2phy | converts newick files to phylip distance files. |
| ccphylo_phycmp | Compares two distance matrices in phylip format. |
| ccphylo_rarify | rarifies an KMA matrix. |
| ccphylo_tree | forms tree(s) in newick format given a set of phylip distance matrices. |
| ccphylo_trim | Trims multiple alignments from different files, and merge them into one |
| ccphylo_tsv2phy | converts tsv files to phylip distance files. |
| ccphylo_union | CCPhylo union finds the union between templates in res files created by e.g. KMA. |

## Reference documentation
- [ccphylo Bitbucket Repository](./references/bitbucket_org_genomicepidemiology_ccphylo.md)
- [Bioconda ccphylo Package](./references/anaconda_org_channels_bioconda_packages_ccphylo_overview.md)