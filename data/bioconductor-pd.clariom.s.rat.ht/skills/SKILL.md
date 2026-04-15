---
name: bioconductor-pd.clariom.s.rat.ht
description: This package provides annotation and platform design information for the Clariom S Rat HT microarray. Use when user asks to process Clariom S Rat HT CEL files, map probes to sequences, or retrieve feature identifiers for high-throughput rat microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.clariom.s.rat.ht.html
---

# bioconductor-pd.clariom.s.rat.ht

name: bioconductor-pd.clariom.s.rat.ht
description: Annotation and platform design information for the Clariom S Rat HT (High Throughput) microarray. Use this skill when processing Affymetrix/Thermo Fisher Clariom S Rat HT CEL files using the oligo package to map probes to sequences and genomic targets.

# bioconductor-pd.clariom.s.rat.ht

## Overview

The `pd.clariom.s.rat.ht` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the essential platform design information required by the `oligo` package to process and analyze Clariom S Rat HT microarrays. This package acts as the bridge between raw intensity data (CEL files) and meaningful biological identifiers by providing probe sequences and feature identifiers.

## Typical Workflow

This package is rarely called directly by the user; instead, it is automatically loaded by the `oligo` package when reading CEL files from the Clariom S Rat HT platform.

### 1. Loading Data
When you read CEL files using `oligo`, the `pd.clariom.s.rat.ht` package must be installed for the `read.celfiles` function to correctly identify the array geometry and feature layout.

```r
library(oligo)
# Assuming CEL files are in the current directory
celFiles <- list.celfiles()
rawData <- read.celfiles(celFiles)
# oligo will automatically look for and use pd.clariom.s.rat.ht
```

### 2. Accessing Sequence Data
If you need to retrieve the actual nucleotide sequences for the Perfect Match (PM) probes on the array, you can load the `pmSequence` dataset.

```r
library(pd.clariom.s.rat.ht)
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# fid corresponds to the feature ID used in the ExpressionFeatureSet
```

### 3. Integration with Downstream Analysis
Once the data is loaded into an `ExpressionFeatureSet` (via `oligo`), you can proceed with standard preprocessing:

```r
# Background correction, normalization, and summarization (RMA)
eset <- rma(rawData)

# The resulting ExpressionSet object can then be used with 'limma' 
# or other Bioconductor tools for differential expression analysis.
```

## Tips and Troubleshooting

- **Automatic Triggering**: If `oligo` throws an error stating "The annotation package, pd.clariom.s.rat.ht, could not be found," ensure this package is installed via `BiocManager::install("pd.clariom.s.rat.ht")`.
- **Memory Management**: Clariom S HT (High Throughput) arrays can be large. Ensure your R session has sufficient RAM when loading multiple CEL files.
- **Platform Specificity**: This package is specific to the **Clariom S** design for **Rat** in the **HT** (Plate) format. It is not compatible with Clariom D arrays or standard cartridge-based Clariom S arrays if they use a different design ID.

## Reference documentation

- [pd.clariom.s.rat.ht Reference Manual](./references/reference_manual.md)