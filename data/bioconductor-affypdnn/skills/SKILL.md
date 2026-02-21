---
name: bioconductor-affypdnn
description: The package contains functions to perform the PDNN method described by Li Zhang et al.
homepage: https://bioconductor.org/packages/3.5/bioc/html/affypdnn.html
---

# bioconductor-affypdnn

name: bioconductor-affypdnn
description: Perform the Position-Dependent Nearest Neighbor (PDNN) method for Affymetrix GeneChip data. Use this skill to calculate gene expression indices based on physical models of hybridization, including chip-type specific energy parameters and experiment-specific parameters.

# bioconductor-affypdnn

## Overview

The `affypdnn` package implements the PDNN model for processing Affymetrix probe-level data. Unlike purely statistical methods, PDNN accounts for the physical properties of hybridization, such as the stacking energies of adjacent nucleotides. The workflow typically involves calculating chip-type specific parameters (using energy data files), finding experiment-specific parameters, and then performing PM correction and summarization.

## Core Workflow

### 1. Load the Package and Data
The package works with `AffyBatch` objects from the `affy` package.

```r
library(affypdnn)
library(affydata)
data(Dilution)
afbatch <- Dilution
```

### 2. Obtain Chip-Type Specific Parameters
PDNN requires energy parameters for dinucleotides. The package includes example energy files for HGU95Av2, HGU133A, and MGU74Av2.

```r
# Locate the energy file provided by the package
energy.file <- system.file("exampleData", 
                          "pdnn-energy-parameter_hg-u95av2.txt", 
                          package = "affypdnn")

# Compute parameters (requires the corresponding probe package)
params.chiptype <- pdnn.params.chiptype(energy.file, probes.pack = "hgu95av2probe")
```

### 3. Find Experiment-Specific Parameters
These parameters are derived from the probe-level values within the specific CEL files/AffyBatch being analyzed.

```r
params <- find.params.pdnn(afbatch, params.chiptype)
```

### 4. High-Level Processing with expressopdnn
The most efficient way to process an entire dataset is using `expressopdnn`, which wraps the background correction, normalization, and PDNN-specific steps.

```r
# Example: Processing a subset of probesets
ids <- ls(getCdfInfo(afbatch))[1:10]

eset <- expressopdnn(afbatch, 
                     bg.correct = FALSE, 
                     normalize = FALSE,
                     findparams.param = list(params.chiptype = params.chiptype, 
                                            give.warnings = FALSE),
                     summary.subset = ids)
```

## Manual PM Correction and Visualization
If you need to inspect specific probesets or perform manual correction:

```r
# Extract a specific probeset
ppset.name <- "41206_r_at"
ppset <- probeset(afbatch, ppset.name)

# Apply PDNN prediction correction
probes.pdnn <- pmcorrect.pdnnpredict(ppset[[1]], params, 
                                     params.chiptype = params.chiptype)

# Visualize raw vs predicted intensities
par(mfrow=c(1,2))
plot(ppset[[1]], main="Raw Intensities")
matplotProbesPDNN(probes.pdnn, main="Predicted Intensities")
```

## Tips and Best Practices
- **Energy Files:** If working with a chip type not included in `exampleData`, you must obtain the external "energy data file" containing Eg, En, Wg, and Wn parameters.
- **Memory Management:** PDNN calculations can be computationally intensive. Use the `summary.subset` argument in `expressopdnn` to test workflows on a small number of probesets before running a full analysis.
- **Integration:** You can mix PDNN with standard Bioconductor methods by toggling `bg.correct` and `normalize` arguments within the `expressopdnn` function.

## Reference documentation
- [affypdnn](./references/affypdnn.md)