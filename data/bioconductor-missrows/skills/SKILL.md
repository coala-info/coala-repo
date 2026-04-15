---
name: bioconductor-missrows
description: This tool integrates multi-omics data with missing individuals using the Multiple Imputation in Multiple Factor Analysis framework. Use when user asks to handle missing rows in multi-omics datasets, create MIDTList objects, perform multiple imputations with MIMFA, visualize missingness patterns, or assess uncertainty via confidence ellipses.
homepage: https://bioconductor.org/packages/release/bioc/html/missRows.html
---

# bioconductor-missrows

name: bioconductor-missrows
description: Expert guidance for the missRows Bioconductor package. Use this skill when you need to handle missing individuals (rows) in multi-omics data integration using the Multiple Imputation in Multiple Factor Analysis (MI-MFA) framework. This includes creating MIDTList objects, performing multiple imputations with MIMFA, visualizing missingness patterns, and assessing uncertainty via confidence ellipses or convex hulls.

## Overview

The `missRows` package addresses a common problem in multi-omics studies: individuals (samples) that are not present across all data tables. It implements the MI-MFA method, which generates multiple imputed datasets using a hot-deck approach, analyzes them via Multiple Factor Analysis (MFA), and combines the results into a single consensus solution using the STATIS method.

## Core Workflow

### 1. Data Preparation (MIDTList)
The central data structure is the `MIDTList` object. It requires the incomplete data tables and a "stratum" indicator for each individual (used for the hot-deck imputation donor pools).

```R
library(missRows)

# From individual matrices/data frames
# Tables must have matching row names (samples) and be in Sample x Variable format
midt <- MIDTList(table1, table2, colData = sample_metadata, assayNames = c("RNA", "Prot"))

# From a MultiAssayExperiment object
midt <- MIDTList(mae_object)
```

### 2. Inspecting Missingness
Before imputation, visualize the distribution of missing rows.

```R
# Plot missingness map and get summary statistics
patt <- missPattern(midt, colMissing = "grey70")
print(patt) # Shows missing/available counts per stratum per table
```

### 3. Performing MI-MFA
The `MIMFA` function performs the imputation, analysis, and combination steps.

```R
# ncomp: number of components for MFA
# M: number of imputations (typically 20-50, depending on missingness)
# estimeNC: if TRUE, estimates the number of components for imputation
midt <- MIMFA(midt, ncomp = 2, M = 30, estimeNC = TRUE)
```

### 4. Visualization and Interpretation
`missRows` provides specialized plotting functions to handle the uncertainty of imputed values.

*   **Individuals Plot:** Visualize observed and imputed individuals.
    ```R
    # Basic plot
    plotInd(midt)

    # Visualize uncertainty with 95% confidence ellipses
    plotInd(midt, confAreas = "ellipse", confLevel = 0.95)

    # Visualize uncertainty with convex hulls
    plotInd(midt, confAreas = "convex.hull")
    ```
*   **Variables Plot:** Correlation circles to see relationships between variables from different tables.
    ```R
    plotVar(midt, radIn = 0.5, cutoff = 0.5)
    ```

## Advanced Tuning

### Determining the Number of Imputations
If you are unsure if `M` is large enough, use `tuneM` to check the stability of the compromise configuration.

```R
# Calculates RV coefficients between configurations as M increases
tune <- tuneM(midt, ncomp = 2, Mmax = 100, inc = 10, N = 20)
# Look for the RV coefficient to stabilize near 1.0
```

### Accessing Results
*   `configurations(midt, M = 5)`: Extract the 5th imputed MFA configuration.
*   `colData(midt)`: Access the sample metadata.
*   `names(midt)`: Get the names of the omics tables.

## Reference documentation

- [missRows](./references/missRows.md)