---
name: bioconductor-icare
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/iCARE.html
---

# bioconductor-icare

## Overview

The `iCARE` package provides a toolset for estimating absolute risk of disease for individuals. It allows for the integration of genetic information (SNPs) and classical risk factors (covariates) with population-level disease and competing mortality rates. The package is designed to handle missing data through imputation and can validate risk models using independent study data.

## Core Workflow

### 1. Data Preparation
To use `iCARE`, you typically need:
- **SNP Information**: A data frame with columns for SNP names and odds ratios/log-relative risks.
- **Risk Factor Information**: A data frame describing the distribution of classical risk factors in the population.
- **Incidence Rates**: Age-specific disease incidence rates and competing mortality rates.
- **Individual Profiles**: Genotypes or covariate values for the individuals for whom risk is being predicted.

### 2. Estimating Absolute Risk
The primary function is `computeAbsoluteRisk()`. It can be used in several modes:

**SNP-only Model (with imputation):**
```r
res = computeAbsoluteRisk(model.snp.info = snp_info,
                          model.disease.incidence.rates = disease_inc,
                          model.competing.incidence.rates = mort_inc,
                          apply.age.start = 50,
                          apply.age.interval.length = 30,
                          return.refs.risk = TRUE)
```

**Combined Model (SNPs + Covariates):**
```r
res = computeAbsoluteRisk(model.formula = bc_formula,
                          model.cov.info = cov_info,
                          model.snp.info = snp_info,
                          model.log.RR = log_or,
                          model.ref.dataset = ref_data,
                          model.disease.incidence.rates = disease_inc,
                          model.competing.incidence.rates = mort_inc,
                          apply.age.start = 50,
                          apply.age.interval.length = 30,
                          apply.cov.profile = new_cov_prof,
                          apply.snp.profile = new_snp_prof,
                          return.refs.risk = TRUE)
```

### 3. Interpreting Results
The output object contains:
- `risk`: The absolute risk estimates for the provided profiles.
- `refs.risk`: A distribution of risks in a reference population (if `return.refs.risk = TRUE`).
- `details`: A data frame showing the specific inputs and imputed values used for the calculation.

### 4. Model Validation
Use `ModelValidation()` to assess the performance of a risk model on external data. This requires calculating sampling weights if using nested case-control data.

```r
output = ModelValidation(study.data = data,
                         total.followup.validation = TRUE,
                         iCARE.model.object = risk_model_list,
                         number.of.percentiles = 10)

# Visualize calibration and discrimination
plotModelValidation(study.data = data, validation.results = output)
```

## Tips for Success
- **Seed Setting**: Use `set.seed()` before running risk estimation if the model requires SNP imputation to ensure reproducibility.
- **Missing Data**: `iCARE` automatically handles missing genotypes or covariates by imputing based on the reference dataset or population frequencies.
- **Reference Distribution**: Always set `return.refs.risk = TRUE` to see where an individual's risk falls relative to the general population.

## Reference documentation

- [iCARE Package Vignette](./references/vignette.md)
- [iCARE Model Validation Vignette](./references/vignette_model_validation.md)