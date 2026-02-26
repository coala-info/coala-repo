---
name: bioconductor-flowbin
description: This tool combines multi-tube flow cytometry data into a unified expression matrix using common binning markers. Use when user asks to integrate data from multiple flow cytometry aliquots, normalize common population markers across tubes, or create a combined expression set for multi-panel experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/flowBin.html
---


# bioconductor-flowbin

name: bioconductor-flowbin
description: A skill for combining multi-tube flow cytometry data using common population markers. Use this skill when you need to integrate data from multiple flow cytometry tubes (aliquots) of the same biological sample that share a set of common "binning" markers but have different "measurement" markers.

# bioconductor-flowbin

## Overview

The `flowBin` package addresses the challenge of multi-tube flow cytometry panels where a single sample is split across multiple tubes to accommodate more antibodies than a cytometer can detect simultaneously. It uses the common markers (e.g., CD45, FSC, SSC) present in every tube to create a common binning structure (using the `flowFP` algorithm) and then maps the tube-specific measurement markers into these bins. This results in a unified expression matrix representing the full antibody panel across all identified cell populations.

## Typical Workflow

### 1. Data Preparation and Object Creation
To use `flowBin`, you must organize your `flowFrame` objects into a `FlowSample` object. You need to identify which channels are common (binning parameters) and which are tube-specific (measurement parameters).

```r
library(flowBin)
# Assuming fs is a flowSet containing your tubes
aml.sample <- new('FlowSample',
                  name='My Experiment',
                  tube.set=as.list(fs@frames),
                  control.tubes=c(1), # Index of isotype/negative control tubes
                  bin.pars=c(1, 2, 5), # Indices of common markers (e.g., FSC, SSC, CD45)
                  measure.pars=list(c(3, 4, 6, 7))) # Indices of markers unique to tubes
```

### 2. Quantile Normalization
Since common markers should have identical distributions across tubes from the same sample, normalization is recommended to correct for technical variation.

```r
# Perform normalization on binning markers
normed.sample <- quantileNormalise(aml.sample)

# Optional: Check normalization quality
qnorm.check <- checkQNorm(aml.sample, normed.sample, do.plot=TRUE)
```

### 3. Running flowBin
The `flowBin` function performs the actual binning and expression estimation.

```r
# Combine tubes into a single expression set
tube.combined <- flowBin(tube.list=aml.sample@tube.set,
                         bin.pars=aml.sample@bin.pars,
                         control.tubes=aml.sample@control.tubes,
                         expr.method='medianFIDist', # or 'propPos'
                         scale.expr=TRUE)
```

### 4. Visualizing Results
The output is a `flowExprSet` which can be visualized using standard R heatmaps.

```r
# Visualize the integrated expression matrix
heatmap(tube.combined, scale='none')
```

## Key Functions and Parameters

- `FlowSample`: The S4 class used to store the collection of tubes and metadata.
- `quantileNormalise`: Adjusts the binning markers across tubes to ensure consistent population identification.
- `flowBin`: The main execution function.
    - `expr.method='medianFIDist'`: Calculates the median fluorescence intensity of the bin, subtracting the median of the control tube.
    - `expr.method='propPos'`: Calculates the proportion of positive cells in a bin based on a 98th percentile cutoff from the control tube.
    - `scale.expr=TRUE`: Scales results to [0, 1] based on the `flowFrame` range, useful for comparing channels with different dynamic ranges (like FSC vs Log-fluorescence).

## Tips for Success
- **Control Tubes**: Always include at least one negative or isotype control tube to allow `flowBin` to calculate background-corrected expression or positive proportions.
- **Binning Markers**: Choose markers that clearly define the major cell populations of interest. These must be present in every tube.
- **Memory Management**: For very large datasets, ensure you have sufficient RAM as `flowBin` processes all tubes to create the global binning schema.

## Reference documentation

- [flowBin: a Package for Combining Multitube Flow Cytometry Data](./references/flowBin.md)