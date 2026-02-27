---
name: bioconductor-tekrabber
description: TEKRABber analyzes the relationship between gene expression and transposable elements using RNA-seq data for comparative transcriptomics. Use when user asks to compare gene and transposable element correlations between species, perform differential expression analysis on transposable elements, or investigate gene-TE interactions in control and treatment groups.
homepage: https://bioconductor.org/packages/release/bioc/html/TEKRABber.html
---


# bioconductor-tekrabber

name: bioconductor-tekrabber
description: Analyze correlations between gene expression and transposable elements (TEs) using RNA-seq data. Use this skill to perform comparative transcriptomics between two species (ortholog-based) or between control and experimental groups within the same species. It provides workflows for normalization, differential expression analysis, and correlation estimation.

# bioconductor-tekrabber

## Overview

TEKRABber is an R package designed to investigate the relationship between genes and transposable elements (TEs). It facilitates the comparison of Gene:TE correlations across different biological contexts, such as evolutionary comparisons between species or experimental comparisons within a single species.

## Installation

Install the package via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("TEKRABber")
library(TEKRABber)
```

## Workflow 1: Comparing Two Species

This workflow handles orthology mapping and scaling factors required for cross-species comparisons.

### 1. Prepare Data
Input tables must have Ensembl gene IDs for genes and TE names for TEs in the first column.

### 2. Query Orthologs and Scale Data
Use `orthologScale()` to fetch orthology information and calculate scaling factors.
- Use `prepareRMSK("ref_db", "compare_db")` to get RepeatMasker annotations from UCSC.
- Use Ensembl abbreviations for species names (e.g., "hsapiens", "ptroglodytes").

```r
# Example using human (ref) and chimp (compare)
fetchData <- orthologScale(
    speciesRef = "hsapiens",
    speciesCompare = "ptroglodytes",
    geneCountRef = hmGene,
    geneCountCompare = chimpGene,
    teCountRef = hmTE,
    teCountCompare = chimpTE,
    rmsk = hg38_panTro6_rmsk
)
```

### 3. Generate Inputs and Run DE Analysis
Use `DECorrInputs()` to format data and `DEgeneTE()` for differential expression. Set `expDesign = TRUE` for two-species comparisons.

```r
inputBundle <- DECorrInputs(fetchData)

# Create metadata with 'species' column
meta <- data.frame(
    species = factor(c(rep("human", n1), rep("chimpanzee", n2)))
)
rownames(meta) <- colnames(inputBundle$geneInputDESeq2)

resultsDE <- DEgeneTE(
    geneTable = inputBundle$geneInputDESeq2,
    teTable = inputBundle$teInputDESeq2,
    metadata = meta,
    expDesign = TRUE
)
```

### 4. Estimate Correlations
Calculate correlations for each group using `corrOrthologTE()`.

```r
corrRef <- corrOrthologTE(
    geneInput = resultsDE$geneCorrInputRef,
    teInput = resultsDE$teCorrInputRef,
    corrMethod = "pearson",
    padjMethod = "fdr"
)
```

## Workflow 2: Control vs. Treatment (Same Species)

Use this workflow when comparing different conditions within the same species.

### 1. Run DE Analysis
Set `expDesign = FALSE` and ensure metadata contains an `experiment` column.

```r
metaExp <- data.frame(experiment = factor(c(rep("control", 5), rep("treatment", 5))))
rownames(metaExp) <- colnames(geneInputDE)

resultDE <- DEgeneTE(
    geneTable = geneInputDE,
    teTable = teInputDE,
    metadata = metaExp,
    expDesign = FALSE
)
```

### 2. Estimate Correlations
Run `corrOrthologTE()` separately for the control and treatment inputs provided in the `resultDE` object.

## Visualization

Use the interactive Shiny app to explore Gene:TE pairs, scatterplots, and DE results.

```r
# Requires gridlayout, plotly, bslib, and shiny
appTEKRABber(
    corrRef = controlCorr,
    corrCompare = treatmentCorr,
    DEobject = resultDE
)
```

## Tips for Efficiency

- **Subsetting**: Correlation analysis is computationally expensive. Subset your gene/TE lists to those of interest or those passing DE thresholds before running `corrOrthologTE()`.
- **Parallelization**: Use the `numCore` parameter in `corrOrthologTE()` to speed up calculations on multi-core systems.
- **Species Names**: Verify Ensembl species names using `biomaRt::listDatasets(biomaRt::useEnsembl(biomart="genes"))`.

## Reference documentation

- [TEKRABber Vignette (Rmd)](./references/TEKRABber.Rmd)
- [TEKRABber Vignette (Markdown)](./references/TEKRABber.md)