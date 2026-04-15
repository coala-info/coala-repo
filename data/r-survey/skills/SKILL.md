---
name: r-survey
description: This tool provides expert guidance for using the R 'survey' package to analyze data from complex sampling designs. Use when user asks to define survey designs, calculate summary statistics for weighted data, perform domain analysis on subpopulations, or fit design-based regression models.
homepage: https://cloud.r-project.org/web/packages/survey/index.html
---

# r-survey

name: r-survey
description: Expert guidance for the R 'survey' package to analyze complex survey samples. Use this skill when performing statistical analysis on data from stratified, cluster, multistage, or unequally weighted samples. It covers survey design specification, summary statistics (means, totals, ratios, quantiles), regression modeling (GLMs, Cox models), and advanced calibration or small-area estimation.

# r-survey

## Overview
The `survey` package is the standard R framework for analyzing data from complex sampling designs. Unlike standard statistical methods that assume simple random sampling (SRS), `survey` accounts for clustering, stratification, and unequal sampling weights to provide valid point estimates and standard errors.

## Installation
```R
install.packages("survey")
library(survey)
```

## Core Workflow

### 1. Defining the Survey Design
The `svydesign` function is the entry point. It links the data frame with the metadata of the sampling design.

```R
# Example: Stratified cluster sample
# id: clusters (PSUs), strata: stratification variable, weights: sampling weights, fpc: finite population correction
dclus1 <- svydesign(id = ~dnum, 
                    strata = ~stype, 
                    weights = ~pw, 
                    data = apiclus1, 
                    fpc = ~fpc)
```

### 2. Descriptive Statistics
Use `svy` prefixed functions instead of base R equivalents.
*   **Mean/Total:** `svymean(~variable, design)`, `svytotal(~variable, design)`
*   **Quantiles:** `svyquantile(~variable, design, quantiles=c(0.5))`
*   **Ratios:** `svyratio(~numerator, ~denominator, design)`
*   **By Groups:** `svyby(~outcome, ~group, design, svymean)`

### 3. Subsetting Data
**Crucial:** Never use standard R subsetting (e.g., `df[df$x > 0, ]`) before creating the design. Use the `subset` function on the design object to maintain correct standard error calculations for subpopulations (domain analysis).
```R
sub_design <- subset(dclus1, enroll > 500)
svymean(~api00, sub_design)
```

### 4. Regression Modeling
Use `svyglm` for generalized linear models. It defaults to a design-based analysis using quasi-likelihood.
```R
# Linear regression
model <- svyglm(api00 ~ ell + meals, design = dclus1)
summary(model)

# Logistic regression
logit_model <- svyglm(I(sch.wide=="Yes") ~ ell + meals, 
                      design = dclus1, 
                      family = quasibinomial())
```

### 5. Calibration and Post-Stratification
Adjust weights so that sample totals match known population totals.
```R
# Calibrate to known population totals
# population: vector of known totals for the levels of the formula
gclus1 <- calibrate(dclus1, formula = ~stype, population = c(E=4421, H=755, M=1018))
```

## Advanced Features
*   **Two-Phase Designs:** Use `twophase()` for case-control or case-cohort studies common in epidemiology.
*   **PPS Sampling:** Supports Probability Proportional to Size sampling without replacement using various approximations (Brewer, Hartley-Rao, etc.).
*   **Small Area Estimation:** Use `svysmoothArea` (requires `SUMMER` and `INLA`) for area-level Fay-Herriot models or unit-level nested error models.
*   **Survival Analysis:** Use `svycoxph` for Cox Proportional Hazards models on survey data.

## Reference documentation
- [Estimates in subpopulations](./references/domain.md)
- [Two-phase designs in epidemiology](./references/epi.md)
- [Describing PPS designs to R](./references/pps.md)
- [Making use of pre-calibrated weights](./references/precalibrated.md)
- [Estimating quantiles](./references/qrule.md)
- [Area level and unit level models for estimating small area means](./references/survey-sae.md)
- [A survey analysis example](./references/survey.md)