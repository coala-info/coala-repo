---
name: r-kmsurv
description: R package kmsurv (documentation from project home).
homepage: https://cran.r-project.org/web/packages/kmsurv/index.html
---

# r-kmsurv

## Overview
The `KMsurv` package is a companion to the textbook "Survival Analysis: Techniques for Censored and Truncated Data" by Klein and Moeschberger. It is primarily used for its extensive collection of real-world survival datasets and specialized functions for survival function estimation.

## Installation
To install the package from CRAN:
```r
install.packages("KMsurv")
```

## Main Functions and Workflows

### Accessing Datasets
The package contains over 60 datasets used in survival analysis examples.
```r
library(KMsurv)
data(tongue) # Example: Death times of patients with cancer of the tongue
data(bmt)    # Example: Bone marrow transplant data
```

### Survival Curve Confidence Intervals
While the standard `survival` package provides basic Kaplan-Meier estimates, `KMsurv` provides `survfit` extensions or specific calculations for different confidence interval transformations (linear, log-log, and arcsine-square root).

**Key Function: `lifetab`**
Used to create life tables for grouped data.
```r
# Example usage of lifetab
# x: intervals, n: number at risk, d: number of events, w: number withdrawn
# lifetab(tis, ninit, nlost, nevent)
```

**Key Function: `survConic`**
Calculates confidence intervals for the survival function at a specific time point using various transformations.

### Common Datasets Reference
- `bmt`: Bone marrow transplant patients (137 patients).
- `channing`: Channing House retirement center data (left-truncated).
- `kidney`: Time to infection in kidney dialysis patients.
- `pneumon`: Length of stay for children hospitalized with pneumonia.
- `std`: Time to reinfection with sexually transmitted diseases.

## Usage Tips
- **Integration with `survival`**: This package is almost always used in conjunction with the `survival` package. Load both to perform analysis: `library(survival); library(KMsurv)`.
- **Teaching and Validation**: Use these datasets to replicate textbook examples or validate new survival models against established benchmarks.
- **Truncation**: Use the `channing` or `burn` datasets specifically when testing models for left-truncation or competing risks.

## Reference documentation
- [KMsurv README](./references/README.html.md)
- [KMsurv Home Page](./references/home_page.md)