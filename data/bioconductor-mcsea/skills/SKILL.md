---
name: bioconductor-mcsea
description: Bioconductor-mcsea identifies differentially methylated regions from Illumina 450k and EPIC microarrays using a set enrichment analysis approach. Use when user asks to rank CpG probes, identify differentially methylated regions in promoters or CpG islands, visualize genomic methylation contexts, or integrate methylation results with gene expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/mCSEA.html
---


# bioconductor-mcsea

name: bioconductor-mcsea
description: Analysis of Differentially Methylated Regions (DMRs) from Illumina 450k and EPIC microarrays using Methylated CpGs Set Enrichment Analysis (mCSEA). Use this skill to rank CpG probes, identify DMRs in predefined regions (promoters, gene bodies, CpG islands), visualize genomic methylation contexts, and integrate methylation results with gene expression data.

# bioconductor-mcsea

## Overview
mCSEA (Methylated CpGs Set Enrichment Analysis) identifies Differentially Methylated Regions (DMRs) by applying Gene Set Enrichment Analysis (GSEA) to DNA methylation data. Unlike probe-level analyses, mCSEA aggregates signals across predefined genomic regions—such as promoters, gene bodies, and CpG islands—to provide more biologically meaningful results. It is specifically designed for Illumina 450k and EPIC microarray data.

## Core Workflow

### 1. Data Preparation
The package requires a matrix of $\beta$-values or M-values. If starting from raw `.idat` files, use `minfi` or `ChAMP` to preprocess and normalize the data first.

```r
library(mCSEA)
library(mCSEAdata)
data(mcseadata) # Loads betaTest and phenoTest
```

### 2. Ranking CpG Probes
Use `rankProbes()` to calculate a metric (usually a t-statistic) for each CpG. By default, it transforms $\beta$-values to M-values for better statistical performance with `limma`.

```r
# refGroup specifies the control/reference level in the phenotype explanatory variable
myRank <- rankProbes(betaTest, phenoTest, refGroup = "Control")
```

Key parameters:
- `explanatory`: Column name in pheno for the main variable.
- `covariates`: Vector of column names for adjustment.
- `paired`: Set to `TRUE` for paired analysis (requires `pairColumn`).
- `typeAnalysis`: Set to "beta" if you prefer not to use M-values.

### 3. Searching for DMRs
Use `mCSEATest()` to identify enriched regions based on the ranked probes.

```r
myResults <- mCSEATest(myRank, betaTest, phenoTest, 
                       regionsTypes = c("promoters", "genes", "CGI"), 
                       platform = "EPIC")
```

Key parameters:
- `regionsTypes`: "promoters", "genes", "CGI" (CpG Islands), or "custom".
- `minCpGs`: Minimum probes per region (default is 5).
- `nproc`: Number of processors for parallel execution.

### 4. Visualizing Results
mCSEA provides two primary visualization methods:

**Genomic Context Plot:** Shows methylation levels of samples across the region alongside gene annotations.
```r
mCSEAPlot(myResults, regionType = "promoters", dmrName = "CLIC6", transcriptAnnotation = "symbol")
```

**GSEA Plot:** Shows the enrichment score and the distribution of ranked CpGs (leading edge) for a specific DMR.
```r
mCSEAPlotGSEA(myRank, myResults, regionType = "promoters", dmrName = "CLIC6")
```

### 5. Integrating with Expression Data
Use `mCSEAIntegrate()` to correlate DMR methylation with gene expression. It calculates the mean methylation of leading-edge CpGs and performs correlation tests with nearby genes.

```r
# exprTest should be a matrix of expression values with matching sample names
resultsInt <- mCSEAIntegrate(myResults, exprTest, regionType = "promoters", geneIDs = "ENSEMBL")
```

Note: For promoters, the function filters for negative correlations; for gene bodies, it filters for positive correlations, following established biological patterns.

## Tips and Best Practices
- **Cell Type Heterogeneity:** For tissue samples (like blood), use `minfi::estimateCellCounts()` and include the resulting proportions as covariates in `rankProbes()`.
- **Custom Regions:** You can analyze user-defined regions by providing a list of CpG-to-region associations to the `customAnnotation` parameter in `mCSEATest()`.
- **Leading Edge:** Pay attention to the `leadingEdge` column in the results; these are the specific CpGs driving the enrichment signal in a DMR.

## Reference documentation
- [mCSEA](./references/mCSEA.md)