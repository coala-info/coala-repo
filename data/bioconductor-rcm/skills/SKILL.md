---
name: bioconductor-rcm
description: This tool performs unconstrained and constrained ordination of microbiome read count data using Row-Column Association Models. Use when user asks to fit ordination models, create biplots or triplots, condition on confounders, or perform diagnostic checks on microbiome datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/RCM.html
---

# bioconductor-rcm

name: bioconductor-rcm
description: Perform unconstrained and constrained ordination of microbiome read count data using the RCM (Row-Column Association Models) package. Use this skill to fit ordination models, create biplots/triplots, condition on confounders, and perform diagnostic checks for microbiome datasets (typically via phyloseq).

# bioconductor-rcm

## Overview
The `RCM` package provides a unified framework for microbiome ordination. It uses Negative Binomial models to handle overdispersed count data, allowing for both exploratory (unconstrained) and hypothesis-driven (constrained) analysis. Key features include the ability to condition on confounding variables, support for linear or non-parametric response functions, and diagnostic tools to assess model fit.

## Core Workflow

### 1. Data Preparation
RCM works best with `phyloseq` objects. Ensure your data is in a count matrix format (taxa as columns, samples as rows if using the internal `RCM_NB` function, but `RCM()` handles phyloseq objects directly).

```r
library(RCM)
library(phyloseq)
data(Zeller) # Example dataset
```

### 2. Unconstrained Ordination
Use this for exploratory analysis to visualize the main sources of variation.

```r
# Fit model with 2 dimensions
# round = TRUE is recommended for non-integer counts
fit_uncon = RCM(Zeller, k = 2, round = TRUE)

# Condition on confounders (e.g., Country) to filter out their effects
fit_cond = RCM(Zeller, k = 2, confounders = "Country", round = TRUE)
```

### 3. Constrained Ordination
Use this to find variability explained by specific covariates.

```r
# Linear response functions
fit_const = RCM(Zeller, k = 2, covariates = c("Age", "BMI", "Diagnosis"), responseFun = "linear")

# Non-parametric response functions (more flexible, uses splines)
fit_np = RCM(Zeller, k = 2, covariates = c("Age", "BMI"), responseFun = "nonparametric")
```

### 4. Visualization
The `plot()` function is highly versatile for RCM objects.

*   **Samples only:** `plot(fit_uncon, plotType = "samples", samColour = "Diagnosis")`
*   **Species only:** `plot(fit_uncon, plotType = "species", taxNum = 10)`
*   **Biplot (Default):** `plot(fit_uncon, taxNum = 10)`
*   **Variables (Constrained):** `plot(fit_const, plotType = "variables")`
*   **Specific Taxa:** Use `taxRegExp = "GenusName"` to filter species in the plot.

### 5. Statistical Testing and Diagnostics
*   **PERMANOVA:** Test significance of clusters in the ordination.
    ```r
    permanova(fit_uncon, "Diagnosis")
    ```
*   **Goodness of Fit:** Identify poorly represented taxa or samples using deviance.
    ```r
    plot(fit_uncon, plotType = "samples", samColour = "Deviance")
    ```
*   **Residuals:** Check for lack of fit in response functions.
    ```r
    residualPlot(fit_const, numTaxa = 6)
    ```
*   **Influence:** Identify samples that disproportionately affect the gradient.
    ```r
    plot(fit_const, inflVar = "Age")
    ```

## Tips for Interpretation
*   **Projections:** In biplots, the orthogonal projection of a taxon arrow onto a sample vector represents the departure from independence (abundance) of that taxon in that sample.
*   **Psi ($\psi$):** These parameters on the axes reflect the relative importance of the dimensions.
*   **Coordinates:** Use `extractCoord(fit_uncon)` to get raw plotting coordinates for custom ggplot2 visualizations.

## Reference documentation
- [Manual for the RCM package](./references/RCMvignette.md)
- [RCM Vignette Source](./references/RCMvignette.Rmd)