---
name: bioconductor-ripseeker
description: This tool performs statistical analysis of RIP-seq data to identify protein-associated transcripts using Hidden Markov Models. Use when user asks to predict RNA-protein binding sites, model strand-specific transcripts, or calculate RPKM and fold-change for known genes in RIP-seq experiments.
homepage: https://bioconductor.org/packages/3.5/bioc/html/RIPSeeker.html
---

# bioconductor-ripseeker

name: bioconductor-ripseeker
description: Statistical analysis of RIP-seq data to identify protein-associated transcripts. Use this skill when analyzing Ribonucleoprotein (RNP) immunoprecipitation sequencing data to predict RNA-protein binding sites (peaks), model strand-specific transcripts (e.g., antisense lncRNAs), or calculate RPKM/fold-change for known genes in RIP-seq experiments.

## Overview

RIPSeeker is a comprehensive Bioconductor package designed for the de novo prediction of RIP-seq peaks using a two-state Hidden Markov Model (HMM) with negative binomial emission probabilities. It handles the entire workflow from post-alignment processing (BAM/SAM/BED) to statistical inference, annotation, and visualization. Key features include strand-specific modeling, multihit disambiguation, and parallel processing across chromosomes.

## Core Workflow

### 1. Data Preparation
Load the library and prepare alignment files. RIPSeeker works with `GAlignments` objects.

```R
library(RIPSeeker)

# Combine technical replicates and handle strand specificity
# reverseComplement=TRUE is common for protocols sequencing the opposite strand
ripGal <- combineAlignGals(bamFiles_vector, reverseComplement = TRUE, genomeBuild = "mm9")
ctlGal <- combineAlignGals(controlFiles_vector, reverseComplement = TRUE, genomeBuild = "mm9")
```

### 2. High-Level Visualization
Before peak calling, visualize read distribution across chromosomes to assess quality.

```R
# Plot coverage for a specific chromosome (e.g., chrX)
plotStrandedCoverage(ripGRList$chrX, binSize = 1000, main = "RIP Coverage")
```

### 3. De Novo Peak Calling (ripSeek)
The `ripSeek` function is the primary interface for the HMM-based inference.

```R
seekOut <- ripSeek(
    bamPath = bamFiles,           # Paths to BAM files
    cNAME = "Control_ID",         # String to identify control files
    reverseComplement = TRUE,     # Match library protocol
    genomeBuild = "mm9",          # Reference genome
    strandType = "-",             # "+" , "-", or "both"
    uniqueHit = TRUE,             # Train HMM on unique hits
    assignMultihits = TRUE,       # Disambiguate reads mapping to multiple loci
    binSize = NULL,               # NULL triggers automatic bin size selection
    biomart = "ensembl",          # Annotation source
    goAnno = "org.Mm.eg.db",      # GO annotation database
    multicore = TRUE,             # Parallelize by chromosome
    outDir = "results_folder"     # Directory for GFF3/TXT outputs
)
```

### 4. Rule-based Analysis (Known Transcripts)
If de novo prediction is not required, use `rulebaseRIPSeek` to calculate RPKM and fold-change for known annotations.

```R
# Compute RPKM for RIP and Control
results <- rulebaseRIPSeek(
    bamFiles = all_bam_files,
    cNAME = "Control_ID",
    idType = "ensembl_transcript_id",
    biomart = "ensembl",
    dataset = "mmusculus_gene_ensembl"
)

# Access results
head(results$rpkmDF)
```

## Interpreting Results

The output of `ripSeek` is a list containing:
- `annotatedRIPGR`: A `GRanges` object containing predicted peaks, statistical scores (p-value, adj-p-value, eFDR), and Ensembl annotations.
- `enrichedGO`: GO terms associated with the identified peaks.
- `RIPGRList`: Raw peaks per chromosome with log-odd scores.

### Key Statistical Metrics
- **eFDR**: Empirical False Discovery Rate. Lower values indicate higher confidence in the RIP peak.
- **logOddScore**: The log-likelihood ratio of the RIP state vs. the background state.

## Visualization and Export
- **UCSC Browser**: Use `viewRIP(seekOut$RIPGRList$chrX, ...)` to launch an online browser session with custom tracks.
- **Files**: Check the `outDir` for `.gff3` files (for IGV) and `.txt` files (for Excel/Spreadsheets).

## Reference documentation
- [RIPSeeker](./references/RIPSeeker.md)