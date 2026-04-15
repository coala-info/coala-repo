---
name: bioconductor-damsel
description: bioconductor-damsel provides an end-to-end workflow for the analysis of DamID sequencing data. Use when user asks to process BAM files into GATC-specific counts, identify differentially methylated regions, call peaks, associate peaks with target genes, or perform bias-corrected gene ontology analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/Damsel.html
---

# bioconductor-damsel

name: bioconductor-damsel
description: Analysis of DamID (DNA Adenine Methyltransferase Identification) data. Use this skill to process BAM files, identify differentially methylated regions, call peaks (bridges), associate peaks with target genes, and perform bias-corrected gene ontology analysis using the Damsel R package.

# bioconductor-damsel

## Overview

Damsel is an end-to-end R package for analyzing DamID data. It leverages `edgeR` for differential methylation testing and `goseq` for gene ontology analysis with length-bias correction. The workflow typically moves from raw BAM files to GATC-specific counts, differential region identification, peak calling, and finally gene annotation.

## Core Workflow

### 1. GATC Region Preparation
DamID analysis requires a GATC region file (the genomic space between GATC sites).
```r
library(Damsel)
library(BSgenome.Dmelanogaster.UCSC.dm6)

# Generate regions from a BSgenome object
regions_and_sites <- getGatcRegions(BSgenome.Dmelanogaster.UCSC.dm6)
regions <- regions_and_sites$regions
gatc_sites <- regions_and_sites$sites
```

### 2. Counting and Quality Control
Extract counts from BAM files based on the GATC regions.
```r
# Extract counts from a folder of BAM files
counts.df <- countBamInGATC(path_to_bams = "path/to/bams", regions = regions)

# Correlation heatmap (Spearman)
plotCorrHeatmap(df = counts.df, method = "spearman")

# Visualize coverage distribution
plotCountsDistribution(counts.df, constant = 1)
```

### 3. Differential Methylation Analysis
Identify regions enriched in the Fusion sample relative to the Dam-only control.
```r
# Setup edgeR object (filters, normalizes, and estimates dispersion)
# Ensure columns are ordered: Dam_1, Fusion_1, Dam_2, Fusion_2...
dge <- makeDGE(counts.df)

# Test for differentially methylated (DM) regions
dm_results <- testDmRegions(dge, p.value = 0.05, lfc = 1, regions = regions, plot = TRUE)
```

### 4. Peak Calling (Bridges)
Aggregate individual enriched GATC regions into larger "peaks" or bridges.
```r
peaks <- identifyPeaks(dm_results)
```

### 5. Gene Annotation
Associate peaks with potential target genes (default within 5kb).
```r
# Option A: Using TxDb and OrgDb
library(TxDb.Dmelanogaster.UCSC.dm6.ensGene)
library(org.Dm.eg.db)
txdb <- TxDb.Dmelanogaster.UCSC.dm6.ensGene
genes <- collateGenes(genes = txdb, regions = regions, org.Db = org.Dm.eg.db)

# Annotate peaks to genes
annotation <- annotatePeaksGenes(peaks, genes, regions = regions, max_distance = 5000)
# Access results: annotation$closest, annotation$top_five, or annotation$all
```

### 6. Visualization
Damsel provides `ggplot2` layers for genomic tracks.
```r
plotCounts(counts.df, seqnames = "chr2L", start_region = 1, end_region = 40000) +
    geom_dm(dm_results) +
    geom_peak(peaks) +
    geom_gatc(gatc_sites) +
    geom_genes_tx(genes, txdb)

# Wrap plot for a specific peak or gene ID
plotWrap(id = "PS_2", counts.df, dm_results, peaks, gatc_sites, genes, txdb)
```

### 7. Gene Ontology (Bias-Corrected)
Perform GO analysis using `goseq` to correct for the fact that longer genes contain more GATC sites and are more likely to be called significant by chance.
```r
ontology <- testGeneOntology(annotation$all, genes, regions = regions, extend_by = 2000)

# Plot top 10 results
plotGeneOntology(ontology$signif_results)
```

## Tips and Constraints
- **Column Naming**: Do not remove the `.BAM` extension from column names in `counts.df`; the package uses this suffix to identify sample columns.
- **Sample Ordering**: `makeDGE` expects samples to be paired and ordered (Control_1, Treatment_1, Control_2, Treatment_2).
- **GATC Bias**: DamID captures ~75bp from each GATC site. While regions vary in width, the biological capture is relatively uniform, so length correction is usually only needed at the Gene Ontology stage, not the counting stage.
- **Peak Aggregation**: Gaps between enriched regions $\le$ 150bp are combined into a single peak by default in `identifyPeaks`.

## Reference documentation
- [Damsel-workflow](./references/Damsel-workflow.md)
- [Damsel-workflow RMarkdown](./references/Damsel-workflow.Rmd)