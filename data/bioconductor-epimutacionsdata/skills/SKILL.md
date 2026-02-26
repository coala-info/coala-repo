---
name: bioconductor-epimutacionsdata
description: This package provides example DNA methylation datasets and candidate regions for testing and running epimutation analysis workflows. Use when user asks to retrieve reference panels, access case-control methylation data, or load raw IDAT files for epimutation detection.
homepage: https://bioconductor.org/packages/release/data/experiment/html/epimutacionsData.html
---


# bioconductor-epimutacionsdata

name: bioconductor-epimutacionsdata
description: Access and utilize the epimutacionsData Bioconductor package. Use this skill when you need to retrieve example datasets for epimutation analysis, including reference panels (RGChannelSet), case-control methylation data (GenomicRatioSet), candidate regions for 450k arrays, or raw IDAT files for testing the epimutacions package.

# bioconductor-epimutacionsdata

## Overview

The `epimutacionsData` package serves as a data repository for the `epimutacions` R package. It provides high-quality DNA methylation datasets from the Gene Expression Omnibus (GEO) and pre-computed candidate regions specifically designed for identifying epimutations in Illumina 450K methylation arrays.

The package primarily delivers data through `ExperimentHub`, though it also includes raw IDAT files in its external data directory.

## Data Retrieval via ExperimentHub

The main datasets are stored in `ExperimentHub`. To access them, you must initialize an `ExperimentHub` object and query for the package.

```r
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "epimutacionsData")
```

### Available Records

| ID | Title | Class | Description |
|:---|:---|:---|:---|
| **EH6690** | Control and case samples | `GenomicRatioSet` | 48 controls (GSE104812) and 3 cases (GSE97362). |
| **EH6691** | Reference panel | `RGChannelSet` | 22 whole cord blood samples from healthy children (GSE127824). |
| **EH6692** | Candidate epimutations | `GRanges` | 40,408 regions on 450K array with at least 3 CpGs. |

### Loading Specific Datasets

To load a specific dataset into your R session:

```r
# Load Case/Control samples
methy <- eh[["EH6690"]]

# Load Reference Panel
reference_panel <- eh[["EH6691"]]

# Load Candidate Regions
candRegsGR <- eh[["EH6692"]]
```

## Working with Raw IDAT Files

The package includes raw microarray intensities (IDAT files) for 4 case samples from the GSE131350 cohort. These are useful for testing preprocessing workflows with `minfi`.

```r
library(minfi)

# Locate the external data directory
baseDir <- system.file("extdata", package = "epimutacionsData")

# Read the sample sheet
targets <- read.metharray.sheet(baseDir)

# Read the IDAT files into an RGChannelSet
rgSet <- read.metharray.exp(targets = targets)
```

## Typical Workflow

1. **Identify Candidate Regions**: Use `EH6692` to define the genomic search space for epimutations.
2. **Establish Background**: Use the reference panel (`EH6691`) to define "normal" methylation levels.
3. **Compare Samples**: Use the case/control dataset (`EH6690`) to test epimutation detection algorithms.
4. **Validation**: Use the raw IDAT files to ensure that your preprocessing pipeline (from raw data to `GenomicRatioSet`) is consistent with the provided processed objects.

## Tips and Best Practices

- **Object Classes**: Note that `EH6691` is an `RGChannelSet` (raw-ish data), while `EH6690` is a `GenomicRatioSet` (processed beta/M values). Ensure your analysis functions support the specific class you are loading.
- **Caching**: `ExperimentHub` downloads data to a local cache. If you encounter download issues, check your `BiocFileCache` settings.
- **Bumphunter**: The candidate regions in `EH6692` were pre-computed using the `bumphunter` clustering approach, requiring at least 3 CpGs per region.

## Reference documentation

- [epimutacionsData Vignette (Rmd)](./references/epimutacionsData.Rmd)
- [epimutacionsData Vignette (Markdown)](./references/epimutacionsData.md)