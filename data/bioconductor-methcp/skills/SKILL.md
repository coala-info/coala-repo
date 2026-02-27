---
name: bioconductor-methcp
description: MethCP identifies differentially methylated regions (DMRs) in whole-genome bisulfite sequencing data using change point detection. Use when user asks to perform DNA methylation analysis, identify DMRs in two-group or time-course experiments, or segment the genome based on methylation statistics.
homepage: https://bioconductor.org/packages/3.10/bioc/html/MethCP.html
---


# bioconductor-methcp

name: bioconductor-methcp
description: Analysis of differentially methylated regions (DMRs) in whole-genome bisulfite sequencing (WGBS) data. Use when Claude needs to perform DNA methylation analysis, including two-group comparisons or time-course experiments, using change point detection to segment the genome and identify significant regions.

# bioconductor-methcp

## Overview

MethCP is a Bioconductor package designed for detecting Differentially Methylated Regions (DMRs) in Whole-Genome Bisulfite Sequencing (WGBS) data. It utilizes change point detection to naturally segment the genome, providing region-level differential analysis. It is highly flexible, supporting two-group comparisons, time-course designs, and custom user-provided statistics.

## Installation

To install the package, use BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MethCP")
```

## Core Workflow

The standard MethCP workflow consists of four main steps:

1.  **Data Loading**: Import raw methylation counts into a `BSseq` object.
2.  **Statistic Calculation**: Compute per-cytosine statistics based on the experimental design.
3.  **Segmentation**: Segment the genome into regions based on the calculated statistics.
4.  **DMR Identification**: Extract significant regions (DMRs).

### 1. Data Loading

MethCP integrates with the `bsseq` package. Use the helper function `createBsseqObject` to load data from text files.

```r
library(bsseq)
library(MethCP)

# Define sample names and file paths
sample_names <- c("control1", "control2", "treatment1", "treatment2")
raw_files <- c("path/to/ctrl1.txt", "path/to/ctrl2.txt", "path/to/trt1.txt", "path/to/trt2.txt")

# Create BSseq object
bs_object <- createBsseqObject(
    files = raw_files, 
    sample_names = sample_names, 
    chr_col = 'Chr', 
    pos_col = 'Pos', 
    m_col = "M", 
    cov_col = 'Cov',
    header = TRUE
)
```

### 2. Calculating Statistics

#### Two-Group Comparison
Use `calcLociStat` for simple group comparisons. You can choose between `DSS` or `methylKit` tests.

```r
group1 <- c("control1", "control2")
group2 <- c("treatment1", "treatment2")

# Calculate statistics using methylKit test
obj_methcp <- calcLociStat(bs_object, group1, group2, test = "methylKit")
```

#### Time-Course Analysis
Use `calcLociStatTimeCourse` for longitudinal data. The metadata must contain `Condition`, `Time`, and `SampleName` columns.

```r
# meta is a data.frame with Condition, Time, and SampleName
obj_time <- calcLociStatTimeCourse(bs_object, meta)
```

#### Custom Statistics
If you have pre-calculated p-values and effect sizes, use `MethCPFromStat`.

```r
obj_custom <- MethCPFromStat(
    data = my_stats_df, 
    test.name = "CustomTest",
    pvals.field = "pvals",
    effect.size.field = "diff",
    seqnames.field = "chr",
    pos.field = "pos"
)
```

### 3. Segmentation

The `segmentMethCP` function performs the change point detection. The `region.test` parameter determines how region-level p-values are calculated (e.g., "fisher", "weighted-coverage", or "stouffer").

```r
# Perform segmentation
obj_methcp <- segmentMethCP(obj_methcp, bs_object, region.test = "fisher")
```

### 4. Extracting Significant Regions

Use `getSigRegion` to retrieve the identified DMRs as a data frame or GRanges object.

```r
dmrs <- getSigRegion(obj_methcp)
head(dmrs)
```

## Tips and Best Practices

- **Filtering**: For time-course data, it is recommended to filter out loci with low coverage across conditions before calculating statistics to improve power and reduce noise.
- **Parallelization**: `calcLociStat` and `segmentMethCP` support parallel computing automatically when multiple chromosomes are present.
- **Region Tests**: 
    - Use `"fisher"` or `"weighted-coverage"` for two-group comparisons.
    - Use `"stouffer"` for time-course analysis.
- **BSseq Compatibility**: Since MethCP relies on `bsseq`, you can use `bsseq` functions like `getCoverage()` or `getMeth()` to inspect the raw data before running MethCP.

## Reference documentation

- [methcp: User's Guide](./references/methcp.Rmd)
- [methcp: User's Guide (Markdown)](./references/methcp.md)