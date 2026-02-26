---
name: bioconductor-gcmapweb
description: This tool provides a web interface and R framework for connectivity mapping and gene-set enrichment analysis. Use when user asks to launch the gCMAPWeb interface, perform connectivity mapping, compare gene sets against reference datasets, or identify experiments with similar expression signatures.
homepage: https://bioconductor.org/packages/3.8/bioc/html/gCMAPWeb.html
---


# bioconductor-gcmapweb

name: bioconductor-gcmapweb
description: Provides a web interface and R framework for gene-set enrichment analysis (GSEA) and connectivity mapping. Use this skill to compare gene sets or differential expression profiles against reference datasets using directional, non-directional, or profile-based queries. It is particularly useful for identifying experiments with similar or opposite expression signatures using JG scores or Fisher's exact tests.

## Overview
The `gCMAPWeb` package acts as a graphical and programmatic interface for the `gCMAP` package. It allows users to perform connectivity mapping—matching a query (gene list or z-scores) against a database of reference experiments (e.g., drug perturbations or knockouts). It supports three primary query types: directional (up/down sets), non-directional (single set), and profile (full z-score vectors).

## Core Workflows

### 1. Launching the Web Interface
To start the local Rook-based web server and open the interface in a browser:
```r
library(gCMAPWeb)
gCMAPWeb()
```

### 2. Preparing Reference Datasets
Reference data must be stored as `NChannelSet` (for quantitative scores like z-scores) or `CMAPCollection` (for gene sets) objects.
*   **Identifiers:** Must use Entrez Gene IDs.
*   **Metadata:** Use the `experimentData` slot to define titles and abstracts which appear in the UI.
*   **Query Support:** Manually restrict query types if necessary:
```r
# Restrict a dataset to only directional and unsigned queries
cmap1@experimentData@other$supported.query <- c("unsigned", "directional")
```

### 3. Configuration via YAML
The application is configured using a YAML file that defines species, annotation packages (e.g., `org.Hs.eg.db`), and paths to `.RData` files containing the reference objects.
```r
# Example config.yml structure
# species:
#   human:
#     annotation: org.Hs.eg
#     cmaps:
#       ref1: /path/to/data.rdata
```
To launch with a custom config:
```r
gCMAPWeb(config.file.path = "path/to/custom_config.yml")
```

### 4. Query Types and Analysis
*   **Directional Queries:** Submit separate lists of up-regulated and down-regulated genes. Uses JG scores to find correlated or anti-correlated experiments.
*   **Non-directional Queries:** Submit a single list of genes. Uses Fisher's exact test to find experiments with significant overlap regardless of direction.
*   **Profile Queries:** Submit a full vector of z-scores. This is the "reverse" of a directional query, matching your global scores against reference gene sets.

### 5. Customizing UI and Thresholds
Global options control the analysis parameters and UI appearance:
```r
options(site.title = "My Lab Connectivity Map")
options(max.results = 100)      # Max similar datasets to return
options(higher.threshold = 3)   # Z-score cutoff for 'up'
options(lower.threshold = -3)   # Z-score cutoff for 'down'
```

## Key Functions
*   `gCMAPWeb()`: Main entry point to start the application.
*   `generate_gCMAP_NChannelSet()`: (From gCMAP) Used to process raw lists of ExpressionSets into a reference object.
*   `induceCMAPCollection()`: Converts quantitative data (NChannelSet) into discrete gene sets (CMAPCollection) based on thresholds.

## Reference documentation
- [gCMAPWeb: a web interface for gene-set enrichment analysis](./references/gCMAPWeb.md)
- [Creating reference datasets: The Broad Connectivity Map (v1)](./references/referenceDatasets.md)