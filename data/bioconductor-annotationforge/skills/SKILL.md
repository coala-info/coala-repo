---
name: bioconductor-annotationforge
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/AnnotationForge.html
---

# bioconductor-annotationforge

## Overview

The `AnnotationForge` package is the primary toolkit for building Bioconductor annotation resources. It allows users to "forge" SQLite-based packages that follow the `AnnotationDbi` standard (providing `select()`, `columns()`, and `keys()` interfaces). It supports creating Organism-level packages (`OrgDb`), platform-specific chip packages (`ChipDb`), and probe sequence packages.

## Core Workflows

### 1. Creating Organism Packages (OrgDb)

Organism packages map central gene identifiers (GIDs) to various annotations like Symbols, GO terms, and Chromosomes.

**From NCBI (Easiest):**
Use this if the organism has a valid NCBI Taxonomy ID.
```r
library(AnnotationForge)
makeOrgPackageFromNCBI(
  version = "0.1.0",
  author = "Your Name <email@example.com>",
  maintainer = "Your Name <email@example.com>",
  outputDir = ".",
  tax_id = "59729",
  genus = "Taeniopygia",
  species = "guttata"
)
```

**From Custom Data Frames:**
Use this when you have proprietary data or non-NCBI sources. Every data frame must have a "GID" column.
```r
# Example data frames
gene_info <- data.frame(GID=c("1","2"), SYMBOL=c("GENEA", "GENEB"))
chrom <- data.frame(GID=c("1","2"), CHROMOSOME=c("1", "2"))

makeOrgPackage(
  gene_info = gene_info,
  chromosome = chrom,
  version = "0.1.0",
  maintainer = "Your Name <email@example.com>",
  author = "Your Name <email@example.com>",
  outputDir = ".",
  tax_id = "0000",
  genus = "Genusname",
  species = "speciesname",
  goTable = NULL # Set to the name of the GO data frame if applicable
)
```

### 2. Creating Chip Packages (ChipDb) via SQLForge

SQLForge builds packages that map manufacturer-specific IDs (probes) to gene identifiers using "base" organism databases (`.db0` packages).

1.  **Identify the Schema:** Use `available.dbschemas()` to find the correct template (e.g., "HUMANCHIP_DB").
2.  **Install Support DBs:** Install the required `.db0` package (e.g., `BiocManager::install("human.db0")`).
3.  **Prepare ID Map:** Create a 2-column tab-delimited file (no header) with `ProbeID` and `GeneID` (Genbank, Entrez, or RefSeq).
4.  **Build:**
```r
makeDBPackage(
  "HUMANCHIP_DB",
  prefix = "myCustomChip",
  fileName = "path/to/id_map.txt",
  baseMapType = "gb", # 'gb' for Genbank, 'eg' for Entrez, 'refseq' for RefSeq
  outputDir = tempdir(),
  version = "1.0.0",
  manufacturer = "MyLab",
  chipName = "Custom Array"
)
```

### 3. Creating Probe Packages

Probe packages store the actual nucleotide sequences of reporters on an array.

```r
makeProbePackage(
  "HG-U95Av2",
  datafile = gzfile("HG-U95Av2_probe_tab.gz", open="r"),
  outdir = tempdir(),
  maintainer = "Your Name <email@example.com>",
  species = "Homo_sapiens",
  version = "0.0.1"
)
```

## Key Functions and Tips

- **`available.db0pkgs()`**: Lists available organism-level base databases required for SQLForge.
- **`available.dbschemas()`**: Lists supported database structures for different organisms and chip types.
- **GO Data Requirements**: When using `makeOrgPackage` with a `goTable`, the data frame must have exactly three columns: `GID`, `GO`, and `EVIDENCE`.
- **Installation**: After generating a package directory, install it using `install.packages("./packageName", repos=NULL, type="source")`.
- **Naming Convention**: OrgDb packages are typically named `org.<GenusAbbreviation>.<speciesAbbreviation>.eg.db` (e.g., `org.Hs.eg.db`).

## Reference documentation

- [Creating select Interfaces for custom Annotation resources](./references/MakingNewAnnotationPackages.md)
- [Making Organism packages](./references/MakingNewOrganismPackages.md)
- [Creating a New Annotation Package using SQLForge](./references/SQLForge.md)
- [Creating probe packages](./references/makeProbePackage.md)