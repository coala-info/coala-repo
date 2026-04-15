---
name: bioconductor-refplus
description: This tool performs reference-based RMA normalization for Affymetrix GeneChip microarray data using the RMA+ and RMA++ algorithms. Use when user asks to generate reference models from training microarrays, apply pre-calculated probe effects to new data, or approximate RMA results for large datasets through extrapolation averaging.
homepage: https://bioconductor.org/packages/3.6/bioc/html/RefPlus.html
---

# bioconductor-refplus

name: bioconductor-refplus
description: Pre-processing Affymetrix GeneChip microarray data using RMA+ and RMA++ methods. Use this skill when you need to perform reference-based RMA normalization, which allows for processing new microarrays using pre-calculated probe effects and quantiles from a reference set, or when approximating RMA results for large datasets through extrapolation averaging.

## Overview

The `RefPlus` package implements the RMA+ and RMA++ algorithms. These methods are extensions of the Robust Multi-array Average (RMA) algorithm designed to process microarrays using a "reference set" approach. 

- **RMA+**: Processes new arrays by applying normalization quantiles and probe effects derived from a previously defined reference set. This allows for consistent preprocessing of samples across different batches or studies.
- **RMA++**: An extension of RMA+ that averages results from multiple RMA+ runs using different reference sets, providing a closer approximation to standard RMA when dealing with large or heterogeneous data.

## Typical Workflow

### 1. Prepare the Reference Model (RMA+)
To use RMA+, you first need to generate a reference model from a set of training microarrays (an `AffyBatch` object).

```r
library(RefPlus)
# Assume 'ReferenceData' is an AffyBatch object
# bg=TRUE performs background correction; exp=TRUE returns expression values
Para <- rma.para(ReferenceData, bg = TRUE, exp = TRUE)

# Para is a list containing:
# Para[[1]]: Reference Quantiles
# Para[[2]]: Reference Probe Effects
# Para[[3]]: RMA expression values for the reference set
```

### 2. Apply the Model to New Data (RMA+)
Once you have the `Para` object, you can process any number of new arrays (or the original set) using the `rmaplus` function.

```r
# Assume 'NewData' is an AffyBatch object
Ex_plus <- rmaplus(NewData, rmapara = Para, bg = TRUE)
```

### 3. Extrapolation Averaging (RMA++)
To improve the approximation to standard RMA, use multiple reference sets and average the resulting RMA+ expression matrices.

```r
# Generate a second reference model from a different subset
Para2 <- rma.para(ReferenceData2, bg = TRUE, exp = TRUE)

# Calculate RMA+ for both models
Ex_plus1 <- rmaplus(NewData, rmapara = Para, bg = TRUE)
Ex_plus2 <- rmaplus(NewData, rmapara = Para2, bg = TRUE)

# Calculate RMA++ by averaging
Ex_pplus <- (Ex_plus1 + Ex_plus2) / 2
```

## Key Functions

- `rma.para(object, bg = TRUE, exp = TRUE)`: Fits the RMA model to a reference `AffyBatch`. Returns the parameters needed for RMA+.
- `rmaplus(object, rmapara, bg = TRUE)`: Performs RMA+ normalization on an `AffyBatch` using the parameters provided in `rmapara`.
- `colSummarizeMethod.microarray.helper`: Internal helper for probe summarization (usually called via `rmaplus`).

## Tips and Best Practices

- **Consistency**: RMA+ is ideal for clinical studies where samples arrive over time. By using a fixed reference set, you ensure that the preprocessing of the first sample is identical to the preprocessing of the last sample.
- **Background Correction**: If you set `bg = FALSE` in `rma.para` or `rmaplus`, ensure your data has been background-corrected independently using functions like `bg.correct.rma`.
- **Memory Efficiency**: RMA+ allows you to process very large datasets that might otherwise crash standard RMA due to memory constraints, as you can process samples in smaller chunks against the same reference parameters.

## Reference documentation

- [RMA+ and RMA++ using the RefPlus package](./references/RefPlus.md)