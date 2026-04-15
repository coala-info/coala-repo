---
name: bioconductor-msgfplus
description: The bioconductor-msgfplus package provides an R interface to the MS-GF+ search engine for peptide identification from mass spectrometry data. Use when user asks to configure proteomic search parameters, define peptide modifications, run MS-GF+ searches, or import mass spectrometry identification results into R.
homepage: https://bioconductor.org/packages/3.8/bioc/html/MSGFplus.html
---

# bioconductor-msgfplus

## Overview

The `MSGFplus` package provides an R interface to the MS-GF+ (Mass Spectrometry-Generating Function Plus) search engine. It allows users to configure complex proteomic search parameters, manage modifications, and execute peptide identification workflows directly from the R console. The package handles the underlying Java execution and can automatically import results into `mzID` objects for downstream analysis.

## Core Workflow

### 1. Creating a Parameter Set

The `msgfPar` object is the central configuration hub. You can initialize it empty or with specific values.

```r
library(MSGFplus)

# Initialize with basic requirements
databaseFile <- system.file('extdata', 'milk-proteins.fasta', package='MSGFplus')
par <- msgfPar(database = databaseFile, 
               tolerance = '20 ppm', 
               instrument = 'QExactive', 
               tda = TRUE)
```

### 2. Modifying Parameters

Parameters can be adjusted iteratively using setter functions:

*   **Search Constraints**: `tolerance(par) <- '10 ppm'`, `chargeRange(par) <- c(2, 4)`, `lengthRange(par) <- c(6, 30)`
*   **Enzymatics**: `enzyme(par) <- 'Trypsin'`, `ntt(par) <- 1` (number of tolerable termini)
*   **Hardware/Protocol**: `instrument(par) <- 'HighRes'`, `fragmentation(par) <- 1`, `protocol(par) <- 0`
*   **Search Logic**: `tda(par) <- TRUE` (Target-Decoy Approach), `matches(par) <- 1`

### 3. Defining Modifications

Modifications are added to the `mods` slot using `msgfParModification`.

```r
# Fixed modification (example: Carbamidomethyl)
mods(par)[[1]] <- msgfParModification(name = 'Carbamidomethyl',
                                      composition = 'C2H3N1O1',
                                      residues = 'C',
                                      type = 'fixed',
                                      position = 'any')

# Variable modification (example: Oxidation)
mods(par)[[2]] <- msgfParModification(name = 'Oxidation',
                                      mass = 15.994915,
                                      residues = 'M',
                                      type = 'opt',
                                      position = 'any')

nMod(par) <- 2 # Max modifications per peptide
```

### 4. Running the Analysis

The `runMSGF` function executes the search.

**Batch Mode (Synchronous):**
```r
# Runs and imports results as an mzID object
results <- runMSGF(par, 'data_file.mzML')
```

**Asynchronous Mode:**
Useful for long-running searches to keep the R session responsive.
```r
msgf_job <- runMSGF(par, 'data_file.mzML', async = TRUE)

# Check status
if (finished(msgf_job)) {
    results <- import(msgf_job)
}
```

## Tips and Best Practices

*   **Memory**: MS-GF+ is Java-based. Ensure your system has sufficient RAM allocated for the Java Virtual Machine if searching large databases.
*   **Result Replication**: Use `msgfParFromID('path/to/result.mzid')` to extract the exact parameters used in a previous search to ensure reproducibility.
*   **GUI Option**: For users preferring a visual interface for parameter selection, `msgfParGUI()` launches a graphical tool to build the `msgfPar` object.
*   **File Formats**: The package primarily supports `.mzML`, `.mzXML`, `.mgf`, `.ms2`, `.pkl`, or `.dta` as input spectra.

## Reference documentation

- [Using MSGFplus](./references/Using_MSGFplus.md)