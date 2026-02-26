---
name: bioconductor-excluster
description: Bioconductor-excluster detects differentially spliced genes in RNA-seq data by comparing exon-level expression between two biological conditions. Use when user asks to identify differential splicing, convert GTF files to flattened GFF format, count exon-level reads from BAM files, or visualize exon log2 fold changes.
homepage: https://bioconductor.org/packages/release/bioc/html/ExCluster.html
---


# bioconductor-excluster

name: bioconductor-excluster
description: Robust detection of differentially spliced genes in RNA-seq data using the ExCluster R package. Use this skill when you need to identify differential splicing between two biological conditions (with at least two replicates each) by comparing exon-level expression. It supports GTF to GFF conversion, library size normalization, exon bin counting via Rsubread, and visualization of exon log2 fold changes.

## Overview

ExCluster is a Bioconductor package designed to detect significantly differentially spliced genes between exactly two conditions. It uses a robust statistical approach to minimize false positives and can optionally combine co-expressed exons into "super-exons" to increase statistical power and reduce computation time. The workflow typically involves converting a GTF annotation to a flattened GFF format, counting reads from BAM files, and running the clustering-based differential splicing analysis.

## Workflow and Functions

### 1. Annotation Preparation
Convert a standard GTF file (e.g., from GENCODE) into a flattened GFF format containing non-overlapping exon bins.

```R
library(ExCluster)

gtf_path <- "path/to/annotation.gtf"
gff_out <- "path/to/flattened.gff"

# Returns a data frame and optionally writes to disk
GFF <- GFF_convert(GTF.File = gtf_path, GFF.File = gff_out)
```

### 2. Read Counting and Normalization
Count reads per exon bin from BAM files. This step requires the `Rsubread` package (not available on Windows).

```R
bam_files <- list.files("path/to/bams", pattern = "*.bam$", full.names = TRUE)
sample_names <- c("Cond1_R1", "Cond1_R2", "Cond2_R1", "Cond2_R2")

# paired.Reads should be TRUE for paired-end data
normCounts <- processCounts(
  bam.Files = bam_files,
  sample.Names = sample_names,
  annot.GFF = GFF,
  paired.Reads = TRUE
)
```

### 3. Differential Splicing Analysis
Run the main `ExCluster` function. This process can take several hours for full genomes.

```R
# Define conditions (must be exactly two conditions, e.g., 1 and 2)
cond_nums <- c(1, 1, 2, 2)

results <- ExCluster(
  exon.Counts = normCounts,
  cond.Nums = cond_nums,
  annot.GFF = GFF,
  out.Dir = "results_folder/",
  result.Filename = "my_experiment_results",
  combine.Exons = TRUE,  # TRUE for speed/power; FALSE if suspecting aberrant splicing
  plot.Results = TRUE    # Automatically plots significant genes (FDR < 0.05)
)
```

### 4. Visualization and Export
If `plot.Results` was FALSE during the main run, or if you want to re-plot with a different FDR cutoff:

```R
# Plotting log2FC means and variances for significant genes
plotExonlog2FC(
  results.Data = results,
  out.Dir = "results_folder/plots/",
  FDR.cutoff = 0.05,
  plot.Type = "PNG" # or "PDF"
)

# Convert results to GRanges for downstream genomic analysis
library(GenomicRanges)
results_gr <- GRangesFromExClustResults(results.ExClust = results)
```

## Key Considerations

- **Operating System**: ExCluster is only compatible with Linux and macOS due to its dependency on `Rsubread`.
- **Replicates**: Requires at least two independent biological replicates per condition.
- **Conditions**: Accepts exactly two conditions at a time. For multiple comparisons, run the pipeline separately for each pair.
- **Super-Exons**: Setting `combine.Exons = TRUE` is recommended for standard analyses to increase power and speed. Set to `FALSE` only if you are looking for highly specific, non-standard splicing events.
- **FDR Cutoff**: The default significance threshold is 0.05, but it can be adjusted between 0.01 and 0.20 in the plotting functions.

## Reference documentation

- [ExCluster](./references/ExCluster.md)