---
name: bioconductor-skewr
description: bioconductor-skewr visualizes and analyzes Illumina Human Methylation 450k BeadChip data using skew-normal finite mixture models in log2 intensity space. Use when user asks to perform quality control on methylation arrays, estimate skew-normal parameters for probe subsets, or compare normalization methods like SWAN and dasen through panel plots.
homepage: https://bioconductor.org/packages/release/bioc/html/skewr.html
---


# bioconductor-skewr

name: bioconductor-skewr
description: Visualizing and analyzing Illumina Human Methylation 450k BeadChip data using skew-normal finite mixture models. Use this skill to perform quality control, visualize signal intensities in log2 space, and compare normalization methods (e.g., SWAN, dasen, illumina) for DNA methylation arrays.

## Overview
The `skewr` package provides tools for visualizing Illumina 450k methylation data to assist in quality control. Unlike many tools that focus on $\beta$-values, `skewr` operates in log2 intensity space, modeling distributions as mixtures of skew-normal distributions. It helps identify signal-to-noise ratios and non-specific binding by subsetting probes into Type I-red, Type I-green, and Type II categories.

## Core Workflow

### 1. Data Loading and Preprocessing
`skewr` works with `MethyLumiSet` objects. You can load raw IDAT files or use existing Bioconductor objects.

```R
library(skewr)
library(minfiData)

# Get barcodes from a directory
baseDir <- system.file("extdata/5723646052", package = "minfiData")
barcodes <- getBarcodes(path = baseDir)

# Load data into a MethyLumiSet
raw_data <- getMethyLumiSet(path = baseDir, barcodes = barcodes)

# Apply normalization (optional)
norm_data <- preprocess(raw_data, norm = 'dasen') # Options: 'illumina', 'SWAN', 'dasen'
```

### 2. Estimating Skew-Normal Parameters
You must estimate parameters for six subsets: Methylated (M) and Unmethylated (U) for each of the three probe types (I-red, I-green, II).

```R
# Example for Type I-red Methylated probes
sn.meth.I.red <- getSNparams(norm_data, 'M', 'I-red')
sn.unmeth.I.red <- getSNparams(norm_data, 'U', 'I-red')

# Repeat for I-green and II
sn.meth.I.green <- getSNparams(norm_data, 'M', 'I-green')
sn.unmeth.I.green <- getSNparams(norm_data, 'U', 'I-green')
sn.meth.II <- getSNparams(norm_data, 'M', 'II')
sn.unmeth.II <- getSNparams(norm_data, 'U', 'II')
```

### 3. Visualization
To generate the standard nine-plot panel, group the parameters into lists and call `panelPlots`.

```R
# Group by channel/assay
mixes.I.red <- list(sn.meth.I.red, sn.unmeth.I.red)
mixes.I.green <- list(sn.meth.I.green, sn.unmeth.I.green)
mixes.II <- list(sn.meth.II, sn.unmeth.II)

# Generate panel plot for all samples
panelPlots(norm_data, mixes.I.red, mixes.I.green, mixes.II, norm = 'Normalized')

# Generate detailed single frames for a specific sample (e.g., sample 1)
panelPlots(norm_data, mixes.I.red, mixes.I.green, mixes.II, 
           plot = 'frames', samp.num = 1, frame.nums = c(1, 2))
```

## Key Functions
- `getBarcodes(path)`: Retrieves clean barcode names from IDAT files.
- `getMethyLumiSet(path, barcodes)`: Wrapper for `methylumIDAT` to create the initial data object.
- `preprocess(mset, norm)`: Normalizes data using 'illumina', 'SWAN', or 'dasen' methods.
- `getSNparams(mset, subtype, assay)`: Fits a skew-normal finite mixture model to a subset of probes.
- `panelPlots(mset, ...)`: Creates a 3x3 grid of density and $\beta$-value plots.

## Interpretation Tips
- **Component Fitting**: Type I probes are typically modeled with three components; Type II probes are modeled with two.
- **Quality Control**: Use the `plot = 'frames'` argument to see legends containing means and modes for each mixture component.
- **Comparison**: Run `panelPlots` on both raw and normalized data to visualize how specific normalization methods shift the intensity distributions.

## Reference documentation
- [An Introduction to the skewr Package](./references/skewr.md)