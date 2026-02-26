---
name: bioconductor-flowsorted.cordbloodcombined.450k
description: This package provides a reference dataset for estimating cell type proportions in umbilical cord blood DNA methylation studies using 450K or EPIC technologies. Use when user asks to estimate cord blood cell type proportions, access IDOL optimized CpG probes, or load reference methylation data for cord blood deconvolution.
homepage: https://bioconductor.org/packages/release/data/experiment/html/FlowSorted.CordBloodCombined.450k.html
---


# bioconductor-flowsorted.cordbloodcombined.450k

## Overview

The `FlowSorted.CordBloodCombined.450k` package provides a comprehensive reference dataset for estimating cell type proportions in umbilical cord blood DNA methylation studies. It combines and curates data from multiple sources to provide a more accurate reference than previous standalone packages. It supports both 450K and EPIC (850K) technologies and includes specific cellular populations: CD4+ and CD8+ T lymphocytes, B cells (CD19+), monocytes (CD14+), NK cells (CD56+), and Granulocytes.

## Key Objects

- `FlowSorted.CordBloodCombined.450k`: An `RGChannelSet` object containing the reference library.
- `IDOLOptimizedCpGsCordBlood`: A specific set of IDOL (Identifying Optimal Libraries) L-DMR probes optimized for cord blood deconvolution.

## Typical Workflow

### 1. Loading the Reference Data
The main dataset is hosted on ExperimentHub. Use `libraryDataGet` to retrieve the `RGChannelSet`.

```r
library(FlowSorted.CordBloodCombined.450k)

# Retrieve the reference RGChannelSet
# Note: Requires significant memory (>8GB recommended)
reference_data <- libraryDataGet('FlowSorted.CordBloodCombined.450k')
```

### 2. Accessing IDOL Optimized Probes
For the most accurate deconvolution, use the IDOL optimized CpG sites rather than the default `minfi` probes.

```r
# Load the optimized probe list
data("IDOLOptimizedCpGsCordBlood")
head(IDOLOptimizedCpGsCordBlood)
```

### 3. Performing Deconvolution
While the package provides the data, the actual estimation is best performed using the `estimateCellCounts2` function from the `FlowSorted.Blood.EPIC` package, which allows for customized probe sets (IDOL).

```r
# Example conceptual workflow for deconvolution
# library(FlowSorted.Blood.EPIC)
# counts <- estimateCellCounts2(your_rgset, 
#                               compositeCellType = "CordBlood", 
#                               processMethod = "preprocessNoob",
#                               probeSelect = "IDOL", 
#                               IDOLOptimizedCpGs = IDOLOptimizedCpGsCordBlood,
#                               referencePlatform = "IlluminaHumanMethylationEPIC")
```

## Usage Tips

- **IDOL vs. minfi**: The package authors strongly recommend using the IDOL procedure over automatic `minfi` estimates for higher precision and reduced bias in cord blood samples.
- **Technology Compatibility**: This reference is suitable for deconvolving samples assayed on both Illumina 450K and EPIC platforms.
- **Memory Management**: Loading the full `RGChannelSet` is memory-intensive. Ensure your R environment has at least 8GB of RAM available.
- **Curation**: This package is not just a merge of existing datasets; it involves rigorous curation to eliminate cell cross-contamination found in earlier versions like `FlowSorted.CordBlood.450k`.

## Reference documentation

- [FlowSorted.CordBloodCombined.450k](./references/FlowSorted.CordBloodCombined.450k.Rmd)
- [FlowSorted.CordBloodCombined.450k](./references/FlowSorted.CordBloodCombined.450k.md)