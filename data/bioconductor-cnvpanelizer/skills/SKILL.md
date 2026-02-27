---
name: bioconductor-cnvpanelizer
description: CNVPanelizer detects copy number variations in amplicon-based targeted sequencing data using a subsampling strategy and background noise correction. Use when user asks to process BED files, count reads from BAM files, perform TMM normalization, or call CNVs using bootstrap-based estimation.
homepage: https://bioconductor.org/packages/release/bioc/html/CNVPanelizer.html
---


# bioconductor-cnvpanelizer

name: bioconductor-cnvpanelizer
description: Expert assistance for the CNVPanelizer R package to detect Copy Number Variations (CNVs) in amplicon-based targeted sequencing data. Use this skill when performing CNV analysis from BAM files, including BED file processing, read counting, TMM normalization, bootstrap-based CNV calling, and background noise estimation.

# bioconductor-cnvpanelizer

## Overview

CNVPanelizer is a Bioconductor package specifically designed for detecting somatic and germline CNVs in targeted sequencing (amplicon) data. It addresses the unique noise profiles of small panels by using a subsampling strategy (similar to Random Forest) and a novel background noise correction method. It is particularly effective for panels with varying numbers of amplicons per gene.

## Core Workflow

### 1. Data Preparation
The package requires a BED file defining amplicons and two sets of BAM files (Test samples and Reference samples).

```r
library(CNVPanelizer)

# 1. Process BED file
# ampliconColumn is the column index for gene names (usually 4)
genomicRanges <- BedToGenomicRanges("panel.bed", ampliconColumn = 4, split = "_")

# Extract metadata for later use
geneNames <- elementMetadata(genomicRanges)["geneNames"][, 1]
ampliconNames <- elementMetadata(genomicRanges)["ampliconNames"][, 1]
```

### 2. Read Counting
Counts reads overlapping amplicons. Mapping quality ≥ 20 is required by default.

```r
# removeDup = TRUE is recommended for Ion Torrent; FALSE for Illumina
removePcrDuplicates <- FALSE 

# Count for Reference and Test samples
refCounts <- ReadCountsFromBam(refBamFiles, genomicRanges, 
                               sampleNames = refBamFiles, 
                               ampliconNames = ampliconNames, 
                               removeDup = removePcrDuplicates)

sampleCounts <- ReadCountsFromBam(sampleBamFiles, genomicRanges, 
                                 sampleNames = sampleBamFiles, 
                                 ampliconNames = ampliconNames, 
                                 removeDup = removePcrDuplicates)
```

### 3. Normalization and CNV Calling
Uses TMM normalization followed by a bootstrap procedure to estimate confidence intervals for gene-level ratios.

```r
# Normalize
normCounts <- CombinedNormalizedCounts(sampleCounts, refCounts, ampliconNames = ampliconNames)
samplesNorm <- normCounts$samples
refNorm <- normCounts$reference

# Bootstrap (Subsampling amplicons)
# replicates = 10000 is recommended for production
bootList <- BootList(geneNames, samplesNorm, refNorm, replicates = 10000)
```

### 4. Background Noise Estimation
Corrects for bias in genes with low amplicon counts.

```r
# robust = TRUE uses median/MAD instead of mean/SD
backgroundNoise <- Background(geneNames, samplesNorm, refNorm, bootList,
                              replicates = 10000, significanceLevel = 0.1, robust = TRUE)
```

### 5. Results and Visualization
Generate tabular reports and diagnostic plots.

```r
# Generate report tables
reportTables <- ReportTables(geneNames, samplesNorm, refNorm, bootList, backgroundNoise)

# Plot distributions (returns a list of ggplot objects)
plots <- PlotBootstrapDistributions(bootList, reportTables)
# View first sample plot
print(plots[[1]])
```

## Interpreting Results

The `ReportTables` output includes several critical columns:
- **Signif.**: Boolean; TRUE if the bootstrap confidence interval (95%) does not cross 1.
- **AboveNoise**: Boolean; TRUE if the observed ratio exceeds the estimated background noise for that specific number of amplicons.
- **PutativeStatus**: The raw call (Amplification/Deletion/Normal).
- **ReliableStatus**: 
    - `2`: Reliable Change (Both Significant and Above Noise).
    - `1`: Non-Reliable Change (Significant but within noise levels).
    - `0`: No Change.

## Interactive Analysis
For a GUI-based exploration of the data and results:
```r
RunCNVPanelizerShiny(port = 8080)
```

## Reference documentation
- [CNVPanelizer](./references/CNVPanelizer.md)