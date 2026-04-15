---
name: bioconductor-isobar
description: This tool provides a framework for the statistical analysis and exploration of iTRAQ and TMT isobaric labeling proteomics data. Use when user asks to process MS/MS data, perform isotope impurity correction, normalize reporter ion intensities, fit noise models, or calculate protein and peptide ratios.
homepage: https://bioconductor.org/packages/release/bioc/html/isobar.html
---

# bioconductor-isobar

name: bioconductor-isobar
description: Analysis and exploration of iTRAQ and TMT isobaric labeling data. Use this skill to process MS/MS proteomics data, including data loading (MGF/ID.CSV), normalization, isotope impurity correction, noise modeling, and protein/peptide ratio calculation. It also supports PTM quantification and site localization (PhosphoRS/Delta Score).

## Overview

The `isobar` package provides a comprehensive framework for the statistical analysis of isobaric tagging data (iTRAQ and TMT). It uses S4 classes to manage qualitative identifications and quantitative reporter ion intensities. The workflow typically involves importing peak lists and identification files, correcting for technical noise, and estimating relative abundances with associated confidence measures.

## Core Workflow

### 1. Data Loading
The primary object is an `IBSpectra` object. You can create it from identification CSVs and MGF peak lists.

```R
library(isobar)

# Create IBSpectra object (e.g., iTRAQ 4-plex)
# Types: iTRAQ4plexSpectra, iTRAQ8plexSpectra, TMT2plexSpectra, TMT6plexSpectra, TMT10plexSpectra
ib <- readIBSpectra("iTRAQ4plexSpectra", 
                    id.file = "identifications.id.csv", 
                    peaklist.file = "peaklist.mgf")

# Access protein grouping information
pg <- proteinGroup(ib)
```

### 2. Pre-processing
Before analysis, data should be corrected for isotope impurities and normalized.

```R
# Isotope impurity correction (uses default or manufacturer-supplied matrices)
ib <- correctIsotopeImpurities(ib)

# Normalization (default: median intensities across channels)
ib <- normalize(ib)

# Visualize reporter mass precision
reporterMassPrecision(ib)
```

### 3. Noise Modeling
A `NoiseModel` accounts for intensity-dependent variation. It is best fitted on 1:1 background proteins.

```R
# Fit noise model on background (excluding spiked or regulated proteins)
# direction="exclude" removes specific proteins
ib.bg <- subsetIBSpectra(ib, protein = c("PROT1", "PROT2"), direction = "exclude")
nm <- NoiseModel(ib.bg)

# Plot noise model over an MA-plot
maplot(ib, noise.model = nm, channel1 = "114", channel2 = "115")
```

### 4. Ratio Calculation
Calculate ratios for proteins or specific peptides.

```R
# Estimate protein ratio (channel2/channel1)
# Returns log10 ratio by default
rat <- estimateRatio(ib, nm, channel1 = "114", channel2 = "115", protein = "P00450")
10^rat['lratio'] # Convert back to fold-change

# Calculate ratios for all proteins
prot.rats <- proteinRatios(ib, nm, cl = c("1", "0", "0", "0"))
```

## PTM Analysis

`isobar` supports Post-Translational Modification (PTM) quantification and site localization.

- **Localization**: Use `filterSpectraDeltaScore` or `filterSpectraPhosphoRS` during data import via the `annotate.spectra.f` argument in `readIBSpectra`.
- **Peptide Ratios**: Use `estimateRatio` with the `peptide` argument instead of `protein`.
- **Normalization**: Correct PTM peptide ratios against global protein expression changes using the `correct.ratio` parameter in `estimateRatio`.

## Automated Reporting

The package includes scripts for generating PDF (Quality Control) and Excel (Analysis) reports.

```R
# Generate standard reports
create.reports(type = "iTRAQ4plexSpectra", 
               identifications = "my.id.csv", 
               peaklist = "my.mgf")
```

## Reference documentation

- [isobar for developers](./references/isobar-devel.md)
- [isobar for quantification of PTM datasets](./references/isobar-ptm.md)
- [Usecases for the isobar package](./references/isobar-usecases.md)
- [isobar package for iTRAQ and TMT protein quantification](./references/isobar.md)