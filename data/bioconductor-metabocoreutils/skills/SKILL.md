---
name: bioconductor-metabocoreutils
description: This package provides core utility functions for metabolomics data processing and mass spectrometry analysis. Use when user asks to convert between masses and m/z values, manipulate chemical formulas, calculate Kendrick mass defects, perform retention time indexing, or correct signal drift in feature abundances.
homepage: https://bioconductor.org/packages/release/bioc/html/MetaboCoreUtils.html
---

# bioconductor-metabocoreutils

name: bioconductor-metabocoreutils
description: Core metabolomics utility functions for mass spectrometry data. Use this skill for converting between compound masses and m/z values, standardizing chemical formulas, calculating Kendrick mass defects, performing retention time indexing, and adjusting feature abundances using linear models.

## Overview
The `MetaboCoreUtils` package provides low-level, data-structure-independent functions for metabolomics. It is a foundational component of the `RforMassSpectrometry` ecosystem, offering tools for mass arithmetic, formula manipulation, and data quality assessment.

## Core Workflows

### Mass and m/z Conversion
Convert between exact compound masses and adduct-specific mass-to-charge ratios (m/z).

```r
library(MetaboCoreUtils)

# List available ESI adducts
adductNames()

# Compound mass to m/z
masses <- c(180.0634, 194.0804)
mass2mz(masses, adduct = c("[M+H]+", "[M+Na]+"))

# Chemical formula to m/z
formula2mz(c("C6H12O6", "C8H10N4O2"), adduct = "[M+H]+")

# Reverse: m/z to mass
mz2mass(181.0707, adduct = "[M+H]+")
```

### Chemical Formula Manipulation
Standardize, combine, or modify chemical formulas.

```r
# Standardize (Hill notation)
standardizeFormula("Na3C4") # Returns "C4Na3"

# Add/Subtract elements
f <- addElements("C6H12O6", "H2O")
f <- subtractElements(f, "H")

# Calculate exact mass (supports isotopes)
calculateMass(c("C6H12O6", "[13C3]C3H12O6"))

# Create adduct formulas
adductFormula("C6H12O6", "[M+Na]+")
```

### Kendrick Mass Defect (KMD)
Identify homologous series (e.g., lipids with different chain lengths).

```r
lipid_masses <- c(760.5851, 762.6007)
calculateKmd(lipid_masses)
rkmd <- calculateRkmd(lipid_masses)
isRkmd(rkmd) # Check if fits expected range
```

### Retention Time Indexing
Convert retention times (RT) to retention indices (RI) for better comparability across systems.

```r
# rti_map: data.frame with 'rtime' and 'rindex' of standards
# query_rtime: vector of measured RTs
rindex <- indexRtime(query_rtime, rti_map)

# Two-point correction of RI using reference standards
ref <- data.frame(rindex = c(1709.8, 553.8), refindex = c(1700, 550))
corrected_ri <- correctRindex(rindex, ref)
```

### Signal Drift Adjustment
Model and correct injection-order dependent signal drift using Quality Control (QC) samples.

```r
# 1. Fit models on QC samples (log2 scale)
# sdata: data.frame with 'injection_index'
# vals: matrix of abundances (features in rows)
qc_lm <- fit_lm(y ~ injection_index, 
                data = sdata[qc_index, ], 
                y = log2(vals[, qc_index]))

# 2. Filter models (e.g., keep only significant drifts)
qc_lm[p_values > 0.05] <- NA

# 3. Adjust all data
vals_adj <- adjust_lm(log2(vals), data = sdata, lm = qc_lm)
vals_adj <- 2^vals_adj
```

### Quality Assessment Metrics
Calculate row-wise statistics for filtering features.

```r
# Coefficient of Variation (Relative Standard Deviation)
rowRsd(metabolomics_data)

# D-ratio (dispersion in QC vs biological samples)
rowDratio(metabolomics_data, qc_samples)

# Missing value percentage
rowPercentMissing(metabolomics_data)

# Blank contamination detection (mean test > 2 * mean blank)
rowBlank(metabolomics_data, blank_samples)
```

## Tips and Best Practices
- **Isotopes**: Use square brackets for isotopes in formulas, e.g., `[13C3]C3H12O6` or `[2H]`.
- **Matrix Input**: Most `row*` functions expect a matrix where rows are features and columns are samples.
- **Linear Models**: Always visually inspect a few features before and after `adjust_lm` to ensure the drift correction is appropriate and not driven by outliers.
- **Adducts**: Use `adducts()` to see the full data frame of adduct definitions including charge and mass offsets.

## Reference documentation
- [Core Utils for Metabolomics Data](./references/MetaboCoreUtils.md)
- [MetaboCoreUtils Vignette Source](./references/MetaboCoreUtils.Rmd)