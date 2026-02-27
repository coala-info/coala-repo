---
name: bioconductor-sampleclassifier
description: This package classifies gene expression profiles from microarray and RNA-seq data by comparing query samples against a reference matrix using marker genes or Support Vector Machines. Use when user asks to classify gene expression profiles, identify sample types from transcriptomic data, or perform SVM-based classification of microarray and RNA-seq samples.
homepage: https://bioconductor.org/packages/release/bioc/html/sampleClassifier.html
---


# bioconductor-sampleclassifier

## Overview

The `sampleClassifier` package provides tools to classify gene expression profiles from both microarray and RNA-seq platforms. It works by comparing a query expression matrix against a reference matrix of known sample types. Classification is performed either through a similarity score based on shared marker genes (automatically identified by the package) or via Support Vector Machines (SVM).

## Core Workflows

### 1. Microarray Classification
For microarray data, the package handles probe-set to gene mapping across different chip types (e.g., hgu133plus2 to hgu133a).

```r
library(sampleClassifier)
# ref_matrix and query_mat should be normalized matrices (rows=probes, cols=samples)
results <- classifyProfile(ref_matrix = micro_refmat, 
                           query_mat = micro_testmat, 
                           chip1 = "hgu133plus2", 
                           chip2 = "hgu133a", 
                           write2File = FALSE)

# View top hits for each query sample
results
```

### 2. RNA-seq Classification
For RNA-seq data, the package supports common gene identifiers (Ensembl, RefSeq, UCSC).

```r
# Matrices should have genes as rows and samples as columns
results_rnaseq <- classifyProfile.rnaseq(ref_matrix = rnaseq_refmat, 
                                         query_mat = rnaseq_testmat, 
                                         gene.ids.type = "ensembl")
```

### 3. SVM-based Classification
If a deterministic class prediction is required rather than a ranked list of similarity scores, use the SVM functions.

```r
# For Microarray
svm_res <- classifyProfile.svm(ref_matrix, query_mat, chip1, chip2)

# For RNA-seq
svm_res_rnaseq <- classifyProfile.rnaseq.svm(ref_matrix, query_mat, gene.ids.type = "ensembl")
```

### 4. Visualizing Results
You can visualize the similarity scores from the list-based classification functions as a heatmap.

```r
get.heatmap(results)
```

## Key Parameters and Tips

- **fun1**: (mean or median) Determines the threshold for selecting marker genes. Default is `median`.
- **fun2**: (mean or median) Used to summarize expression values of multiple probe sets belonging to the same gene when comparing different chips. Default is `mean`.
- **Data Preparation**: Ensure that the input matrices are normalized. For RNA-seq, ensure gene IDs match the `gene.ids.type` parameter.
- **Output**: `classifyProfile` returns a list of ranked hits. `classifyProfile.svm` returns a data frame with predicted class labels.
- **Marker Genes**: If `write2File = TRUE`, the package will save the specific marker genes used for the classification to the specified `out.dir`.

## Reference documentation

- [Sample Classifier Reference Manual](./references/reference_manual.md)