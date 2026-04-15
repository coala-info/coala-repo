---
name: bioconductor-river
description: This tool predicts the regulatory impact of rare variants by integrating genomic annotations with gene expression data using a hierarchical Bayesian model. Use when user asks to prioritize functional rare variants, estimate the probability of a variant having regulatory effects, or integrate WGS and RNA-seq data to identify expression outliers.
homepage: https://bioconductor.org/packages/release/bioc/html/RIVER.html
---

# bioconductor-river

name: bioconductor-river
description: Jointly analyze personal genome and transcriptome data to estimate the probability that a variant has regulatory impact. Use when integrating genomic annotations (WGS) with gene expression outliers (RNA-seq) to prioritize functional rare variants using the RIVER (RNA-Informed Variant Effect on Regulation) hierarchical Bayesian model.

## Overview

RIVER is a probabilistic modeling framework that predicts the regulatory effects of rare variants by integrating gene expression data with genomic annotations. It uses a generative model where genomic annotations determine the prior probability of a variant being a functional regulatory variant (unobserved latent variable), which in turn influences the likelihood of observing outlier gene expression levels. The model parameters are optimized via an Expectation-Maximization (EM) algorithm.

## Data Preparation

The package uses a standardized `ExpressionSet` object. Data is typically imported from a gzipped text file containing subject IDs, gene names, genomic features, expression Z-scores, and N2 pair identifiers.

```r
library(RIVER)

# Load example or custom data
filename <- system.file("extdata", "simulation_RIVER.gz", package="RIVER")
dataInput <- getData(filename)

# Inspect data
print(dataInput)
features <- t(Biobase::exprs(dataInput))
outliers <- as.numeric(unlist(dataInput$Outlier)) - 1
```

## Model Evaluation

Use `evaRIVER` to compare the predictive accuracy of RIVER (genomic + expression) against a Genomic Annotation Model (GAM, genomic only). This function uses held-out N2 pairs (individuals sharing the same rare variants) for validation.

```r
# Run evaluation
evaROC <- evaRIVER(dataInput, 
                   pseudoc = 50, 
                   verbose = TRUE)

# Access results
cat("AUC (GAM):", evaROC$GAM_auc, "\n")
cat("AUC (RIVER):", evaROC$RIVER_auc, "\n")
cat("P-value:", evaROC$pvalue, "\n")

# Plot ROC curves
plot(NULL, xlim=c(0,1), ylim=c(0,1), xlab="FPR", ylab="TPR")
lines(1-evaROC$RIVER_spec, evaROC$RIVER_sens, col='blue')
lines(1-evaROC$GAM_spec, evaROC$GAM_sens, col='purple')
```

## Application and Prioritization

Use `appRIVER` to train the model on the full dataset and calculate posterior probabilities for all instances. This is the primary workflow for prioritizing variants in disease studies.

```r
# Train model and get posterior probabilities
postprobs <- appRIVER(dataInput, 
                      pseudoc = 50, 
                      costs = c(100, 10, 1, 0.1, 0.01))

# Extract probabilities
results <- data.frame(
  Subject = postprobs$indiv_name,
  Gene = postprobs$gene_name,
  RIVER_Score = postprobs$RIVER_posterior,
  GAM_Score = postprobs$GAM_posterior
)

# Visualize the impact of expression data
plotPosteriors(postprobs, outliers = as.numeric(unlist(dataInput$Outlier)) - 1)
```

## Key Parameters

- `pseudoc`: Hyperparameter for the Beta distribution of $\theta$ (default: 50). Lower values increase reliance on observed expression data.
- `theta_init`: Initial conditional probabilities $P(E|FR)$. Default is matrix `c(0.99, 0.01, 0.3, 0.7)`.
- `costs`: Candidate $\lambda$ values for L2-regularized logistic regression (GAM) selected via cross-validation.
- `verbose`: Set to `TRUE` to monitor EM convergence (norms of $\beta$ and $\theta$ differences).

## Reference documentation

- [RIVER Vignette (Rmd)](./references/RIVER.Rmd)
- [RIVER Vignette (Markdown)](./references/RIVER.md)