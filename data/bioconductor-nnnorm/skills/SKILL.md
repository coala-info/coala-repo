---
name: bioconductor-nnnorm
description: This tool uses neural networks to normalize two-color DNA microarray data by correcting for spatial and intensity-dependent biases. Use when user asks to normalize two-color DNA microarray data, correct spatial or intensity-dependent distortions, or perform neural network-based normalization of M-A values.
homepage: https://bioconductor.org/packages/release/bioc/html/nnNorm.html
---

# bioconductor-nnnorm

## Overview
The `nnNorm` package provides a robust neural network-based approach for normalizing two-color DNA microarray data. It is specifically designed to detect and correct for spatial biases (location on the chip) and intensity-dependent distortions. While similar in intent to print-tip loess normalization, `nnNorm` uses neural network models to handle complex bivariate distortions (spatial + intensity) more effectively.

## Workflow and Usage

### 1. Data Preparation
The package primarily works with `marrayRaw` objects from the `marray` package. If your data is in `limma` formats (RGList or MAList), use the `convert` package to transform them into `marray` objects first.

```r
library(marray)
library(nnNorm)

# Example using built-in swirl data
data(swirl)
# swirl is an object of class marrayRaw
```

### 2. Performing Normalization
The primary function is `maNormNN`. It fits a neural network to the data to estimate the bias and returns a `marrayNorm` object containing the normalized log ratios (M values).

```r
# Normalize the first two arrays in the batch
swirl_n <- maNormNN(swirl[, 1:2])
```

### 3. Advanced Normalization Options
The `maNormNN` function allows for fine-tuning of the neural network parameters:
- **Spatial Normalization**: By default, it accounts for both `maL` (layout/spatial) and `maA` (intensity) variables.
- **Print-tip Groups**: The model can be applied across different grid layouts to account for print-tip specific biases.

### 4. Visualization and Comparison
After normalization, you should evaluate the distribution of the log ratios.
- Use `maPlot` (from the `marray` package) to view M-A plots.
- Compare the distributions of normalized log ratios across different arrays to ensure consistency and bias removal.

## Tips for Success
- **Memory/Time**: Neural network fitting is more computationally intensive than loess. For large datasets, processing may take a few moments per array (indicated by `*` progress markers).
- **Object Classes**: Always ensure your input is a `marrayRaw` object. If you have raw intensity files, use `read.marrayRaw` from the `marray` package to load them correctly before calling `nnNorm` functions.
- **Univariate vs. Bivariate**: While `nnNorm` excels at spatial (2D) correction, it can also be used for simple intensity-based normalization if spatial coordinates are ignored, though its strength lies in the combined model.

## Reference documentation
- [nnNorm Overview](./references/nnNorm.md)