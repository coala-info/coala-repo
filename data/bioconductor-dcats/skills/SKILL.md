---
name: bioconductor-dcats
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DCATS.html
---

# bioconductor-dcats

name: bioconductor-dcats
description: Differential composition analysis for single-cell RNA-seq data using DCATS. Use this skill to detect changes in cell type abundances between conditions or along continuous covariates, while accounting for clustering uncertainty and misclassification errors.

# bioconductor-dcats

## Overview

DCATS (Differential Composition Analysis with Transformed Similarity) is an R package designed to detect differential cell type abundances in single-cell experiments. It addresses common challenges such as small sample sizes, high clustering uncertainty, and misclassification by using a beta-binomial generalized linear model (GLM) and a similarity matrix to correct for cell type confusion.

## Core Workflow

### 1. Prepare Input Data
DCATS requires a count matrix where rows are samples and columns are cell types, along with a design data frame.

```r
library(DCATS)

# Example count matrix (Samples x Cell Types)
sim_count <- matrix(c(36, 35, 29, 271, 279, 250, 84, 87, 79), 
                    nrow = 3, byrow = TRUE)
colnames(sim_count) <- c("TypeA", "TypeB", "TypeC")

# Design matrix
sim_design <- data.frame(condition = c("g1", "g1", "g2"))
```

### 2. Estimate the Similarity Matrix
The similarity matrix represents the misclassification rates between cell types. DCATS provides three ways to generate this:

*   **Uniform Confusion:** Assumes unbiased misclassification.
    ```r
    simil_mat <- create_simMat(K = 3, confuse_rate = 0.2)
    ```
*   **KNN-based:** Uses Seurat's KNN graph to estimate similarity based on neighborhood overlaps.
    ```r
    # Requires a Seurat Graph object and cell labels
    knn_mat <- knn_simMat(seurat_obj@graphs$RNA_nn, seurat_obj$cell_type)
    ```
*   **SVM-based:** Uses a Support Vector Machine classifier on PCA/feature data to estimate confusion via cross-validation.
    ```r
    # Requires a data frame with features and a 'clusterRes' column
    svm_mat <- svm_simMat(svm_dataframe)
    ```

### 3. Run Differential Abundance Analysis
Use `dcats_GLM` to perform the statistical testing.

```r
# Basic GLM
res <- dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat)

# Access results
res$LRT_pvals  # P-values from Likelihood Ratio Test
res$fdr        # Adjusted p-values (Benjamini-Hochberg)
res$ceoffs     # Estimated coefficients (effect sizes)
```

### 4. Advanced Modeling Options

*   **Controlling for Covariates:** Set `base_model = 'FULL'` to test a factor while controlling for others in the design matrix.
*   **Global Dispersion:** To avoid overfitting on small clusters, estimate a global over-dispersion parameter ($\phi$).
    ```r
    phi <- getPhi(sim_count, sim_design)
    res <- dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat, fix_phi = phi)
    ```
*   **Reference Cell Types:** Use specific cell types as a normalization baseline if they are known to be stable.
    ```r
    # Manual selection
    res <- dcats_GLM(sim_count, sim_design, reference = c("TypeA", "TypeB"))
    
    # Automatic detection of stable reference types
    ref_obj <- detect_reference(sim_count, sim_design)
    res <- dcats_GLM(sim_count, sim_design, reference = ref_obj$ordered_celltype[1:ref_obj$min_celltypeN])
    ```

## Tips for Success
*   **Convergence Warnings:** Warnings regarding "Optimization process code: 10" are common with low replicate numbers and typically do not invalidate the results.
*   **Similarity Matrix Importance:** If biological replicates are numerous and balanced, a uniform similarity matrix often suffices. For datasets with high clustering overlap, KNN or SVM-based matrices provide better correction.
*   **Reference Selection:** When using `detect_reference`, always validate the suggested cell types against biological knowledge, as automatic selection is a heuristic.

## Reference documentation
- [Differential Composition Analysis with DCATS](./references/Intro_to_DCATS.md)