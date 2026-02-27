---
name: bioconductor-mgfm
description: This tool identifies tissue-specific or cell-type-specific marker genes from normalized microarray gene expression data. Use when user asks to detect marker genes, calculate specificity scores for probe sets, or generate HTML reports of identified markers.
homepage: https://bioconductor.org/packages/release/bioc/html/MGFM.html
---


# bioconductor-mgfm

name: bioconductor-mgfm
description: Identification of marker genes from microarray gene expression data using the MGFM package. Use this skill to detect tissue-specific or cell-type-specific marker genes, calculate specificity scores, and generate HTML reports of identified markers.

# bioconductor-mgfm

## Overview

MGFM (Marker Gene Finder in Microarray) is a tool designed to identify marker genes associated with specific sample types (e.g., tissues or cell types) from microarray expression data. It uses a fast algorithm based on sorting expression values rather than traditional differential expression testing. A probe set is considered a marker candidate if its highest expression values correspond exclusively to all replicates of a single sample type.

## Core Workflow

### 1. Data Preparation
The input must be a normalized microarray expression matrix where rows are probe sets and columns are samples. Replicate samples must have identical column names.

```R
library(MGFM)
# Load example data
data("ds2.mat")
# Check column names (replicates must match)
colnames(ds2.mat) 
```

### 2. Marker Gene Identification
The primary function is `getMarkerGenes()`.

```R
# Basic usage with annotation (requires corresponding ChipDb package)
library(hgu133a.db)
marker_list <- getMarkerGenes(ds2.mat, 
                             samples2compare = "all", 
                             annotate = TRUE, 
                             chip = "hgu133a", 
                             score.cutoff = 1)

# Usage without annotation
marker_list_no_annot <- getMarkerGenes(ds2.mat, 
                                      samples2compare = "all", 
                                      annotate = FALSE)
```

### 3. Parameters
- `data.mat`: Matrix of normalized expression values.
- `samples2compare`: Character vector of specific sample types to include (default is "all").
- `annotate`: Boolean. If TRUE, requires `chip` parameter and appropriate Bioconductor annotation package.
- `chip`: The name of the annotation package (e.g., "hgu133a").
- `score.cutoff`: Value between 0 and 1. Lower values are more specific. 1 includes all potential markers.

### 4. Interpreting Results
The function returns a list where each element corresponds to a sample type (e.g., `liver_markers`). Each entry in the result contains:
`Probe Set ID : Gene Symbol : Entrez ID : Specificity Score`

The **Specificity Score** ranges from 0 to 1, where values closer to 0 indicate higher specificity for that tissue.

### 5. Exporting Results
Use `getHtmlpage()` to create an interactive table of results with external links.

```R
# Example of generating an HTML report
getHtmlpage(marker_list, filename = "markers.html", title = "Marker Genes Report")
```

## Usage Tips
- **Normalization**: Data must be normalized (e.g., using RMA) before using MGFM. If combining datasets from different studies, batch effect correction (e.g., ComBat) is mandatory.
- **Strict Selection**: MGFM's algorithm is strict; it will not identify markers shared between two or more tissues.
- **Speed**: Because it relies on sorting rather than complex statistical modeling, it is very efficient for large datasets.

## Reference documentation
- [MGFM](./references/MGFM.md)