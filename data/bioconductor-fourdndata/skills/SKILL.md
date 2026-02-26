---
name: bioconductor-fourdndata
description: This package provides programmatic access to uniformly processed 4D Nucleome (4DN) Hi-C data and genomic features within the R/Bioconductor environment. Use when user asks to browse, download, or import 4DN-hosted contact matrices, insulation scores, compartments, or domains into R workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/fourDNData.html
---


# bioconductor-fourdndata

name: bioconductor-fourdndata
description: Programmatic access to 4D Nucleome (4DN) uniformly processed Hi-C data, including contact matrices (.hic, .mcool) and derived files (compartments, domains, insulation scores). Use when needing to browse, download, or import 4DN-hosted chromatin conformation data into R/Bioconductor workflows.

# bioconductor-fourdndata

## Overview

The `fourDNData` package provides a programmatic interface to the 4D Nucleome Data Coordination and Integration Center (DCIC) portal. It allows users to search for and retrieve uniformly processed Hi-C contact files and associated genomic features (insulation scores, compartments, boundaries) directly into R. It integrates seamlessly with the `HiCExperiment` package for downstream analysis.

## Core Workflows

### Browsing and Searching Data

Use `fourDNData()` without arguments to retrieve a data frame of all available files, or provide an accession ID to filter for specific experiment sets.

```r
library(fourDNData)

# List all available 4DN processed files
all_files <- fourDNData()

# Search for a specific experiment set by accession
# Returns a data frame of available file types (pairs, hic, mcool, etc.)
experiment_files <- fourDNData('4DNESDP9ECMN')

# Filter by specific criteria in the data frame
mouse_hic <- all_files[all_files$organism == "mouse" & all_files$fileType == "hic", ]
```

### Retrieving File Paths

To get the local path (cached) for a specific file type within an experiment set, use the `type` argument.

```r
# Get the path to an .mcool file
mcool_path <- fourDNData('4DNESDP9ECMN', type = 'mcool')

# Get the path to insulation scores (BigWig)
insulation_path <- fourDNData('4DNESDP9ECMN', type = 'insulation')
```

### Importing into HiCExperiment

The package provides a high-level wrapper to import 4DN data directly into a `HiCExperiment` object, which automatically handles metadata and associated feature files.

```r
library(HiCExperiment)

# Automatically fetch and import all available files for an accession
# This typically includes the contact map and available features like compartments
hic_obj <- fourDNHiCExperiment('4DNESDP9ECMN')

# Manual import with specific resolution and genomic focus
cf <- CoolFile(
    path = fourDNData('4DNESDP9ECMN', type = 'mcool'),
    metadata = as.list(fourDNData('4DNESDP9ECMN'))
)
x <- import(cf, resolution = 250000, focus = 'chr5:10000000-50000000')
```

## Tips and Best Practices

- **Caching**: `fourDNData` uses `BiocFileCache`. The first time a file is requested, it is downloaded; subsequent calls return the local path.
- **File Types**: Supported types include `hic`, `mcool`, `pairs`, `boundaries`, `insulation`, and `compartments`.
- **Metadata**: The data frame returned by `fourDNData()` contains rich metadata including `experimentType`, `biosource`, `condition`, and `publication` info. Use this to programmatically filter datasets before downloading.
- **Integration**: For advanced analysis of the imported objects (e.g., plotting, transformations), use the `HiContacts` package alongside `HiCExperiment`.

## Reference documentation

- [fourDNData](./references/fourDNData.md)