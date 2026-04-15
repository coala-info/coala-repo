---
name: bioconductor-genestructuretools
description: This tool analyzes and manipulates gene structures to evaluate the functional impact of alternative splicing events. Use when user asks to import splicing results from Whippet or Leafcutter, generate in silico transcript isoforms for splicing events, or analyze functional consequences like ORF changes and NMD potential.
homepage: https://bioconductor.org/packages/release/bioc/html/GeneStructureTools.html
---

# bioconductor-genestructuretools

name: bioconductor-genestructuretools
description: Analysis and manipulation of gene structures from alternative splicing data. Use this skill to import Whippet, Leafcutter, or DEXSeq results, create in silico transcript isoforms for splicing events (exon skipping, intron retention, etc.), and analyze functional consequences like ORF changes and NMD potential.

# bioconductor-genestructuretools

## Overview
GeneStructureTools provides a framework for investigating the functional impact of alternative splicing. It allows users to take differential splicing events identified by tools like Whippet or Leafcutter and generate the corresponding transcript sequences and structures. Key capabilities include annotating Open Reading Frames (ORFs), calculating UTR changes, and predicting the likelihood of Nonsense Mediated Decay (NMD).

## Core Workflow

### 1. Data Import and Preparation
The package supports several splicing analysis tools. You typically need a GTF annotation and a BSgenome object for sequence extraction.

```r
library(GeneStructureTools)
library(GenomicRanges)
library(BSgenome.Mmusculus.UCSC.mm10)

# Load GTF and extract exons/transcripts
gtf <- rtracklayer::import("path/to/annotation.gtf")
exons <- gtf[gtf$type == "exon"]
transcripts <- gtf[gtf$type == "transcript"]

# Import Whippet data
wds <- readWhippetDataSet("path/to/whippet_files/")
```

### 2. Summarizing Transcript Changes
Use high-level functions to quickly assess how splicing affects gene structures across a dataset.

```r
# For Whippet
whippet_summary <- whippetTranscriptChangeSummary(wds, 
                                                  exons = exons, 
                                                  transcripts = transcripts, 
                                                  BSgenome = BSgenome.Mmusculus.UCSC.mm10,
                                                  NMD = FALSE)

# For Leafcutter
leafcutter_summary <- leafcutterTranscriptChangeSummary(intron_results, 
                                                        exons = exons, 
                                                        BSgenome = BSgenome.Mmusculus.UCSC.mm10)
```

### 3. Manual Isoform Creation
You can manually create "included" vs "skipped" (or "retained" vs "spliced") isoforms for specific events to perform detailed comparisons.

*   **Exon Skipping (CE):** Use `findExonContainingTranscripts` followed by `skipExonInTranscript`.
*   **Intron Retention (RI):** Use `findIntronContainingTranscripts` followed by `addIntronInTranscript`.
*   **Alternative Sites (AA/AD/AF/AL):** Use `findJunctionPairs` followed by `replaceJunction`.

### 4. ORF and Functional Analysis
Analyze how the alternative structure changes the protein-coding potential.

```r
# Get ORF details (returns coordinates, lengths, and sequences)
orfs <- getOrfs(myTranscripts, BSgenome = g, returnLongestOnly = FALSE, allFrames = TRUE)

# Compare two sets of isoforms (e.g., included vs skipped)
orf_diff <- orfDiff(orfsX = orfs_included, 
                    orfsY = orfs_skipped, 
                    geneSimilarity = TRUE, 
                    compareUTR = TRUE)
```

### 5. NMD Prediction
If the `notNMD` package is installed, you can integrate NMD probability into the workflow by setting `NMD = TRUE` in summary functions or using `predictNMD` on the ORF objects.

## Tips and Best Practices
*   **Pre-annotate GTF:** Adding "first/last" exon annotations to your GRanges object (using `exon_number`) significantly speeds up junction finding and isoform generation.
*   **Broad Biotypes:** Use `addBroadTypes(gtf)` to simplify complex Gencode biotypes into broader categories like `lncRNA`, `nmd`, or `protein_coding`.
*   **Visualization:** The package integrates well with `Gviz`. Use `makeGeneModel()` to convert GeneStructureTools outputs into a format compatible with `GeneRegionTrack`.
*   **DEXSeq Integration:** Use `findDEXexonType()` to annotate which part of a gene (CDS, UTR5, UTR3) a DEXSeq differential exonic part overlaps.

## Reference documentation
- [Introduction to GeneStructureTools](./references/Vignette.md)