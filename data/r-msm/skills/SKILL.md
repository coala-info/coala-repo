---
name: r-msm
description: "Functions for fitting continuous-time Markov and hidden     Markov multi-state models to longitudinal data.  Designed for     processes observed at arbitrary times in continuous time (panel data)     but some other observation schemes are supported. Both Markov     transition rates and the hidden Markov output process can be modelled     in terms of covariates, which may be constant or piecewise-constant     in time.</p>"
homepage: https://cloud.r-project.org/web/packages/msm/index.html
---

# r-msm

name: r-msm
description: Fitting and analyzing continuous-time multi-state Markov and hidden Markov models (HMMs) for longitudinal data. Use this skill when you need to model processes where individuals move between discrete states at arbitrary times (panel data), estimate transition intensities, incorporate covariates on transition rates or emission distributions, and perform model diagnostics like prevalence plots or Pearson-type tests.

# r-msm

## Overview
The `msm` package is designed for multi-state modeling of longitudinal data observed at discrete time points (panel data). It allows for:
*   Estimation of transition intensities ($Q$ matrix) and probabilities ($P(t)$ matrix).
*   Modeling transition rates as functions of covariates (proportional intensities).
*   Hidden Markov Models (HMMs) where states are observed with error or through continuous markers.
*   Handling exactly-observed death times and censored states.

## Installation
```R
install.packages("msm")
library(msm)
```

## Core Workflow

### 1. Data Preparation
Data must be in "long" format, grouped by subject and ordered by time.
*   `subject`: Unique identifier for each individual.
*   `time`: Time of observation (numeric).
*   `state`: Observed state (numeric, starting from 1).

### 2. Specifying the Transition Matrix (Q)
Define a square matrix where non-zero entries are initial values for allowed transitions. Zeros represent impossible instantaneous transitions.
```R
# Example: 3-state model (1 -> 2, 1 -> 3, 2 -> 3)
Q <- rbind(
  c(0, 0.2, 0.1),
  c(0, 0,   0.2),
  c(0, 0,   0)
)
```

### 3. Fitting the Model
Use the `msm()` function.
```R
fit <- msm(state ~ time, subject = ptid, data = mydata, qmatrix = Q)
```
**Key Arguments:**
*   `covariates`: A formula (e.g., `~ age + sex`) or a list for transition-specific effects (e.g., `list("1-2" = ~ age)`).
*   `deathexact`: Vector of states representing exactly-observed death times.
*   `obstype`: 1 for panel data (default), 2 for exact transition times.
*   `ematrix`: For misclassification models, a matrix of initial misclassification probabilities.

## Extractor Functions
*   `qmatrix.msm(fit)`: Estimated transition intensities.
*   `pmatrix.msm(fit, t = 5)`: Transition probabilities over a time interval $t$.
*   `sojourn.msm(fit)`: Mean time spent in each state.
*   `hazard.msm(fit)`: Hazard ratios for covariates.
*   `totlos.msm(fit)`: Total length of stay in each state.
*   `viterbi.msm(fit)`: Most likely path of underlying states (for HMMs).

## Model Assessment
*   `prevalence.msm(fit)`: Compares observed vs. expected number of individuals in each state over time.
*   `plot(fit)`: Plots survival curves from each state.
*   `pearson.msm(fit)`: Formal Pearson-type goodness-of-fit test.

## Hidden Markov Models (HMMs)
For HMMs, use the `hmodel` argument with constructor functions:
*   `hmmNorm(mean, sd)`: Normal distribution.
*   `hmmIdent(x)`: Exactly observed state.
*   `hmmBinom(size, prob)`: Binomial distribution.
*   `hmmPois(lambda)`: Poisson distribution.

```R
# Example HMM with continuous marker 'y'
hmodel <- list(hmmNorm(mean=100, sd=10), hmmNorm(mean=80, sd=12), hmmIdent(3))
fit_hmm <- msm(y ~ time, subject = ptid, data = mydata, qmatrix = Q, hmodel = hmodel)
```

## Tips
*   **Initial Values:** If the model fails to converge, use `crudeinits.msm` or provide better manual guesses in `qmatrix`.
*   **Scaling:** Use `control = list(fnscale = ...)` in `msm()` if the log-likelihood is very large to improve numerical stability.
*   **Constraints:** Use `qconstraint` to force different transition intensities to be equal.

## Reference documentation
- [Multi-state modelling with R: the msm package](./references/msm-manual.md)