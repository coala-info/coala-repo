---
name: r-fastqcr
description: The r-fastqcr package parses, aggregates, and analyzes FastQC reports to summarize sequencing quality control metrics into tidy data frames. Use when user asks to run FastQC from R, aggregate multiple FastQC reports, identify quality control failures and warnings, or generate consolidated HTML reports.
homepage: https://cran.r-project.org/web/packages/fastqcr/index.html
---

# r-fastqcr

## Overview
The `fastqcr` package provides a suite of R functions to parse, aggregate, and analyze FastQC reports. It is designed to handle large numbers of samples by summarizing quality control metrics into tidy data frames, allowing for programmatic inspection of sequencing quality rather than manual review of individual HTML files.

## Installation
To install the package from CRAN:
```R
install.packages("fastqcr")
library(fastqcr)
```

## Main Workflows

### 1. Running FastQC from R
If FastQC is not installed on a Unix-based system (Linux/macOS), you can install it via R.
```R
# Install FastQC
fastqc_install()

# Run FastQC on a directory of FASTQ files
fastqc(fq.dir = "path/to/fastq",
       qc.dir = "path/to/output",
       threads = 4)
```

### 2. Aggregating Multiple Reports
Walks a directory to find all FastQC zip files and combines their data into a single data frame.
```R
# Aggregate reports
qc <- qc_aggregate("path/to/fastqc_results")

# View general statistics (reads, GC content, duplication)
qc_stats(qc)

# Summary of pass/fail/warn status per module
summary(qc)
```

### 3. Inspecting QC Problems
Identify which samples or modules are problematic.
```R
# Find modules that failed in the most samples
qc_fails(qc, element = "module")

# Find samples with the most warnings
qc_warns(qc, element = "sample")

# Get a detailed list of all problems (fails and warns)
qc_problems(qc, element = "sample", compact = FALSE)

# Filter for a specific module
qc_problems(qc, element = "module", name = "Per sequence GC content")
```

### 4. Generating HTML Reports
Create consolidated HTML reports for one or many samples.
```R
# Multi-QC Report for a directory
qc_report("path/to/fastqc_results", result.file = "multi-qc-report")

# One-Sample Report with automated result interpretation
qc_report("path/to/sample_fastqc.zip", result.file = "sample-report", interpret = TRUE)
```

### 5. Programmatic Plotting
Import raw FastQC data into R for custom visualization.
```R
# Read data
qc_data <- qc_read("path/to/sample_fastqc.zip")

# Plot specific modules
qc_plot(qc_data, "Per base sequence quality")
qc_plot(qc_data, "Per sequence GC content")
```

## Tips
- **File Formats**: `qc_aggregate()` looks for `.zip` files produced by FastQC. Ensure you haven't unzipped them manually unless using `qc_unzip()`.
- **Partial Matching**: When using `qc_problems()`, the `name` argument supports partial matching (e.g., "GC content" matches "Per sequence GC content").
- **Tidyverse Integration**: The output of `qc_aggregate()` is a tibble, making it compatible with `dplyr` for custom filtering and `ggplot2` for custom plotting.

## Reference documentation
- [fastqcr: Quality Control of Sequencing Data](./references/home_page.md)