---
name: bioconductor-metagene
description: The metagene package produces enrichment profiles and metagene plots by extracting alignment data from BAM files across specified genomic regions. Use when user asks to generate metagene plots, calculate mean enrichment with confidence intervals, or compare genomic signal across different samples and regions.
homepage: https://bioconductor.org/packages/3.8/bioc/html/metagene.html
---

# bioconductor-metagene

## Overview
The `metagene` package is designed to produce enrichment profiles (metagene plots) by extracting alignment data from BAM files across specified genomic regions (BED files or GRanges). It uses bootstrapping to estimate mean enrichment and confidence intervals, allowing for statistically robust comparisons between different samples, replicates, or genomic feature groups.

## Core Workflow

### 1. Prepare Inputs
You need two primary inputs:
*   **BAM Files**: A vector of paths to indexed BAM files.
*   **Regions**: A vector of paths to BED files or a `GRanges`/`GRangesList` object.

```r
library(metagene)
bam_files <- c("sample1.bam", "sample2.bam")
regions <- c("promoters.bed", "enhancers.bed")
```

### 2. Define Experimental Design (Optional)
A design `data.frame` allows you to group replicates and subtract controls.
*   **Column 1 (Samples)**: BAM filenames or paths.
*   **Other Columns**: Group names. Values: `0` (ignore), `1` (input), `2` (control).

```r
design <- data.frame(Samples = c("s1_rep1.bam", "s1_rep2.bam", "ctrl.bam"),
                    group1 = c(1, 1, 2))
```

### 3. The metagene Object
The package uses an R6 class. You can perform a minimal analysis or a step-by-step complete analysis.

**Minimal Analysis:**
```r
mg <- metagene$new(regions = regions, bam_files = bam_files)
mg$plot(title = "Metagene Plot")
```

**Complete Step-by-Step Analysis:**
```r
mg <- metagene$new(regions = regions, bam_files = bam_files)
mg$produce_table(design = design, bin_count = 100) # Noise removal & normalization
mg$produce_data_frame()                           # Bootstrap calculations
mg$plot(region_names = "promoters", title = "Custom Plot")
```

## Key Functions and Methods

### Object Methods (R6)
*   `$new(regions, bam_files, ...)`: Initializes the object and extracts raw coverage.
*   `$produce_table(design, bin_count)`: Processes coverage data. `bin_count` (default 100) determines the resolution.
*   `$produce_data_frame(alpha, sample_count)`: Calculates the mean and confidence intervals (ribbons) via bootstrap.
*   `$plot(region_names, design_names, ...)`: Generates a ggplot2 object.
*   `$add_design(design)`: Adds a design without re-extracting coverage.

### Getters
*   `$get_table()`: Returns the processed data.table.
*   `$get_data_frame()`: Returns the data used for plotting (includes `qinf` and `qsup` for ribbons).
*   `$get_regions()`: Returns the GRanges used.
*   `$get_normalized_coverages()`: Returns coverages in RPM.

## Advanced Usage

### Chaining
Since methods return the object pointer, you can chain commands:
```r
mg <- metagene$new(regions, bams)$produce_table(design = d)$plot()
```

### Managing Large Datasets
If memory is an issue, process regions separately and merge the resulting data frames:
```r
df1 <- mg1$get_data_frame()
df2 <- mg2$get_data_frame()
combined_df <- rbind(df1, df2)
p <- plot_metagene(combined_df)
```

### Permutation Tests
To compare two profiles statistically, use the `permutation_test` function (requires the `similaRpeak` package for metrics).

## Tips for Success
*   **Indexing**: Ensure all BAM files have corresponding `.bai` files in the same directory.
*   **Naming**: Use named vectors for `bam_files` to make the `design` table and plot legends easier to manage.
*   **Built-in Data**: Use `data(promoters_hg19)` for quick testing on human promoter regions.

## Reference documentation
- [Introduction to metagene](./references/metagene.md)
- [metagene: a package to produce metagene plots](./references/metagene.Rmd)
- [metagene RNA-Seq analysis](./references/metagene_rnaseq.md)
- [metagene RNA-Seq workflow](./references/metagene_rnaseq.Rmd)