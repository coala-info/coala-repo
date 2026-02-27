---
name: bioconductor-mageckflute
description: MAGeCKFlute performs downstream analysis and visualization of CRISPR/Cas9 screen data. Use when user asks to process MAGeCK RRA or MLE results, perform quality control on CRISPR read counts, normalize beta scores, identify essential genes, or conduct functional enrichment analysis.
homepage: https://bioconductor.org/packages/3.8/bioc/html/MAGeCKFlute.html
---


# bioconductor-mageckflute

name: bioconductor-mageckflute
description: Downstream analysis and visualization of CRISPR/Cas9 screen data. Use this skill to process MAGeCK RRA or MLE results, perform quality control on read counts, normalize beta scores, identify essential genes, and conduct functional enrichment analysis (GO, KEGG, CORUM).

## Overview

MAGeCKFlute is a Bioconductor package designed for the integrative analysis of pooled CRISPR functional genetic screens. It serves as a downstream companion to MAGeCK and MAGeCK-VISPR, providing tools for quality control, data normalization (including cell-cycle effect removal), and biological interpretation. It supports identifying essential, non-essential, and treatment-associated genes through various visualization techniques and enrichment analysis methods.

## Core Workflows

### 1. Quality Control of Read Counts
Before gene-level analysis, evaluate the quality of the library and sequencing.
```r
library(MAGeCKFlute)
data("countsummary") # Example data

# Visualize mapping rates
MapRatesView(countsummary)

# Check library evenness (Gini Index)
IdentBarView(countsummary, x = "Label", y = "GiniIndex", ylab = "Gini index", main = "Evenness of sgRNA reads")

# Check for missed sgRNAs (Zero counts)
countsummary$Missed = log10(countsummary$Zerocounts)
IdentBarView(countsummary, x = "Label", y = "Missed", fill = "#394E80", ylab = "Log10 missed gRNAs")
```

### 2. MAGeCK RRA Analysis (Two-condition comparison)
Use RRA results to identify genes with significant positive or negative selection.
```r
data("rra.gene_summary")
data("rra.sgrna_summary")

# Automated pipeline
FluteRRA(rra.gene_summary, rra.sgrna_summary, prefix="RRA", organism="hsa")

# Manual visualization
dd.rra = ReadRRA(rra.gene_summary, organism = "hsa")
VolcanoView(dd.rra, x = "LFC", y = "FDR", Label = "Official")

# Rank view of top hits
geneList = dd.rra$LFC
names(geneList) = dd.rra$Official
RankView(geneList, top = 10, bottom = 10)
```

### 3. MAGeCK MLE Analysis (Multi-condition/Beta Scores)
MLE provides beta scores representing the degree of selection.

**Normalization and Batch Correction:**
```r
data("mle.gene_summary")
dd = ReadBeta(mle.gene_summary, organism="hsa")

# Remove batch effects if necessary
# edata1 = BatchRemove(edata, batchMat)

# Normalize beta scores (cell_cycle method is recommended for CRISPR screens)
dd_essential = NormalizeBeta(dd, samples=c("dmso", "plx"), method="cell_cycle")

# Visualize distribution after normalization
DensityView(dd_essential, samples=c("dmso", "plx"))
```

**Identifying Hits and 9-Square Model:**
The 9-square model groups genes based on their selection status in control vs. treatment.
```r
# Scatter plot of Control vs Treatment
ScatterView(dd_essential, "dmso", "plx")

# 9-square model visualization
p3 = SquareView(dd_essential, label = "Gene")
# Access grouped data
square_data = p3$data 
```

### 4. Functional Enrichment Analysis
Perform enrichment on selected gene sets using Over-Representation Test (ORT), GSEA, or Hypergeometric Test (HGT).
```r
# Example: HGT enrichment for CORUM complexes
universe = dd.rra$EntrezID
geneList = dd.rra$LFC
names(geneList) = universe

enrich = enrich.GSE(geneList = geneList, type = "CORUM")
EnrichedGSEView(slot(enrich, "result"))

# KEGG Pathway visualization
genedata = dd_essential[, c("dmso", "plx")]
# Visualize specific pathway (e.g., first hit)
keggID = gsub("KEGG_", "", slot(enrich, "result")$ID[1])
arrangePathview(genedata, pathways = keggID, organism = "hsa")
```

## Key Functions
- `FluteRRA` / `FluteMLE`: Comprehensive wrapper pipelines for RRA and MLE outputs.
- `ReadBeta` / `ReadRRA`: Parsers for MAGeCK output files.
- `NormalizeBeta`: Normalizes beta scores using `cell_cycle` or `loess` methods.
- `SquareView`: Implements the 9-square logic to identify treatment-specific hits.
- `EnrichedView` / `EnrichedGSEView`: Standardized plotting for enrichment results.
- `KeggPathwayView`: Overlays screen data onto KEGG pathway maps.

## Tips
- **Organism Support**: Ensure the `organism` parameter (e.g., "hsa" for human, "mmu" for mouse) matches your data.
- **Gene IDs**: The package often requires Entrez IDs for enrichment functions; use `TransID` if conversion is needed.
- **Cell Cycle Normalization**: Use `method="cell_cycle"` in `NormalizeBeta` to account for different proliferation rates between conditions, which is a common bias in CRISPR screens.

## Reference documentation
- [Integrative analysis pipeline for pooled CRISPR functional genetic screens - MAGeCKFlute](./references/MAGeCKFlute.md)