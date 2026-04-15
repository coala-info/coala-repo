---
name: mzquality
description: mzquality monitors and reports the quality of mass spectrometry measurements in metabolomics studies by transforming raw data into standardized objects for automated analysis. Use when user asks to monitor data quality, perform batch correction using quality control samples, detect outliers, or filter unreliable compounds and samples.
homepage: https://github.com/hankemeierlab/mzQuality
metadata:
  docker_image: "biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15"
---

# mzquality

## Overview

mzquality is a specialized R package designed to monitor and report the quality of mass spectrometry measurements in metabolomics studies. It transforms raw data into a Bioconductor `SummarizedExperiment` object, providing a standardized framework for outlier detection, batch correction using pooled study quality control (SQC) samples, and filtering of unreliable compounds. The tool automates complex metrics such as matrix effect calculations, background signal percentages, and internal standard suggestions to ensure data integrity before downstream statistical analysis.

## Core Workflow

The standard mzquality workflow follows a three-step process: data ingestion, experiment construction, and automated analysis.

### 1. Data Ingestion and Validation
Use `readData()` to import tab-delimited text files. This function automatically validates the presence of mandatory columns required for quality metrics.

```r
library(mzQuality)
# Path to your tab-delimited data
path <- "path/to/your_data.tsv"
raw_data <- readData(path)
```

### 2. Building the Experiment
Convert the validated data into a `SummarizedExperiment` object, which serves as the primary data structure for all subsequent calculations.

```r
exp <- buildExperiment(raw_data)
```

### 3. Executing Quality Analysis
The `doAnalysis()` function is a comprehensive wrapper that performs the following operations:
* Calculates compound-to-internal standard ratios.
* Performs batch correction via pooled SQC samples.
* Determines background signal percentages and matrix effects.
* Identifies statistical outliers in QC samples using the Rosner Test.
* Suggests optimal Internal Standards.

```r
# Run the full suite of quality metrics
exp <- doAnalysis(exp = exp)
```

## Expert Tips and Best Practices

### Filtering Unreliable Data
mzquality does not automatically delete data; instead, it flags it. After running `doAnalysis()`, check the `use` column in both `rowData` (for compounds) and `colData` (for samples).
* **Compounds**: Flagged based on RSDQC, background signal, and presence in QC samples.
* **Samples**: Flagged based on the Rosner Test for statistical outliers.

```r
# Filter for high-quality compounds and samples
clean_exp <- exp[rowData(exp)$use == "TRUE", colData(exp)$use == "TRUE"]
```

### Handling Calibration Lines
If your input data includes known concentrations for calibration, `doAnalysis()` will automatically calculate concentrations and R² values. Ensure your input file follows the specific schema for calibration levels defined in the package vignettes.

### Batch Correction
The tool uses pooled SQC samples to correct for analytical drift. For optimal results, ensure that SQC samples are interspersed regularly throughout your injection sequence and correctly labeled in your input data.



## Subcommands

| Command | Description |
|---------|-------------|
| qcli.py | CLI to the mzQuality |
| qcli.py | CLI to the mzQuality |
| qcli.py | CLI to the mzQuality |
| qcli.py | CLI to the mzQuality |
| qcli.py | CLI to the mzQuality |
| qcli.py | CLI to the mzQuality |
| qcli.py | CLI to the mzQuality |
| qcli.py | CLI to the mzQuality |
| qcli.py | CLI to the mzQuality |

## Reference documentation
- [mzQuality README](./references/github_com_hankemeierlab_mzQuality_blob_main_README.md)
- [mzQuality Description](./references/github_com_hankemeierlab_mzQuality_blob_main_DESCRIPTION.md)