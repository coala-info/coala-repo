---
name: r-coloc
description: This tool performs genetic colocalisation analysis to determine if two traits share a common causal variant in a genomic region. Use when user asks to prepare GWAS summary statistics for colocalisation, run Approximate Bayes Factor tests, perform multi-signal colocalisation using SuSiE, or conduct sensitivity analyses on prior probability assumptions.
homepage: https://cloud.r-project.org/web/packages/coloc/index.html
---


# r-coloc

name: r-coloc
description: Perform genetic colocalisation analysis using the coloc R package to determine if two traits share a common causal variant in a genomic region. Use this skill when you need to: (1) Prepare GWAS summary statistics for colocalisation, (2) Run Approximate Bayes Factor (ABF) tests with `coloc.abf`, (3) Perform multi-signal colocalisation using SuSiE with `coloc.susie`, or (4) Conduct sensitivity analyses to validate prior probability assumptions.

# r-coloc

## Overview
The `coloc` package is used to assess whether two genetic traits (e.g., a disease GWAS and an eQTL) share a common causal variant in a specific genomic region. It moves beyond simple "overlap" by using Bayesian framework to evaluate the support for five hypotheses ($H_0$ to $H_4$), where $H_4$ represents a shared causal variant.

## Installation
```R
install.packages("coloc")
# For SuSiE support:
install.packages("susieR")
```

## Data Preparation
`coloc` requires data in a specific **list** format for each trait. Use `check_dataset(d)` to validate.

### Minimum Dataset Requirements
- **Quantitative Trait**: `beta`, `varbeta` (SE squared), `snp`, `position`, `type="quant"`, and `sdY` (or `N` and `MAF` to estimate `sdY`).
- **Case-Control Trait**: `beta`, `varbeta`, `snp`, `position`, `type="cc"`, and `s` (proportion of samples that are cases).

### Key Considerations
- **Region Selection**: Do not use whole chromosomes. Select a dense region (e.g., +/- 500kb around a lead SNP).
- **SNP Matching**: Only SNPs present in both datasets are analyzed.
- **Allele Alignment**: Ensure `beta` values refer to the same "effect" allele in both studies. Use `check_alignment(dataset)` to verify LD and Z-score consistency.

## Workflows

### 1. Single Causal Variant Assumption (ABF)
Use `coloc.abf` when you assume at most one causal variant per trait in the region.
```R
library(coloc)
result <- coloc.abf(dataset1 = D1, dataset2 = D2, p1 = 1e-4, p2 = 1e-4, p12 = 1e-6)
print(result)

# Extract 95% credible set for H4
o <- order(result$results$SNP.PP.H4, decreasing=TRUE)
cs <- cumsum(result$results$SNP.PP.H4[o])
w <- which(cs > 0.95)[1]
result$results[o,][1:w, ]$snp
```

### 2. Multiple Causal Variants (SuSiE)
The preferred method for regions with multiple signals. Requires an LD matrix (`LD` entry in the dataset list).
```R
# 1. Run SuSiE on each dataset individually
S1 <- runsusie(D1)
S2 <- runsusie(D2)

# 2. Colocalise all pairs of signals
susie_res <- coloc.susie(S1, S2)
print(susie_res$summary)
```

### 3. Sensitivity Analysis
Check if your $H_4$ conclusion is robust to the choice of the prior $p_{12}$.
```R
# 'rule' defines the threshold for colocalisation support
sensitivity(result, rule = "H4 > 0.5")
```

## Tips
- **Priors**: The default $p_{12} = 10^{-6}$ is often conservative. Use `sensitivity()` to see how results change if you increase/decrease this.
- **Visualization**: Use `plot_dataset(D1)` to check for signal quality and `check_alignment(D1)` to ensure the LD matrix matches the effect directions.
- **Missing Beta/Varbeta**: If only p-values are available, `coloc` can estimate ABFs if provided with `MAF`, `N`, and `s` (for CC).

## Reference documentation
- [Coloc: a package for colocalisation analyses](./references/a01_intro.Rmd)
- [Coloc: data structures](./references/a02_data.Rmd)
- [Coloc: under a single causal variant assumption](./references/a03_enumeration.Rmd)
- [Coloc: sensitivity to prior values](./references/a04_sensitivity.Rmd)
- [DEPRECATED Coloc: relaxing the single causal variant assumption](./references/a05_conditioning.Rmd)
- [Coloc: using SuSiE to relax the single causal variant assumption](./references/a06_SuSiE.Rmd)