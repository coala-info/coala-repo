---
name: bioconductor-rgreat
description: This tool performs Genomic Regions Enrichment of Annotations Tool (GREAT) analysis to associate non-coding genomic regions with biological functions. Use when user asks to perform functional enrichment analysis on genomic regions, associate ChIP-seq peaks with nearby genes, or run GREAT analysis locally or via the web service.
homepage: https://bioconductor.org/packages/release/bioc/html/rGREAT.html
---

# bioconductor-rgreat

name: bioconductor-rgreat
description: Perform Genomic Regions Enrichment of Annotations Tool (GREAT) analysis in R. Use this skill to associate genomic regions (e.g., ChIP-seq peaks) with biological functions using either the online GREAT web service or a local implementation. Supports multiple organisms, custom gene sets (GO, MSigDB, KEGG, Reactome), and background region sets.

# bioconductor-rgreat

## Overview
The `rGREAT` package implements the GREAT algorithm, which assigns biological functions to non-coding genomic regions by associating them with nearby genes. It supports two main modes:
1. **Local GREAT (`great()`)**: A flexible, Bioconductor-integrated version that supports any organism, custom gene sets, and large datasets.
2. **Online GREAT (`submitGreatJob()`)**: A wrapper for the official GREAT web service (supports hg38, hg19, mm10, mm9).

## Core Workflows

### 1. Local GREAT Analysis (Recommended)
Local GREAT is more robust and supports more organisms/ontologies than the web version.

```r
library(rGREAT)
library(GenomicRanges)

# 1. Prepare input regions (GRanges)
gr = GRanges(seqnames = "chr1", ranges = IRanges(start = c(100, 500), end = c(200, 600)))

# 2. Perform enrichment (Default: GO:BP for hg19)
# tss_source can be a genome string ("hg38"), TxDb object, or Gencode version ("Gencode_v19")
res = great(gr, "GO:BP", "hg19")

# 3. Get results
tb = getEnrichmentTable(res)
```

### 2. Online GREAT Analysis
Use this to replicate results from the official GREAT web server.

```r
# Submit job to GREAT server
job = submitGreatJob(gr, genome = "hg19")

# Retrieve enrichment tables (returns a list of data frames)
tbls = getEnrichmentTables(job)
```

### 3. Working with Custom Gene Sets
You can use KEGG, Reactome, or MSigDB by providing a named list of gene vectors.

```r
# Example: Using MSigDB Hallmark sets
res = great(gr, "MSigDB:H", "hg38")

# Example: Manual list of genes (Entrez IDs)
my_gs = list(SET_A = c("1", "2", "3"), SET_B = c("4", "5"))
res = great(gr, my_gs, "hg38")
```

### 4. Background and Exclusions
To avoid false positives, exclude gap regions or provide a specific background (e.g., all peaks from a specific assay).

```r
# Exclude gap regions (default behavior in local GREAT)
res = great(gr, "GO:BP", "hg19", exclude = "gap")

# Use specific background regions
res = great(gr, "GO:BP", "hg19", background = background_gr)
```

## Visualization and Reporting

- **Volcano Plot**: `plotVolcano(res)` - Visualize fold enrichment vs. p-values.
- **Region-Gene Associations**: 
  - `plotRegionGeneAssociations(res)` - Distribution of distances to TSS.
  - `getRegionGeneAssociations(res)` - Get a GRanges object showing which genes are linked to which regions.
- **Interactive Report**: `shinyReport(res)` - Launch a Shiny app to explore results.

## Tips for Success
- **Genome Versions**: Ensure your input `GRanges` and the `tss_source` (e.g., "hg19" vs "hg38") match exactly. Using the wrong version significantly degrades results.
- **Gene IDs**: Local GREAT primarily uses **Entrez IDs**. If using custom gene sets or TSS sources, ensure ID types match (e.g., use `SYMBOL` or `ENSEMBL` explicitly in `extendTSS()` if needed).
- **Distance to TSS**: By default, GREAT uses a "Basal plus extension" rule (5kb upstream, 1kb downstream, up to 1Mb extension). You can modify this in `great()` or `submitGreatJob()`.

## Reference documentation
- [Get gene-region associations for a group of GO terms](./references/group_associations.Rmd)
- [Analyze with local GREAT](./references/local-GREAT.Rmd)
- [Analyze with online GREAT](./references/online-GREAT.Rmd)
- [Work with other geneset databases](./references/other-geneset-databases.Rmd)
- [Work with other organisms](./references/other-organisms.Rmd)
- [The rGREAT package overview](./references/rGREAT.Rmd)
- [Compare GO annotations from online and local GREAT](./references/suppl_compare_GO.Rmd)
- [Compare different genome versions](./references/suppl_compare_genome_versions.Rmd)
- [Compare online and local GREAT results](./references/suppl_compare_online_and_local.Rmd)
- [Compare different TSS sources](./references/suppl_compare_tss.Rmd)
- [Use background regions](./references/suppl_use_background.Rmd)