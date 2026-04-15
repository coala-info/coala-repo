---
name: r-clinfun
description: The r-clinfun package provides specialized statistical utilities for designing and analyzing clinical trials, focusing on Phase II trial designs and exact power calculations. Use when user asks to determine optimal or minimax two-stage designs, calculate exact sample sizes for Fisher's exact test, or generate stopping boundaries for toxicity and futility monitoring.
homepage: https://cloud.r-project.org/web/packages/clinfun/index.html
---

# r-clinfun

## Overview
The `clinfun` package provides specialized utilities for clinical trialists. It is primarily used for determining optimal and minimax designs for Phase II trials, calculating exact power and sample sizes for binomial outcomes, and generating stopping boundaries for safety and efficacy monitoring.

## Installation
To install the package from CRAN:
```R
install.packages("clinfun")
library(clinfun)
```

## Phase II Trial Design

### Simon's Two-Stage Design
Used to minimize the number of patients exposed to an ineffective treatment.
- **Function**: `ph2simon(pu, pa, ep1, ep2)`
- **Parameters**: 
  - `pu`: Unacceptable response rate ($p_0$)
  - `pa`: Desirable response rate ($p_1$)
  - `ep1`: Type I error ($\alpha$)
  - `ep2`: Type II error ($\beta$)

```R
# Example: p0=0.05, p1=0.20, alpha=0.1, beta=0.1
trial <- ph2simon(0.05, 0.2, 0.1, 0.1)
print(trial)
plot(trial)

# Find admissible designs (compromise between Optimal and Minimax)
twostage.admissible(trial)
```

### Single-Stage Design
Used when early stopping is not a priority or endpoints take long to evaluate.
- **Function**: `ph2single(pu, pa, ep1, ep2)`

```R
ph2single(0.4, 0.6, 0.1, 0.1)
```

## Stopping Boundaries
Layer these rules on top of existing designs for risk management.

### Toxicity Boundaries
Computes boundaries for monitoring toxicity in Phase II or III trials.
```R
# n: total sample size, ptok: unacceptable toxicity rate, alpha: significance level
toxbdry(p0=0.1, p1=0.3, n=20, alpha=0.1)
```

### Futility Boundaries
Specifically for Phase II single-stage designs where continuous monitoring is needed.
```R
# Example for a trial of 41 patients
futilbdry(0.4, 0.6, n=41, ep1=0.1, ep2=0.1)
```

## Sample Size and Power (Fisher's Exact Test)
`clinfun` provides exact calculations which are more accurate than the normal approximations used in `power.prop.test`.

| Function | Purpose |
| :--- | :--- |
| `fe.ssize()` | Sample size for Fisher's Exact Test |
| `fe.power()` | Exact power for given sample sizes |
| `fe.mdor()` | Minimum detectable odds ratio |
| `mdrr()` | Minimum detectable response rates for marker-based designs |

```R
# Calculate sample size for p1=0.2 vs p2=0.3 with 80% power
fe.ssize(p1 = 0.2, p2 = 0.3, power = 0.8)
```

## Data Analysis Functions
- **Jonckheere-Terpstra Test**: `jonckheere.test(x, g)` - A non-parametric test for ordered differences among classes.
- **Permutation Tests**: `pperm()` and `qperm()` for permutation distributions.
- **Survival Quantiles**: `calcsurv()` for estimating survival probabilities and quantiles.

## Workflow Tips
1. **Optimal vs. Minimax**: Use the "Optimal" design to minimize the expected sample size under $H_0$. Use "Minimax" to minimize the absolute maximum number of patients.
2. **Admissible Designs**: Always check `twostage.admissible()` as it often finds designs that are nearly optimal in expected size but significantly smaller in maximum size than the standard optimal design.
3. **Visualization**: Use `plot()` on a `ph2simon` object to see the trade-offs between different design types visually.

## Reference documentation
- [Functions For Clinical Trial Design](./references/clinical-trial-functions.Rmd)