---
name: bioconductor-lobstahs
description: This tool identifies lipid and oxylipin biomarkers in high-resolution HPLC-MS data using adduct hierarchy sequences. Use when user asks to screen mass spectrometry data for lipids, generate custom lipid databases, or identify isomers and isobars in lipidomics datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/LOBSTAHS.html
---

# bioconductor-lobstahs

name: bioconductor-lobstahs
description: Comprehensive lipidomics workflow for discovery and identification of lipid and oxylipin biomarkers in HPLC-MS data. Use when Claude needs to process high-resolution mass spectrometry data using the LOBSTAHS R package, including database generation, adduct-based screening, and isomer/isobar identification.

# bioconductor-lobstahs

## Overview

LOBSTAHS (Lipid and Oxylipin Biomarker Screening through Adduct Hierarchy Sequences) is an R package for the discovery and identification of lipids and oxidized lipids in HPLC-MS datasets. It operates on data pre-processed with `xcms` and `CAMERA`. LOBSTAHS uses exact mass matching against customizable databases followed by orthogonal screening criteria—including adduct ion hierarchy rules, retention time windows, and fatty acid structural constraints—to refine compound assignments.

## Typical Workflow

### 1. Pre-processing (xcms and CAMERA)
LOBSTAHS requires an `xsAnnotate` object as input. Data must be converted to .mzXML (centroid mode) and processed through `xcms` (feature detection, alignment) and `CAMERA` (pseudospectra construction).

```R
library(xcms)
library(CAMERA)
library(LOBSTAHS)

# Create xsAnnotate object (example using CAMERA)
# Note: Ensure quick = FALSE to run groupCorr for better pseudospectra
xsA <- annotate(xcmsSet_object, quick = FALSE, polarity = "positive")
```

### 2. Database Management
LOBSTAHS uses `LOBdbase` objects. You can use the default databases or generate custom ones using `generateLOBdbase`.

```R
# Access default databases
data(default.LOBdbase)
pos_db <- default.LOBdbase$positive
neg_db <- default.LOBdbase$negative

# Generate a custom database from CSV tables
my_db <- generateLOBdbase(polarity = "positive", 
                          component.defs = "my_components.csv",
                          AIH.defs = "my_adducts.csv")
```

### 3. Screening with doLOBscreen
The core function `doLOBscreen` applies identification and screening rules to the `xsAnnotate` object.

```R
# Perform screening
myLOBSet <- doLOBscreen(xsA, 
                        polarity = "positive",
                        database = NULL, # Uses default if NULL
                        match.ppm = 2.5,
                        retain.unidentified = TRUE,
                        rt.restrict = TRUE,
                        exclude.oddFA = TRUE)
```

Key parameters:
- `match.ppm`: Mass spectrometer accuracy tolerance.
- `rt.restrict`: If TRUE, validates assignments against expected retention time windows.
- `exclude.oddFA`: If TRUE, removes assignments with odd-numbered fatty acid carbons (useful for eukaryotic samples).
- `remove.iso`: If TRUE, removes secondary isotope peaks identified by CAMERA.

### 4. Diagnostics and Results
Evaluate the screening performance and extract the final peak list.

```R
# View screening diagnostics
LOBscreen_diagnostics(myLOBSet)

# View isomer/isobar identification diagnostics
LOBisoID_diagnostics(myLOBSet)

# Extract results to a data frame and CSV
peaklist <- getLOBpeaklist(myLOBSet, gen.csv = TRUE, include.unidentified = TRUE)
```

## Customization Tips

- **Retention Time Windows**: If using custom chromatography, provide a custom `rt.windows` table to `doLOBscreen`. LOBSTAHS expands these windows by 10% to account for alignment shifts.
- **Database Customization**: To add new lipid classes, modify the four input tables: `componentCompTable` (base fragments), `acylRanges` (carbon/double bond limits), `oxyRanges` (oxidation states), and `adductHierarchies` (empirical adduct patterns).
- **Isomers/Isobars**: LOBSTAHS annotates regioisomers (C3r), functional/structural isomers (C3f), and isobars (C3c) in the final output.

## Reference documentation

- [Discovery, Identification, and Screening of Lipids and Oxylipins in HPLC-MS Datasets Using LOBSTAHS](./references/LOBSTAHS.Rmd)
- [LOBSTAHS Vignette](./references/LOBSTAHS.md)