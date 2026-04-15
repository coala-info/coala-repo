---
name: bioconductor-sparsesignatures
description: SparseSignatures extracts mutational signatures from point mutation data using LASSO regularization and a fixed background signature to improve interpretability. Use when user asks to extract mutational signatures, perform NMF with LASSO regularization, or estimate the optimal number of signatures and sparsity penalty for genomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/SparseSignatures.html
---

# bioconductor-sparsesignatures

## Overview
SparseSignatures is an R package designed to extract mutational signatures from point mutation data (96 trinucleotide categories). It improves upon standard Non-negative Matrix Factorization (NMF) by incorporating a background signature (representing replication errors) and using LASSO regularization to produce sparser, more interpretable signatures.

## Workflow and Key Functions

### 1. Data Preparation
Transform raw mutation lists (sample, chrom, start, end, ref, alt) into a 96-column count matrix.
```r
library(SparseSignatures)
library(BSgenome.Hsapiens.1000genomes.hs37d5)

# Load reference genome
bsg = BSgenome.Hsapiens.1000genomes.hs37d5

# Import data from a data frame or text file
imported_data = import.trinucleotides.counts(data = ssm_data, reference = bsg)

# Visualize counts for a specific sample
patients.plot(trinucleotides_counts = imported_data, samples = "Patient_ID")
```

### 2. Parameter Estimation
Before running the final discovery, estimate the starting values for the signature matrix (beta) and the range for the LASSO penalty (lambda).
```r
# Estimate starting betas for a range of K (number of signatures)
# Requires a background signature (provided in package or custom)
data(background)
starting_betas = startingBetaEstimation(x = patients, K = 3:12, background_signature = background)

# Evaluate lambda range to determine sparsity penalty
lambda_range = lambdaRangeBetaEvaluation(x = patients, K = 10, beta = starting_betas[[8,1]], lambda_values = c(0.05, 0.10))
```

### 3. Model Selection (Cross-Validation)
Use cross-validation to find the optimal number of signatures (K) and lambda value. This step is computationally intensive; use parallel processing if available.
```r
# Perform cross-validation
cv_results = nmfLassoCV(x = patients, K = 3:10, lambda_rate_beta = c(0.05, 0.10))
```

### 4. Signature Discovery
Run the NMF with LASSO using the chosen parameters.
```r
# Extract signatures for K=5
best_beta = starting_betas[["5_signatures", "Value"]]
res = nmfLasso(x = patients, K = 5, beta = best_beta, background_signature = background, seed = 12345)

# Access the discovered signatures (beta) and exposures (alpha)
signatures = res$beta
exposures = res$alpha
```

### 5. Visualization
```r
# Plot the discovered signatures
signatures.plot(beta = signatures, xlabels = FALSE)
```

## Tips and Best Practices
*   **Background Signature:** Always include a background signature (e.g., the one provided in the package) to account for baseline replication errors, which prevents them from being "discovered" as a de novo signature.
*   **Computational Efficiency:** `nmfLassoCV` is slow. For large datasets, split the cross-validation into multiple runs (e.g., 10 runs of 10 iterations) and use the `parallel` options.
*   **Lambda Selection:** If the likelihood is not increasing during `nmfLasso`, try a lower value of lambda.
*   **Input Format:** Ensure your input data frame contains the columns: `sample`, `chrom`, `start`, `end`, `ref`, and `alt`.

## Reference documentation
- [Introduction](./references/v1_introduction.md)
- [Using the package](./references/v2_using_the_package.md)