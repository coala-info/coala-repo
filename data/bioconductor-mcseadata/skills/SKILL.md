---
name: bioconductor-mcseadata
description: This package provides experimental data, probe-to-feature association objects, and genomic annotations required for Methylated CpG Set Enrichment Analysis. Use when user asks to perform DNA methylation enrichment analysis, map Illumina probes to genomic features, or access example methylation datasets for mCSEA workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/mCSEAdata.html
---

# bioconductor-mcseadata

name: bioconductor-mcseadata
description: Access to experimental data, probe-to-feature association objects, and genomic annotations for the mCSEA (Methylated CpG Set Enrichment Analysis) package. Use this skill when performing DNA methylation enrichment analysis, testing mCSEA workflows, or requiring mapping between Illumina probes (450k, EPIC, EPICv2) and genomic features like promoters, gene bodies, and CpG islands.

## Overview

mCSEAdata is a specialized data package that provides the infrastructure required for the mCSEA package to perform enrichment analysis. Its primary role is to provide "association objects"—pre-defined lists that group CpG probes into functional genomic sets (promoters, genes, and CpG islands) based on specific Illumina platforms. It also includes example methylation and expression datasets used for demonstrating differential methylation workflows.

## Data Loading

To access the datasets and association objects, load the package and use the `data()` function:

```r
library(mCSEAdata)

# Load core association and annotation objects
data(mcseadata)

# Load chromosome band information for plotting
data(bandTable)
```

## Key Components

### 1. Test Datasets
These objects are used to demonstrate mCSEA functionality, typically representing a leukemia vs. healthy control study:
*   `betaTest`: A matrix of beta-values for 9,241 EPIC probes across 20 samples.
*   `phenoTest`: A data frame containing sample phenotypes (Case/Control) and covariates.
*   `exprTest`: A matrix of gene expression values for 100 genes across the same 20 samples.

### 2. Association Objects
These are lists where each element is a genomic feature (e.g., a gene name or CGI coordinate) containing a character vector of associated CpG probes. They are essential for the `mCSEA.test()` function.

*   **Promoters**: `assocPromoters450k`, `assocPromotersEPIC`, `assocPromotersEPICv2`
*   **Gene Bodies**: `assocGenes450k`, `assocGenesEPIC`, `assocGenesEPICv2`
*   **CpG Islands**: `assocCGI450k`, `assocCGIEPIC`, `assocCGIEPICv2`

### 3. Annotation and Visualization Objects
*   **GRanges Annotations**: `annot450K`, `annotEPIC`, and `annotEPICv2` provide genomic coordinates for probes, used by `mCSEAPlot()` and `mCSEAIntegrate()`.
*   **Ideogram Data**: `bandTablehg19` and `bandTablehg38` provide chromosome band and centromere locations for genomic tracks.

## Typical Workflow Integration

The objects in this package are designed to be passed directly into `mCSEA` functions. For example, when running a regional analysis:

```r
# The mCSEA.test function internally searches for these association 
# objects based on the 'platform' and 'regionTypes' arguments.
# If using custom data, ensure your probe IDs match the format in these objects.
head(assocPromotersEPIC[[1]]) # View probes for the first promoter
```

When plotting results with `mCSEAPlot()`, the package uses the `bandTable` objects to render the chromosome track correctly for the specified genome build (hg19 or hg38).

## Reference documentation
- [mCSEAdata](./references/mCSEAdata.md)