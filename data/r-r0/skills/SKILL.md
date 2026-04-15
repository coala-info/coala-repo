---
name: r-r0
description: This tool estimates basic and real-time reproduction numbers from epidemic incidence data using various statistical methods. Use when user asks to calculate R0 or R(t), define generation time distributions, perform sensitivity analyses on outbreak parameters, or plot epidemic curves with fitted models.
homepage: https://cran.r-project.org/web/packages/r0/index.html
---

# r-r0

name: r-r0
description: Estimation of reproduction numbers (R0 and R(t)) from epidemic incidence data. Use this skill when analyzing infectious disease outbreaks in R to calculate the basic reproduction number (R0) or real-time reproduction number (R(t)) using various documented methods (EG, ML, TD, SB, etc.), performing sensitivity analyses on generation time, or plotting epidemic curves with adjusted models.

## Overview
The `R0` package provides a comprehensive toolkit for estimating reproduction numbers from incidence data. It allows for the comparison of different estimation methods, including Exponential Growth (EG), Maximum Likelihood (ML), Time-Dependent (TD), and Sequential Bayesian (SB). The package also includes tools for defining generation time distributions and performing sensitivity analyses to account for uncertainty in parameters.

## Installation
```R
install.packages("R0")
```

## Core Workflow

### 1. Define Generation Time
Before estimating R, you must define the Generation Time (GT) distribution using `generation.time()`.
```R
library(R0)
# Define a Gamma distribution for GT (mean=3, sd=1.5)
mGT <- generation.time("gamma", c(3, 1.5))
```

### 2. Estimate Reproduction Number
Use `estimate.R()` as a wrapper for multiple methods, or call specific functions like `est.R0.EG()`, `est.R0.ML()`, or `est.R0.TD()`.

**Using the wrapper:**
```R
# incidence_data is a vector of daily counts
# methods can be "EG", "ML", "TD", "SB", "AR"
res <- estimate.R(epid = incidence_data, GT = mGT, methods = c("EG", "TD"))
```

**Common Methods:**
- **EG (Exponential Growth):** Best for the early phase of an outbreak.
- **ML (Maximum Likelihood):** Assumes Poisson distribution for secondary cases.
- **TD (Time-Dependent):** Estimates R(t) throughout the outbreak.
- **SB (Sequential Bayesian):** Updates R(t) estimates as new data arrives.

### 3. Inspect and Plot Results
```R
# Summary of estimates
summary(res)

# Plot epidemic curve and R(t) evolution
plot(res)
```

## Sensitivity Analysis
To evaluate how choice of time window or GT parameters affects R0:
```R
# Sensitivity on the time window for EG method
sen <- sensitivity.analysis(epid = incidence_data, GT = mGT, begin = 1:5, end = 15:20, est.method = "EG")
plot(sen)
```

## Tips
- **Data Format:** Incidence data should be a numeric vector of counts. If dates are used, ensure they are properly formatted or passed as the `t` argument.
- **Method Selection:** Use `EG` or `ML` for a single "basic" R0 value. Use `TD` or `SB` if you need to see how transmissibility changed over time (e.g., due to interventions).
- **GT Importance:** R0 estimates are highly sensitive to the Generation Time distribution. Always perform sensitivity analysis on GT parameters if they are not precisely known.

## Reference documentation
- [R0: Estimation of R0 and Real-Time Reproduction Number from Epidemics](./references/home_page.md)