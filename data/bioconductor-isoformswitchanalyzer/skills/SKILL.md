---
name: bioconductor-isoformswitchanalyzer
description: IsoformSwitchAnalyzeR identifies and analyzes isoform switches with functional consequences from RNA-seq data. Use when user asks to identify differential transcript usage, predict functional consequences of isoform switches, or visualize alternative splicing events and their genomic impacts.
homepage: https://bioconductor.org/packages/release/bioc/html/IsoformSwitchAnalyzeR.html
---

# bioconductor-isoformswitchanalyzer

name: bioconductor-isoformswitchanalyzer
description: Statistical identification and functional annotation of isoform switches from RNA-seq data. Use this skill when analyzing differential transcript usage (DTU), predicting functional consequences of isoform switches (e.g., protein domain gain/loss, NMD sensitivity), or visualizing alternative splicing events and their genomic impacts.

# bioconductor-isoformswitchanalyzer

## Overview
IsoformSwitchAnalyzeR is a Bioconductor package designed to identify and analyze isoform switches with functional consequences. Unlike standard gene-level differential expression, this package focuses on changes in the relative usage of transcripts (isoform fractions) within a gene. It integrates sequence-level information to predict how switches affect protein domains, signal peptides, and coding potential.

## Core Workflow

### 1. Data Import and Object Creation
The package uses a `switchAnalyzeRlist` object. You can import data from Salmon, Kallisto, RSEM, or StringTie.

```r
library(IsoformSwitchAnalyzeR)

# Import quantification data (Salmon example)
salmonQuant <- importIsoformExpression(parentDir = "path/to/data")

# Create design matrix
myDesign <- data.frame(
    sampleID = colnames(salmonQuant$abundance)[-1],
    condition = c("Ctrl", "Ctrl", "Treat", "Treat")
)

# Create the switchAnalyzeRlist
aSwitchList <- importRdata(
    isoformCountMatrix   = salmonQuant$counts,
    isoformRepExpression = salmonQuant$abundance,
    designMatrix         = myDesign,
    isoformExonAnnoation = "annotation.gtf",
    isoformNtFasta       = "transcripts.fasta"
)
```

### 2. Part 1: Identification and Sequence Extraction
This stage filters data, tests for differential isoform usage (DTU), and prepares sequences for external tools (Pfam, CPAT, etc.).

```r
# High-level wrapper for Part 1
aSwitchList <- isoformSwitchAnalysisPart1(
    switchAnalyzeRlist = aSwitchList,
    pathToOutput = "isoform_analysis/",
    outputSequences = TRUE # Generates fasta files for external tools
)

# Summary of switches found
extractSwitchSummary(aSwitchList)
```

### 3. External Analysis (Manual Step)
Run the generated fasta files through external servers/tools:
- **Pfam**: Protein domain identification.
- **CPAT/CPC2**: Coding potential.
- **SignalP**: Signal peptide prediction.
- **IUPred2A**: Intrinsically Disordered Regions (IDR).

### 4. Part 2: Functional Annotation and Visualization
Import external results and predict the consequences of the switches.

```r
# High-level wrapper for Part 2
aSwitchList <- isoformSwitchAnalysisPart2(
    switchAnalyzeRlist = aSwitchList,
    pathToCPC2resultFile = "cpc2_results.txt",
    pathToPFAMresultFile = "pfam_results.txt",
    pathToSignalPresultFile = "signalP_results.txt",
    outputPlots = TRUE # Generates PDF reports for top switches
)
```

## Visualization and Analysis

### Individual Gene Plots
Visualize specific genes showing the transcript structure, expression, and isoform fraction changes.
```r
switchPlot(aSwitchList, gene = "ZAK")
```

### Genome-wide Summaries
Analyze global patterns of splicing and consequences.
```r
# Summarize functional consequences (e.g., domain loss vs gain)
extractConsequenceSummary(aSwitchList)

# Analyze enrichment of specific splicing events
extractSplicingEnrichment(aSwitchList)
```

## Key Functions and Tips
- **`preFilter()`**: Always use this to remove lowly expressed isoforms or single-isoform genes before testing to increase statistical power.
- **`isoformSwitchTestDEXSeq()`**: The recommended statistical test for DTU. It handles complex designs and batch effects if they are included in the design matrix.
- **`extractTopSwitches()`**: Quickly identify the most significant switches filtered by dIF (delta Isoform Fraction) and Q-value.
- **dIF (delta Isoform Fraction)**: This is the effect size. A dIF > 0.1 means an isoform's usage changed by more than 10% of the total gene output.

## Reference documentation
- [IsoformSwitchAnalyzeR Vignette](./references/IsoformSwitchAnalyzeR.md)
- [IsoformSwitchAnalyzeR RMarkdown Source](./references/IsoformSwitchAnalyzeR.Rmd)