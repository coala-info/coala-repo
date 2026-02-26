---
name: bioconductor-bandle
description: BANDLE is a Bioconductor package for comparative spatial proteomics that identifies protein translocation between two experimental conditions. Use when user asks to perform differential localization analysis, fit Gaussian Processes to organelle niches, or quantify uncertainty in protein subcellular movement using MCMC sampling.
homepage: https://bioconductor.org/packages/release/bioc/html/bandle.html
---


# bioconductor-bandle

## Overview
BANDLE is a Bioconductor package designed for comparative spatial proteomics. It uses an integrative semi-supervised functional mixture model to determine the probability that a protein changes its subcellular localisation between two conditions. It builds upon the TAGM model by incorporating Gaussian Processes (GPs) to model organelle niches and Markov-chain Monte-Carlo (MCMC) to quantify uncertainty in both localisation and translocation.

## Core Workflow

### 1. Data Preparation
Data must be stored as `MSnSet` objects. For differential analysis, you need two sets of replicates (Control and Treatment).

```r
library(bandle)
library(pRoloc)

# Ensure common features across all replicates
# objects is a list of MSnSets (e.g., 3 control, 3 treatment)
msn_list <- commonFeatureNames(list(ctrl1, ctrl2, ctrl3, trt1, trt2, trt3))

# Split back into conditions
control <- msn_list[1:3]
treatment <- msn_list[4:6]
```

### 2. Fitting Gaussian Processes (GPs)
Before running the main model, fit GPs to the marker profiles to define the niche boundaries.

```r
# Fit GPs for each replicate
gpParams <- lapply(msn_list, function(x) fitGPmaternPC(x))

# Visualize the fit for a specific replicate
plotGPmatern(msn_list[[1]], params = gpParams[[1]])
```

### 3. Setting Priors
Define the Dirichlet prior on mixing weights. The diagonal represents the belief that proteins stay in the same compartment; off-diagonal terms represent the belief in translocation.

```r
K <- length(getMarkerClasses(msn_list[[1]]))
# Small off-diagonal values (e.g., 0.001) imply translocations are rare
dirPrior <- diag(rep(1, K)) + matrix(0.001, nrow = K, ncol = K)

# Check prior predictive distribution
predDirPrior <- prior_pred_dir(object = msn_list[[1]], dirPrior = dirPrior, q = 15)
```

### 4. Running BANDLE
Execute the MCMC sampling. In production, use `numIter = 10000` and `numChains >= 4`.

```r
bandleres <- bandle(objectCond1 = control,
                    objectCond2 = treatment,
                    numIter = 1000, 
                    burnin = 500,
                    thin = 1,
                    gpParams = gpParams,
                    numChains = 4,
                    dirPrior = dirPrior)
```

### 5. Convergence Diagnostics
Assess if the MCMC chains have reached a stationary distribution.

```r
# Gelman diagnostics (should be < 1.2)
calculateGelman(bandleres)

# Trace and density plots for outliers
plotOutliers(bandleres)
```

### 6. Processing and Predicting
Summarize the MCMC samples and append results to the `MSnSet` objects.

```r
# Populate summary slots
bandleres <- bandleProcess(bandleres)

# Append predictions to MSnSets
res_list <- bandlePredict(control, treatment, params = bandleres)
res_ctrl <- res_list[[1]][[1]] # First replicate of control with results
```

## Key Functions and Interpretation

### Differential Localisation Probability
The primary output is the `bandle.differential.localisation` score (0 to 1).
```r
# Extract probabilities
diff_probs <- fData(res_ctrl)$bandle.differential.localisation

# Estimate Expected False Discovery Rate (EFDR)
EFDR(diff_probs, threshold = 0.95)
```

### Visualizing Translocations
Use alluvial or chord diagrams to see where proteins moved.
```r
# Plot all movements
plotTranslocations(bandleres)

# Plot movements for high-confidence movers only
movers <- which(fData(res_ctrl)$bandle.differential.localisation > 0.95)
plotTranslocations(res_list, fcol = "bandle.allocation")
```

### Uncertainty Quantification
Use bootstrapping or binomial sampling to see the confidence intervals for translocation.
```r
boot_res <- bootstrapdiffLocprob(params = bandleres, top = 50)
boxplot(t(boot_res), las = 2, main = "Uncertainty in Translocation")
```

## Reference documentation
- [Vignette 1: Getting Started with BANDLE](./references/v01-getting-started.md)
- [Vignette 2: A workflow for analysing differential localisation](./references/v02-workflow.md)