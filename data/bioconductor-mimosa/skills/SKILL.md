---
name: bioconductor-mimosa
description: This tool performs statistical analysis of paired count data from single-cell assays to identify responders in immunological studies using mixture models. Use when user asks to identify responders in vaccine trials, analyze ICS or ELISpot data, fit Beta-Binomial or Dirichlet-Multinomial models to paired count data, or compare stimulated versus unstimulated samples.
homepage: https://bioconductor.org/packages/3.8/bioc/html/MIMOSA.html
---


# bioconductor-mimosa

name: bioconductor-mimosa
description: Statistical analysis of paired count data from single-cell assays (like ICS or ELISpot) using Mixture Models for Single-Cell Analysis (MIMOSA). Use this skill to identify responders vs. non-responders in vaccine trials or immunological studies by fitting Beta-Binomial or Dirichlet-Multinomial models to stimulated vs. unstimulated samples.

# bioconductor-mimosa

## Overview

MIMOSA (Mixture Models for Single-Cell Analysis) is an R package designed to analyze paired count data, typically from Intracellular Cytokine Staining (ICS) assays. It identifies "responders" by comparing cytokine-positive cell counts in an antigen-stimulated sample against a paired unstimulated (negative control) sample from the same individual. It uses a Bayesian framework to borrow strength across subjects, improving sensitivity over frequentist tests like Fisher's Exact Test, especially when cell counts are low.

## Core Workflow

### 1. Data Preparation
MIMOSA requires data in a tidy format containing positive counts, negative counts (or total counts), and metadata (Subject ID, Antigen, Cytokine, etc.).

```r
library(MIMOSA)

# Example: Constructing the MIMOSAExpressionSet
# 'ICS' is a data.frame with columns: CYTNUM (pos), NSUB (neg), UID (ID), ANTIGEN, etc.
E <- ConstructMIMOSAExpressionSet(
  data = ICS,
  reference = ANTIGEN %in% "negctrl", # Logical expression for baseline
  measure.columns = c("CYTNUM", "NSUB"), # Positive and Negative counts
  other.annotations = c("CYTOKINE", "TCELLSUBSET", "ANTIGEN", "UID"),
  default.cast.formula = component ~ UID + ANTIGEN + CYTOKINE + TCELLSUBSET,
  .variables = .(TCELLSUBSET, CYTOKINE, UID), # Variables defining a unique unit
  featureCols = 1
)
```

### 2. Fitting the Model
The `MIMOSA` function fits the mixture model. You can choose between "EM" (Expectation-Maximization, faster) or "MCMC" (Markov Chain Monte Carlo, more stable/detailed).

```r
# Formula: NegCount + PosCount ~ ID + Metadata | ConditioningVariable
result <- MIMOSA(NSUB + CYTNUM ~ UID + TCELLSUBSET + CYTOKINE | ANTIGEN,
                 data = E, 
                 method = "EM")
```

### 3. Extracting Results
The result is a `MIMOSAResultList`. You can extract posterior probabilities (z-scores) and calculate False Discovery Rates (FDR).

*   **Posterior Probabilities:** `result[[1]]@z` or `getZ(result)`
*   **FDR Calculation:** `fdr(result[[1]])`
*   **Response Weights:** `getW(result)` (The estimated proportion of responders in the population).

```r
# Identify responders at 1% FDR
responders <- lapply(result, function(x) fdr(x) < 0.01)
table(responders[[1]])
```

### 4. Visualization
MIMOSA provides built-in plotting functions to evaluate model fit and discrimination.

```r
# Volcano Plot: Effect size vs. Probability of Response
volcanoPlot(result, effect_expression = CYTNUM - CYTNUM_REF, facet_var = ~ANTIGEN)
```

## Key Functions and Parameters

*   **`ConstructMIMOSAExpressionSet`**: Converts a data.frame into the specialized ExpressionSet required for modeling.
    *   `reference`: Crucial argument defining which rows are the "negative control".
*   **`MIMOSA`**: The main engine.
    *   `method = "EM"`: Recommended for initial screening.
    *   `method = "MCMC"`: Recommended for final analysis or when EM fails to converge.
*   **`fdr()`**: Computes the False Discovery Rate from the posterior probabilities.

## Tips for Success
*   **Column Order**: In the formula `NSUB + CYTNUM`, the **negative** cell counts must come first.
*   **Experimental Units**: Ensure `.variables` in the constructor correctly identifies unique subjects/subsets so that stimulated and unstimulated samples are paired correctly.
*   **Filtering**: It is often useful to filter out samples with extremely low total cell counts before running MIMOSA to avoid noise.

## Reference documentation
- [The MIMOSA Package](./references/MIMOSA.md)