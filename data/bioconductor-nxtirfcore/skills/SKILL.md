---
name: bioconductor-nxtirfcore
description: NxtIRFcore is an R/Bioconductor package for the quantification and differential analysis of intron retention and alternative splicing events. Use when user asks to build genomic references, quantify splicing from BAM files using the IRFinder engine, collate results into NxtSE objects, perform differential splicing analysis, or visualize RNA-seq coverage.
homepage: https://bioconductor.org/packages/3.14/bioc/html/NxtIRFcore.html
---

# bioconductor-nxtirfcore

name: bioconductor-nxtirfcore
description: Analysis of Differential Alternative Splicing (DAS) and Intron Retention (IR) using the NxtIRFcore R package. Use this skill to build genomic references, quantify IR/DAS from BAM files using the IRFinder algorithm, collate results into NxtSE objects, and perform differential analysis using limma, DESeq2, or DoubleExpSeq.

## Overview
NxtIRFcore is a comprehensive R/Bioconductor pipeline for quantifying and analyzing Intron Retention (IR) and other Alternative Splicing (AS) events. It integrates the IRFinder C++ engine into R, allowing for cross-platform execution. The workflow typically involves building a reference, quantifying BAM files, collating data into a `NxtSE` object (which extends `SummarizedExperiment`), and performing statistical testing and visualization.

## Core Workflow

### 1. Building the Reference
A NxtIRF reference is required for quantification and visualization. It uses a genome FASTA and a GTF annotation.

```r
library(NxtIRFcore)

ref_path = "./NxtIRF_Reference"

# Build from local files
BuildReference(
    reference_path = ref_path,
    fasta = "genome.fa",
    gtf = "annotation.gtf",
    genome_type = "hg38" # Supports hg38, hg19, mm10, mm9 for mappability exclusions
)

# Build using AnnotationHub resources
BuildReference(
    reference_path = ref_path,
    fasta = "AH65745",
    gtf = "AH64631",
    genome_type = "hg38"
)
```

### 2. Quantification (IRFinder)
Quantify IR and splice junctions from BAM files. This step produces `.txt.gz` and `.COV` files.

```r
# Find BAM files recursively
bams = Find_Bams("./bam_dir", level = 1)

IRFinder(
    bamfiles = bams$path,
    sample_names = bams$sample,
    reference_path = ref_path,
    output_path = "./IRFinder_output",
    n_threads = 4
)
```

### 3. Data Collation and NxtSE Object Creation
Collate individual sample outputs into a unified experiment structure.

```r
# Locate IRFinder outputs
expr = Find_IRFinder_Output("./IRFinder_output")

# Collate into a NxtIRF experiment
CollateData(
    Experiment = expr,
    reference_path = ref_path,
    output_path = "./NxtIRF_collated"
)

# Create the NxtSE object
se = MakeSE("./NxtIRF_collated", RemoveOverlapping = TRUE)
```

### 4. Filtering and Differential Analysis
Filter for expressed events and perform DAS analysis.

```r
# Apply default filters (Depth > 20, etc.)
se.filtered = se[apply_filters(se, get_default_filters()), ]

# Add metadata
colData(se.filtered)$condition = rep(c("Control", "Treat"), each = 3)

# Differential analysis (Limma)
res = limma_ASE(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "Treat",
    test_denom = "Control"
)

# Also available: DESeq_ASE() and DoubleExpSeq_ASE()
```

## Visualization

### Coverage Plots
NxtIRFcore uses `.COV` files for high-performance coverage visualization, allowing for group-based normalization.

```r
# Plot a specific event by condition
p = Plot_Coverage(
    se = se.filtered,
    Event = res$EventName[1],
    condition = "condition",
    tracks = c("Control", "Treat"),
    stack_tracks = TRUE,
    t_test = TRUE
)

# Convert to static ggplot for display
as_egg_ggplot(p)
```

### Heatmaps and Matrices
```r
# Create a PSI matrix for top events
mat = make_matrix(
    se.filtered,
    event_list = res$EventName[1:10],
    method = "PSI"
)

pheatmap::pheatmap(mat, annotation_col = as.data.frame(colData(se.filtered)))
```

## Tips and Best Practices
- **Memory Management**: For large datasets, use the `colData` argument in `MakeSE()` to load only a subset of samples.
- **IRMode**: The default `SpliceOverMax` in `CollateData` is recommended as it accounts for complex overlapping splice events.
- **Mappability**: For non-human/mouse species, use `BuildReference_Full()` with `use_STAR_mappability = TRUE` if STAR is available to calculate low-mappability regions de-novo.
- **COV Files**: These are proprietary compressed formats. Use `BAM2COV()` if you only need coverage visualization without full IR quantification.

## Reference documentation
- [NxtIRFcore: Differential Alternative Splicing and Intron Retention analysis](./references/NxtIRF.md)