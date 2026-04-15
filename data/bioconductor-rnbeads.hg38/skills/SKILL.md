---
name: bioconductor-rnbeads.hg38
description: This package provides annotation data for the hg38 genome assembly for use within the RnBeads DNA methylation analysis framework. Use when user asks to perform DNA methylation analysis on the hg38 assembly, retrieve CpG site annotations, or access genomic region data for GRCh38 in RnBeads.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RnBeads.hg38.html
---

# bioconductor-rnbeads.hg38

name: bioconductor-rnbeads.hg38
description: Provides annotation data for the hg38 (GRCh38) genome assembly for use with the RnBeads DNA methylation analysis framework. Use this skill when performing DNA methylation analysis in R where the reference genome is hg38, specifically for loading genomic coordinates, CpG sites, and region annotations (genes, tiling, etc.) required by RnBeads.

# bioconductor-rnbeads.hg38

## Overview

`RnBeads.hg38` is a data experiment package that serves as the annotation scaffold for the Human genome assembly hg38 within the RnBeads ecosystem. It contains the necessary mapping structures, chromosome conventions, and placeholders for sites and regions that RnBeads functions require to process methylation data (such as EPIC, 450k, or Bisulfite sequencing) mapped to hg38.

This package is typically not called directly by the user for data manipulation but is automatically loaded by `RnBeads` when the assembly is set to "hg38".

## Usage in R

### Initialization
The package is triggered when you initialize an RnBeads analysis or explicitly request hg38 annotations.

```r
library(RnBeads)
library(RnBeads.hg38)

# Check supported assemblies
rnb.get.assemblies()
```

### Accessing Annotations
You can retrieve specific genomic annotations for hg38 using the standard RnBeads API.

```r
# Get supported chromosomes for hg38
chroms <- rnb.get.chromosomes(assembly = "hg38")

# Get site annotations (e.g., CpG sites)
cpg_sites <- rnb.get.annotation(type = "sites", assembly = "hg38")

# Get region annotations (e.g., genes or tiling regions)
gene_ann <- rnb.get.annotation(type = "genes", assembly = "hg38")
tiling_ann <- rnb.get.annotation(type = "tiling", assembly = "hg38")
```

### Annotation Structure
The underlying `hg38` object is a list containing:
- **GENOME**: The Bioconductor package containing the sequence (e.g., BSgenome.Hsapiens.UCSC.hg38).
- **CHROMOSOMES**: Mapping between Ensembl (1, 2, ...) and UCSC (chr1, chr2, ...) naming conventions.
- **regions/sites**: Tables for built-in and custom genomic intervals.

### Typical Workflow Integration
When starting an RnBeads analysis from data files (IDATs or BED files), specify the assembly in the options:

```r
rnb.options(assembly = "hg38")

# When importing data, RnBeads will use RnBeads.hg38 to annotate the sites
data.set <- rnb.execute.import(data.source = data.dir, data.type = "idat.dir")
```

## Tips
- **Automatic Loading**: You rarely need to call `data(hg38)`. Calling `rnb.get.annotation` with `assembly = "hg38"` will handle the loading.
- **Memory**: Annotation objects for hg38 can be large. Ensure your R session has sufficient memory when retrieving full site-level annotations.
- **Consistency**: Ensure your input data (e.g., BAM or BED files) was actually aligned to hg38/GRCh38 before using this package, as coordinates are not compatible with hg19.

## Reference documentation
- [RnBeads.hg38 Reference Manual](./references/reference_manual.md)