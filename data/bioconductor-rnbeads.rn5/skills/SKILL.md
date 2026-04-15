---
name: bioconductor-rnbeads.rn5
description: This package provides annotation data for the Rattus norvegicus genome assembly rn5 for use with the RnBeads DNA methylation analysis framework. Use when user asks to retrieve genomic coordinates, access chromosome information, or perform DNA methylation analysis on the rn5 assembly.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RnBeads.rn5.html
---

# bioconductor-rnbeads.rn5

name: bioconductor-rnbeads.rn5
description: Provides annotation data for the Rat (Rattus norvegicus) genome assembly rn5. Use this skill when performing DNA methylation analysis with the RnBeads package on rn5 data, specifically for retrieving genomic coordinates, chromosome information, and predefined genomic regions (genes, promoters, CpG islands, tiling regions).

## Overview

The `RnBeads.rn5` package is a data-centric annotation package for the Bioconductor `RnBeads` ecosystem. It contains the scaffold and metadata required to map methylation sites and probes to the rn5 (UCSC) assembly. This package is typically not called directly by the user for complex logic but is automatically loaded by `RnBeads` when the assembly is set to "rn5".

## Usage in R

### Initialization
The annotation data is automatically loaded when you call any core RnBeads annotation function. You do not usually need to call `library(RnBeads.rn5)` manually if `RnBeads` is already loaded.

```r
library(RnBeads)
# The first call to an annotation function triggers the loading of RnBeads.rn5
rnb.get.assemblies()
```

### Retrieving Annotation Data
Use the standard `RnBeads` API to access the rn5-specific data provided by this package:

```r
# Get supported chromosomes for rn5
chroms <- rnb.get.chromosomes(assembly = "rn5")

# Get genomic annotation for a specific region type (e.g., 'genes' or 'promoters')
gene_ann <- rnb.get.annotation(type = "genes", assembly = "rn5")

# Check the number of sites or regions defined
rnb.annotation.size(type = "cpgislands", assembly = "rn5")
```

### Data Structure
The package provides a scaffold (`rn5`) which is a list containing:
- `GENOME`: The name of the Bioconductor genome sequence package.
- `CHROMOSOMES`: Mapping between Ensembl and UCSC chromosome naming conventions.
- `regions`: Built-in region annotation tables (e.g., tiling, genes, promoters, CpG islands).
- `sites`: Site and probe annotation tables (e.g., CpGs).
- `controls`: Control probe annotation tables.

## Typical Workflow

1. **Set Assembly**: When initializing an RnBeads analysis (e.g., via `rnb.run.analysis` or `rnb.execute.import`), specify `assembly = "rn5"`.
2. **Automatic Loading**: RnBeads will look for `RnBeads.rn5` to resolve genomic coordinates.
3. **Custom Regions**: If you need to add custom annotations on top of the rn5 scaffold, use `rnb.set.annotation`.

## Tips
- Ensure the `BSgenome.Rnorvegicus.UCSC.rn5` package is installed if you require the actual genomic sequences, as `RnBeads.rn5` points to it.
- If you encounter errors regarding missing annotations for rn5, ensure this package is installed: `BiocManager::install("RnBeads.rn5")`.

## Reference documentation
- [RnBeads.rn5 Reference Manual](./references/reference_manual.md)