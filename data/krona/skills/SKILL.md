---
name: krona
description: Krona creates interactive, multi-layered pie charts for visualizing hierarchical datasets and metagenomic classifications. Use when user asks to visualize taxonomic data, create interactive HTML charts from text or BLAST results, or compare multiple hierarchical datasets.
homepage: https://github.com/marbl/Krona
---

# krona

## Overview
Krona is a visualization tool designed to transform complex hierarchical datasets into interactive, multi-layered pie charts. It is a standard in bioinformatics for exploring metagenomic classifications, allowing users to zoom through taxonomic levels and compare multiple datasets within a single interface. The tool generates self-contained HTML5 files that are highly portable and viewable in any modern web browser without requiring external dependencies or plugins.

## Core Workflows

### 1. Database Preparation
Before processing taxonomic data, you must initialize or update the local NCBI taxonomy database. This is required for scripts that map accessions or TaxIDs to names.
- **Update Taxonomy**: Run `ktUpdateTaxonomy.sh` to download and build the latest NCBI taxonomy files.

### 2. Creating Charts from Text Data
The most flexible way to use Krona is with `ktImportText`. The input should be a tab-delimited file where the first column is a magnitude (count) and subsequent columns represent the hierarchy.
- **Basic Command**: `ktImportText input.txt -o output.html`
- **Multiple Samples**: Provide multiple files to create a single chart with a drop-down menu to switch between them:
  `ktImportText sample1.txt sample2.txt -o comparison.html`
- **Naming the Root**: Use `-n` to provide a label for the center of the pie chart.

### 3. Bioinformatics Tool Integrations
KronaTools includes specialized scripts for various pipeline outputs:
- **BLAST**: Use `ktImportBLAST` to process BLAST tabular output.
- **RDP**: Use `ktImportRDP` for Ribosomal Database Project classifications.
- **METAREP/MG-RAST**: Use the respective `ktImport` scripts for these functional and taxonomic platforms.

### 4. Customizing the Output
- **SVG Snapshots**: While viewing the HTML chart, use the "Snapshot" button to generate an SVG file suitable for publication-quality figures.
- **URL Parameters**: You can modify the default view of a generated chart by appending GET variables to the URL:
  - `?collapse=false`: Prevents redundant wedges from being merged.
  - `?color=true`: Enables custom color schemes defined in the data.
  - `?key=true/false`: Toggles the legend for small wedges.

## Troubleshooting & Best Practices
- **Missing Perl Modules**: If you encounter "Can't locate KronaTools.pm", ensure the `KronaTools/lib` directory is in your `PERL5LIB` environment variable or that you are running the scripts from their installed location.
- **Memory Limits**: For extremely large datasets (e.g., millions of BLAST hits), ensure your system has sufficient RAM for the taxonomy mapping phase, or use the `-tax` option where available to point to a pre-processed taxonomy directory.
- **Excel Integration**: For non-CLI users, the `ExcelTemplate` directory contains a macro-enabled workbook that can generate Krona HTML files directly from spreadsheet data.



## Subcommands

| Command | Description |
|---------|-------------|
| ktImportBLAST | Creates a Krona chart of taxonomic classifications computed from tabular BLAST results. |
| ktImportTaxonomy | Creates a Krona chart based on taxonomy IDs and, optionally, magnitudes and scores. Taxonomy IDs corresponding to a rank of "no rank" in the database will be assigned to their parents to make the hierarchy less cluttered (e.g. "Cellular organisms" will be assigned to "root"). |
| ktImportText | Creates a Krona chart from text files listing quantities and lineages. |
| updateTaxonomy.sh | Update the Krona taxonomy database. |

## Reference documentation
- [Krona Wiki Home](./references/github_com_marbl_Krona_wiki.md)
- [KronaTools Overview](./references/github_com_marbl_Krona_wiki_KronaTools.md)
- [Changing Chart Viewing Defaults](./references/github_com_marbl_Krona_wiki_Changing-chart-viewing-defaults.md)
- [Importing Text and XML Data](./references/github_com_marbl_Krona_wiki_Importing-text-and-XML-data.md)