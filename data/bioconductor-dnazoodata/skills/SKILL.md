---
name: bioconductor-dnazoodata
description: This package provides programmatic access to the DNA Zoo Consortium's repository of refined genome assemblies and Hi-C contact data. Use when user asks to browse available species, download Hi-C files, or retrieve URLs for corrected genome assemblies.
homepage: https://bioconductor.org/packages/release/data/experiment/html/DNAZooData.html
---

# bioconductor-dnazoodata

## Overview

The `DNAZooData` package provides programmatic access to the DNA Zoo Consortium's repository of refined genome assemblies and Hi-C contact data. It allows users to browse available species, download cached `.hic` files, and retrieve URLs for corrected genome assemblies in FASTA format. The package is designed to work seamlessly with the `HiCExperiment` framework for downstream analysis of chromatin conformation.

## Installation

To install the package from Bioconductor:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DNAZooData")
```

## Core Workflow

### 1. Browsing Available Data
Calling `DNAZooData()` without arguments returns a data frame of all available species and their associated metadata, including assembly names and download links.

```r
library(DNAZooData)
all_data <- DNAZooData()
head(all_data[, c("species", "new_assembly", "hic_link")])
```

### 2. Fetching Specific Species Data
To download or retrieve a specific dataset, provide the species name. This returns a `HicFile` object and caches the `.hic` file locally.

```r
# Fetch data for a specific organism (e.g., Tardigrade)
hicfile <- DNAZooData(species = 'Hypsibius_dujardini')
```

### 3. Accessing Metadata
The `HicFile` object contains extensive metadata about the organism and the assembly.

```r
library(S4Vectors)
meta <- metadata(hicfile)

# View organism details
meta$organism$vernacular
meta$organism$funFact

# Get the URL for the corrected genome assembly (FASTA)
meta$assemblyURL
```

### 4. Data Exploration and Import
Once the `HicFile` is retrieved, use `HiCExperiment` functions to inspect and load the contact data.

```r
library(HiCExperiment)

# Check available resolutions (e.g., 5000, 10000, 25000, etc.)
availableResolutions(hicfile)

# Check available chromosomes/scaffolds
availableChromosomes(hicfile)

# Import a specific region into memory as a HiCExperiment object
# Focus on a specific scaffold at 10kb resolution
x <- import(hicfile, resolution = 10000, focus = 'HiC_scaffold_4')

# View interactions
interactions(x)

# Convert to a ContactMatrix for numerical analysis
cm <- as(x, 'ContactMatrix')
```

## Tips and Best Practices

- **Caching**: `DNAZooData` uses `BiocFileCache`. Subsequent calls for the same species will use the locally cached file rather than re-downloading.
- **Species Names**: Ensure species names match the format in the `DNAZooData()` table (usually `Genus_species`).
- **Memory Management**: Hi-C files can be very large. Always use the `focus` argument in `import()` to load specific chromosomes or regions rather than the entire genome at high resolution.
- **Assembly Links**: Some entries may have a `404` status in `new_assembly_link_status`; always verify the link status in the main data frame if a download fails.

## Reference documentation

- [DNAZooData](./references/DNAZooData.md)