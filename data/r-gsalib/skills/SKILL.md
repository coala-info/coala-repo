---
name: r-gsalib
description: The r-gsalib package provides utility functions to read and parse Genome Analysis Toolkit (GATK) report files into R data frames. Use when user asks to load GATK reports, process multi-table GATK output files, or analyze BaseRecalibrator and VariantEval data in R.
homepage: https://cloud.r-project.org/web/packages/gsalib/index.html
---


# r-gsalib

name: r-gsalib
description: Utility functions for the Genome Analysis Toolkit (GATK). Use this skill when you need to read, parse, and process GATK report files within R. It is specifically designed to handle the multi-table format of GATK output files used in variant discovery and high-throughput sequencing data analysis.

## Overview

The `gsalib` package provides essential utility functions for interfacing R with the Genome Analysis Toolkit (GATK). Its primary purpose is to load GATK report files—which often contain multiple tables with metadata in a single text file—into structured R data frames for analysis and visualization.

## Installation

To install the package from CRAN:

install.packages("gsalib")

## Core Functions

### Reading GATK Reports

The primary function in the package is `gsalib_read_gatkreport`. GATK reports are structured text files that can contain multiple independent tables (e.g., from BaseRecalibrator or VariantEval).

# Load a GATK report file
report <- gsalib_read_gatkreport("path/to/your.report")

# The result is a list of data frames
# Each element in the list corresponds to a table in the report
names(report)

### Accessing Data

Since the output is a named list, you can access specific tables using standard R list indexing:

# Access a specific table by name
recal_table <- report$RecalTable0

# Access by index
first_table <- report[[1]]

## Common Workflows

### Base Quality Score Recalibration (BQSR) Analysis
A common use case is analyzing the output of GATK's BaseRecalibrator.

library(gsalib)
library(ggplot2)

# Read the recalibration report
recal_data <- gsalib_read_gatkreport("recal_data.table")

# Extract the relevant table for plotting (e.g., Quality Score Recalibration)
qs_table <- recal_data$BaseRecal

# Plotting the data
ggplot(qs_table, aes(x = ReportedQuality, y = EmpiricalQuality)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  theme_minimal()

## Tips for Success

1. **File Format**: Ensure the file is a native GATK report format. `gsalib` is specifically written to parse the headers and table delimiters used by GATK tools.
2. **List Management**: Always check `names(report)` after loading, as GATK tools often output multiple tables with specific internal names that are required for correct indexing.
3. **Data Types**: `gsalib` attempts to preserve the data types (numeric, character) defined in the GATK report headers.

## Reference documentation

- [README](./references/README.html.md)
- [Home Page](./references/home_page.md)