---
name: bioconductor-ivygapse
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ivygapSE.html
---

# bioconductor-ivygapse

name: bioconductor-ivygapse
description: Access and analyze the Ivy Glioblastoma Atlas Project (Ivy-GAP) data. Use when working with glioblastoma expression data (FPKM), tumor metadata, and anatomical structure annotations from the Ivy-GAP project. Supports differential expression analysis and structural classification of tumor sub-blocks.

# bioconductor-ivygapse

## Overview
The `ivygapSE` package provides a `SummarizedExperiment` container for the Ivy Glioblastoma Atlas Project (Ivy-GAP) dataset. It includes RNA-seq FPKM values for 270 samples across 42 donors, integrated with detailed metadata regarding tumor anatomy, sub-block details, and molecular subtypes.

## Core Data Access
Load the package and the primary dataset:

```r
library(ivygapSE)
data(ivySE)
# View the SummarizedExperiment object
ivySE
```

The `ivySE` object contains:
- **Assays**: `fpkm` (expression values).
- **RowData**: Gene IDs, symbols, and genomic coordinates.
- **ColData**: Sample-level metadata including `tumor_id`, `structure_acronym`, and BAM links.
- **Metadata**: Project README, tumor-level details, and sub-block-level details.

## Metadata Exploration
Access specific tables for donors and tumor sub-blocks:

```r
# Get tumor-level details (N=42)
td = tumorDetails(ivySE)

# Get sub-block-level details (N=946)
sb = subBlockDetails(ivySE)

# View project README
cat(metadata(ivySE)$README, sep="\n")
```

## RNA-seq Sample Analysis
Samples are often categorized by their anatomical structure or measurement objective.

### Filtering by Structure
Use the `structure_acronym` in `colData` to identify sample origins (e.g., CT: Cellular Tumor, LE: Leading Edge, IT: Infiltrating Tumor):

```r
# Extract structural basis
struc = as.character(colData(ivySE)$structure_acronym)
basis = vapply(strsplit(struc, "-"), function(x) x[1], character(1))
table(basis)
```

### Integrating Molecular Subtypes
Molecular subtypes are stored in `tumorDetails` and can be mapped back to the expression samples:

```r
moltype = tumorDetails(ivySE)$molecular_subtype
names(moltype) = tumorDetails(ivySE)$tumor_name
ivySE$moltype = factor(moltype[ivySE$tumor_name])
```

## Differential Expression (DE)
The package provides pre-computed results and supports custom `limma` workflows.

### Using Pre-computed Results
Retrieve moderated test statistics for reference histology comparisons:

```r
library(limma)
ebout = getRefLimma()
# View top genes for a specific contrast (e.g., CT vs CT-mvp)
topTable(ebout, coef=2)
```

### Custom DE Workflow
Perform DE analysis on specific subsets, such as "reference histology" samples:

```r
# Subset to reference histology
refex = ivySE[, grep("reference", ivySE$structure_acronym)]
refmat = assay(refex)

# Create design matrix (e.g., by molecular subtype)
tydes = model.matrix(~moltype, data=as.data.frame(colData(refex)))

# Model with duplicate correlation for tumor_id (random effect)
block = factor(refex$tumor_id)
dd = duplicateCorrelation(refmat, tydes, block=block)
fit = lmFit(refmat, tydes, correlation=dd$consensus)
fit = eBayes(fit)
topTable(fit)
```

## Structural Classification
Use expression data to classify samples into structural types (e.g., using Random Forest):

```r
library(randomForest)
library(genefilter)

# Filter for high-variance genes
iqrs = rowIQRs(assay(refex))
inds = which(iqrs > quantile(iqrs, .5))

# Train classifier
rf1 = randomForest(x=t(assay(refex[inds,])), 
                   y=factor(refex$structure_acronym), 
                   importance=TRUE)
print(rf1)
varImpPlot(rf1)
```

## Reference documentation
- [ivygapSE](./references/ivygapSE.md)