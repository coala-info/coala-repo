---
name: bioconductor-maqcsubsetafx
description: This package provides a curated subset of the MicroArray Quality Control reference data for the Affymetrix Human Genome U133 Plus 2.0 platform. Use when user asks to load reference AffyBatch objects, compare microarray data against MAQC benchmarks, or perform quality control and reproducibility assessments.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/MAQCsubsetAFX.html
---


# bioconductor-maqcsubsetafx

name: bioconductor-maqcsubsetafx
description: Access and utilize the MAQC (MicroArray Quality Control) reference subset for the Affymetrix platform (Human Genome U133 Plus 2.0 GeneChips). Use this skill when you need to load high-quality reference AffyBatch objects (refA, refB, refC, refD) to compare against user-generated microarray data, estimate reproducibility, or perform quality control using the yaqcaffy package.

# bioconductor-maqcsubsetafx

## Overview
The `MAQCsubsetAFX` package provides a curated subset of the MicroArray Quality Control (MAQC) project data specifically for the Affymetrix Human Genome U133 Plus 2.0 platform. It contains four reference RNA datasets (A, B, C, and D), each consisting of 6 randomly chosen .CEL files (one from each of the six test sites). These datasets serve as gold-standard benchmarks for assessing the quality and reproducibility of Affymetrix microarray experiments.

## Loading Reference Data
The package provides four primary data objects, each representing a different RNA source:
- `refA`: 100% Stratagene’s Universal Human Reference RNA.
- `refB`: 100% Ambion’s Human Brain Reference RNA.
- `refC`: Mixed RNA (75% A, 25% B).
- `refD`: Mixed RNA (25% A, 75% B).

### Basic Workflow
To use the reference data, load the library and use the `data()` function:

```r
# Load the package
library(MAQCsubsetAFX)

# Load a specific reference dataset (e.g., Reference A)
data(refA)

# Inspect the AffyBatch object
print(refA)

# Access sample names to see the origin (Site_Replicate)
sampleNames(refA)
```

## Technical Details
- **Object Class**: The data is stored as `AffyBatch` objects (from the `affy` package).
- **Platform**: Affymetrix Human Genome U133 Plus 2.0 (`hgu133plus2`).
- **Dimensions**: 1164x1164 features, 54,675 Affy IDs, 6 samples per object.

## Usage Tips
- **Memory Efficiency**: This package is designed to be a memory-efficient alternative to loading the full MAQC dataset (120 chips). It provides a representative sample (1 chip per test site) for quick comparisons.
- **Integration with yaqcaffy**: These objects are frequently used as arguments in functions within the `yaqcaffy` package to automate reproducibility metrics.
- **Comparison**: When analyzing your own U133 Plus 2.0 data, you can use these reference sets to determine if your array's signal intensities and noise levels fall within the expected ranges established by the MAQC consortium.

## Reference documentation
- [MAQCsubsetAFX](./references/MAQCsubsetAFX.md)