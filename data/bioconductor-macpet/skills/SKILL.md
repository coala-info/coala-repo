---
name: bioconductor-macpet
description: bioconductor-macpet is an R package for the comprehensive analysis of ChIA-PET data, providing a full pipeline from raw reads to peak calling and genomic interaction identification. Use when user asks to filter linkers, map paired-end reads, classify PETs, call peaks using mixture models, or identify significant chromatin interactions.
homepage: https://bioconductor.org/packages/3.8/bioc/html/MACPET.html
---


# bioconductor-macpet

## Overview
MACPET is a comprehensive R package designed for the analysis of ChIA-PET (Chromatin Interaction Analysis by Paired-End Tag sequencing) data. It provides a complete pipeline from raw fastq files to significant binding sites (peaks) and genomic interactions. It uses a model-based approach (Skewed Generalized Student's-t distributions) for peak calling, which identifies binding sites more accurately than single-end algorithms.

## Core Workflow: MACPETUlt
The primary function is `MACPETUlt`, which manages the five stages of analysis. You can run all stages at once or sequentially.

```r
library(MACPET)

# Run stages 2 to 4 (Classification, Peak-calling, Interaction-calling)
MACPETUlt(
    SA_AnalysisDir = "path/to/output",
    SA_stages = c(2:4),
    SA_prefix = "Sample_Name",
    S2_PairedEndBAMpath = "path/to/paired_end.bam",
    S2_BlackList = TRUE,
    S3_image = TRUE,
    S4_image = TRUE
)
```

### The Five Stages
- **Stage 0 (Linker Filtering):** Identifies and classifies linkers in fastq files.
- **Stage 1 (Mapping):** Maps reads to the reference genome and creates a paired-end BAM file.
- **Stage 2 (PET Classification):** Classifies PETs into Self-ligated, Intra-chromosomal, or Inter-chromosomal using the elbow method.
- **Stage 3 (Peak-calling):** Uses 2D mixture models on self-ligated PETs to find binding sites.
- **Stage 4 (Interaction-calling):** Identifies significant interactions between peaks using intra-chromosomal PETs.

## Data Classes
MACPET uses specialized S4 classes (inheriting from `GInteractions`) to store results:
- `PSelf`: Self-ligated PETs (Stage 2).
- `PSFit`: Peak-calling results and PET assignments (Stage 3).
- `PIntra` / `PInter`: Intra- and Inter-chromosomal PETs (Stage 2).
- `GenomeMap`: Interaction calling results (Stage 4).

## Key Methods and Utilities

### Visualization
Use the standard `plot()` method on MACPET objects.
```r
# Plot PET counts by chromosome
plot(MACPET_pselfData)

# Visualize binding sites in a specific region (RegIndex 1 = highest PET count)
plot(MACPET_psfitData, kind = "PeakPETs", RegIndex = 1)

# Network plot of interactions
plot(MACPET_pinterData)
plot(MACPET_GenomeMapData, Type = 'network-circle')
```

### Data Extraction and Conversion
- `PeaksToGRanges(object, threshold)`: Converts peaks to a `GRanges` object.
- `TagsToGInteractions(object, threshold)`: Returns PETs belonging to significant peaks.
- `GetSignInteractions(object, threshold)`: Subsets significant interactions from a `GenomeMap`.
- `exportPeaks(object, savedir)`: Saves peak information to a CSV file.
- `PeaksToNarrowPeak(object, file.out)`: Exports peaks in narrowPeak format for external tools (MANGO/MICC).

### Statistics
- `summary(object)`: Provides a detailed breakdown of PET counts, peak counts, and genome info.
- `AnalysisStatistics(x.self, x.intra, x.inter)`: Generates a comprehensive summary table across all PET types.

### Pre-processing Utilities
- `ConvertToPE_BAM()`: Pairs two separate BAM files (Read 1 and Read 2) into a single paired-end BAM.
- `ConvertToPSelf()`: Converts a standard `GInteractions` object into a `PSelf` object for Stage 3 analysis.

## Reference documentation
- [MACPET](./references/MACPET.md)