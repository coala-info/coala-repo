---
name: krona
description: "Krona creates interactive, zoomable pie charts to visualize hierarchical datasets and taxonomic compositions. Use when user asks to create Krona charts, visualize metagenomic data, import taxonomy IDs, or transform hierarchical text files into interactive HTML visualizations."
homepage: https://github.com/marbl/Krona
---


# krona

## Overview

Krona is a visualization suite designed to handle complex, hierarchical datasets through "Krona charts"—interactive, zoomable pie charts. It is most commonly used in bioinformatics to explore the taxonomic composition of metagenomic samples, but it is flexible enough to visualize any data with a nested structure (e.g., disk usage, budgets). The toolset, known as KronaTools, consists of several Perl scripts that transform raw data or tool-specific outputs into a single, portable HTML file that requires only a web browser to view.

## Common CLI Patterns

### 1. Preparing the Taxonomy Database
Before using scripts that rely on NCBI taxonomy (like `ktImportTaxonomy`), you must initialize or update the local taxonomy database.
```bash
ktUpdateTaxonomy.sh
```
*Note: This requires an internet connection and can take significant time/disk space.*

### 2. Importing Tab-Delimited Text
The most flexible way to use Krona is via `ktImportText`. The input file should be tab-delimited, with the first column being a magnitude (count/abundance) and subsequent columns representing the hierarchy from root to leaf.

**Command:**
```bash
ktImportText input.txt -o output.krona.html
```

**Input Format Example (`input.txt`):**
```text
400    Bacteria    Proteobacteria    Alphaproteobacteria
200    Bacteria    Proteobacteria    Betaproteobacteria
100    Archaea     Euryarchaeota     Methanogens
```

### 3. Importing Bioinformatics Tool Outputs
KronaTools includes dedicated scripts for various common tools (e.g., BLAST, Kraken, RDP, PhymmBL).

*   **From BLAST results:**
    ```bash
    ktImportBLAST blast_output.txt -o blast_viz.html
    ```
*   **From Taxonomy IDs:**
    If you have a list of NCBI TaxIDs and counts:
    ```bash
    ktImportTaxonomy taxids_counts.txt -o taxonomy_viz.html
    ```

### 4. Comparing Multiple Datasets
You can include multiple input files in a single command to create a chart with a drop-down menu to switch between samples.
```bash
ktImportText sample1.txt sample2.txt -o comparison.html
```

## Expert Tips and Best Practices

*   **Self-Contained Files:** By default, Krona creates HTML files that reference resources online. If you need to view charts offline, use the `-url` flag to point to a local copy of the Krona resources or ensure you are using a version that bundles them.
*   **Magnitude vs. Count:** Use the `-n` flag to provide a name for the "magnitude" being visualized (e.g., `-n "Reads"` or `-n "Abundance"`) to make the legend clearer.
*   **Handling Unknowns:** When importing taxonomy, use the `-u` flag to specify how to handle taxa that cannot be found in the local database (e.g., assigning them to "Unknown").
*   **Coloring by Score:** For tools that provide confidence scores (like RDP or BLAST), Krona can color the wedges based on these scores to visualize classification certainty.
*   **Excel Integration:** For non-programmers, Krona provides an Excel template (`ExcelTemplate`) where data can be entered into a spreadsheet and exported as a Krona chart via a macro.

## Reference documentation

- [Krona Wiki Home](./references/github_com_marbl_Krona_wiki.md)
- [Krona Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_krona_overview.md)
- [Krona GitHub Repository](./references/github_com_marbl_Krona.md)