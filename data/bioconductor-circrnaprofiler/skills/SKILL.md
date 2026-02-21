---
name: bioconductor-circrnaprofiler
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/circRNAprofiler.html
---

# bioconductor-circrnaprofiler

## Overview
The `circRNAprofiler` package provides a modular computational framework for the downstream analysis of circular RNAs. It is designed to integrate results from various annotation-based circRNA detection tools (e.g., MapSplice2, NCLscan, CircMarker) and perform automated workflows for filtering, differential expression, and functional characterization.

## Project Initialization
The package relies on a specific directory structure. Use the initialization module to set up the environment.

```r
library(circRNAprofiler)

# Initialize project folder with subfolders for specific tools
initCircRNAprofiler(
    projectFolderName = "circ_analysis",
    detectionTools = c("mapsplice", "nclscan", "circmarker")
)
# Set the new folder as working directory
setwd("circ_analysis")
```

**Mandatory Project Files:**
- `experiment.txt`: Defines sample labels, file names, and biological conditions.
- `.gtf` file: Genome annotation (e.g., GENCODE or Ensembl).
- `circRNAs_X.txt`: Prediction results from tools placed in their respective subfolders.

## Core Workflow

### 1. Data Import and Merging
Format the annotation and import the back-spliced junction (BSJ) data.

```r
# Format GTF
gtf <- formatGTF("annotation.gtf")

# Import BSJs from all tool subfolders
bsj <- getBackSplicedJunctions(gtf)

# Merge BSJs identified by multiple tools and fix coordinates with GTF
merged_bsj <- mergeBSJunctions(bsj, gtf, fixBSJsWithGTF = TRUE)
```

### 2. Filtering and Differential Expression
Filter low-confidence circRNAs and identify significant changes between conditions.

```r
# Filter: keep circRNAs with >= 5 reads in all samples of at least one condition
filtered_bsj <- filterCirc(merged_bsj, allSamples = FALSE, min = 5)

# Differential expression using DESeq2
res_deseq <- getDeseqRes(filtered_bsj, condition = "Control-Treatment")

# Differential expression using EdgeR
res_edger <- getEdgerRes(filtered_bsj, condition = "Control-Treatment")

# Visualization
volcanoPlot(res_deseq, log2FC = 1, padj = 0.05)
```

### 3. Structural Annotation
Annotate the internal structure (exons) and flanking introns of the circRNAs.

```r
# Annotate BSJs
annotated <- annotateBSJs(filtered_bsj, gtf)

# Generate random BSJs for background comparison
random_bsj <- getRandomBSJunctions(gtf, n = nrow(annotated), f = 0.1)
annotated_bg <- annotateBSJs(random_bsj, gtf, isRandom = TRUE)
```

## Sequence Retrieval and Functional Screening

### Sequence Extraction
Retrieve sequences from a `BSgenome` object for downstream analysis.

```r
library(BSgenome.Hsapiens.UCSC.hg19)
genome <- getBSgenome("BSgenome.Hsapiens.UCSC.hg19")

# Internal circRNA sequences
circ_seqs <- getCircSeqs(annotated, gtf, genome)

# Sequences flanking the BSJ (e.g., 200nt intron + 9nt exon)
flanking_seqs <- getSeqsFromGRs(annotated, genome, lIntron = 200, lExon = 9, type = "ie")
```

### Functional Analysis
- **RBP Motifs:** Scan for RNA Binding Protein motifs using the ATtRACT or MEME databases.
- **miRNA Binding:** Search for miRNA seed matches within circRNA sequences.
- **Genomic Features:** Annotate GWAS SNPs or repetitive elements (e.g., Alu elements) in flanking introns.

```r
# RBP Motif analysis
motifs <- getMotifs(flanking_seqs, width = 6, database = 'ATtRACT', rbp = TRUE)

# miRNA binding site analysis
mir_sites <- getMiRsites(circ_seqs, miRspeciesCode = "hsa", totalMatches = 7)

# Repeat annotation (e.g., looking for complementary repeats that promote circularization)
repeats <- annotateRepeats(flanking_seqs, annotationHubID = "AH5122", complementary = TRUE)
```

## Tips and Best Practices
- **Coordinate Consistency:** Always use the same GTF file for `circRNAprofiler` that was used during the initial read mapping and circRNA detection.
- **Antisense circRNAs:** `mergeBSJunctions()` automatically identifies and removes antisense circRNAs (where the circRNA strand differs from the host gene strand) to ensure high-quality downstream analysis.
- **Normalization:** When comparing motif counts between foreground and background sets using `plotMotifs()`, normalize by the total length of the sequences analyzed.
- **Computational Time:** miRNA binding site prediction (`getMiRsites`) is computationally intensive. Filter for miRNAs expressed in your specific tissue of interest using `miRs.txt` to reduce run time.

## Reference documentation
- [circRNAprofiler: An R-based computational framework for the downstream analysis of circular RNAs](./references/circRNAprofiler.Rmd)
- [circRNAprofiler: An R-based computational framework for the downstream analysis of circular RNAs](./references/circRNAprofiler.md)