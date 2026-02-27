---
name: bioconductor-timecoursedata
description: This tool provides access to curated time course gene expression datasets from the Bioconductor package timecoursedata. Use when user asks to load longitudinal microarray or RNA-seq data from influenza-infected mice or drought-stressed Sorghum bicolor studies.
homepage: https://bioconductor.org/packages/release/data/experiment/html/timecoursedata.html
---


# bioconductor-timecoursedata

name: bioconductor-timecoursedata
description: Access and load time course gene expression datasets from the Bioconductor package timecoursedata. Use this skill when you need to retrieve microarray or RNA-seq data from specific longitudinal studies, including influenza-exposed mice (Shoemaker 2015) and drought-stressed Sorghum bicolor (Varoquaux 2019).

## Overview

The `timecoursedata` package provides curated, high-quality time course gene expression datasets for research and benchmarking. It includes data from two major studies:
1.  **Shoemaker (2015)**: Microarray data from mouse lung tissue infected with different influenza strains across 14 time points.
2.  **Varoquaux (2019)**: RNA-seq data from leaf and root samples of *Sorghum bicolor* under drought conditions across 15 weeks.

Datasets are available either as simple lists (containing a `data` matrix and a `meta` data.frame) or as `SummarizedExperiment` objects.

## Data Loading Workflows

### 1. Loading as SummarizedExperiment (Recommended)
The preferred way to load these datasets for Bioconductor workflows is using the dedicated loader functions, which return a `SummarizedExperiment` object.

```r
library(timecoursedata)

# Load Shoemaker 2015 (Influenza)
se_shoe <- load_shoemaker2015()

# Load Varoquaux 2019 (Sorghum Drought) - specify sample_type "leaf" or "root"
se_leaf <- load_varoquaux2019(sample_type = "leaf")
se_root <- load_varoquaux2019(sample_type = "root")
```

### 2. Loading as Matrix/Data.frame
If you prefer working with standard R matrices and data frames, use the `data()` function.

```r
# Shoemaker 2015
data(shoemaker2015)
# Access components:
# shoemaker2015$data (expression matrix)
# shoemaker2015$meta (metadata data.frame)

# Varoquaux 2019
data(varoquaux2019leaf)
data(varoquaux2019root)
```

## Dataset Details

### Shoemaker 2015
- **Type**: Microarray.
- **Samples**: 209 samples (3 replicates, 14 time points).
- **Metadata Columns**: `Group`, `Replicate`, `Timepoint`.

### Varoquaux 2019 (Leaf and Root)
- **Type**: RNA-seq (Raw counts, not normalized).
- **Samples**: ~400 transcriptomes across 15 weeks.
- **Metadata Columns**: `Block`, `Week`, `Genotype` (RTx430 or BTx642), `Condition` (Control, preflowering drought, postflowering drought), `Day`.
- **Note**: Leaf and root samples were sequenced in separate batches; comparisons between them should account for batch effects.

## Common Metadata Columns
Across all datasets, the metadata typically includes:
- `Timepoint` / `Week` / `Day`: The temporal axis.
- `Group` / `Condition`: The experimental treatment.
- `Replicate`: Biological replicate identifier.

## Reference documentation
- [timecoursedata: Time course gene expression datasets](./references/documentation.md)