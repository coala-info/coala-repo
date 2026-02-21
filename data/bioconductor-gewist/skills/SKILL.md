---
name: bioconductor-gewist
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GEWIST.html
---

# bioconductor-gewist

name: bioconductor-gewist
description: Optimal SNP prioritization for gene-gene and gene-environment interaction testing using the Variance Prioritization (VP) method. Use this skill to calculate optimal p-value thresholds for Levene's test to increase statistical power in genome-wide interaction studies (GWIS).

## Overview

The `GEWIST` package implements the Gene Environment Wide Interaction Search Threshold algorithm. It is designed to solve the low statistical power problem in genome-wide interaction studies by prioritizing SNPs based on their variance differences across genotypes. 

The workflow follows a two-step "Variance Prioritization" (VP) procedure:
1. **Prioritization**: Use Levene’s test to identify SNPs where the trait variance differs by genotype. A SNP is selected if its Levene’s test p-value is below an optimal threshold ($\eta_0$).
2. **Interaction Testing**: Perform standard interaction testing (e.g., linear regression) only on the prioritized SNPs, applying a multiple testing correction based on the number of selected SNPs rather than the entire genome.

## Main Functions

### 1. Calculating Optimal Thresholds (Known Effect Size)
Use `gewistLevene` when you have an estimate of the interaction effect size ($\theta_{gc}$).

```r
library(GEWIST)

# Parameters:
# p: Minor Allele Frequency (MAF)
# N: Sample size
# theta_gc: Proportion of variance explained by GxE interaction
# theta_c: Proportion of variance explained by environmental covariate
# M: Total number of SNPs in the study
# K: Number of simulations (default 20,000)

result <- gewistLevene(p = 0.2, N = 10000, theta_gc = 0.002, 
                       theta_c = 0.15, M = 250000, verbose = FALSE)

# Access results
result$Optimal_pval_threshold  # The eta_0 to use for filtering
result$Optimal_VP_power        # Power achieved using this method
result$Conventional_power      # Power without prioritization
```

### 2. Calculating Optimal Thresholds (Unknown Effect Size)
Use `effectPDF` when the interaction effect size is unknown but can be described by a probability distribution (Weibull, Beta, Normal, or Uniform).

```r
# Example using a Weibull distribution for effect sizes
weibull_result <- effectPDF(distribution = "weibull", 
                            parameter1 = 0.8, parameter2 = 0.3,
                            p = 0.1, N = 10000, theta_c = 0.1, 
                            M = 350000, K = 10000, nb_incr = 50, 
                            range = c(0.00025, 0.003))

print(weibull_result$Optimal_pval_threshold)
```

## Typical Workflow

### Step 1: Compute Levene's Test P-values
For each SNP in your dataset, calculate the variance inequality p-value.

```r
library(car)
# Trait: quantitative phenotype vector
# GenoSet: matrix of genotypes (rows=individuals, cols=SNPs)

levene_pvals <- apply(GenoSet, 2, function(snp) {
  leveneTest(Trait, as.factor(snp), center = mean)[1, 3]
})
```

### Step 2: Determine SNP-Specific Thresholds
Calculate the optimal threshold for each SNP based on its specific MAF.

```r
optimal_thresholds <- sapply(1:ncol(GenoSet), function(i) {
  # Assume mafs is a vector of MAFs for your SNPs
  res <- gewistLevene(p = mafs[i], N = length(Trait), 
                      theta_gc = estimated_theta_gc, 
                      theta_c = estimated_theta_c, M = ncol(GenoSet))
  return(res$Optimal_pval_threshold)
})
```

### Step 3: Filter and Test Interactions
Select SNPs that pass the threshold and run the interaction model.

```r
# Identify prioritized SNPs
prioritized_indices <- which(levene_pvals < optimal_thresholds)

# Test interactions for prioritized SNPs only
# COV: Environmental covariate vector
results <- lapply(prioritized_indices, function(idx) {
  mod <- lm(Trait ~ GenoSet[, idx] * COV)
  summary(mod)$coefficients[4, 4] # P-value for interaction term
})
```

## Tips for Usage
- **Computational Efficiency**: For genome-wide data, instead of calculating a threshold for every SNP, create a lookup table (matrix) of optimal thresholds for ranges of MAF and effect sizes.
- **Verbose Mode**: Set `verbose = TRUE` in `gewistLevene` or `effectPDF` to generate power curves across the full range of p-value thresholds (0 to 1).
- **Levene's Test**: Always use `center = mean` in `car::leveneTest` as recommended by the GEWIST authors for this specific prioritization method.

## Reference documentation
- [Prioritizing SNPs for Genetic Interaction Testing with R package GEWIST](./references/GEWIST.md)