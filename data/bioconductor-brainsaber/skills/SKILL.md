---
name: bioconductor-brainsaber
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.12/bioc/html/BrainSABER.html
---

# bioconductor-brainsaber

name: bioconductor-brainsaber
description: Analysis and comparison of human brain development RNA-Seq data against the Allen Institute BrainSpan atlas. Use this skill to facilitate transcriptional mechanism studies by comparing user-provided expression data with various developmental stages and brain structures using similarity scoring (cosine/euclidean) and differential expression (Up/Down/Normal) analysis.

## Overview

BrainSABER (Brain Structure-Agnostic Biological Evaluation in R) is a Bioconductor package designed to map user-provided RNA-Seq data onto the Allen Institute for Brain Science (AIBS) BrainSpan atlas. It utilizes the `CellScabbard` class (extending `SummarizedExperiment`) to store user data alongside reference data. The package provides tools for gene identifier matching, similarity matrix generation, and interactive heatmap visualization to identify which developmental ages and brain structures most closely match the user's samples.

## Core Workflow

### 1. Reference Data Preparation
The AIBSARNA reference dataset must be constructed first. This function downloads, formats, and caches the BrainSpan data.

```r
library(BrainSABER)
AIBSARNA <- buildAIBSARNA()
```

### 2. Creating a CellScabbard Object
The `CellScabbard` object is the primary container. It requires expression data, phenotype data, feature data, and the AIBSARNA reference.

```r
# exprsData: matrix (genes x samples)
# phenoData: DataFrame (sample attributes)
# featureData: DataFrame (gene attributes)
# autoTrim: If TRUE, automatically matches genes between user and reference
toySet <- CellScabbard(exprsData = my_exprs, 
                       phenoData = my_pd,
                       featureData = my_fd, 
                       AIBSARNA = AIBSARNA,
                       autoTrim = TRUE)
```

### 3. Gene Identifier Matching
To maximize the overlap between user data and the reference, test different identifier columns (e.g., "ensembl_gene_id", "gene_symbol").

```r
# Check match count for a specific identifier
getExternalVector(toySet, index = 1, AIBSARNA = AIBSARNA,
                  dataSetId = "ensembl_gene_id", 
                  AIBSARNAid = "ensembl_gene_id")
```

### 4. Similarity Analysis
Generate scores comparing user samples to reference samples. Supported methods are "cosine" and "euclidean".

```r
# Generate scores (0 to 1, where 1 is a perfect match)
similarityScores(toySet) <- getSimScores(data = toySet, similarity_method = "cosine")

# Generate Age x Structure matrices
similarityMatrices(toySet) <- getSimMatrix(data = toySet)

# Generate ranked DataFrames of matches
similarityDFs(toySet) <- getSimDataFrame(data = toySet, similarity_method = "cosine")
```

### 5. Differential Expression (UND Matrices)
Identify if genes are Up-regulated (U/1), Down-regulated (D/-1), or Normal (N/0) relative to the reference.

```r
# Using log2 fold-change method
und_mats <- getUNDmatrix(dataSet = toySet, method = "log2fc", matrix_type = "char")
```

## Visualization
The similarity matrices can be visualized using `heatmaply` to create interactive maps of brain structure vs. developmental age.

```r
library(heatmaply)
# Visualize the first sample's similarity across the atlas
heatmaply(similarityMatrices(toySet)[[1]])
```

## Tips and Best Practices
- **Identifier Choice**: AIBSARNA is natively sequenced with Ensembl identifiers. Using `ensembl_gene_id` typically yields the highest match rate.
- **Auto-trimming**: Setting `autoTrim = TRUE` in the `CellScabbard` constructor simplifies the workflow by automatically handling `getTrimmedExternalSet` and `getRelevantGenes`.
- **Accessors**: Always use the provided accessor functions (`similarityScores()`, `similarityMatrices()`, `relevantGenes()`) to interact with `CellScabbard` slots.

## Reference documentation
- [Installing and Using BrainSABER](./references/Installing_and_Using_BrainSABER.md)