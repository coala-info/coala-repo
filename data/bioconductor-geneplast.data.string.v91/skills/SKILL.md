---
name: bioconductor-geneplast.data.string.v91
description: This package provides evolutionary root inference data and phylogenetic trees from the STRING database version 9.1 for phylogenomic analysis. Use when user asks to retrieve COG mappings, access eukaryotic species identifiers, or perform bridge-species analysis with the geneplast package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/geneplast.data.string.v91.html
---

# bioconductor-geneplast.data.string.v91

name: bioconductor-geneplast.data.string.v91
description: Access and utilize evolutionary root inference data from STRING database v9.1. Use this skill when performing phylogenomic analysis with the geneplast package, specifically for retrieving COG mappings, species identifiers, and eukaryotic phylogenetic trees.

# bioconductor-geneplast.data.string.v91

## Overview

The `geneplast.data.string.v91` package is a dedicated data annotation package for Bioconductor. It provides the necessary input objects for the `geneplast` package to perform evolutionary root inference and bridge-species analysis. The data is derived from the STRING database (version 9.1) and focuses on Eukaryotic species.

## Data Objects

The package provides a central dataset named `gpdata_string_v91` which, when loaded, populates the R environment with four specific objects:

- **cogids**: A data frame containing 143,458 Orthologous Groups (COGs).
- **cogdata**: A mapping table linking proteins, species (ssp_id), COGs, and human gene identifiers.
- **sspids**: A metadata table for species, including IDs, names, and taxonomic domains.
- **phyloTree**: An object of class 'phylo' representing the evolutionary relationships between 121 Eukaryotic species.

## Usage and Workflow

### Loading the Data

To use the data in an R session, load the library and call the `data()` function:

```r
library(geneplast.data.string.v91)
data(gpdata_string_v91)
```

### Inspecting Components

Once loaded, you can interact with the individual objects:

```r
# View species information
head(sspids)

# Check the phylogenetic tree structure
print(phyloTree)
plot(phyloTree)

# Explore COG to Gene mappings
head(cogdata)
```

### Integration with geneplast

This package is typically used as the `ogr` (Orthologous Groups Repository) input for `geneplast` functions.

```r
library(geneplast)

# Example: Initializing a GenePlast object (requires geneplast package)
# res <- gplast(cogdata = cogdata, sspids = sspids, phyloTree = phyloTree)
```

## Tips

- **Memory Management**: The `cogdata` object can be large. Ensure your R session has sufficient memory when performing joins or filters on this data frame.
- **Species Filtering**: Use the `sspids` table to filter `cogdata` if you only need a subset of the 121 Eukaryotes for your specific analysis.
- **Version Consistency**: This package specifically uses STRING v9.1. If your analysis requires more recent STRING versions, this data may need to be supplemented or updated manually.

## Reference documentation

- [geneplast.data.string.v91 Reference Manual](./references/reference_manual.md)