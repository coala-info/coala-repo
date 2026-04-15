---
name: bioconductor-plasmut
description: This tool uses Bayesian modeling to distinguish whether mutations in liquid biopsies originate from tumors or clonal hematopoiesis. Use when user asks to analyze cell-free DNA and white blood cell sequencing data, estimate Bayes factors for somatic versus hematopoietic models, or account for circulating tumor cell contamination in buffy coat samples.
homepage: https://bioconductor.org/packages/release/bioc/html/plasmut.html
---

# bioconductor-plasmut

name: bioconductor-plasmut
description: Bayesian modeling to distinguish the origin of mutations in liquid biopsies (cancer vs. clonal hematopoiesis). Use this skill when analyzing cell-free DNA (cfDNA) and matched white blood cell (WBC/buffy coat) sequencing data to estimate Bayes factors for somatic vs. hematopoietic models.

## Overview

The `plasmut` package provides a Bayesian framework to determine if a mutation detected in a liquid biopsy originates from a tumor (somatic) or from clonal hematopoiesis (CH). It uses an importance sampling approach to estimate Bayes factors, accounting for potential circulating tumor cell (CTC) contamination in the buffy coat and uneven sequencing depths.

## Data Organization

The package requires data in a specific nested tibble format. Each row should represent a unique mutation within a sample.

```r
library(plasmut)
library(tidyverse)

# Example data structure
# y: mutant reads, n: total reads
p53_data <- tibble(
  y = c(4, 0),
  n = c(1000, 600),
  analyte = c("plasma", "buffy coat"),
  mutation = "TP53",
  sample_id = "id1"
)

# Nest data by unique mutation ID
dat <- p53_data %>%
    unite("uid", c(sample_id, mutation), remove = FALSE) %>%
    group_by(uid) %>%
    nest()
```

## Workflow: Importance Sampling

The core function is `importance_sampler()`, which calculates marginal likelihoods for the Somatic (S) and Hematopoietic (H) models.

### 1. Define Parameters
Set priors for CTC contamination, ctDNA fraction, and CHIP (Clonal Hematopoiesis of Indeterminate Potential) variants.

```r
param.list <- list(
  ctc = list(a = 1, b = 10000), # Prior for CTCs in buffy coat (Beta)
  ctdna = list(a = 1, b = 9),    # Prior for ctDNA in plasma (Beta)
  chip = list(a = 1, b = 9),     # Prior for CH/germline in WBC (Beta)
  montecarlo.samples = 50000,
  prior.weight = 0.1             # Mixture weight for importance sampling
)
```

### 2. Run the Sampler
Execute the sampler on the nested data.

```r
# For a single mutation
stats <- importance_sampler(dat$data[[1]], param.list, save_montecarlo = FALSE)

# For multiple mutations using purrr
mut_results <- dat %>%
  mutate(results = map(data, ~importance_sampler(.x, param.list, save_montecarlo = FALSE)))
```

## Interpreting Results

The output includes marginal likelihoods (`ctc`, `ctdna`, `chip`) and the `bayesfactor`.

- **Positive log Bayes Factor:** Evidence supports the Somatic (tumor-derived) model.
- **Negative log Bayes Factor:** Evidence supports the Hematopoietic (CH-derived) model.
- **Magnitude:** A log Bayes factor of 190 is definitive; values near 0 (e.g., 1.3) represent weak evidence.

## Tips for Efficiency

- **Importance Sampling:** Setting `prior.weight` (e.g., 0.1) is significantly more stable than simple prior sampling (`prior.weight = 1`), especially for small sample sizes.
- **Sample Size:** 10,000 to 50,000 Monte Carlo samples are typically sufficient for stable estimates.
- **Memory:** Set `save_montecarlo = FALSE` when processing large datasets to avoid storing all iterations.

## Reference documentation

- [Modeling the origin of mutations identified in a liquid biopsy: cancer or clonal hematopoiesis?](./references/plasmut.md)