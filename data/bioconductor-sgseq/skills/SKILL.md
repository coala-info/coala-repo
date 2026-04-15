---
name: bioconductor-sgseq
description: SGSeq analyzes alternative splicing in RNA-seq data using a splice graph representation. Use when user asks to analyze alternative splicing, construct splice graphs, quantify splice variants, calculate PSI, predict novel transcript features, or visualize splice events.
homepage: https://bioconductor.org/packages/release/bioc/html/SGSeq.html
---

# bioconductor-sgseq

## Overview

SGSeq is a Bioconductor package designed to analyze alternative splicing using a splice graph representation. It processes BAM files (from splice-aware aligners like STAR, HISAT2, or GSNAP) to identify transcript features (exons and junctions), construct splice graphs, and quantify splice variants. It supports both annotation-based analysis and *de novo* prediction of novel splice sites and exons.

## Core Workflow

### 1. Sample Information
SGSeq requires a `data.frame` or `DataFrame` containing sample metadata. Use `getBamInfo()` to automatically extract library statistics from BAM files.

```r
library(SGSeq)
# Required columns: sample_name, file_bam
si <- data.frame(
  sample_name = c("N1", "T1"),
  file_bam = c("path/to/n1.bam", "path/to/t1.bam"),
  stringsAsFactors = FALSE
)
# Extract read length, fragment length, and library size
si <- getBamInfo(si)
```

### 2. Feature Analysis (Annotation-based)
To analyze splicing based on known transcripts, convert a `TxDb` object to `TxFeatures`, then to `SGFeatures`.

```r
# Extract features from TxDb
txf <- convertToTxFeatures(txdb)
# Convert to splice graph features (disjoins overlapping exons)
sgf <- convertToSGFeatures(txf)
# Quantify features across samples
sgfc <- analyzeFeatures(si, features = txf)
```

### 3. De Novo Prediction
To discover novel splice events, SGSeq can predict features directly from BAM files.

```r
# Predict features within a specific genomic range
gr <- GRanges("chr16", IRanges(87362930, 87393901), strand = "-")
sgfc_pred <- analyzeFeatures(si, which = gr)

# Annotate predicted features with known gene/transcript names
sgfc_pred <- annotate(sgfc_pred, txf)
```

### 4. Splice Variant Identification and PSI
Splice events are identified as alternative paths in the graph. Relative usage is quantified as "Percentage Spliced In" (PSI/$\Psi$).

```r
# Identify variants and calculate PSI
sgvc <- analyzeVariants(sgfc_pred)

# Access PSI values (variantFreq assay)
psi_values <- variantFreq(sgvc)

# Access variant metadata (e.g., variantType like SE for skipped exon)
mcols(sgvc)$variantType
```

### 5. Visualization
SGSeq provides high-level plotting functions for splice graphs and heatmaps.

```r
# Plot splice graph and feature expression heatmap
plotFeatures(sgfc, geneID = 1)

# Plot specific splice event and variant usage
plotVariants(sgvc, eventID = 1)

# Plot per-base coverage and junction counts
plotCoverage(sgfc[, 1], geneID = 1)
```

## Advanced Tasks

### Variant Effect Prediction
Predict how alternative splicing affects the protein-coding sequence.

```r
library(BSgenome.Hsapiens.UCSC.hg19)
vep <- predictVariantEffects(sgvc, txdb, Hsapiens)
```

### Differential Splicing
SGSeq does not perform statistical testing directly but provides counts compatible with `DEXSeq` or `limma`. Use `getSGVariantCounts()` to obtain a single count per variant (assay `countsVariant5pOr3p`) for these tools.

```r
sgvc_counts <- getSGVariantCounts(rowRanges(sgvc), sample_info = si)
counts_matrix <- counts(sgvc_counts)
```

## Tips and Constraints
- **BAM Requirements**: BAM files must be indexed and contain the `XS` tag (provided by most splice-aware aligners) to indicate strand.
- **Memory**: For genome-wide analysis, process by chromosome or gene clusters to manage memory. Use the `cores` argument in `analyzeFeatures` for parallelization.
- **Library Size**: Ensure `lib_size` in sample info reflects the total aligned fragments in the original BAM, even if working with subsetted BAMs, to ensure accurate FPKM calculation.

## Reference documentation
- [Splice event prediction and quantification from RNA-seq data](./references/SGSeq.md)