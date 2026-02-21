---
name: bioconductor-flowqb
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/flowQB.html
---

# bioconductor-flowqb

name: bioconductor-flowqb
description: Automated quadratic characterization of flow cytometer instrument sensitivity. Use this skill to calculate detection efficiency (Q), background illumination (B), and intrinsic CV (CV0) using LED pulses or multi-level bead sets (e.g., Spherotech Sph8, Thermo Fisher 6-level).

# bioconductor-flowqb

## Overview

The `flowQB` package provides a standardized framework for characterizing flow cytometer sensitivity. It uses a weighted quadratic least squares model ($V = c_0 + c_1M + c_2M^2$) to relate signal means ($M$) and variances ($V$). This allows for the calculation of:
- **Q (Detection Efficiency):** Statistical photoelectrons (Spe) per intensity unit.
- **B (Background):** Effective background level in Spe.
- **CV0:** Intrinsic non-statistical variability of beads.

## Core Workflow

### 1. Characterizing with LED Data
LED data is typically provided as a series of FCS files, each representing a different intensity level.

```r
library(flowQB)

# Define file paths
fcs_files <- list.files("path/to/led_series", "*.fcs", full.names = TRUE)

# Configure parameters
ignore <- c("Time", "FSC-A", "SSC-A")
dyes <- c("FITC", "PE", "APC")
detectors <- c("FITC-A", "PE-A", "APC-A")

# Run fitting
led_results <- fit_led(
  fcs_file_path_list = fcs_files,
  ignore_channels = ignore,
  dyes = dyes,
  detectors = detectors,
  signal_type = "Area",
  bounds = list(minimum = -100, maximum = 100000)
)

# Extract Q and B
qb_stats <- qb_from_fits(led_results$iterated_dye_fits)
```

### 2. Characterizing with Multi-level Beads
Bead sets (mixture of populations) are usually contained within a single FCS file. The package uses K-means clustering on Logicle-transformed data to identify peaks.

```r
# For Spherotech 8-peak beads
bead_results <- fit_spherotech(
  fcs_file_path = "path/to/bead_file.fcs",
  scatter_channels = c("FSC-A", "SSC-A"),
  dyes = dyes,
  detectors = detectors
)

# For Thermo Fisher 6-level beads
tf_results <- fit_thermo_fisher(fcs_file_path, scatter_channels, dyes, detectors)

# For custom bead sets
custom_results <- fit_beads(fcs_file_path, scatter_channels, N_peaks = 8, dyes, detectors)
```

## Key Functions

- `fit_led()`: Fits quadratic and linear models to LED pulse series.
- `fit_spherotech()` / `fit_thermo_fisher()`: Specialized wrappers for common bead sets.
- `fit_beads()`: General function for multi-peak bead data using K-means clustering.
- `qb_from_fits()`: Converts model coefficients ($c_0, c_1, c_2$) into physical parameters ($Q, B, CV_0^2$).
- `plot()`: Use on `transformed_data` within results to verify K-means clustering quality.

## Interpretation of Results

- **Peak Stats:** Check `results$peak_stats` to see if specific peaks were omitted (`Omit == TRUE`) due to being outside `bounds` or having excessive CV.
- **Model Selection:** For LED data, if the quadratic term $c_2$ is near zero, the linear fit (`l_QI`) is often more robust. For beads, always use the quadratic fit (`q_QI`) to account for $CV_0$.
- **Convergence:** Review `results$iteration_numbers` to ensure the weighted fit converged within the `max_iterations` (default 10).

## Reference documentation

- [flowQB – Automated Quadratic Characterization of Flow Cytometer Instrument Sensitivity](./references/flowQBVignettes.md)