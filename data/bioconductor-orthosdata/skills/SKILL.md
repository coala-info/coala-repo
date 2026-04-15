---
name: bioconductor-orthosdata
description: This tool provides access to pre-trained variational models and large-scale RNA-seq contrast databases for mouse and human mechanistic studies. Use when user asks to download orthos models, access ARCHS4-derived contrast databases, or manage experiment data for the orthos package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/orthosData.html
---

# bioconductor-orthosdata

name: bioconductor-orthosdata
description: Access and manage the orthosData companion database for mechanistic studies using differential gene expression. Use this skill to download, cache, and load pre-trained variational models (ContextEncoder, DeltaEncoder, DeltaDecoder) and contrast databases (ARCHS4-derived RNAseq experiments) for mouse and human, which are required for inference in the 'orthos' package.

## Overview

`orthosData` is a Bioconductor experiment data package that provides the necessary data infrastructure for the `orthos` software. It serves as a repository for over 100,000 uniformly processed mouse and human RNAseq differential expression experiments derived from ARCHS4. Additionally, it provides access to pre-trained Variational Autoencoder (VAE) and conditional VAE (cVAE) models used to map experimental treatments to mechanisms of action.

## Installation and Setup

Install the package using `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("orthosData")
library(orthosData)
```

## Managing Pre-trained Models

The package provides three types of Keras models for each organism:
1. **ContextEncoder**: Encodes gene expression profiles (log2CPMs) into a latent representation.
2. **DeltaEncoder**: Encodes gene expression contrasts (log2FCs) conditioned on context.
3. **DeltaDecoder**: Decodes latent representations back into contrast matrices.

To download and cache these models locally:

```r
# Check current ExperimentHub cache location
ExperimentHub::getExperimentHubOption("CACHE")

# Download models for a specific organism (e.g., "Mouse" or "Human")
GetorthosModels(organism = "Mouse")
```

## Accessing the Contrast Database

The contrast database contains log2 fold changes, decoded components, and metadata for thousands of experiments. It is stored as an `HDF5SummarizedExperiment`.

### Downloading and Caching

Use `GetorthosContrastDB()` to retrieve the data. Note the `mode` parameter:
- `mode = "DEMO"`: Downloads a small "toy" database for testing and quick queries.
- `mode = "ANALYSIS"`: Downloads the full database (requires significant time and disk space).

```r
# Download the demo version for Mouse
GetorthosContrastDB(organism = "Mouse", mode = "DEMO")
```

### Loading the Data

Once cached, the database must be loaded using `HDF5Array`. The prefix required for loading typically follows a specific naming convention based on the version and mode.

```r
# Load the HDF5SummarizedExperiment from the cache
# Note: The prefix must match the filename downloaded to the cache
se <- HDF5Array::loadHDF5SummarizedExperiment(
    dir = ExperimentHub::getExperimentHubOption("CACHE"),
    prefix = "mouse_v212_NDF_c100_DEMO"
)

# Inspect the object
SummarizedExperiment::colData(se) # Contrast annotation
SummarizedExperiment::rowData(se) # Gene annotation
SummarizedExperiment::assays(se)  # log2FCs and components
```

## Workflow Tips

- **Integration with orthos**: This package is primarily a data provider. For actual mechanistic analysis, latent space projections, and treatment mapping, use the functions provided in the `orthos` package.
- **Cache Management**: Since these datasets are large, ensure your `ExperimentHub` cache directory has sufficient space before running `mode = "ANALYSIS"`.
- **File Integrity**: Do not rename the files within the cache directory, as `HDF5SummarizedExperiment` objects rely on specific relative filenames between the `.rds` and `.h5` components.

## Reference documentation

- [The orthosData package](./references/orthosData.md)