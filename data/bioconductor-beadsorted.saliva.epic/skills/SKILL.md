---
name: bioconductor-beadsorted.saliva.epic
description: This package provides Illumina EPIC DNA methylation reference data for sorted saliva epithelial and immune cell types. Use when user asks to load saliva cell-type reference panels, perform cell-type deconvolution for saliva samples, or access methylation comparison tables between epithelial and immune cells.
homepage: https://bioconductor.org/packages/release/data/experiment/html/BeadSorted.Saliva.EPIC.html
---

# bioconductor-beadsorted.saliva.epic

name: bioconductor-beadsorted.saliva.epic
description: Provides access to the BeadSorted.Saliva.EPIC Bioconductor data package, which contains Illumina EPIC DNA methylation reference data for saliva cell types (epithelial and immune cells). Use this skill when a user needs to load the saliva cell-type reference panel, perform cell-type deconvolution for saliva samples, or access comparison tables between epithelial and immune cell methylation profiles.

# bioconductor-beadsorted.saliva.epic

## Overview

The **BeadSorted.Saliva.EPIC** package provides a DNA methylation reference panel specifically for saliva samples. It is based on the Illumina HumanMethylationEPIC array and includes data from 60 samples, including sorted epithelial and immune cells from children. This resource is essential for researchers looking to estimate and control for cell-type heterogeneity in saliva-based epigenetic studies using the Houseman algorithm or similar deconvolution methods.

## Loading Data via ExperimentHub

The data objects are hosted on ExperimentHub. To use them, you must first initialize the hub and query for the specific resource IDs.

### Accessing the RGChannelSet
The primary dataset is an `RGChannelSet` containing raw intensities for 60 samples.

```r
library(ExperimentHub)
hub <- ExperimentHub()

# Query for the main dataset
query(hub, "BeadSorted.Saliva.EPIC")

# Load the RGChannelSet (Resource ID: EH4539)
saliva_rgset <- hub[["EH4539"]]
```

### Accessing the Comparison Table
The comparison table contains statistics (t-tests, p-values, and mean beta values) comparing epithelial vs. immune cell methylation for each CpG probe.

```r
# Load the comparison table (Resource ID: EH4540)
saliva_compTable <- hub[["EH4540"]]
head(saliva_compTable)
```

### Accessing Cell Proportion Estimates
The package includes pre-computed cell proportion estimates for the reference samples, calculated using the `ewastools` implementation of the Houseman algorithm.

```r
# Load the estimates (Resource ID: EH4541)
saliva_estimates <- hub[["EH4541"]]
head(saliva_estimates)
```

## Typical Workflows

### Cell-Type Deconvolution
The primary use case for this package is providing a reference for estimating cell counts in "bulk" saliva samples. While the package provides the reference data, you typically use it in conjunction with packages like `minfi` or `ewastools`.

1. **Reference-Based Estimation**: Use the sorted epithelial and immune cell profiles from the `RGChannelSet` to create a reference matrix.
2. **Houseman Algorithm**: Apply the `estimateLC()` function from `ewastools` or `pickCompProbes`/`estimateCellCounts` from `minfi` using this saliva-specific panel instead of the standard blood-based Reinius reference.

### Quality Control and Filtering
The `compTable` can be used to identify the most informative CpGs for saliva cell-type differentiation.
- Filter for probes with the largest mean differences between epithelial and immune cells.
- Use these top-ranked probes to improve the precision of your own deconvolution pipeline.

## Tips for Usage
- **Sample Composition**: Remember that saliva is a mixture of buccal epithelial cells and leukocytes (immune cells). Using a blood reference for saliva often leads to biased results; always prefer this saliva-specific panel.
- **Array Compatibility**: While designed for EPIC, many probes overlap with the 450k array. Ensure you handle probe filtering correctly if applying this to 450k data.
- **Data Source**: The raw IDAT files associated with this package are available on GEO under accession **GSE147318**.

## Reference documentation

- [BeadSorted.Saliva.EPIC](./references/BeadSorted.Saliva.EPIC.md)