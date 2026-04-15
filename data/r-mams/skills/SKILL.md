---
name: r-mams
description: This tool designs and evaluates multi-arm multi-stage clinical trial designs with normal endpoints. Use when user asks to calculate sample sizes, determine group sequential boundaries, or simulate operating characteristics for adaptive trials with multiple treatment arms.
homepage: https://cran.r-project.org/web/packages/mams/index.html
---

# r-mams

name: r-mams
description: Designing and evaluating multi-arm multi-stage (MAMS) clinical trial designs with (asymptotically) normal endpoints and known variance. Use this skill when you need to calculate sample sizes, power, or operating characteristics for adaptive clinical trials with multiple treatment arms and multiple stages.

## Overview

The `mams` package provides tools for the design of multi-arm multi-stage studies. It allows for the calculation of group sequential boundaries and sample sizes for trials where multiple treatments are compared against a single control, with the possibility of dropping ineffective arms or stopping the entire trial early for efficacy or futility.

## Installation

```R
install.packages("mams")
```

## Core Functions

### Designing a Trial
The primary function is `mams()`, which calculates the power and boundaries for a specific design.

```R
library(mams)

# Example: 3 arms (2 active vs 1 control), 2 stages
# K: number of active treatments
# J: number of stages
# alpha: Type I error
# power: Desired power
# p: Interesting effect size (probability of active > control)
# p0: Uninteresting effect size
res <- mams(K=2, J=2, alpha=0.05, power=0.8, p=0.65, p0=0.5)
print(res)
plot(res)
```

### Key Parameters for `mams()`
- `K`: Number of treatment arms (excluding control).
- `J`: Number of stages.
- `alpha`: Family-wise error rate.
- `power`: Target power (for the "least favorable configuration").
- `p`: The effect size expressed as $P(X_i > X_{control})$. $p=0.5$ means no effect.
- `u`: Upper boundary (efficacy). Can be fixed (e.g., `u=2.5`) or calculated.
- `l`: Lower boundary (futility).
- `ushape`: Shape of the upper boundary (e.g., "pocock", "obf", "triangular", "fixed").
- `lshape`: Shape of the lower boundary.

### Simulating Trials
Use `mams.sim()` to evaluate the operating characteristics of a specific design under different scenarios.

```R
# Simulate a design with specific effect sizes
# ns: sample size per arm per stage
sim_res <- mams.sim(K=2, J=2, ns=20, p=c(0.65, 0.55), 
                    u=c(2.7, 2.0), l=c(0, 2.0))
```

### Sample Size for Fixed Designs
For a single-stage multi-arm trial, use `mams` with `J=1`:
```R
# 3 active arms vs control, 1 stage
ss_fixed <- mams(K=3, J=1, alpha=0.05, power=0.9, p=0.65)
```

## Workflows

### 1. Finding Boundaries for a Specific Sample Size
If the sample size per stage (`n`) is already fixed, use `mams` to find the required boundaries to maintain alpha and power:
```R
# Find boundaries for a fixed n=30 per arm per stage
res_fixed_n <- mams(K=2, J=3, n=30, p=0.65, alpha=0.05)
```

### 2. Non-integer Sample Size Ratios
Use `r` and `r0` to specify the ratio of allocation to treatment and control arms respectively. By default, these are 1:1.

### 3. Step-down Procedures
The package supports highly flexible boundary shapes. For standard group sequential designs, "pocock" (constant boundaries) and "obf" (O'Brien-Fleming, conservative early) are most common.

## Tips
- **Parallel Processing**: For complex designs with many stages or arms, `mams` can be slow. The package uses `future.apply` for parallelization. Set `plan(multisession)` before running to speed up calculations.
- **Effect Size Conversion**: The package uses the probability $P(X > Y)$ to define effect size. For normal distributions with common variance $\sigma^2$ and mean difference $\Delta$, $p = \Phi(\Delta / \sqrt{2\sigma^2})$.
- **Output**: The `mams` object contains `n` (sample size per arm per stage) and `N` (total maximum sample size).

## Reference documentation
- [MAMS Home Page](./references/home_page.md)