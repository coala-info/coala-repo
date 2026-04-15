---
name: bioconductor-flowcore
description: This tool provides infrastructure for managing, manipulating, and analyzing flow cytometry data within the Bioconductor framework. Use when user asks to read or write FCS files, work with flowFrame or flowSet objects, perform compensation and transformation, apply gating and filtering operations, or subset and split flow cytometry datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/flowCore.html
---

# bioconductor-flowcore

name: bioconductor-flowcore
description: Expert guidance for using the flowCore R package to manage, manipulate, and analyze flow cytometry data. Use this skill when you need to: (1) Read or write FCS files (versions 2.0, 3.0, 3.1), (2) Work with flowFrame and flowSet objects, (3) Perform data preprocessing including compensation and transformation (logicle, arcsinh, etc.), (4) Apply gating/filtering operations (rectangle, polygon, norm2Filter), or (5) Subset and split flow cytometry datasets for downstream analysis.

# bioconductor-flowcore

## Overview
The `flowCore` package is the foundational Bioconductor infrastructure for flow cytometry data. It provides standardized S4 data structures—primarily the `flowFrame` (representing a single FCS file) and the `flowSet` (a collection of flowFrames)—along with a robust framework for compensation, transformation, and gating. It is designed to be a research platform that ensures interoperability between different flow cytometry analysis methods.

## Core Workflows

### 1. Data Import and Inspection
Load single files or entire directories into R.

```r
library(flowCore)

# Read a single FCS file
ff <- read.FCS("path/to/file.fcs", transformation = FALSE, alter.names = TRUE)

# Read a directory of files into a flowSet
fs <- read.flowSet(path = "data_dir", pattern = ".fcs")

# Inspect data
summary(ff)
exprs(ff)          # Access the raw expression matrix
keyword(ff)        # Access FCS metadata/keywords
colnames(ff)       # View detector/parameter names
pData(ff)          # View parameter metadata (stains/descriptions)
```

### 2. Compensation
Correct for spectral overlap using spillover matrices.

```r
# Extract spillover matrix from keywords
spill <- spillover(ff)$SPILL

# Apply compensation
ff_comp <- compensate(ff, spill)

# Apply to a flowSet (requires a list of matrices or one matrix for all)
fs_comp <- compensate(fs, spill)
```

### 3. Transformation
Apply common flow transformations to linearize or scale data.

```r
# Logicle (Biexponential) transformation - recommended for visualization
lgcl <- estimateLogicle(ff, channels = c("FL1-H", "FL2-H"))
ff_trans <- transform(ff, lgcl)

# Standard transforms (arcsinh, log, etc.)
asinh_trans <- arcsinhTransform(transformationId="asinh", a=1, b=1, c=1)
trans_list <- transformList("FL1-H", asinh_trans)
ff_trans <- transform(ff, trans_list)
```

### 4. Gating and Filtering
Define regions of interest and extract populations.

```r
# Define a rectangular gate
rect_gate <- rectangleGate(filterId="Fluorescence Region", 
                           "FL1-H"=c(0, 12), "FL2-H"=c(0, 12))

# Apply filter to get statistics
result <- filter(ff, rect_gate)
summary(result)

# Subset the data based on the gate
ff_subset <- Subset(ff, rect_gate)

# Split data into multiple populations (e.g., using k-means)
km_filter <- kmeansFilter("FSC-H"=c("Low", "Medium", "High"), filterId="myKM")
split_sets <- split(ff, km_filter)
```

### 5. Combining Filters
Use Boolean logic to create complex gating strategies.

```r
# Intersection (&), Union (|), Complement (!)
complex_gate <- rect_gate & morph_gate

# Subset-based gating (%subset% or %&%)
# Applies the second gate, then the first gate on the result
final_result <- filter(ff, rect_gate %&% morph_gate)
```

## Tips for Success
- **Column Names**: Use `alter.names = TRUE` in `read.FCS` to ensure parameter names are R-compatible (e.g., replacing dashes with dots).
- **Memory Management**: For very large datasets, consider using `ncdfFlow` (which extends `flowCore`) to store data on disk rather than in RAM.
- **Visualization**: While `flowCore` provides basic plotting, use the `ggcyto` package for advanced, ggplot2-compatible visualizations of `flowFrames` and `flowSets`.
- **Metadata**: Use `phenoData(fs)` to add experimental metadata (e.g., treatment, timepoint) to your `flowSet` for easier group-based analysis.

## Reference documentation
- [HowTo-flowCore](./references/HowTo-flowCore.md)
- [fcs3](./references/fcs3.md)
- [hyperlog.notice](./references/hyperlog.notice.md)