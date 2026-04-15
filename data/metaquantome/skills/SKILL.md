---
name: metaquantome
description: metaquantome integrates taxonomic identification and functional quantification to analyze community activity in metaproteomics data. Use when user asks to expand taxonomic or functional annotations, filter and normalize peptide data, perform differential abundance testing, or visualize taxonomic contributions to metabolic functions.
homepage: https://github.com/galaxyproteomics/metaquant
metadata:
  docker_image: "quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0"
---

# metaquantome

## Overview
metaquantome is a specialized framework designed to bridge the gap between taxonomic identification and functional quantification in metaproteomics. While many tools treat taxonomy and function as separate silos, this tool allows for "functional-taxonomic" integration, enabling researchers to determine not just what functions are present in a microbiome, but specifically which taxa are responsible for those functions. It is particularly effective for analyzing large-scale mass spectrometry data to identify shifts in community activity across different experimental conditions.

## Core Workflows and CLI Patterns

### 1. Data Expansion (Annotation)
The first step involves expanding raw input files (peptide intensities and identifications) into a format containing full taxonomic and functional hierarchies.

*   **Taxonomy Expansion**: Map peptides to NCBI taxids.
    ```bash
    metaquantome expand --db ncbi --input peptides.tab --outfile expanded_tax.tab --type t
    ```
*   **Functional Expansion**: Map to GO terms or EC numbers.
    ```bash
    metaquantome expand --db go --input peptides.tab --outfile expanded_func.tab --type f
    ```

### 2. Data Filtering and Normalization
Before statistical testing, data must be cleaned to remove low-confidence assignments and normalized to account for varying sample depths.

*   **Filtering**: Use the `filter` command to remove entries with too few observations across replicates.
    *   *Tip*: Set a threshold (e.g., minimum 2 replicates per condition) to increase statistical power.
*   **Normalization**: Supports various methods including Total Ion Current (TIC) or median centering.

### 3. Statistical Analysis (Stat Mode)
Perform differential abundance testing between experimental groups.

*   **Comparison**: Define experimental conditions using a sample annotation file.
    ```bash
    metaquantome stat --input expanded_data.tab --sample_file samples.tab --compare "Control-vs-Treatment" --outfile stats_results.tab
    ```

### 4. Visualization
Generate plots to interpret the complex multi-dimensional data.

*   **Heatmaps**: Visualize top differentially abundant functions or taxa.
*   **Barplots/Stacked Plots**: Show taxonomic contribution to a specific metabolic pathway.
*   **Volcano Plots**: Identify significant outliers in functional expression.

## Expert Tips for Metaproteomics
*   **Database Selection**: Ensure the database used during the `expand` step matches the one used for initial peptide identification (e.g., UniProt vs. RefSeq) to prevent mapping mismatches.
*   **LCA (Lowest Common Ancestor)**: When mapping peptides to taxonomy, metaquantome utilizes LCA logic. Be aware that highly conserved peptides will map to higher taxonomic ranks (e.g., Phylum or Kingdom) rather than Species.
*   **Functional Redundancy**: Use the integrated "function-taxonomy" mode to see if a decrease in a specific enzyme's activity is due to a decrease in the total population or a specific shift in one genus.



## Subcommands

| Command | Description |
|---------|-------------|
| metaquantome | metaQuantome is a tool that performs quantitative analysis on the function and taxonomy of microbomes and their interactions. For more background information, please read the associated manuscript: https://doi.org/10.1074/mcp.ra118.001240. For a more hands-on tutorial, please visit the following page: https://galaxyproteomics.github.io/metaquantome_mcp_analysis/cli_tutorial/cli_tutorial.html. |
| metaquantome db | metaQuantome uses freely available bioinformatic databases to expand your set of direct annotations. For most cases, all 3 databases can be downloaded (the default). |
| metaquantome expand | The expand module is the first analysis step in the metaQuantome analysis workflow, and can be run to analyze function, taxonomy, or function and taxonomy together. |
| metaquantome filter | The filter module is the second step in the metaQuantome analysis workflow. The purpose of the filter module is to filter expanded terms to those that are representative and well-supported by the data. Please see the manuscript (https://doi.org/10.1074/mcp.ra118.001240) for further details about filtering. |
| metaquantome stat | The stat module is the third step in the metaQuantome analysis workflow. The purpose of the stat module is to perform differential expression analysis between 2 experimental conditions. metaQuantome offers paired and unpaired tests, as well as parametric and non-parametric options. |
| metaquantome viz | The viz module is the final step in the metaQuantome analysis workflow. The available visualizations are: -bar plot -volcano plot -heatmap -PCA plot Please consult the manuscript (https://doi.org/10.1074/mcp.ra118.001240.) for full details on each of these plots. |

## Reference documentation
- [metaquantome Overview](./references/anaconda_org_channels_bioconda_packages_metaquantome_overview.md)