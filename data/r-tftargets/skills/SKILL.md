---
name: r-tftargets
description: The r-tftargets package provides access to human transcription factor target gene sets from six major databases within the R environment. Use when user asks to identify downstream targets of human transcription factors, perform gene regulatory network analysis, or query TF-target interactions from databases like TRRUST, ENCODE, and TRED.
homepage: https://cran.r-project.org/web/packages/tftargets/index.html
---


# r-tftargets

name: r-tftargets
description: Access and query human transcription factor (TF) target genes from six major databases (TRED, ITFP, ENCODE, Neph2012, TRRUST, and Marbach2016). Use this skill when performing gene regulatory network analysis, enrichment analysis, or identifying downstream targets of specific human transcription factors in R.

## Overview
The `tftargets` package provides a unified collection of human transcription factor target gene sets. It simplifies the process of finding which genes are activated or repressed by a specific TF by aggregating data from multiple curated and predicted databases into standard R list structures.

## Installation
To install the package, use the following command:
```R
install.packages("r-tftargets")
```
Alternatively, for the latest development version:
```R
devtools::install_github("slowkow/tftargets")
```

## Usage and Workflows

### Loading Data
The package provides several datasets as named lists. Load the library to access them:
```R
library(tftargets)
```

### Available Datasets
Each dataset has a specific structure and gene identifier type:

| Dataset | Gene Identifier | Description |
| :--- | :--- | :--- |
| `TRED` | Entrez ID | Predicted and known targets (2007) |
| `ITFP` | HGNC Symbol | Predicted targets (2008) |
| `ENCODE` | Entrez ID | ChIP-seq based putative targets (2012) |
| `Neph2012` | Entrez ID | DNaseI footprinting (Nested by tissue) |
| `TRRUST` | HGNC Symbol | Manually curated regulatory network (2015) |
| `Marbach2016` | HGNC Symbol | Tissue-specific regulatory circuits (2016) |

### Querying a Transcription Factor
To find targets for a specific TF (e.g., STAT3), access the list element by the TF name:
```R
# Get targets from TRRUST (HGNC Symbols)
stat3_targets <- TRRUST[["STAT3"]]

# Get targets from ENCODE (Entrez IDs)
stat3_entrez <- ENCODE[["STAT3"]]
```

### Working with Neph2012 (Nested List)
The `Neph2012` dataset is organized by tissue type first. To access targets, you must specify the tissue:
```R
# List available tissues
names(Neph2012)

# Get STAT3 targets in a specific tissue
stat3_brain <- Neph2012[["fBrain-DS11872"]][["STAT3"]]
```

### Common Tasks
- **Check TF coverage**: `names(TRRUST)` returns all TFs available in that database.
- **Count targets**: `length(TRED[["STAT3"]])` returns the number of targets for STAT3 in TRED.
- **Intersection of targets**: Find high-confidence targets by looking for the intersection across multiple databases.

## Tips
- **Identifier Mapping**: Since some databases use Entrez IDs and others use HGNC Symbols, use packages like `org.Hs.eg.db` or `biomaRt` to convert identifiers if you need to compare across all six databases.
- **Data Source Selection**: Use `TRRUST` for manually curated, high-confidence interactions, and `ENCODE` or `Marbach2016` for large-scale, evidence-based putative targets.

## Reference documentation
- [CHANGELOG.md](./references/CHANGELOG.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)