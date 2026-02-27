---
name: bioconductor-svaretro
description: svaRetro identifies retrotransposed transcripts by analyzing structural variant calls for intronic deletions and exon-boundary fusions. Use when user asks to detect retrotransposed transcripts, identify processed pseudogene insertion sites, or analyze structural variants for evidence of retrotransposition.
homepage: https://bioconductor.org/packages/release/bioc/html/svaRetro.html
---


# bioconductor-svaretro

## Overview

The `svaRetro` package is designed to identify retrotransposed transcripts (RTs) by analyzing structural variant (SV) calls. It works by detecting "intronic deletions"—breakpoints that coincide with exon-intron boundaries—and identifying fusions between exon boundaries and distal genomic locations (potential insertion sites). It utilizes a breakend-centric data structure compatible with the `StructuralVariantAnnotation` package.

## Workflow

### 1. Data Preparation
Load SV calls from a VCF file and convert them into a breakend-centric `GRanges` object.

```r
library(svaRetro)
library(VariantAnnotation)
library(StructuralVariantAnnotation)

# Load VCF
vcf <- readVcf("path/to/your.vcf")

# Convert to breakend-centric GRanges
# nominalPosition=TRUE is often required for precise breakpoint mapping
rt_gr <- breakpointRanges(vcf, nominalPosition = TRUE)
```

### 2. Detecting Retrotransposed Transcripts
Use `rtDetect` to identify RT events. This requires a gene annotation object (e.g., `TxDb`).

```r
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

# Detect RTs
# maxgap: maximum distance between SV breakpoint and exon boundary
# minscore: threshold for matching
rt_results <- rtDetect(rt_gr, txdb, maxgap = 10, minscore = 0.8)
```

### 3. Interpreting Results
The output is a list of `GRanges` objects, typically named by the source gene/transcript. Each entry contains:
*   `junctions`: Exon-exon junctions (intronic deletions) supporting the processed pseudogene.
*   `insSite`: Candidate genomic insertion sites where the retrotranscript has integrated.

```r
# Inspect a specific gene's RT evidence
rt_results$GENENAME$junctions
rt_results$GENENAME$insSite
```

### 4. Visualization
RT events can be visualized using circos plots via the `circlize` package.

```r
library(circlize)

# Prepare pairs for plotting
rt_event <- c(rt_results$GENENAME$junctions, rt_results$GENENAME$insSite)
GenomeInfoDb::seqlevelsStyle(rt_event) <- "UCSC"
pairs <- breakpointgr2pairs(rt_event)

# Basic Circos Plot
circos.initializeWithIdeogram(plotType = c("ideogram", "labels"))
circos.genomicLink(
  as.data.frame(S4Vectors::first(pairs)),
  as.data.frame(S4Vectors::second(pairs))
)
circos.clear()
```

## Tips and Best Practices
*   **Breakpoint Consistency**: Ensure the input `GRanges` object is composed of valid breakpoints. `StructuralVariantAnnotation` utilities can help validate and clean the input.
*   **Annotation Matching**: Ensure the `seqlevelsStyle` (e.g., "UCSC" vs "Ensembl") of your SV calls matches your `TxDb` object.
*   **Filtering**: RT detection is sensitive to the quality of SV calls. Filter your VCF for high-confidence "PASS" variants before running `rtDetect` to reduce false positives.

## Reference documentation
- [svaRetro Quick Overview](./references/svaRetro.md)
- [svaRetro RMarkdown Source](./references/svaRetro.Rmd)