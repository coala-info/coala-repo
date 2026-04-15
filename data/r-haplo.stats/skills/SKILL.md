---
name: r-haplo.stats
description: This tool performs statistical analysis of haplotypes with traits and covariates when linkage phase is ambiguous. Use when user asks to estimate haplotype frequencies, test associations between haplotypes and traits using score statistics, perform haplotype-based regression, or calculate power and sample size for haplotype studies.
homepage: https://cloud.r-project.org/web/packages/haplo.stats/index.html
---

# r-haplo.stats

name: r-haplo.stats
description: Statistical analysis of haplotypes with traits and covariates when linkage phase is ambiguous. Use this skill when analyzing genetic data from unrelated subjects where phase is unknown, specifically for: (1) Estimating haplotype frequencies (EM algorithm), (2) Testing associations between haplotypes and various traits (Gaussian, Binomial, Ordinal, Poisson) using score statistics, (3) Performing haplotype-based regression (GLM), and (4) Calculating power and sample size for haplotype studies.

## Overview

The `haplo.stats` package provides a suite of R routines for analyzing indirectly measured haplotypes. It handles the ambiguity of linkage phase and missing alleles in unrelated subjects. Key features include the progressive insertion EM algorithm for frequency estimation, score tests for association, and generalized linear models (GLM) for haplotype effects.

## Installation

```R
install.packages("haplo.stats")
library(haplo.stats")
```

## Core Workflows

### 1. Data Preparation
Haplotype functions require a genotype matrix where each locus has two adjacent columns (one for each allele).

```R
# Example: 3 loci (DQB, DRB, B) from hla.demo
data(hla.demo)
geno <- hla.demo[, c(17, 18, 21:24)]
locus.label <- c("DQB", "DRB", "B")

# Use setupGeno for haplo.glm to handle missing values and allele coding
geno.glm <- setupGeno(geno, miss.val = c(0, NA), locus.label = locus.label)
```

### 2. Frequency Estimation (EM Algorithm)
Use `haplo.em` to compute maximum likelihood estimates of haplotype probabilities.

```R
save.em <- haplo.em(geno = geno, locus.label = locus.label, miss.val = c(0, NA))
print(save.em, nlines = 10)
summary(save.em, show.haplo = TRUE)
```

### 3. Haplotype Score Tests
Use `haplo.score` to test associations without full regression. Supports Gaussian, Binomial, Ordinal, and Poisson traits.

```R
# Quantitative trait (Gaussian)
score.gaus <- haplo.score(hla.demo$resp, geno, trait.type = "gaussian", 
                          min.count = 5, locus.label = locus.label)

# Binary trait (Binomial)
y.bin <- as.numeric(hla.demo$resp.cat == "low")
score.bin <- haplo.score(y.bin, geno, trait.type = "binomial", min.count = 5)

# Plotting scores
plot(score.gaus)
```

### 4. Haplotype Regression (GLM)
Use `haplo.glm` for modeling traits with haplotypes and other covariates.

```R
# Create data frame with setupGeno object
glm.data <- data.frame(geno.glm, age = hla.demo$age, male = hla.demo$male, y = hla.demo$resp)

# Fit model (Additive effect is default)
fit.gaus <- haplo.glm(y ~ male + geno.glm, family = gaussian, data = glm.data,
                      na.action = "na.geno.keep",
                      control = haplo.glm.control(haplo.freq.min = 0.02))
summary(fit.gaus)
```

### 5. Power and Sample Size
Calculate requirements for haplotype association studies.

```R
# Quantitative Traits
ss.qt <- haplo.power.qt(hmat, hfreq, hbase, hbeta, alpha = 0.05, power = 0.80)

# Case-Control
ss.cc <- haplo.power.cc(hmat, hfreq, hbase, hbeta.cc, case.frac = 0.5, prevalence = 0.1)
```

## Key Functions and Parameters

- `haplo.em.control()`: Adjust `n.try`, `insert.batch.size`, and `min.posterior` to find global maxima or manage memory.
- `haplo.score.slide()`: Performs a "sliding window" analysis across a region.
- `haplo.design()`: Creates an expected haplotype design matrix for use in other R modeling functions (e.g., `survival::coxph`).
- `haplo.cc()`: Wrapper that combines `haplo.score`, `haplo.group`, and `haplo.glm` for case-control studies.
- `min.count` / `haplo.freq.min`: Critical for pooling rare haplotypes to ensure model stability.

## Tips for Success

- **Random Seeds**: Many functions use random starting values. Use `set.seed()` to ensure reproducibility.
- **Missing Data**: Use `summaryGeno()` to identify subjects with excessive ambiguity (e.g., >50,000 possible pairs) which can cause memory issues.
- **Rare Haplotypes**: By default, `haplo.glm` pools haplotypes with frequency < 0.01 into a "rare" category.
- **Baseline**: The most frequent haplotype is typically chosen as the baseline. This can be changed via `haplo.glm.control(haplo.base = code)`.

## Reference documentation

- [The haplo.stats package](./references/haplostats.Rmd)