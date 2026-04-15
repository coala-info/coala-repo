---
name: r-mfassignr
description: MFAssignR provides expert guidance for assigning multi-element molecular formulas to ultrahigh resolution mass spectrometry data using the MFAssignR R package. Use when user asks to estimate noise levels, perform internal mass recalibration, filter isotopes, or assign molecular formulas to complex environmental mixtures.
homepage: https://cran.r-project.org/web/packages/mfassignr/index.html
---

# r-mfassignr

name: r-mfassignr
description: Expert guidance for using the MFAssignR R package for multi-element molecular formula (MF) assignment of ultrahigh resolution mass spectrometry data. Use this skill when performing internal mass recalibration, signal-to-noise evaluation, isotope filtering, and formula assignment for complex environmental mixtures (e.g., NOM, LC-MS data).

## Overview

MFAssignR is a specialized R package for assigning molecular formulas to ultrahigh resolution mass spectrometry measurements. It utilizes a de novo assignment approach combined with Kendrick Mass Defect (KMD) analysis and formula extensions (CH2, O, H2, etc.) to provide high-confidence assignments for complex mixtures. Key features include internal recalibration, noise assessment, and isotope filtering for 13C and 34S.

## Installation

Install the package from CRAN:

```R
install.packages("MFAssignR")
library(MFAssignR)
```

## Recommended Workflow

For optimal results, follow this sequential order of operations:

1.  **Noise Assessment**: Use `KMDNoise()` or `HistNoise()` to determine the noise level.
2.  **S/N Verification**: Use `SNplot()` to visualize the threshold and ensure analyte signal is separated from noise.
3.  **Isotope Filtering**: Run `IsoFiltR()` to identify potential 13C and 34S isotopes to prevent incorrect monoisotopic assignments.
4.  **Preliminary Assignment**: Run `MFAssignCHO()` on the filtered data to assess initial mass accuracy.
5.  **Recalibration List**: Use `RecalList()` to identify potential recalibrant CH2 homologous series.
6.  **Internal Recalibration**: Use `Recal()` with selected series to perform a "walking" recalibration across the spectrum.
7.  **Final Assignment**: Use `MFAssign()` on the recalibrated list for multi-element assignment (C, H, O, N, S, P, Cl, Br, F, I).

## Key Functions

### Molecular Formula Assignment
- `MFAssign()`: The primary function for multi-element assignment. Supports isotopes and heteroatoms.
- `MFAssignCHO()`: A faster, simplified version for CHO-only assignments, ideal for preliminary checks.
- `MFAssign_RMD()` / `MFAssignCHO_RMD()`: Variants optimized for use within R Markdown files.

### Noise and Signal Evaluation
- `KMDNoise()`: Estimates noise using a mass-dependent KMD region (recommended for Orbitrap/FT-ICR data).
- `HistNoise()`: Estimates noise based on the histogram distribution of natural log intensities.
- `SNplot()`: Generates a mass spectrum plot coloring noise (red) and signal (blue).

### Recalibration
- `RecalList()`: Generates a dataframe of potential recalibrant series. Look for high "Number Observed" and "Series Score".
- `Recal()`: Applies a polynomial central moving average to recalibrate ion masses in segments.

### Isotope Handling
- `IsoFiltR()`: Uses a four-step method (mass difference, KMD, resolution-enhanced KMD, and abundance ratios) to flag 13C and 34S pairs.

## Usage Tips

- **DeNovo Cutoff**: In `MFAssign()`, the `DeNovo` parameter (default e.g., 300 m/z) determines the threshold below which formulas are assigned directly and above which they are assigned via extensions.
- **Ambiguity**: Set `Ambig = "on"` to retain all chemically reasonable assignments for a mass, or `"off"` to prioritize based on path frequency.
- **MSMS Mode**: Use the `MSMS` parameter for non-continuous data (like fragmentation spectra) to assign all ions directly without pre-filtering.
- **Quality Assurance**: Customize parameters like `DBE-O` limits, `O/C` and `H/C` ratios, and `HetCut` to refine the chemical reasonableness of the output.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)