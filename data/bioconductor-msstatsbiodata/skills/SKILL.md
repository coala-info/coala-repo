---
name: bioconductor-msstatsbiodata
description: The MSstatsBioData package provides a curated collection of peak intensity datasets from biological investigations formatted for use with the MSstats R package. Use when user asks to load example DDA or SRM datasets, access curated mass spectrometry data, or test differential abundance analysis pipelines.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/MSstatsBioData.html
---


# bioconductor-msstatsbiodata

## Overview

The `MSstatsBioData` package is a curated collection of peak intensity datasets from seven published biological investigations using Data-Dependent Acquisition (DDA) or Selected Reaction Monitoring (SRM) experiments. These datasets are pre-formatted for immediate use with the `MSstats` R package, making them ideal for testing differential abundance analysis pipelines.

## Available Datasets

The package includes the following data objects:

| Object | Experiment Type | Study Description |
| :--- | :--- | :--- |
| `DDA_cardio` | DDA | Cardiovascular disease study (no missing values) |
| `SRM_crc_training` | SRM | Colorectal cancer (Training set) |
| `SRM_crc_validation` | SRM | Colorectal cancer (Validation set) |
| `SRM_mpm_training` | SRM | Malignant pleural mesothelioma (Training set) |
| `SRM_mpm_validation` | SRM | Malignant pleural mesothelioma (Validation set) |
| `SRM_ovarian` | SRM | Ovarian cancer study |
| `SRM_yeast` | SRM | Time course of central carbon metabolism in S. cerevisiae |

## Workflow: Loading and Analyzing Data

### 1. Load the Data
Datasets are loaded using the standard R `data()` function.

```r
library(MSstatsBioData)

# Load the yeast dataset
data(SRM_yeast)

# Inspect the structure
head(SRM_yeast)
```

### 2. Data Structure
All datasets follow the 10-column `MSstats` required format:
- **ProteinName**: Protein identifier.
- **PeptideSequence**: Sequence of the peptide.
- **PrecursorCharge**: Charge of the precursor ion.
- **FragmentIon**: Fragment identifier.
- **ProductCharge**: Charge of the product ion.
- **IsotopeLabelType**: 'L' (endogenous) or 'H' (labeled reference).
- **Condition**: Experimental groups.
- **BioReplicate**: Unique identifier for biological replicates.
- **Run**: MS run identifier.
- **Intensity**: Raw peak intensity (area under curve).

### 3. Integration with MSstats
Once loaded, these datasets can be passed directly into `MSstats` functions for processing and testing.

```r
library(MSstats)

# Process data (Normalization and Feature Selection)
input.proposed <- dataProcess(SRM_yeast,
                              summaryMethod="TMP",
                              cutoffCensored="minFeature",
                              censoredInt="0",
                              MBimpute=TRUE)

# Define a contrast matrix (e.g., comparing Time 2 to Time 1)
comparison <- matrix(c(-1, 1, 0, 0, 0, 0, 0, 0, 0, 0), nrow=1)
row.names(comparison) <- "T2-T1"

# Perform differential abundance testing
test.results <- groupComparison(contrast.matrix=comparison, data=input.proposed)
head(test.results$ComparisonResult)
```

## Important Considerations

- **Pre-normalized Data**: The `SRM_crc_training` and `SRM_crc_validation` datasets have already undergone two-step normalization (median normalization via heavy references and endogenous normalization via standard proteins). Extra normalization in `MSstats` may not be required for these specific sets.
- **Missing Values**: While most DDA datasets contain missing values, `DDA_cardio` contains no missing values because background signals were reported for non-detected features.
- **Isotope Labeling**: Most SRM datasets in this package include both Heavy (H) and Light (L) channels. Ensure your `MSstats` parameters account for the presence of reference peptides if applicable.

## Reference documentation

- [MSstatsBioData](./references/MSstatsBioData.md)