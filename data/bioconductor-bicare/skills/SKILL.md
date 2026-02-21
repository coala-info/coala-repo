---
name: bioconductor-bicare
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BicARE.html
---

# bioconductor-bicare

name: bioconductor-bicare
description: Biclustering analysis of gene expression data using the FLOC (FLexible Overlapped biClustering) algorithm. Use this skill to identify sets of genes co-expressed across subsets of samples, perform functional enrichment on biclusters, and generate HTML reports for results exploration.

## Overview

The `BicARE` package implements the FLOC algorithm to find biclusters in gene expression data. Unlike standard clustering, biclustering identifies local patterns where a subset of genes shows coherent expression across only a subset of samples. Coherence is measured using a "residue" score; lower residues indicate more tightly correlated biclusters.

## Core Workflow

### 1. Data Preparation and Residue Calculation
BicARE typically works with `ExpressionSet` objects. You can calculate the residue of the entire dataset to understand the baseline coherence.

```R
library(BicARE)
data(sample.bicData)

# Calculate residue of the whole matrix
res_val <- residue(sample.bicData)
```

### 2. Biclustering with FLOC
The `FLOC` function is the primary tool. It can be initialized randomly or with prior knowledge.

**Random Initialization:**
```R
# k: number of biclusters
# r: residue threshold (e.g., 0.01)
# pGene/pSample: initial probability of inclusion
# N/M: minimum genes/samples per bicluster
# t: number of iterations
res.biclustering <- FLOC(sample.bicData, k=15, pGene=0.3, pSample=0.6, r=0.01, N=10, M=8, t=200)
```

**Directed Initialization:**
To guide the algorithm using known gene sets or sample groups, provide boolean matrices to `blocGene` and `blocSample`.

```R
init.genes <- matrix(0, nrow=nrow(sample.bicData), ncol=5)
init.genes[1:10, 1] <- 1 # Force first 10 genes into bicluster 1
res.directed <- FLOC(sample.bicData, k=5, blocGene=init.genes)
```

### 3. Extracting and Visualizing Biclusters
Extract specific biclusters as matrices and visualize their expression profiles.

```R
# Extract the 6th bicluster
bic <- bicluster(res.biclustering, 6, graph=TRUE)

# The result is a matrix of expression values for the subset
head(bic)
```

## Downstream Analysis

### Functional Enrichment
Test if biclusters are enriched for specific Gene Sets (e.g., GO terms).

```R
library(GSEABase)
# Create a GeneSetCollection
gsc <- GeneSetCollection(res.biclustering$ExpressionSet[1:50], setType=GOCollection())

# Run hypergeometric test
res.enriched <- testSet(res.biclustering, gsc)
```

### Sample Covariate Enrichment
Test if biclusters are associated with specific sample phenotypes (e.g., "Case" vs "Control").

```R
# annot: data frame of sample metadata
# covariates: columns to test
res.annot <- testAnnot(res.biclustering, annot=pData(sample.bicData), covariates=c("sex", "type"))
```

### Reporting
Generate an interactive HTML report to explore genes, samples, and enrichment results.

```R
makeReport(dirPath=getwd(), dirName="BicARE_Report", resBic=res.annot, browse=TRUE)
```

## Tips for Success
- **Residue Threshold (`r`)**: If FLOC returns no biclusters or very small ones, try slightly increasing the residue threshold.
- **Non-trivial Biclusters**: Check the `rowvar` column in the results. Biclusters with very low `rowvar` might represent constant expression levels rather than interesting correlation patterns.
- **Iteration (`t`)**: For large datasets, increase the number of iterations to ensure the algorithm converges on stable biclusters.

## Reference documentation
- [BicARE](./references/BicARE.md)