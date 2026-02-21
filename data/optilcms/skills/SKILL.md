---
name: optilcms
description: OptiLCMS is a specialized R package that provides an optimized workflow for Liquid Chromatography-Mass Spectrometry (LC-MS) raw data processing.
homepage: https://github.com/xia-lab/OptiLCMS
---

# optilcms

## Overview
OptiLCMS is a specialized R package that provides an optimized workflow for Liquid Chromatography-Mass Spectrometry (LC-MS) raw data processing. It functions as the underlying engine for the "MS Spectral Processing" module of MetaboAnalyst, allowing researchers to perform peak detection, retention time correction, and feature alignment with parameters tailored to their specific instrumentation and sample types. It is particularly useful for transitioning from web-based analysis to local, reproducible R workflows.

## Installation and Setup
OptiLCMS can be installed via Conda or directly from GitHub within an R environment.

**Conda Installation:**
```bash
conda install bioconda::optilcms
```

**R Installation (Development Version):**
```R
# Requires devtools
devtools::install_github("xia-lab/OptiLCMS", build = TRUE, build_vignettes = FALSE, build_manual = TRUE)
```

## Core Workflow Patterns
The package is typically used within an R script to process raw spectra files (e.g., .mzXML, .mzML).

### 1. Data Initialization
Initialize the data objects to define the analysis type and prepare the environment for spectral processing.
```R
# Typical initialization pattern
mSet <- InitDataObjects("raw", "spec", FALSE)
```

### 2. Parameter Optimization
The primary advantage of OptiLCMS is its ability to automate the selection of optimal processing parameters (e.g., ppm, peak width, signal-to-noise threshold), which are traditionally difficult to tune manually in XCMS-based workflows.
- Use the optimization functions to generate a Design of Experiments (DoE) to identify the best settings for your specific instrument (Agilent, Thermo, Waters, etc.).

### 3. Processing Modes
OptiLCMS supports various MS acquisition strategies:
- **DDA (Data-Dependent Acquisition):** Standard workflow for untargeted metabolomics.
- **DIA (Data-Independent Acquisition):** Specialized handling for DIA data, including fixes for empty scans and deconvolution.
- **Direct Infusion:** Support for processing raw data without a liquid chromatography step.
- **Exposome Exploration:** Specific updates support large-scale datasets typical in exposomics.

## Expert Tips
- **MetaboAnalystR Integration:** OptiLCMS is an optional but recommended dependency for `MetaboAnalystR`. Use it to perform the "Raw Spectral Processing" step before moving into statistical analysis.
- **Asari Compatibility:** The package includes support for `asari` results, allowing users to leverage asari's feature detection within the OptiLCMS framework.
- **Memory Management:** For large-scale datasets, ensure your environment (especially on macOS or clusters) is configured to handle the memory-intensive C++ backends used for ROI (Region of Interest) extraction.
- **Result Exporting:** Use the built-in formatting functions to ensure peak tables are compatible with downstream MetaboAnalyst modules, avoiding "0 result" errors or NA issues during export.

## Reference documentation
- [OptiLCMS GitHub Repository](./references/github_com_xia-lab_OptiLCMS.md)
- [Bioconda OptiLCMS Overview](./references/anaconda_org_channels_bioconda_packages_optilcms_overview.md)