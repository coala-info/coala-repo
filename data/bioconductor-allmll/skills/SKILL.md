---
name: bioconductor-allmll
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ALLMLL.html
---

# bioconductor-allmll

name: bioconductor-allmll
description: Access and utilize the ALLMLL Bioconductor data package, which provides probe-level microarray data (AffyBatch objects) from a pediatric acute lymphoblastic leukemia (ALL) study. Use this skill when a user needs to load, inspect, or analyze the MLL.A (HGU133A) or MLL.B (HGU133B) datasets for leukemia research or microarray bioinformatics workflows.

# bioconductor-allmll

## Overview
The `ALLMLL` package is an experiment data package providing a subset of arrays from a significant study on pediatric acute lymphoblastic leukemia (Ross et al., 2003). It contains probe-level data for 20 HGU133A and 20 HGU133B arrays specifically focusing on the MLL (Mixed-Lineage Leukemia) subtype. The data is stored as `AffyBatch` objects, making it compatible with the `affy` package for preprocessing and analysis.

## Loading the Data
To use the datasets, you must load the library and then use the `data()` function to bring the objects into the environment.

```r
# Load the package
library(ALLMLL)

# Load the HGU133A subset (20 arrays)
data(MLL.A)

# Load the HGU133B subset (20 arrays)
data(MLL.B)
```

## Working with AffyBatch Objects
Since the data is provided in `AffyBatch` format, you can use standard functions from the `affy` package to inspect and process the data.

### Inspection
```r
# View summary of the objects
print(MLL.A)
print(MLL.B)

# Check sample names
sampleNames(MLL.A)

# Access phenoData (metadata)
pData(MLL.A)
```

### Preprocessing (Normalization)
Before analysis, these probe-level objects typically require normalization (e.g., using RMA or MAS5).

```r
library(affy)

# Robust Multi-array Average (RMA) normalization
eset.a <- rma(MLL.A)
eset.b <- rma(MLL.B)

# The resulting objects are ExpressionSet instances ready for differential expression analysis
```

## Typical Workflow
1. **Initialization**: Load `ALLMLL` and `affy`.
2. **Data Retrieval**: Call `data(MLL.A)`.
3. **Quality Control**: Use `boxplot(MLL.A)` or `hist(MLL.A)` to visualize probe intensities.
4. **Normalization**: Convert `AffyBatch` to `ExpressionSet` using `rma()`.
5. **Analysis**: Proceed with downstream statistical testing (e.g., using `limma`).

## Reference documentation
- [ALLMLL Reference Manual](./references/reference_manual.md)