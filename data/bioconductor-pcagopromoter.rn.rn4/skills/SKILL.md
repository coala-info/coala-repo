---
name: bioconductor-pcagopromoter.rn.rn4
description: This package provides promoter sequences and transcription factor binding site thresholds for Rattus norvegicus (rn4 assembly) to support functional genomics analysis. Use when user asks to perform transcription factor over-representation analysis, scan rat promoter sequences for binding sites, or provide data for the primo function in the pcaGoPromoter package.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/pcaGoPromoter.Rn.rn4.html
---

# bioconductor-pcagopromoter.rn.rn4

name: bioconductor-pcagopromoter.rn.rn4
description: Data package for transcription factor analysis in Rattus norvegicus (Rat). Use this skill when performing functional genomics analysis with the pcaGoPromoter package specifically for rat data (rn4 assembly), providing the necessary promoter sequences and thresholds for the primo() function.

# bioconductor-pcagopromoter.rn.rn4

## Overview

The `pcaGoPromoter.Rn.rn4` package is a specialized data experiment package for *Rattus norvegicus*. It serves as a dependency for the `pcaGoPromoter` software package. It contains the essential regulatory infrastructure—specifically promoter sequences and position weight matrix (PWM) thresholds—required to perform transcription factor binding site (TFBS) over-representation analysis using the `primo()` function.

This package is specifically tailored to the **rn4** genome assembly.

## Usage and Workflow

### Loading the Data
While the package is often loaded automatically by `pcaGoPromoter` when the organism is set to "Rn", you can load it manually to inspect the data structures:

```r
library(pcaGoPromoter.Rn.rn4)

# The package provides two main data objects:
data(promotersRefseqs)
data(thresholds)
```

### Integration with pcaGoPromoter
The primary use case for this package is providing the background data for the `primo()` function. `primo` uses these objects to scan for transcription factor binding sites in a set of gene promoters compared to a background set.

```r
library(pcaGoPromoter)
library(pcaGoPromoter.Rn.rn4)

# Example workflow:
# 1. Conduct PCA or grouping on your expression data
# 2. Identify a list of RefSeq identifiers for genes of interest
my_genes <- c("NM_012345", "NM_023456", "NM_034567") 

# 3. Run primo() specifying the rat organism
# The function will internally access the data in pcaGoPromoter.Rn.rn4
results <- primo(my_genes, organism = "Rn")
```

### Data Components
- `promotersRefseqs`: A list containing promoter sequences for rat genes, indexed by RefSeq identifiers. These sequences are used to search for matches to transcription factor PWMs.
- `thresholds`: A list of pre-calculated score thresholds for various transcription factor PWMs, used to determine what constitutes a "hit" during the scanning process.

## Tips
- **Version Consistency**: Ensure your gene identifiers are RefSeq IDs, as the `promotersRefseqs` object is mapped to RefSeq.
- **Genome Assembly**: This package is specific to **rn4**. If your data is mapped to a newer assembly (like rn6 or rn7), results may vary due to changes in promoter coordinates or sequence definitions.
- **Memory**: As a data package containing genomic sequences, it uses LazyLoad. The data is only pulled into memory when explicitly accessed or called by `primo()`.

## Reference documentation
- [pcaGoPromoter.Rn.rn4 Reference Manual](./references/reference_manual.md)