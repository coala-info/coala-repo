---
name: bioconductor-methyanalysis
description: This tool provides a chromosome-location-based framework for the analysis, annotation, and visualization of DNA methylation data. Use when user asks to manage MethyGenoSet objects, perform sliding-window smoothing, identify differentially methylated regions, annotate regions with genomic features, or create chromosome-location-based heatmaps.
homepage: https://bioconductor.org/packages/3.6/bioc/html/methyAnalysis.html
---

# bioconductor-methyanalysis

name: bioconductor-methyanalysis
description: Analysis and visualization of DNA methylation data using the methyAnalysis R package. Use this skill to manage MethyGenoSet objects, perform sliding-window smoothing, identify Differentially Methylated Regions (DMRs), annotate DMRs with genomic features, and create chromosome-location-based heatmaps.

## Overview
The `methyAnalysis` package provides a chromosome-location-based framework for DNA methylation analysis. It extends the `genoset` and `eSet` classes to handle methylation data (typically M-values or Beta-values) alongside genomic coordinates. It is particularly effective for Illumina Infinium arrays but can be generalized to other methylation platforms.

## Core Data Structure: MethyGenoSet
The `MethyGenoSet` class stores methylation data in the `exprs` assayData slot and genomic locations in the `rowRanges` slot.

```R
library(methyAnalysis)
data(exampleMethyGenoSet)

# Access methylation data (M-values by default)
m_values <- exprs(exampleMethyGenoSet)

# Access genomic locations
coords <- rowRanges(exampleMethyGenoSet)

# Access sample metadata
metadata <- colData(exampleMethyGenoSet)
```

## Identifying Differentially Methylated Regions (DMR)

### 1. Smoothing Data
Nearby CpG sites are highly correlated. Smoothing reduces noise before differential testing.
```R
# Default winSize is 250bp (half-window)
methyGenoSet.sm <- smoothMethyData(exampleMethyGenoSet, winSize = 250)
```

### 2. Differential Testing
Perform sliding-window differential tests (t-test or wilcox-test).
```R
sampleType <- colData(exampleMethyGenoSet)$SampleType
# detectDMR.slideWin performs smoothing automatically if not already done
allResult <- detectDMR.slideWin(exampleMethyGenoSet, sampleType = sampleType, testMethod = 't-test')
```

### 3. Defining DMRs
Merge differentially methylated probes into continuous regions.
```R
# Returns a list with 'sigDMRInfo' (regions) and 'sigDataInfo' (probes)
allDMRInfo <- identifySigDMR(allResult)
```

## Annotation and Export
Annotate DMRs with gene elements (promoters, exons) using a Transcript Database (TxDb).

```R
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

# Annotate
DMRInfo.ann <- annotateDMRInfo(allDMRInfo, annotationDatabase = txdb)

# Export to CSV
export.DMRInfo(DMRInfo.ann, savePrefix = 'my_results')
```

## Visualization

### External Visualization
Export data for IGV or other genome browsers.
```R
# Export as IGV .gct file
export.methyGenoSet(exampleMethyGenoSet, file.format = 'gct', savePrefix = 'export_file')

# Export as BigWig (.bw) files (one per sample)
export.methyGenoSet(exampleMethyGenoSet, file.format = 'bw', savePrefix = 'export_file')
```

### Chromosome Heatmaps
Create localized heatmaps showing methylation levels relative to gene models.
```R
# Heatmap by Gene ID
heatmapByChromosome(exampleMethyGenoSet, 
                    gene = '6493', 
                    genomicFeature = txdb, 
                    includeGeneBody = TRUE)

# Heatmap with phenotype side-panel (uses Beta-values 0-1 by default)
plotMethylationHeatmapByGene(geneID = '6493', 
                             methyGenoSet = exampleMethyGenoSet,
                             phenoData = colData(exampleMethyGenoSet), 
                             genomicFeature = txdb)
```

## Reference documentation
- [methyAnalysis](./references/methyAnalysis.md)