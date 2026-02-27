---
name: bioconductor-seahtrue
description: This tool analyzes Agilent Seahorse Extracellular Flux data by transforming Excel exports into tidy data structures for metabolic flux analysis. Use when user asks to read Seahorse Excel files, extract OCR and ECAR rate data, access raw sensor measurements, or validate experimental metadata.
homepage: https://bioconductor.org/packages/release/bioc/html/seahtrue.html
---


# bioconductor-seahtrue

name: bioconductor-seahtrue
description: Specialized for analyzing Agilent Seahorse Extracellular Flux (XF) data using the seahtrue R package. Use this skill to read, preprocess, and validate Seahorse Excel files (.xlsx), extract tidy rate and raw data, and access experimental metadata for reproducible metabolic flux analysis.

# bioconductor-seahtrue

## Overview
The `seahtrue` package provides a robust framework for the reproducible analysis of extracellular flux data (e.g., Seahorse XF). It transforms complex Excel exports into organized, tidy nested tibbles. This skill enables the extraction of Oxygen Consumption Rate (OCR), Extracellular Acidification Rate (ECAR), and raw sensor data while ensuring data integrity through built-in validation rules.

## Main Functions and Workflows

### 1. Reading and Preprocessing Data
The primary entry point is `revive_xfplate()`. This function reads the Seahorse Excel file, identifies the plate ID, determines if background correction was applied, and validates the data structure.

```r
library(seahtrue)
library(tidyverse)

# Load a Seahorse Excel file
xf_data <- seahtrue::revive_xfplate("path/to/your/seahorse_file.xlsx")

# Inspect the nested structure
glimpse(xf_data)
```

### 2. Accessing Rate Data
The `rate_data` column contains the calculated OCR and ECAR values. Use `purrr::pluck()` to extract the data for analysis.

```r
# Extract rate data
rates <- xf_data %>% purrr::pluck("rate_data", 1)

# Key columns:
# - OCR_wave_bc: Background-corrected Oxygen Consumption Rate
# - ECAR_wave_bc: Background-corrected Extracellular Acidification Rate
# - well, measurement, group, injection: Experimental identifiers
```

### 3. Accessing Raw Data
For quality control and detailed sensor analysis, access the `raw_data` column. This includes timescale information and corrected emission values for O2 and pH.

```r
# Extract raw sensor data
raw <- xf_data %>% purrr::pluck("raw_data", 1)
```

### 4. Experimental Metadata
Metadata is stored in `assay_info` and `injection_info`. This includes cartridge barcodes, calibration constants (KSV, F0), and the timing of injections (e.g., Oligomycin, FCCP).

```r
# Check injection sequence
injections <- xf_data %>% purrr::pluck("injection_info", 1)

# Check assay metadata (e.g., time to start measurement)
assay_meta <- xf_data %>% purrr::pluck("assay_info", 1)
start_time <- assay_meta$minutes_to_start_measurement_one
```

## Tips for Analysis
- **Background Correction**: `seahtrue` automatically detects if the input Excel file was exported with background correction. It provides `OCR_wave_bc` and `ECAR_wave_bc` to ensure you are always working with corrected values regardless of the export settings.
- **Validation**: The `validation_output` column contains logical flags and detailed reports on whether the data meets expected quality standards.
- **Tidy Integration**: The output is a `tibble`, making it natively compatible with `ggplot2` for plotting and `dplyr` for filtering or summarizing by experimental group.

## Reference documentation
- [Introduction to Seahtrue](./references/seahtrue.md)