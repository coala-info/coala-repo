---
name: bioconductor-rnbeads.mm10
description: This package provides annotation data for the mouse genome assembly mm10 to support DNA methylation analysis within the RnBeads framework. Use when user asks to perform methylome analysis on mouse samples, retrieve mm10 genomic annotations for CpG sites or genes, or configure the RnBeads assembly for the GRCm38 genome.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RnBeads.mm10.html
---


# bioconductor-rnbeads.mm10

name: bioconductor-rnbeads.mm10
description: Provides annotation data for the Mouse (Mus musculus) genome assembly mm10 for use with the RnBeads DNA methylation analysis framework. Use this skill when performing methylome analysis in R for mouse samples where genomic coordinates, CpG sites, gene regions, or tiling regions based on the mm10 assembly are required.

## Overview

`RnBeads.mm10` is a data experiment package that serves as the annotation scaffold for the mm10 (GRCm38) mouse genome assembly within the `RnBeads` ecosystem. It contains the necessary metadata, chromosome conventions (Ensembl vs. UCSC), and placeholders for genomic regions (genes, promoters, CpG islands) and sites (CpG probes) specific to mouse studies.

This package is typically not called directly by the user for data processing but is automatically loaded by `RnBeads` when the assembly is set to "mm10".

## Usage in R

### Loading the Annotation
The package is usually triggered by initializing the RnBeads annotation system:

```r
library(RnBeads)
library(RnBeads.mm10)

# Check supported assemblies
rnb.get.assemblies()

# Get chromosomes for mm10
rnb.get.chromosomes(assembly = "mm10")
```

### Accessing Genomic Annotations
You can retrieve specific annotation tables (e.g., for CpG sites or genes) using the `RnBeads` API:

```r
# Get CpG site annotations for mm10
cpg_sites <- rnb.get.annotation(type = "sites", assembly = "mm10")

# Get gene region annotations
gene_regions <- rnb.get.annotation(type = "genes", assembly = "mm10")

# Check the size of the annotation (number of units)
rnb.annotation.size(type = "probes450", assembly = "mm10")
```

### Data Structure
The underlying `mm10` object is a list containing:
- `GENOME`: The Bioconductor package containing the sequence (e.g., `BSgenome.Mmusculus.UCSC.mm10`).
- `CHROMOSOMES`: Mapping between Ensembl ("1") and UCSC ("chr1") naming conventions.
- `regions`: Built-in region tables (genes, promoters, CpG islands, tiling).
- `sites`: Site-level probe or CpG information.
- `controls`: Control probe information for specific platforms.

## Workflow Integration
When starting an RnBeads analysis pipeline, ensure this package is installed so that the `data.import` and `preprocessing` modules can map your data to the mouse genome:

```r
rnb.options(assembly = "mm10")
# Subsequent calls to rnb.run.analysis() or rnb.execute.import() 
# will now use RnBeads.mm10 automatically.
```

## Reference documentation
- [RnBeads.mm10 Reference Manual](./references/reference_manual.md)