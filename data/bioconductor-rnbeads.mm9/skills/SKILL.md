---
name: bioconductor-rnbeads.mm9
description: This package provides genomic annotation data for the mouse mm9 assembly to support DNA methylation analysis within the RnBeads framework. Use when user asks to perform mouse epigenome analysis, retrieve mm9-specific genomic coordinates, or access site and region annotations for DNA methylation data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RnBeads.mm9.html
---


# bioconductor-rnbeads.mm9

name: bioconductor-rnbeads.mm9
description: Provides annotation data for the Mus musculus (mouse) genome assembly mm9 for use with the RnBeads DNA methylation analysis framework. Use this skill when performing mouse epigenome analysis in R that requires mm9-specific genomic coordinates, probe locations, or region definitions (genes, promoters, CpG islands).

# bioconductor-rnbeads.mm9

## Overview
The `RnBeads.mm9` package is a data experiment package that provides the essential genomic annotation scaffold for the mm9 (mouse) assembly. It is designed to be used in conjunction with the `RnBeads` package to facilitate DNA methylation analysis. It contains information regarding chromosomes, genomic regions (like genes and tiling regions), and site-specific annotations required for processing mouse methylation data.

## Usage in R

### Initialization
The package does not typically require manual loading of data objects. Instead, its contents are automatically accessed by `RnBeads` when the assembly is set to "mm9".

```r
library(RnBeads)
library(RnBeads.mm9)

# The annotation is triggered by standard RnBeads getter functions
rnb.get.assemblies()
rnb.get.chromosomes(assembly = "mm9")
```

### Accessing Annotations
You can retrieve specific annotation tables (e.g., for sites or regions) using the `rnb.get.annotation` function.

```r
# Get gene annotations for mm9
genes_mm9 <- rnb.get.annotation(type = "genes", assembly = "mm9")

# Get CpG island annotations
cpg_islands <- rnb.get.annotation(type = "cpgislands", assembly = "mm9")

# Check the size of the annotation
rnb.annotation.size(type = "genes", assembly = "mm9")
```

### Supported Data Structures
The `mm9` object within the package is a list containing:
- **GENOME**: The name of the Bioconductor package containing the genomic sequence.
- **CHROMOSOMES**: Supported chromosomes following Ensembl and UCSC conventions.
- **regions**: Built-in region annotation tables (e.g., genes, promoters, tiling).
- **sites**: Site and probe annotation tables.
- **controls**: Control probe annotation tables.
- **mappings**: Mapping structures for region annotations.

### Workflow Integration
When initializing an RnBeads analysis (e.g., via `rnb.run.analysis` or `rnb.execute.import`), ensure the `assembly` parameter is set to `"mm9"`.

```r
# Example of setting options for an mm9 analysis
rnb.options(assembly = "mm9")

# Import data (RnBeads will automatically use RnBeads.mm9 for annotation)
# data.source <- "path/to/idat/files"
# result <- rnb.run.import(data.source = data.source, data.type = "infinium.idat.dir")
```

## Tips
- **Automatic Loading**: You rarely need to interact with the `mm9` object directly. Use the `rnb.get.*` functional interface provided by the `RnBeads` package.
- **Consistency**: Ensure that your input data (e.g., BED files or probe IDs) actually corresponds to the mm9 assembly to avoid coordinate mismatch errors.
- **Dependencies**: This package requires `GenomicRanges` and is most useful when `RnBeads` is also installed.

## Reference documentation
- [RnBeads.mm9 Reference Manual](./references/reference_manual.md)