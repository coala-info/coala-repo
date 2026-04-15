---
name: bioconductor-rmassbank
description: This tool processes high-resolution MS/MS spectra to create standardized MassBank records. Use when user asks to extract and recalibrate LC-MS/MS data, annotate fragments with molecular formulas, or generate records for mass spectrometry database submission.
homepage: https://bioconductor.org/packages/release/bioc/html/RMassBank.html
---

# bioconductor-rmassbank

name: bioconductor-rmassbank
description: Processing high-resolution MS/MS spectra for MassBank record creation. Use when you need to extract, recalibrate, and clean LC-MS/MS data, annotate fragments with molecular formulas, and generate standardized MassBank records for database submission.

# bioconductor-rmassbank

## Overview

`RMassBank` is a workflow for processing high-resolution mass spectrometry (MS/MS) data. It transforms raw LC-MS files into high-quality, recalibrated, and denoised spectra, which are then compiled into MassBank records. The workflow is divided into two main phases: the **MSMS Workflow** (data processing) and the **MassBank Record Workflow** (annotation and export).

## MSMS Workflow (Steps 1-8)

The MSMS workflow processes raw data (mzML) into cleaned spectra.

### 1. Setup and Configuration
Load the library and initialize settings. Settings are typically managed via a YAML/INI file.

```r
library(RMassBank)
loadRmbSettings("mysettings.ini") # Load your custom settings
w <- newMsmsWorkspace()
w@files <- list.files("path/to/mzML", full.names = TRUE)
loadList("compound_list.csv") # CSV with ID, Name, SMILES, RT, CAS
```

### 2. Running the Workflow
The workflow consists of 8 steps that can be run together or in blocks.

```r
# Run steps 1-4: Extraction and Recalibration
w <- msmsWorkflow(w, mode="pH", steps=1:4, archivename = "my_project")

# Inspect recalibration
plotRecalibration(w)

# Run steps 5-8: Re-analysis, Noise Cleaning, and Multiplicity Filtering
w <- msmsWorkflow(w, mode="pH", steps=5:8, archivename = "my_project")
```

**Workflow Steps:**
1. `findMsMsHR`: Extract spectra based on compound list.
2. `analyzeMsMs`: Initial formula assignment.
3. `aggregateSpectra`: Combine peaks across files.
4. `recalibrateSpectra`: Calculate and apply mass recalibration.
5. `analyzeMsMs`: Re-analyze recalibrated spectra.
6. `aggregateSpectra` & `cleanElnoise`: Aggregate and remove electronic noise.
7. `reanalyzeFailpeaks`: Attempt to assign formulas to previously unmatched peaks.
8. `filterMultiplicity`: Remove peaks appearing only once (spurious peaks).

## MassBank Record Workflow

Once spectra are processed, use the `mbWorkflow` to generate database records.

### 1. Annotation Retrieval
Retrieve compound metadata (InChI, SMILES, etc.) from services like CTS.

```r
mb <- newMbWorkspace(w)
mb <- resetInfolists(mb)
# Load existing info or fetch new data
mb <- mbWorkflow(mb, infolist_path="./my_infolist.csv")
```

### 2. Record Compilation and Export
After manually verifying the generated CSV infolist, compile the final records.

```r
# Reload corrected infolist
mb <- loadInfolists(mb, "path/to/corrected_infolists")
# Finalize records and export to files
mb <- mbWorkflow(mb) 
```

## Advanced Usage

### Skipping Recalibration
If data is insufficient for a loess fit, use the identity function:
```r
rmbo <- getOption("RMassBank")
rmbo$recalibrator <- list("MS1" = "recalibrate.identity", "MS2" = "recalibrate.identity")
options("RMassBank" = rmbo)
```

### Combining Multiplicities
To prevent losing peaks that only appear in specific collision energies, combine multiple workspace runs (e.g., primary and confirmation scans):
```r
wTotal <- combineMultiplicities(c(w1, w2))
wTotal <- msmsWorkflow(wTotal, steps=8, mode="pH")
```

## Tips for Success
- **File Naming**: Ensure mzML files follow the `xxxxxxxx_ID_xxx.mzML` pattern where ID matches the compound list.
- **OpenBabel**: Install OpenBabel and set `babeldir` in settings for high-quality structure generation.
- **Modes**: Common modes include `pH` ([M+H]+), `pNa` ([M+Na]+), `mH` ([M-H]-), and `mFA` ([M+FA]-).
- **Failpeaks**: Check the generated `_Failpeaks.csv` after step 8. Mark valid peaks with `OK = 1` to include them in the final record via `addPeaks()`.

## Reference documentation
- [RMassBank: The workflow by example](./references/RMassBank.md)
- [RMassBank: Non-standard usage](./references/RMassBankNonstandard.md)