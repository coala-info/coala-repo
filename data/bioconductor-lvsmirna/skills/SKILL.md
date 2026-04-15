---
name: bioconductor-lvsmirna
description: This tool normalizes and summarizes miRNA microarray data using the Least-Variant Set method to identify stable reference miRNAs. Use when user asks to normalize miRNA expression data, identify a least-variant set of miRNAs, or perform robust summarization of microarray intensities.
homepage: https://bioconductor.org/packages/3.6/bioc/html/LVSmiRNA.html
---

# bioconductor-lvsmirna

name: bioconductor-lvsmirna
description: Normalization and summarization of miRNA microarray data using the Least-Variant Set (LVS) method. Use this skill when analyzing miRNA expression data to identify stable housekeeping miRNAs for normalization, particularly when standard assumptions (like majority of features not varying) might be violated.

# bioconductor-lvsmirna

## Overview

The `LVSmiRNA` package provides a robust framework for normalizing miRNA microarray data. Unlike methods that assume most miRNAs do not change across conditions, LVS identifies a data-driven "Least-Variant Set" of miRNAs to serve as a reference for normalization. The workflow typically involves reading raw intensity data, estimating array and probe effects to identify stable miRNAs, and then performing normalization and summarization.

## Core Workflow

### 1. Data Input
The package uses `read.mir` to import data. You need a sample description file (e.g., a text file with a "Sample" column) and the corresponding image processing output files.

```r
library(LVSmiRNA)

# Read sample description
sample_info <- read.table("Comparison_Array.txt", header=TRUE, as.is=TRUE)

# Read raw intensities
MIR <- read.mir(sample_info, path="path/to/files")
```

### 2. Identifying the Least-Variant Set (LVS)
The `estVC` function is the most computationally intensive step. It fits a robust linear model (rlm) or a joint model to calculate residual variance and array-to-array variability.

```r
# Estimate Variance Components
MIR.RA <- estVC(MIR)

# Visualize the relationship (RA-plot)
# Plots square-root/log of array effect vs log residual SD
plot(MIR.RA)
```

### 3. Normalization and Summarization
The `lvs` function performs normalization based on the reference set identified in the previous step. By default, it summarizes the data using the "rlm" method.

```r
# Perform LVS normalization
MIR.lvs <- lvs(MIR, RA=MIR.RA)

# Verify results with a boxplot
boxplot(MIR.lvs)
```

### 4. Alternative Summarization
If normalization is not required, or if a different summarization algorithm is preferred (like median polish), use the `summarize` function directly.

```r
# Summarize using rlm without specific LVS normalization
ex.1 <- summarize(MIR, RA=MIR.RA, method="rlm")

# Summarize using median polish
ex.2 <- summarize(MIR, method="medianpolish")
```

## Parallel Computation

Because `estVC` is slow, `LVSmiRNA` supports parallel processing via `multicore` or `snow`.

**Using multicore:**
```r
library(multicore)
options(cores=8)
MIR.RA <- estVC(MIR)
```

**Using snow:**
```r
library(snow)
cl <- makeCluster(8, "SOCK")
MIR.RA <- estVC(MIR, clName=cl)
stopCluster(cl)
```

## Tips and Best Practices
- **Save Intermediate Results:** Always save the object returned by `estVC` (e.g., `MIR.RA`). If you call `lvs` without the `RA` argument, it will re-run the entire estimation process, which is time-consuming.
- **Model Selection:** The default `estVC` uses a standard robust linear model. For more complex data, consider the joint model which accounts for non-constant residual variation.
- **Input Format:** Ensure your sample description file contains a `FileName` column that correctly points to the raw data files on your disk.

## Reference documentation
- [LVSmiRNA Quick Start Guide](./references/LVSmiRNA.md)