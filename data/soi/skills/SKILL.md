---
name: soi
description: The soi tool identifies orthologous synteny by integrating synteny detection with orthology inference to calculate an Orthology Index. Use when user asks to visualize syntenic relationships with dot plots, filter genomic noise for high-confidence orthologous blocks, or construct phylogenomic pipelines from syntenic orthogroups.
homepage: https://github.com/zhangrengang/SOI/
---


# soi

## Overview
The `soi` (Community Orthology Index) tool provides a robust framework for identifying orthologous synteny by integrating synteny detection with orthology inference. It calculates an Orthology Index (OI)—the proportion of orthologous gene pairs within a syntenic block—to provide a scalable metric for evolutionary analysis. Use this skill to filter out genomic noise, visualize syntenic relationships via colored dot plots, and construct phylogenomic pipelines from syntenic orthogroups (SOGs).

## Core CLI Usage

### Generating Dot Plots
The `dotplot` subcommand is used to visualize synteny. It can color dots by Ks (synonymous substitution rate) or by the Orthology Index.

*   **Standard Ks-colored plot:**
    ```bash
    soi dotplot -s species1-species2.collinearity.gz -g species1-species2.gff.gz -c species1-species2.ctl --kaks species1-species2.ks.gz -o output_prefix --ks-hist --max-ks 1.5
    ```
*   **OI-colored plot (integrating OrthoFinder results):**
    ```bash
    soi dotplot -s species1-species2.collinearity.gz -g species1-species2.gff.gz -c species1-species2.ctl --ofdir OrthoFinder/Results_Dir/ --of-color -o output_oi_colored
    ```

### Filtering Synteny
Use the `filter` command to extract high-confidence orthologous blocks. The default OI cutoff is 0.6, which typically yields clean 1:1 orthology.

*   **Filter by OI threshold:**
    ```bash
    soi filter -s input.collinearity.gz -o OrthoFinder/Results_Dir/ -c 0.6 > filtered.ortho.collinearity
    ```

### Phylogenomic Pipeline
`soi` supports a full workflow from clustering to tree building:

1.  **Cluster**: Group syntenic blocks into orthogroups.
    ```bash
    soi cluster -s collinearity_list.txt -o clusters_output
    ```
2.  **Phylo**: Build gene trees from the identified SOGs.
    ```bash
    soi phylo -i clusters_output -d cds_dir -p protein_dir
    ```

## Expert Tips and Best Practices

*   **Gene ID Formatting**: For full compatibility with the phylogenomics pipeline, label Gene IDs with a Species ID prefix using a pipe separator (e.g., `SpeciesName|GeneID`).
*   **Input Consistency**: Ensure that Gene and Chromosome IDs are consistent across all input files (GFF, Collinearity, and OrthoFinder results).
*   **Interpreting OI**: An OI near 1.0 indicates a high density of orthologs (likely 1:1 orthologous synteny), while an OI near 0.0 suggests the block is composed of paralogs or non-orthologous segments.
*   **Memory Management**: When working with large plant genomes, ensure GFF files are indexed or simplified to include only primary transcripts to speed up the `dotplot` and `filter` subcommands.
*   **Control Files**: The `.ctl` file used in `dotplot` defines the chromosome display order and grouping; ensure this file matches the naming convention used in your GFF.

## Reference documentation
- [Robust identification of orthologous Synteny with the Orthology Index](./references/github_com_zhangrengang_SOI.md)
- [soi - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_soi_overview.md)