---
name: bioconductor-tfutils
description: This tool provides structured access to transcription factor catalogs, target gene sets, and binding affinity predictions within the R Bioconductor environment. Use when user asks to enumerate transcription factors from catalogs, identify transcription factor targets, analyze binding affinity scores, or integrate transcription factor data with GWAS results to identify phenotypic associations.
homepage: https://bioconductor.org/packages/release/bioc/html/TFutils.html
---

# bioconductor-tfutils

name: bioconductor-tfutils
description: Tools for transcription factor (TF) bioinformatics in R. Use this skill to enumerate TFs from catalogs (CISBP, HOCOMOCO, GO), identify TF targets using MSigDb, analyze TF binding affinity scores (FIMO), and integrate TF data with GWAS results to identify phenotypic associations.

# bioconductor-tfutils

## Overview

TFutils is a Bioconductor package designed to unify disparate resources for transcription factor (TF) analysis. It provides structured access to TF catalogs, target gene sets, and quantitative binding affinity predictions. The package is particularly useful for genetic epidemiology, allowing users to link GWAS hits to TFs or their downstream targets.

## Core Workflows

### 1. Accessing TF Catalogs
TFutils provides snapshots of major TF databases. Use the TFCatalog S4 class to manage these resources.

```r
library(TFutils)

# Load CISBP catalog
data(cisbpTFcat)
TFs_CISBP = TFCatalog(name="CISBP.info", 
                      nativeIds=cisbpTFcat[,1], 
                      HGNCmap = cisbpTFcat)

# Access HOCOMOCO
data("hocomoco.mono.sep2018")
```

### 2. Integrating with GWAS Data
You can identify TFs that are directly associated with traits or find traits associated with the targets of a specific TF. This requires a GWAS catalog object (e.g., from the gwascat package).

```r
library(gwascat)
# Load example GWAS data
load(system.file("legacy/ebicat37.rda", package="gwascat"))

# Find TFs that are direct GWAS hits for a trait
hits = directHitsInCISBP("Rheumatoid arthritis", ebicat37)

# Find traits associated with the targets of a specific TF (e.g., MTF1)
# Uses the tftColl (MSigDb TF targets collection)
traits = topTraitsOfTargets("MTF1", TFutils::tftColl, ebicat37)
```

### 3. Analyzing TF Binding Affinity (FIMO)
The package includes `fimo16`, a GenomicFiles object referencing FIMO scores for 16 TFs on hg19.

```r
library(GenomicRanges)
library(GenomicFiles)

# Define a genomic region of interest
query_gr = GRanges("chr17", IRanges(38.07e6, 38.09e6))

# Extract scores for specific TFs (e.g., VDR)
# Note: fimo_granges handles the parsing of Tabix-indexed BED-like files
vdr_hits = fimo_granges(fimo16[, "VDR"], query_gr)
```

### 4. Working with TF Targets
The `tftColl` object is a GeneSetCollection containing targets for over 600 TFs/motifs.

```r
# Inspect the collection
TFutils::tftColl

# Search for specific TF target sets (e.g., NFKB)
grep("NFKB", names(TFutils::tftColl), value=TRUE)
```

### 5. ENCODE ChIP-seq Integration
The `encode690` data frame provides metadata for 690 ENCODE experiments, which can be used to retrieve cell-type-specific binding peaks via AnnotationHub.

```r
data(encode690)
head(encode690) # Columns include 'cell', 'tf', and 'ahubid'
```

## Tips and Best Practices
- **Identifier Mapping**: Many functions rely on HGNC gene symbols. Ensure your input gene lists or GWAS objects use consistent nomenclature.
- **Genomic Coordinates**: The provided `fimo16` and `gwascat_hg19_chr17` data use hg19 coordinates. Ensure your query ranges match this build.
- **Interactive Exploration**: Use the `TFtargs()` function to launch a Shiny app for interactive exploration of TF-target-GWAS associations.
- **Memory Management**: When working with `fimo16`, use `reduceByRange` or `fimo_granges` to subset data to specific intervals rather than loading entire files.

## Reference documentation
- [TFutils: Data Structures for Transcription Factor Bioinformatics](./references/TFutils.md)
- [A note on fimo16 in TFutils](./references/fimo16.md)