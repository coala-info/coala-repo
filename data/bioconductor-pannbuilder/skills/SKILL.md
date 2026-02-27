---
name: bioconductor-pannbuilder
description: PAnnBuilder automates the assembly of proteomic annotation data and the creation of R annotation packages from diverse public databases. Use when user asks to build custom SQLite-based annotation packages, map protein identifiers, assign annotations to sequences based on similarity, or retrieve protein-specific features like subcellular locations and post-translational modifications.
homepage: https://bioconductor.org/packages/3.5/bioc/html/PAnnBuilder.html
---


# bioconductor-pannbuilder

name: bioconductor-pannbuilder
description: Assembling proteomic annotation data and building R annotation packages from diverse public sources (UniProt, IPI, RefSeq, etc.). Use this skill when you need to create custom SQLite-based annotation packages for proteins, map protein identifiers, or assign annotations to unknown sequences based on similarity.

## Overview

PAnnBuilder is a Bioconductor package designed to automate the assembly of proteomic annotation data. It extends the capabilities of the older AnnBuilder package by focusing on protein-specific features like 3D structure, subcellular location, and post-translational modifications. It supports 16+ databases and provides tools to build standard Bioconductor annotation packages (.db) for various organisms.

## Core Workflows

### 1. Building a Primary Annotation Package
Use `pBaseBuilder_DB` to create a comprehensive annotation package from major databases (IPI, SwissProt, or RefSeq).

```r
library(PAnnBuilder)

# 1. Set metadata
pkgPath <- tempdir()
author <- list(authors = "Your Name", maintainer = "your@email.com")

# 2. Build the package (e.g., Mouse IPI)
pBaseBuilder_DB(
  baseMapType = "ipi", 
  organism = "Mus musculus",
  prefix = "org.Mm.ipi", 
  pkgPath = pkgPath, 
  version = "1.0.0",
  author = author
)
```

### 2. Building Specialized Annotation Packages
PAnnBuilder provides specific builders for different types of proteomic data:

*   **Subcellular Location**: `subcellBuilder_DB(src="BaCelLo", ...)`
*   **Protein Interactions**: `intBuilder_DB(src="IntAct", ...)`
*   **Homolog/Ortholog Groups**: `HomoloGeneBuilder_DB(...)` or `InParanoidBuilder_DB(...)`
*   **Post-translational Modifications**: `ptmBuilder_DB(...)`
*   **Structural Classification**: `scopBuilder_DB(...)`

### 3. Sequence-Based Annotation (pSeqBuilder_DB)
Assign annotations to unknown proteins by comparing them against well-annotated subject packages using BLAST.

```r
# query: named character vector of sequences
# annPkgs: existing annotation packages to use as templates
pSeqBuilder_DB(
  query = my_sequences, 
  annPkgs = c("org.Hs.sp.db"), 
  seqName = c("org.Hs.spSEQ"),
  blast = c(p="blastp", e="10.0"), 
  match = c(e=0.00001, c=0.9, i=0.9),
  prefix = "my_custom_ann", 
  pkgPath = pkgPath, 
  version = "1.0.0", 
  author = author
)
```

### 4. Using Generated Packages
Once a package (e.g., `org.Hs.ipi.db`) is built and installed, use standard `AnnotationDbi` methods:

```r
library(org.Hs.ipi.db)

# List available mappings
ls("package:org.Hs.ipi.db")

# Convert mapping to list
gene_map <- as.list(org.Hs.ipiGENEID)

# Use toTable for data frames
pathway_df <- toTable(org.Hs.ipiPATH)

# Reverse mapping (e.g., Pathway to Protein)
prot_by_path <- revmap(org.Hs.ipiPATH)
```

## Key Functions Reference

*   `getALLUrl(organism)`: Retrieve download URLs for supported databases.
*   `getALLBuilt(organism)`: Check the version/release date of source data.
*   `pBaseBuilder_DB()`: Main engine for primary protein annotation packages.
*   `crossBuilder_DB()`: Creates ID mapping packages between different databases.
*   `dNameBuilder_DB()`: Creates packages mapping IDs to names (GO, KEGG, Pfam).

## Requirements & Tips

*   **External Tools**: Building packages requires **Perl** (for parsing large files) and **Rtools** (on Windows). Sequence-based builders require **BLAST+**.
*   **Disk Space**: Ensure `tempdir()` has sufficient space, as source files from UniProt or NCBI can be very large.
*   **Installation**: After running a builder, the package is created as a directory. You must install it using `R CMD INSTALL` or `devtools::install()` to use it in R.

## Reference documentation
- [Using the PAnnBuilder Package](./references/PAnnBuilder.md)