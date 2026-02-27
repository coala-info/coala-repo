---
name: bioconductor-resolve
description: This tool performs robust mutational signature analysis using regularized Non-Negative Matrix Factorization to extract and assign signatures. Use when user asks to perform de novo signature extraction, estimate signature exposures, cluster patients based on mutational processes, or analyze associations between signatures and clinical outcomes.
homepage: https://bioconductor.org/packages/release/bioc/html/RESOLVE.html
---


# bioconductor-resolve

name: bioconductor-resolve
description: Robust mutational signature analysis using the RESOLVE R package. Use when Claude needs to perform de novo signature extraction, estimate signature exposures, cluster patients based on mutational processes, or analyze associations between signatures and clinical outcomes/driver mutations.

## Overview

RESOLVE (Robust EStimation Of mutationaL signatures Via rEgularization) is a framework for the efficient extraction and assignment of mutational signatures. It implements a regularized Non-Negative Matrix Factorization (NMF) procedure that incorporates background signatures and employs elastic net regression to reduce overfitting. It supports various signature types, including Single Base Substitutions (SBS), Multi-Nucleotide Variants (MNV), Chromosomal Instability (CX), and Copy Number (CN) signatures.

## Installation

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RESOLVE")
```

## Data Preparation

To perform signature discovery, input data must be converted into a count matrix. For SBS signatures, use a reference genome (BSgenome object).

```R
library(RESOLVE)
library(BSgenome.Hsapiens.1000genomes.hs37d5)

# Import data into a count matrix
imported_data = getSBSCounts(data = ssm560_reduced, 
                             reference = BSgenome.Hsapiens.1000genomes.hs37d5)

# Visualize counts for specific samples
patientsSBSPlot(trinucleotides_counts = imported_data, samples = "PD10010a")
```

## De Novo Signature Extraction

The extraction process involves two main steps: decomposition across a range of possible signature counts ($K$) and cross-validation to determine the optimal $K$.

### 1. Signature Decomposition
```R
# Requires a background signature and patient count matrix
data(background)
data(patients)

set.seed(12345)
res_denovo = signaturesDecomposition(x = patients,
                                     K = 1:15,
                                     background_signature = background,
                                     nmf_runs = 100,
                                     num_processes = 4)
```

### 2. Cross-Validation
To determine the optimal number of signatures:
```R
res_cv = signaturesCV(x = patients,
                      beta = res_denovo$beta,
                      cross_validation_repetitions = 100,
                      num_processes = 4)
```

## Downstream Analysis

### Patient Clustering
Group patients with similar active mutational processes using k-medoids. It is recommended to use normalized exposures (alpha).
```R
# Normalize exposures
norm_alpha = (sbs_assignments$alpha / rowSums(sbs_assignments$alpha))

# Perform clustering
sbs_clustering = signaturesClustering(alpha = norm_alpha, 
                                      num_clusters = 1:5, 
                                      num_processes = 1)
```

### Association with Driver Mutations
Investigate links between signatures and somatic mutations in driver genes.
*   **Mutations as predictors**: `associationAlterations`
*   **Signatures as predictors**: `associationSignatures`

```R
# Mutations predicting signature exposures
assoc_alt = associationAlterations(alterations = alterations_df, 
                                   signatures = normalized_alpha)

# Signatures predicting mutation status (logistic regression)
assoc_sig = associationSignatures(alterations = alterations_df, 
                                  signatures = normalized_alpha)
```

### Survival Analysis (Prognosis)
Associate signature exposures with clinical outcomes using regularized Cox regression.
```R
# Positive coefficients = higher risk; Negative = better prognosis
prognosis_res = associationPrognosis(clinical_data = clinical_df, 
                                     signatures = normalized_alpha)
```

## Tips and Best Practices
*   **Reproducibility**: Always use `set.seed()` before running decomposition or cross-validation, as NMF is a stochastic process.
*   **Parallelization**: Use the `num_processes` argument in `signaturesDecomposition` and `signaturesCV` to speed up computation on multi-core systems.
*   **Normalization**: Ensure signature exposures (`alpha`) are normalized (sum to 1 per patient) before performing clustering or association studies to ensure comparability.
*   **Signature Types**: While SBS is common, the same functions support MNV, CX, and CN signatures by providing the appropriate count matrices.

## Reference documentation
- [RESOLVE](./references/RESOLVE.md)