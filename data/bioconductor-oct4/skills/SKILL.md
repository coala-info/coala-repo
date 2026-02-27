---
name: bioconductor-oct4
description: The bioconductor-oct4 package provides Salmon quantification results and metadata for RNA-seq samples investigating the relationship between OCT4 and BRG1 in mouse embryonic stem cells. Use when user asks to access RNA-seq quantification data for OCT4 and BRG1 studies, retrieve experimental metadata for mouse stem cells, or load Salmon files for analysis with tximport.
homepage: https://bioconductor.org/packages/release/data/experiment/html/oct4.html
---


# bioconductor-oct4

## Overview

The `oct4` package is a Bioconductor ExperimentData package providing Salmon quantification results for 12 RNA-seq samples. The data originates from a study investigating the relationship between the pioneer factor OCT4 and the chromatin remodeller BRG1 in mouse embryonic stem cells. It includes three replicates each for OCT4-treated/control and BRG1-treated/control conditions.

## Data Access and Workflow

### Locating Package Resources
The package stores its primary data in the `inst/extdata` directory. Use `system.file` to retrieve the absolute paths required for R analysis.

```r
# Load the package
library(oct4)

# Find the base directory for external data
data_dir <- system.file("extdata", package="oct4")
```

### Loading Sample Metadata
The sample information (phenotypes, cell lines, and treatment conditions) is stored in `coldata.csv`.

```r
# Read the sample metadata
coldata_path <- file.path(data_dir, "coldata.csv")
coldata <- read.csv(coldata_path)

# View the experimental design
# Columns: names (SRX IDs), line (OCT4 or BRG1), condition (untrt or trt)
print(coldata)
```

### Accessing Salmon Quantifications
The quantification files are located in the `quant` sub-directory. Note that the `quant.sf` files are gzipped.

```r
# Construct paths to the Salmon quant files
files <- file.path(data_dir, "quant", coldata$names, "quant.sf.gz")
names(files) <- coldata$names

# Check if files exist
all(file.exists(files))
```

### Integration with Downstream Tools
Because these files were generated with Salmon (version 0.12.0) using Gencode mouse reference M20, they are ideal for use with `tximport` or `tximeta`.

```r
# Example: Preparing for tximport
# library(tximport)
# txi <- tximport(files, type = "salmon", txOut = TRUE)
```

## Technical Details
- **Reference Genome:** Gencode mouse reference transcripts M20.
- **Quantification Tool:** Salmon v0.12.0.
- **Inferential Replicates:** Includes 20 Gibbs replicates per sample for uncertainty estimation.
- **Experimental Design:** 
    - **OCT4 line:** Control vs. 24hr Doxycycline treatment (1 ug/mL).
    - **BRG1 line:** Control vs. 72hr 4-hydroxytamoxifen treatment.

## Reference documentation

- [oct4](./references/oct4.md)