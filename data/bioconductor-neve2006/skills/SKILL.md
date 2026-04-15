---
name: bioconductor-neve2006
description: This package provides synchronized gene expression and comparative genomic hybridization data for 50 breast cancer cell lines. Use when user asks to load the Neve 2006 breast cancer dataset, access matched RMA-normalized expression and CGH data, or correlate copy number alterations with transcriptomics.
homepage: https://bioconductor.org/packages/release/data/experiment/html/Neve2006.html
---

# bioconductor-neve2006

## Overview
The `Neve2006` package provides a standardized dataset from the study "A collection of breast cancer cell lines for the study of functionally distinct cancer subtypes" (Neve et al., 2006). It contains two primary data objects: `neveRMAmatch` (ExpressionSet) and `neveCGHmatch` (cghSet). These objects are synchronized, containing data for the same 50 breast cancer cell lines, allowing for integrated analysis of transcriptomics and copy number alterations.

## Loading Data
To begin using the dataset, load the library and the specific data objects:

```r
library(Neve2006)

# Load matched ExpressionSet (RMA normalized)
data(neveRMAmatch)

# Load matched CGH data (cghSet)
data(neveCGHmatch)
```

## Data Exploration
The samples in both objects are identical and can be verified using `sampleNames()`.

### Expression Data (`neveRMAmatch`)
- **Platform**: Affymetrix hgu133a.
- **Features**: 22,283 probe sets.
- **Metadata**: Access phenotype data (cell line info) using `pData(neveRMAmatch)`.
- **Abstract**: View the study abstract using `abstract(experimentData(neveRMAmatch))`.

### CGH Data (`neveCGHmatch`)
- **Platform**: Neve2006.caArrayDB (OncoBAC arrays).
- **Features**: 2,696 clones.
- **Feature Metadata**: Access genomic locations (Chromosome, kb position) via `fData(neveCGHmatch)`.

## Common Workflows

### Correlating Copy Number and Expression
A typical workflow involves identifying a genomic region of interest (e.g., 8p12) and correlating the copy number log-ratios of a clone with the expression of nearby genes.

1. **Identify Clones**: Search for specific clones by name or location.
   ```r
   # Find index for a specific clone
   clone_idx <- grep("RP11-265K5", featureNames(neveCGHmatch))
   # Extract log-ratios
   nevlr <- as.numeric(logRatios(neveCGHmatch)[clone_idx, ])
   ```

2. **Identify Probe Sets**: Use annotation packages (like `hgu133a.db`) to find probe sets mapping to the same cytoband.
   ```r
   library(hgu133a.db)
   # Map probe sets to cytobands
   cb <- as.list(hgu133aMAP)
   ps8p12 <- names(unlist(cb)[grep("8p12", unlist(cb))])
   # Extract expression values
   nevex <- exprs(neveRMAmatch)[ps8p12, ]
   ```

3. **Visualization**: Plot the relationship between copy number (log-ratio) and expression (RMA).
   ```r
   plot(nevlr, nevex[1, ], xlab="CGH log-ratio", ylab="RMA expression", main="Gene Symbol")
   ```

## Tips
- **Sample Matching**: Always ensure sample order is consistent before performing row-wise correlations between the two objects.
- **Annotation**: The genomic coordinates in the CGH data are based on older builds. For modern analysis, consider re-mapping clone sequences or gene symbols to current genome builds (e.g., GRCh38).
- **Phenotypes**: The `pData` contains 15 variables including `cellLine` and `reductMamm`, which can be used for group-wise comparisons.

## Reference documentation
- [Combining expression and CGH data on breast cancer cell lines: Neve2006](./references/neve06notes.md)