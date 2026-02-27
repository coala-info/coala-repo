---
name: bioconductor-pcagopromoter.mm.mm9
description: This package provides promoter sequences and transcription factor binding site thresholds for Mus musculus mapped to the mm9 genome assembly. Use when user asks to perform transcription factor analysis, identify enriched binding sites using the primo function, or analyze mouse promoter sequences.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/pcaGoPromoter.Mm.mm9.html
---


# bioconductor-pcagopromoter.mm.mm9

name: bioconductor-pcagopromoter.mm.mm9
description: Data package for transcription factor analysis in Mus musculus (mouse). Use this skill when performing promoter analysis, transcription factor binding site (TFBS) enrichment, or using the 'primo' function within the pcaGoPromoter framework for mm9 genome builds.

# bioconductor-pcagopromoter.mm.mm9

## Overview

The `pcaGoPromoter.Mm.mm9` package is a specialized data annotation package for the Bioconductor ecosystem. It provides the necessary promoter sequence data and threshold values required by the `pcaGoPromoter` engine to perform transcription factor analysis on mouse (*Mus musculus*) data mapped to the mm9 genome assembly. It specifically contains `thresholds` and `promotersRefseqs` objects used by the `primo` function to identify enriched transcription factor binding sites in gene lists.

## Usage and Workflow

### Loading the Data
This package is primarily a data dependency for `pcaGoPromoter`. While it can be loaded directly, it is typically accessed internally by the analysis functions.

```r
# Install if necessary
# BiocManager::install("pcaGoPromoter.Mm.mm9")

# Load the library
library(pcaGoPromoter.Mm.mm9)

# List the data objects contained in the package
data(package = "pcaGoPromoter.Mm.mm9")
```

### Integration with pcaGoPromoter
The core use case is providing the mouse-specific background for the `primo()` function. The `primo()` function uses this data to scan for transcription factor binding sites (TFBS) in the promoters of a provided list of RefSeq identifiers.

```r
library(pcaGoPromoter)
library(pcaGoPromoter.Mm.mm9)

# Example workflow:
# 1. Have a list of mouse RefSeq IDs (e.g., from a differential expression analysis)
# my_genes <- c("NM_001011874", "NM_001011735", ...)

# 2. Run the primo function specifying the organism
# The 'primo' function will automatically look for pcaGoPromoter.Mm.mm9 
# when 'org' is set to "Mm"
# results <- primo(my_genes, org = "Mm", pctThreshold = 90)
```

### Data Objects
- `promotersRefseqs`: A list containing promoter sequences for mouse genes.
- `thresholds`: Pre-calculated score thresholds for transcription factor matrices, used to determine what constitutes a "hit" in a promoter region.

## Tips and Best Practices
- **Genome Version**: Ensure your gene identifiers and coordinates correspond to the **mm9** (NCBI37) build. If you are using mm10 (GRCm38), this package is not appropriate.
- **Input IDs**: The `primo` function expects RefSeq identifiers. If you have Ensembl IDs or Gene Symbols, use `biomaRt` or `org.Mm.eg.db` to convert them to RefSeq before analysis.
- **Memory**: As a `LazyLoad` package, the data is only loaded into memory when accessed, which helps manage R session resources.

## Reference documentation

- [pcaGoPromoter.Mm.mm9 Reference Manual](./references/reference_manual.md)