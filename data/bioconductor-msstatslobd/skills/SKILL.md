---
name: bioconductor-msstatslobd
description: MSstatsLOBD calculates the Limit of Blank and Limit of Detection for mass spectrometry proteomics data using linear and non-linear regression models. Use when user asks to calculate LOB and LOD, estimate detection limits from spike-in experiments, or visualize quantification limits.
homepage: https://bioconductor.org/packages/release/bioc/html/MSstatsLOBD.html
---


# bioconductor-msstatslobd

## Overview

The `MSstatsLOBD` package provides tools to calculate the Limit of Blank (LOB) and Limit of Detection (LOD) from spike-in experiments. It is particularly useful for mass spectrometry-based proteomics where the relationship between spiked concentration and measured intensity may be non-linear at low concentrations (e.g., leveling off due to noise). The package supports both standard linear regression and an "elbow" non-linear regression model to better capture the detection threshold.

## Core Workflow

### 1. Data Preparation and Normalization

The input data must be a data frame containing columns for concentration, intensity, peptide name, and replicate. A common workflow involves normalizing light peptide intensities against heavy (reference) peptides.

```r
library(MSstatsLOBD)
library(dplyr)

# Example normalization workflow
# 1. Sum fragment areas and log transform
df_summed <- raw_data %>%
  group_by(Peptide.Sequence, Replicate, Concentration) %>%
  summarize(A_light = sum(light.Area), A_heavy = sum(heavy.Area)) %>%
  mutate(log2light = log2(A_light), log2heavy = log2(A_heavy))

# 2. Normalize light area based on heavy median
df_norm <- df_summed %>%
  group_by(Peptide.Sequence) %>%
  mutate(medianlog2heavy = median(log2heavy),
         log2light_norm = log2light + (medianlog2heavy - log2heavy),
         A_light_norm = 2^log2light_norm)

# 3. Format for MSstatsLOBD
df_input <- df_norm %>%
  ungroup() %>%
  select(INTENSITY = A_light_norm, 
         CONCENTRATION = Concentration, 
         NAME = Peptide.Sequence, 
         REPLICATE = Replicate)
```

### 2. Estimating LOB and LOD

The package provides two main functions for estimation. `nonlinear_quantlim` is generally preferred as it automatically adapts to either linear or "elbow" (threshold) behaviors.

**Non-linear Estimation (Recommended):**
```r
# Filter for a specific peptide
peptide_data <- df_input %>% filter(NAME == "PEPTIDE_SEQUENCE")

# Run non-linear estimation
quant_out <- nonlinear_quantlim(peptide_data)

# View results (LOB and LOD are columns in the output)
head(quant_out)
```

**Linear Estimation:**
```r
# Use if you assume a strictly linear response across all concentrations
quant_out_lin <- linear_quantlim(peptide_data)
```

### 3. Visualization

Use `plot_quantlim` to visualize the fit, the prediction intervals, and the calculated LOB/LOD intersections.

```r
# address = FALSE displays the plot in the R session
plot_quantlim(spikeindata = peptide_data, 
              quantlim_out = quant_out, 
              address = FALSE)
```

## Key Functions

- `nonlinear_quantlim(data, alpha = 0.05, beta = 0.05, Npoints = 100)`: Fits a non-linear model. `alpha` is the probability of false positive (LOB); `beta` is the probability of false negative at LOD.
- `linear_quantlim(data, alpha = 0.05, beta = 0.05)`: Fits a standard linear model.
- `plot_quantlim(...)`: Generates diagnostic plots showing the MEAN fit (red), LOW/UP prediction intervals (orange/red shade), and the noise threshold (blue).

## Tips for Success

- **Blank Samples:** Ensure your dataset includes "0" concentration samples (blanks) to accurately estimate the noise distribution.
- **Discretization:** If the fit looks "jagged" in plots, increase the `Npoints` parameter in `nonlinear_quantlim` for a smoother discretization of the concentration axis.
- **Column Names:** The package is strict about input column names. Ensure your data frame has `INTENSITY`, `CONCENTRATION`, `NAME`, and `REPLICATE`.
- **Interpretation:** 
  - **LOB:** The highest apparent concentration expected in a blank sample.
  - **LOD:** The concentration where we can reliably distinguish the signal from the blank.

## Reference documentation

- [LOB/LOD Estimation Workflow](./references/MSstatsLOBD_workflow.md)
- [LOB/LOD Estimation Workflow (Rmd Source)](./references/MSstatsLOBD_workflow.Rmd)