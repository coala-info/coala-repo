---
name: bioconductor-rnbeads.hg19
description: This package provides genomic annotations and example data for the human hg19 assembly within the RnBeads DNA methylation analysis framework. Use when user asks to retrieve hg19 chromosome information, access genomic region annotations, or perform DNA methylation analysis on human hg19 data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RnBeads.hg19.html
---

# bioconductor-rnbeads.hg19

name: bioconductor-rnbeads.hg19
description: Provides genomic annotations and example data for the hg19 (human) assembly to be used with the RnBeads DNA methylation analysis framework. Use this skill when performing DNA methylation analysis in R specifically for human hg19 data, including retrieving chromosome information, region annotations (genes, promoters, CpG islands), and site-level probe details.

## Overview
The `RnBeads.hg19` package is a data-specific annotation package for the RnBeads ecosystem. It contains the scaffold for human genome build hg19, including coordinates for sites (probes) and regions (genomic features). It is not a standalone analysis tool but a required dependency for `RnBeads` when processing human 450k, EPIC, or Bisulfite sequencing data mapped to hg19.

## Usage and Workflows

### Initialization
The annotation structures are automatically loaded when you call standard RnBeads annotation functions. You do not usually need to call `library(RnBeads.hg19)` manually if `RnBeads` is already loaded, but it must be installed.

### Accessing Annotations
Use the following `RnBeads` functions to interact with the hg19 data provided by this package:

```r
library(RnBeads)

# Get supported assemblies (hg19 should appear in this list)
rnb.get.assemblies()

# Get chromosomes available for hg19
chroms <- rnb.get.chromosomes(assembly = "hg19")

# Retrieve specific annotation tables (e.g., genes, promoters, sites)
gene_ann <- rnb.get.annotation(type = "genes", assembly = "hg19")
cpg_ann <- rnb.get.annotation(type = "cpgislands", assembly = "hg19")

# Check the number of sites or regions defined
rnb.annotation.size(type = "sites", assembly = "hg19")
```

### Example Dataset
The package includes a small subset of data for testing and demonstration purposes.

```r
# Load the example RnBeadRawSet object
data(small.example.object)

# Inspect the object (typically 12 samples and ~1,736 sites)
small.example.object
```

### Key Data Structures
- `hg19`: The main scaffold containing "regions", "sites", "controls", and "mappings".
- `regions`: A list of available region types (e.g., "genes", "promoters", "cpgislands", "tiling").
- `sites`: A list of site-level annotations (e.g., "probes450", "probesEPIC").

## Tips
- **Assembly Consistency**: Ensure your `RnBSet` object is initialized with `assembly = "hg19"` to trigger the use of this package.
- **Memory Management**: Annotation tables can be large. Use `rnb.get.annotation` only when you need to perform manual overlaps or custom filtering outside the standard RnBeads pipeline.
- **Custom Regions**: While this package provides defaults, you can add custom regions to the hg19 scaffold using `rnb.set.annotation`.

## Reference documentation
- [RnBeads.hg19 Reference Manual](./references/reference_manual.md)