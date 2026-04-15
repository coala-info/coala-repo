---
name: bioconductor-isanalytics
description: ISAnalytics analyzes genomic insertion site data to track clonal evolution in gene therapy studies. Use when user asks to import VISPA2 data, perform collision removal, aggregate integration site values, or analyze clonal sharing and abundance.
homepage: https://bioconductor.org/packages/release/bioc/html/ISAnalytics.html
---

# bioconductor-isanalytics

## Overview
ISAnalytics is designed for the analysis of genomic insertion sites (IS) data, typically generated in gene therapy studies to track clonal evolution. It provides a robust framework for importing data from the VISPA2 pipeline, managing metadata (association files), performing data cleaning (recalibration, collision removal), and answering biological questions through statistical analysis and visualization.

## Core Workflow

### 1. Initialization and Configuration
The package uses a "dynamic variables" system to handle different input formats.
```r
library(ISAnalytics)

# Check current configuration
mandatory_IS_vars()
association_file_columns()

# Enable progress bars and reports
enable_progress_bars()
options("ISAnalytics.reports" = TRUE)
```

### 2. Data Import
Import metadata (Association File) and quantification matrices.
```r
# Import metadata with file system alignment
af <- import_association_file("path/to/af.tsv", root = "path/to/data", report_path = "reports")

# Import matrices (automated for VISPA2 structures)
matrices <- import_parallel_Vispa2Matrices(af, 
                                           quantification_type = c("seqCount", "fragmentEstimate"),
                                           mode = "AUTO")
```

### 3. Data Cleaning
Address common sequencing artifacts like collisions (same IS in different independent samples).
```r
# Remove collisions using sequence counts
cleaned_data <- remove_collisions(x = matrices, 
                                  association_file = af, 
                                  report_path = "reports")
```

### 4. Aggregation
Combine replicates or group data by biological metadata (e.g., Subject, Tissue, TimePoint).
```r
# Aggregate metadata
agg_meta <- aggregate_metadata(af, grouping_keys = c("SubjectID", "Tissue"))

# Aggregate IS values
agg_values <- aggregate_values_by_key(cleaned_data, 
                                      af, 
                                      key = c("SubjectID", "Tissue"),
                                      value_cols = c("seqCount_sum", "fragmentEstimate_sum"))
```

### 5. Biological Analysis
Perform clonal sharing, abundance, and diversity analyses.
```r
# Compute IS abundance
abundance <- compute_abundance(agg_values, columns = "seqCount_sum")

# Analyze sharing between groups
sharing <- is_sharing(agg_values, group_key = c("SubjectID", "Tissue"))

# Visualization
sharing_heatmap(sharing)
integration_alluvial_plot(agg_values)
```

## Key Functions Reference
- `import_association_file()`: Loads metadata and validates the file system.
- `import_parallel_Vispa2Matrices()`: Efficiently loads multiple quantification files.
- `remove_collisions()`: Filters or reassigns IS found in multiple independent samples based on dates or read ratios.
- `compute_near_integrations()`: Recalibrates IS coordinates to condense near-miss events.
- `is_sharing()`: Calculates the intersection of IS sets across different metadata groups.
- `sample_statistics()`: Generates descriptive stats (Shannon entropy, Gini, etc.).
- `NGSdataExplorer()`: Launches a Shiny app for interactive data exploration.

## Tips for Success
- **Tags**: Use `inspect_tags()` to understand which metadata columns are required for specific functions.
- **Tidy Data**: The package prefers "long" (tidy) formats for matrices. If using custom data, ensure columns for `chr`, `integration_locus`, and `strand` are correctly mapped via `set_mandatory_IS_vars()`.
- **Reports**: Always check the HTML reports generated during import and collision removal; they highlight parsing errors and data loss.

## Reference documentation
- [Getting started with ISAnalytics](./references/ISAnalytics.md)
- [Setting up the workflow and first steps](./references/workflow_start.md)