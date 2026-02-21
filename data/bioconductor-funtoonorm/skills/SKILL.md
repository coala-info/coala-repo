---
name: bioconductor-funtoonorm
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/funtooNorm.html
---

# bioconductor-funtoonorm

name: bioconductor-funtoonorm
description: Normalization of Illumina Infinium Human Methylation 450 BeadChip (450K) data, specifically designed for datasets containing multiple tissues or cell types. Use this skill to perform funtooNorm normalization, handle SampleSet objects, and convert between RGChannelSet and funtooNorm formats.

# bioconductor-funtoonorm

## Overview

The `funtooNorm` package provides a specialized normalization method for Illumina HumanMethylation450 BeadChip data. Unlike standard normalization methods, `funtooNorm` explicitly accounts for differences between tissues or cell types. It is most effective when the dataset contains samples from multiple different biological sources. The package uses either Principal Component Regression (PCR) or Partial Least Squares (PLS) to normalize signal intensities across different probe types and color channels.

## Typical Workflow

### 1. Data Loading and Object Creation
`funtooNorm` operates on a specialized `SampleSet` class. You can create this object from `minfi` objects or GenomeStudio files.

**From minfi (RGChannelSet):**
Ensure your `RGChannelSet` contains a `cell_type` column in its phenotype data (`pData`).
```r
library(funtooNorm)
library(minfiData)

# Prepare data
data(RGsetEx)
pData(RGsetEx)$cell_type <- rep(c("TypeA", "TypeB"), 3)

# Convert to SampleSet
mySampleSet <- fromRGChannelSet(RGsetEx)
```

**From GenomeStudio:**
```r
mySampleSet <- fromGenStudFiles(controlProbeFile = "control_probes.txt", 
                                signalFile = "signal_file.txt", 
                                cell_type = c("TypeA", "TypeB", ...))
```

### 2. Parameter Selection (Validation)
Before running the full normalization, determine the optimal number of components (`ncmp`).
```r
# Generates a PDF 'plotValidationGraph.pdf' to help choose ncmp
plotValidationGraph(mySampleSet, type.fits = "PCR")
```

### 3. Normalization
Run the normalization using the chosen fit type (default is "PCR") and number of components.
```r
# Perform normalization
mySampleSet <- funtooNorm(mySampleSet, type.fits = "PCR", ncmp = 4)
```
*Note: Chromosome Y is handled separately via quantile normalization applied only to males.*

### 4. Extracting Results
After normalization, extract Beta or M-values for downstream analysis.

```r
# Get Normalized Beta values (0 to 1)
normBeta <- getNormBeta(mySampleSet)

# Get Normalized M-values (log2 ratio)
normM <- getNormM(mySampleSet)

# Get Raw Beta values for comparison
rawBeta <- getRawBeta(mySampleSet)

# Get SNP M-values
snpM <- getSnpM(mySampleSet)
```

## Key Functions and Parameters

| Function | Description |
| :--- | :--- |
| `funtooNorm` | Main normalization function. Parameters: `type.fits` ("PCR" or "PLS"), `ncmp` (components), `sex` (optional boolean vector). |
| `agreement` | Measures intra-replicate agreement. Lower values after normalization indicate better performance. |
| `getGRanges` | Returns a GRanges object with CpG positions for the SampleSet. |
| `fromRGChannelSet` | Converter for `minfi` users. Requires `cell_type` in `pData`. |

## Tips and Best Practices
- **Cell Type Requirement:** This package is specifically designed for multi-tissue/cell-type studies. If your study involves only one cell type, other normalization methods (like `preprocessQuantile` in `minfi`) might be more appropriate.
- **Replicate Validation:** Use the `agreement(Beta, individualID)` function to compare pre- and post-normalization data. A successful normalization should reduce the distance between technical replicates.
- **Sex Chromosomes:** If `sex` is not provided to `funtooNorm`, the package attempts to classify samples based on ChrY probe signals.

## Reference documentation
- [funtooNorm Reference Manual](./references/reference_manual.md)