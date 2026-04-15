---
name: bioconductor-ctcf
description: This tool provides access to genomic coordinates of CTCF binding sites for human and mouse genomes through AnnotationHub. Use when user asks to retrieve FIMO-predicted CTCF motifs, access ENCODE SCREEN experimental data, filter binding sites by p-value, or perform coordinate liftOver between genome assemblies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/CTCF.html
---

# bioconductor-ctcf

name: bioconductor-ctcf
description: Access and analyze genomic coordinates of CTCF binding sites for human and mouse genomes. Use this skill when you need to retrieve FIMO-predicted CTCF motifs or ENCODE SCREEN experimental data from AnnotationHub, filter sites by p-value, or perform coordinate liftOver between genome assemblies (e.g., hg19 to hg38).

## Overview
The `CTCF` package provides an `AnnotationHub` resource containing genomic coordinates for CTCF binding sites. It covers human (hg18, hg19, hg38, T2T) and mouse (mm8, mm9, mm10, mm39) assemblies. Data includes both predicted sites (using various Position Weight Matrices like JASPAR, HOCOMOCO, and SwissRegulon) and experimental cis-regulatory elements (cCREs) from ENCODE SCREEN.

## Installation
```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("AnnotationHub", "GenomicRanges", "plyranges", "CTCF"))
```

## Typical Workflow

### 1. Discovering and Loading Data
Data is accessed via `AnnotationHub`.
```r
library(AnnotationHub)
ah <- AnnotationHub()
# Query for CTCF specific records
query_data <- subset(ah, preparerclass == "CTCF")

# Example: Find JASPAR 2022 sites for hg38
hg38_query <- subset(query_data, species == "Homo sapiens" & 
                                 genome == "hg38" & 
                                 dataprovider == "JASPAR 2022")

# Retrieve specific record (e.g., MA0139.1 matrix)
ctcf_hg38 <- hg38_query[["AH104729"]]
```

### 2. Data Processing and Filtering
The default FIMO p-value threshold (1e-4) is often too permissive. A threshold of **1e-6** is recommended for high-confidence sites.
```r
library(plyranges)
library(GenomeInfoDb)

# Standardize chromosomes and sort
ctcf_hg38 <- ctcf_hg38 %>% 
  keepStandardChromosomes() %>% 
  sort()

# Filter for high-confidence sites (p < 1e-6)
ctcf_filtered <- ctcf_hg38 %>% 
  filter(pvalue < 1e-6)

# Optional: Reduce overlapping sites
ctcf_reduced <- ctcf_filtered %>% reduce()
```

### 3. Exporting Data
To avoid coordinate system conversion issues (0-based vs 1-based) in `rtracklayer`, export as a data frame.
```r
write.table(as.data.frame(ctcf_filtered), 
            file = "CTCF_hg38_filtered.bed",
            sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
```

## Key Data Objects
- **Human hg38 (JASPAR MA0139.1):** `AH104729`
- **Mouse mm10 (JASPAR MA0139.1):** `AH104755`
- **ENCODE SCREEN (Experimental):** `AH104730` (hg38) or `AH104756` (mm10)
- **T2T (Telomere-to-Telomere):** Available for various PWMs (e.g., `AH104719`)

## Tips
- **Multiple PWMs:** Some objects (like `JASPAR2022_CORE_vertebrates_non_redundant_v2`) contain sites from multiple matrices, leading to high overlap (~40%). Use `reduce()` if you need unique genomic locations.
- **liftOver:** The package includes CTCFBSDB data lifted over from older assemblies (hg18/mm8) to modern ones (hg19/hg38).
- **Metadata:** FIMO-predicted objects include columns for `score`, `pvalue`, `qvalue`, and the actual `sequence` of the motif.

## Reference documentation
- [CTCF introduction](./references/CTCF.md)
- [CTCF R Markdown Source](./references/CTCF.Rmd)