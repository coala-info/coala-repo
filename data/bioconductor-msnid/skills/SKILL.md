---
name: bioconductor-msnid
description: This package manages MS/MS peptide-to-spectrum matches and optimizes filtering criteria to estimate False Discovery Rates in proteomics datasets. Use when user asks to read mzIdentML files, assess peptide cleavage patterns, calculate mass measurement errors, or optimize PSM and protein filters for specific FDR levels.
homepage: https://bioconductor.org/packages/release/bioc/html/MSnID.html
---


# bioconductor-msnid

name: bioconductor-msnid
description: Utilities for handling MS/MS identifications, estimating False Discovery Rate (FDR), and optimizing filtering criteria for proteomics data. Use this skill when you need to read mzIdentML files, assess peptide cleavage patterns, calculate mass measurement errors, or optimize PSM/peptide/protein filters to achieve specific FDR thresholds in R.

# bioconductor-msnid

## Overview
The `MSnID` package provides a framework for managing and filtering Mass Spectrometry (MS/MS) peptide-to-spectrum matches (PSMs). It is designed to handle the uncertainty of identifications by leveraging decoy databases to estimate False Discovery Rates (FDR) at the PSM, peptide, and protein levels. Its core strength lies in its ability to optimize multi-parameter filters (e.g., combining MS/MS scores and mass accuracy) to maximize the number of identifications while maintaining a user-defined FDR.

## Core Workflow

### 1. Initialization and Data Loading
The `MSnID` object stores PSM data and caches results in a specified working directory.

```r
library(MSnID)
msnid <- MSnID(".")

# Preferred: Read mzIdentML files
msnid <- read_mzIDs(msnid, "path/to/file.mzid.gz")

# Alternative: Load from data.frame
# Required columns: accession, chargeState, isDecoy, peptide, spectrumID, 
# calculatedMassToCharge, experimentalMassToCharge, spectrumFile
psms(msnid) <- my_psm_dataframe
```

### 2. Peptide Sequence Analysis
Assess the quality of digestion by checking for irregular or missed cleavages.

```r
# Assess tryptic termini (0, 1, or 2 irregular)
msnid <- assess_termini(msnid, validCleavagePattern="[KR]\\.[^P]")

# Assess missed cleavages
msnid <- assess_missed_cleavages(msnid, missedCleavagePattern="[KR](?=[^P$])")

# Custom peptide properties (e.g., length)
msnid$PepLength <- nchar(msnid$peptide) - 4
```

### 3. Mass Error Handling
Calculate and correct parent ion mass measurement errors.

```r
# Calculate error in ppm
ppm <- mass_measurement_error(msnid)

# Correct for non-monoisotopic peak selection (1 Da shifts)
msnid <- correct_peak_selection(msnid)

# Post-experimental recalibration of systematic error
msnid <- recalibrate(msnid)
```

### 4. Filtering and Optimization
Filtering is performed using `MSnIDFilter` objects. You can manually set thresholds or optimize them.

```r
# Create filter object
filtObj <- MSnIDFilter(msnid)
filtObj$absParentMassErrorPPM <- list(comparison="<", threshold=10.0)
filtObj$msmsScore <- list(comparison=">", threshold=10.0)

# Evaluate current FDR
evaluate_filter(msnid, filtObj, level="peptide")

# Optimize filter to maximize identifications at 1% FDR
filtObj.opt <- optimize_filter(filtObj, msnid, fdr.max=0.01, 
                               method="Grid", level="peptide", n.iter=500)

# Apply the filter
msnid <- apply_filter(msnid, filtObj.opt)
```

### 5. Handling Modifications (PTMs)
Map modification sites to protein sequences using FASTA files.

```r
# Add symbols to modified peptides
msnid <- add_mod_symbol(msnid, mod_mass="79.9663", symbol="*")

# Map sites to protein sequence
library(Biostrings)
fst <- readAAStringSet("path/to/fasta.fasta")
msnid <- map_mod_sites(msnid, fst, 
                       accession_col="accession", 
                       peptide_mod_col="peptide_mod", 
                       mod_char="*", 
                       site_delimiter="lower")
```

### 6. Data Export and Integration
Convert `MSnID` data for use in other Bioconductor packages like `MSnbase`.

```r
# Export as data.frame
df <- psms(msnid)

# Convert to MSnSet for quantitative analysis (spectral counting)
msnset <- as(msnid, "MSnSet")

# Aggregate to protein level
library(MSnbase)
msnset.prot <- combineFeatures(msnset, fData(msnset)$accession, 
                               redundancy.handler="unique", fun="sum")
```

## Tips and Best Practices
- **Decoy Hits**: Ensure your input data contains a `isDecoy` logical column. FDR is calculated as `#decoy / #forward`.
- **Accession Remapping**: Use `remap_accessions` and `fetch_conversion_table` to switch between UniProt IDs and Gene Symbols for more readable Site IDs.
- **String Filters**: `apply_filter` can accept simple strings for quick trimming, e.g., `apply_filter(msnid, "isDecoy == FALSE")`.
- **Optimization Methods**: Start with `"Grid"` search for a broad sweep, then refine with `"Nelder-Mead"` or `"SANN"` (Simulated Annealing).

## Reference documentation
- [Handling Modifications with MSnID](./references/handling_mods.md)
- [MSnID Package for Handling MS/MS Identifications](./references/msnid_vignette.md)