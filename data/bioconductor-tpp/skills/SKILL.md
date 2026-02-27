---
name: bioconductor-tpp
description: This tool analyzes Thermal Proteome Profiling data to identify drug-target interactions by monitoring changes in protein thermal stability. Use when user asks to analyze thermal proteome profiling data, fit protein melting curves, calculate pEC50 values from dose-response experiments, or perform 2D-TPP analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/TPP.html
---


# bioconductor-tpp

name: bioconductor-tpp
description: Analysis of Thermal Proteome Profiling (TPP) data, including temperature range (TR), compound concentration range (CCR), and 2D-TPP experiments. Use this skill to perform protein thermal stability analysis, melting curve fitting, dose-response curve fitting, and statistical assessment of drug-target interactions from mass spectrometry data.

## Overview
The `TPP` package provides a comprehensive workflow for analyzing Thermal Proteome Profiling data. It enables the identification of drug targets by monitoring changes in protein thermal stability (melting curves) or dose-dependent stability changes (CCR). It supports three main experiment types:
1. **TPP-TR**: Temperature Range experiments to detect melting point shifts.
2. **TPP-CCR**: Compound Concentration Range experiments to determine pEC50 values.
3. **2D-TPP**: Combined temperature and concentration ranges for high-resolution target identification.

## Core Workflow: TPP-TR (Temperature Range)
Use this workflow to compare vehicle vs. treatment across a range of temperatures.

### 1. Configuration and Data Import
Create a configuration data frame specifying experiment names, conditions, and isobaric label-to-temperature mappings.

```r
library(TPP)
# Load example data
data("hdacTR_smallExample") 

# Import data into ExpressionSets
trData <- tpptrImport(configTable = hdacTR_config, data = hdacTR_data)
```

### 2. Normalization and Curve Fitting
Normalization accounts for experiment-specific noise by fitting a sigmoidal curve to median fold changes of a "non-changing" protein set.

```r
# Normalize data
normResults <- tpptrNormalize(data = trData)
trDataNormalized <- normResults[["normData"]]

# Fit melting curves
trDataFitted <- tpptrCurveFit(data = trDataNormalized, nCores = 2)
```

### 3. Statistical Analysis
Assess the significance of melting point shifts between conditions.

```r
# Analyze melting curves and calculate p-values
TRresults <- tpptrAnalyzeMeltingCurves(data = trDataFitted)

# Filter for proteins fulfilling quality requirements
targets <- subset(TRresults, fulfills_all_4_requirements)
```

## Core Workflow: TPP-CCR (Concentration Range)
Use this workflow to analyze isothermal dose-response data.

```r
# Import and Normalize
ccrData <- tppccrImport(configTable = hdacCCR_config[1,], data = hdacCCR_data[[1]])
ccrNorm <- tppccrNormalize(data = ccrData)

# Transform and Fit
ccrTransformed <- tppccrTransform(data = ccrNorm)
ccrFitted <- tppccrCurveFit(data = ccrTransformed)

# Generate result table with pEC50 values
ccrResults <- tppccrResultTable(ccrFitted)
```

## Core Workflow: 2D-TPP
For experiments varying both temperature and concentration simultaneously.

```r
# Automated workflow
tpp2dResults <- analyze2DTPP(configTable = config_2d, 
                             data = data_2d, 
                             methods = "doseResponse")

# Manual steps: Import -> Compute Fold Changes -> Normalize -> Fit
data2d <- tpp2dImport(configTable = config_2d, data = data_2d)
fcData2d <- tpp2dComputeFoldChanges(data = data2d)
normData2d <- tpp2dNormalize(data = fcData2d)
ccr2dResults <- tpp2dCurveFit(data = normData2d)
```

## NPARC (Non-Parametric Analysis of Response Curves)
For more robust statistical testing of TR data, use the NPARC approach which models curves using splines or sigmoid functions to compare null vs. alternative models.

```r
# NPARC is typically invoked via the TPP-TR workflow or specialized functions
# to detect significant improvements in goodness-of-fit for treatment models.
```

## Tips for Success
- **Configuration Table**: Ensure the `Label` columns (e.g., 126, 127L) exactly match the isobaric labels used in your MS data.
- **Quality Filters**: The package uses default filters (e.g., $R^2 > 0.8$, plateau $< 0.3$). You can relax these in `tpptrAnalyzeMeltingCurves` if you suspect true targets are being filtered out, but beware of increased false positives.
- **Parallelization**: Use the `nCores` argument in fitting functions to speed up analysis on large datasets.
- **Visualizations**: Always inspect the PDF outputs in the `Melting_Curves` or `DoseResponse_Curves` directories to verify the quality of the fits.

## Reference documentation
- [Analyzing Thermal Proteome Profiling experiments by NPARC](./references/NPARC_analysis_of_TPP_TR_data.md)
- [Introduction to TPP: TR and CCR experiments](./references/TPP_introduction_1D.md)
- [Introduction to TPP: 2D-TPP experiments](./references/TPP_introduction_2D.md)