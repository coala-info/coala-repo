---
name: bioconductor-pcagopromoter.hs.hg19
description: This data package provides promoter sequences and transcription factor binding site thresholds for human hg19 genomic analysis. Use when user asks to perform transcription factor enrichment analysis, analyze human gene lists using the pcaGoPromoter package, or map RefSeq identifiers to promoter sequences for the primo function.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/pcaGoPromoter.Hs.hg19.html
---

# bioconductor-pcagopromoter.hs.hg19

name: bioconductor-pcagopromoter.hs.hg19
description: Data package for transcription factor analysis in Homo sapiens. Use when performing functional annotation of gene lists or PCA results using the pcaGoPromoter package, specifically for mapping RefSeq identifiers to promoter sequences and applying thresholds for the 'primo' function.

# bioconductor-pcagopromoter.hs.hg19

## Overview
The `pcaGoPromoter.Hs.hg19` package is a specialized data experiment package for *Homo sapiens*. It provides the necessary promoter sequence data and pre-calculated thresholds required by the `pcaGoPromoter` software package to perform transcription factor binding site (TFBS) enrichment analysis. It specifically targets the hg19 (GRCh37) genome assembly.

## Usage
This package is primarily a dependency for `pcaGoPromoter`. You do not typically call functions within this package directly; instead, you load it so that its data objects are available to the `primo` function.

### Loading the Data
To make the human hg19 promoter data available in your R session:

```r
library(pcaGoPromoter.Hs.hg19)

# The package contains two main data objects:
data(promotersRefseqs)
data(thresholds)
```

### Integration with pcaGoPromoter
The primary workflow involves using these data objects within the `primo` function to find enriched transcription factor proximal promoters in a list of genes (e.g., genes significantly contributing to a Principal Component).

```r
library(pcaGoPromoter)
library(pcaGoPromoter.Hs.hg19)

# Example: Running primo analysis for Homo sapiens
# 'geneList' should be a character vector of RefSeq identifiers
results <- primo(geneList, organism = "Hs", threshold = 0.05)
```

### Data Objects
- `promotersRefseqs`: A list containing promoter sequences mapped to RefSeq identifiers.
- `thresholds`: Pre-calculated score thresholds used to determine significant transcription factor binding hits.

## Tips
- **Identifier Match**: Ensure your input gene list uses RefSeq identifiers, as the underlying data in this package is indexed by RefSeq.
- **Genome Version**: This package is specific to **hg19**. If your analysis is based on hg38, this data package may not be appropriate for precise genomic coordinates, though it remains the standard for the `pcaGoPromoter` workflow for human samples in many Bioconductor releases.
- **Automatic Loading**: In many cases, calling `primo(..., organism = "Hs")` will attempt to load this package automatically if it is installed.

## Reference documentation
- [pcaGoPromoter.Hs.hg19 Reference Manual](./references/reference_manual.md)