---
name: bioconductor-spikeli
description: bioconductor-spikeli performs physical-chemistry based analysis of Affymetrix spike-in data using the Langmuir Isotherm model. Use when user asks to analyze intensity versus concentration, visualize intensity versus free energy, or perform data collapse to identify outliers in hybridization kinetics.
homepage: https://bioconductor.org/packages/release/bioc/html/spikeLI.html
---


# bioconductor-spikeli

## Overview
The `spikeLI` package provides tools for the physical-chemistry based analysis of Affymetrix spike-in (Latin square) data. Unlike traditional statistical normalization, it uses the Langmuir Isotherm model to relate fluorescent intensity to target concentration and hybridization free energy ($\Delta G$). It accounts for both Perfect Match (PM) and Mismatch (MM) probes, and includes a refined model for hybridization in solution (the $\alpha$ factor).

## Loading the Package and Data
To use the package, you must load it along with the `stats` library for non-linear fitting.

```r
library(spikeLI)
library(stats)

# Available spike-in probe set vectors:
# SPIKE_IN (All HGU133), SPIKE_INH (Human), SPIKE_INA (Artificial), 
# SPIKE_INB (Bacterial), SPIKE_IN95 (HGU95)

# Concentration vectors:
# conc133, conc95
```

## Core Functions and Workflows

### 1. Intensity vs. Concentration: `Ivsc()`
Use this to visualize how a specific probe's intensity changes across the spike-in concentration gradient. It performs a 3-parameter non-linear fit.

```r
# Plot intensity vs concentration for probe 1 of a specific set
Ivsc("37777_at", probe = 1)

# If probe is omitted, it defaults to 1
Ivsc(SPIKE_IN95[1])
```
**Interpretation:** The output displays $I_{max}$ (asymptotic intensity), representing the saturation limit of the probe.

### 2. Intensity vs. Free Energy: `IvsDG()`
Use this to analyze probe behavior at a fixed concentration across different binding affinities.

```r
# Plot for a specific probe set at 128 pM
IvsDG("AFFX-r2-TagE_at", 128)

# Loop through all concentrations for a probe set
for(i in 2:length(conc133)) {
  IvsDG(SPIKE_IN[1], conc133[i])
}
```
**Interpretation:** 
- **Left Plot:** PM and MM intensities vs. probe number (background subtracted).
- **Right Plot:** Intensities vs. $z = \Delta G - RT \log \alpha$. 
- Points falling outside the dashed lines (representing 4x concentration variance) are potential outliers.

### 3. Data Collapse: `collapse()`
This is the primary diagnostic tool. It rescales data from different concentrations and probes into a single curve based on the Langmuir model.

```r
# Visualize up to 4 probe sets simultaneously
collapse(SPIKE_INA[1:4])

# Compare basic Langmuir vs. Hybridization-in-solution model for one set
collapse("1091_at")
```
**Interpretation:** 
- The x-axis uses the rescaled variable $x' = \alpha c e^{\beta \Delta G}$.
- In a perfect model, all points should "collapse" onto the curve $Ax'/(1+x')$.
- Significant deviations indicate probes that do not follow standard hybridization kinetics (outliers).

## Data Structures
- **Free Energies:** Calculated using the nearest neighbor model for RNA/DNA hybrids.
- **Alpha ($\alpha$):** A sequence-dependent factor (0 to 1) representing the reduction of available target due to target-target hybridization in solution.

## Reference documentation
- [SpikeLI: Analysis of Affymetrix Spike-in data with Langmuir Isotherms](./references/spikeLI.md)