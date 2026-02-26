---
name: bioconductor-htseqgenie
description: HTSeqGenie provides an integrated pipeline for the end-to-end analysis of high-throughput sequencing data such as RNA-Seq and Exome-Seq. Use when user asks to perform read preprocessing, align reads using GSNAP, count genomic features, or generate coverage reports and RPKM values.
homepage: https://bioconductor.org/packages/3.8/bioc/html/HTSeqGenie.html
---


# bioconductor-htseqgenie

name: bioconductor-htseqgenie
description: Analyze high-throughput sequencing data (RNA-Seq, Exome-Seq) using the HTSeqGenie pipeline. Use this skill for end-to-end NGS workflows including preprocessing, alignment with GSNAP, genomic feature counting, and coverage computation.

# bioconductor-htseqgenie

## Overview

HTSeqGenie is an integrated pipeline for the analysis of high-throughput sequencing experiments. It wraps several Bioconductor packages (ShortRead, gmapR, GenomicRanges) to provide a unified workflow for RNA-Seq and Exome-Seq data. The package is designed for reproducibility, using configuration files or lists to define parameters for preprocessing, alignment, and quantification.

## Core Workflow

The primary entry point is the `runPipeline` function, which executes the entire analysis based on a configuration.

### 1. Setup Configuration
Configuration can be provided as a named list or a DCF file.

```r
library(HTSeqGenie)

# Define basic parameters
config <- list(
  ## Input
  input_file = "sample_R1.fastq.gz",
  input_file2 = "sample_R2.fastq.gz", # Optional for paired-end
  paired_ends = TRUE,
  quality_encoding = "illumina1.8",
  
  ## Genome and Features
  path.gsnap_genomes = "/path/to/gsnap_indices",
  alignReads.genome = "hg19",
  path.genomic_features = "/path/to/features",
  countGenomicFeatures.gfeatures = "human_features.RData",
  
  ## Output
  save_dir = "analysis_results",
  prepend_str = "sample1",
  overwrite_save_dir = "erase"
)
```

### 2. Execute Pipeline
The `runPipeline` function returns the path to the output directory.

```r
output_dir <- do.call(runPipeline, config)
```

### 3. Accessing Results
HTSeqGenie organizes output into specific subdirectories:
- `bams/`: Aligned BAM files and indexes.
- `results/`: Tab-separated files for counts and summary statistics.
- `reports/`: HTML quality control reports.
- `logs/`: Audit trails and progress logs.

Use `getTabDataFromFile` to load count data into R:

```r
# Load gene counts
gene_counts <- getTabDataFromFile(output_dir, "counts_gene")

# Load exon counts
exon_counts <- getTabDataFromFile(output_dir, "counts_exon")
```

## Key Modules and Parameters

### Preprocessing
Controlled by `preprocessReads`.
- `trimReads.do`: Set to `TRUE` to enable trimming.
- `filterQuality.do`: Filter reads based on nucleotide quality (default `TRUE`).
- `subsample_nbreads`: Useful for testing pipelines on a subset of data.

### Alignment
Uses the GSNAP aligner via `gmapR`.
- `alignReads.snp_index`: Path to a SNP database for SNP-tolerant alignment.
- `alignReads.splice_index`: Path to a splice site index for RNA-Seq.

### Counting
Counts overlaps with genomic intervals.
- `countGenomicFeatures.do`: Enable/disable feature counting.
- RPKM values are automatically calculated and included in the `.tab` output files.

## Tips for Success
- **Genome Objects**: Ensure your `GmapGenome` object and genomic features (GRanges) are compatible and correctly indexed.
- **Memory Management**: For large datasets, use `num_cores` to parallelize, but monitor RAM usage as GSNAP can be memory-intensive.
- **Quality Encoding**: If `quality_encoding` is not specified, the package attempts to guess, but explicit definition (e.g., "sanger", "illumina1.8") is safer.
- **Downstream Analysis**: The output of `getTabDataFromFile` is formatted for easy integration with differential expression packages like `DESeq2` or `edgeR`.

## Reference documentation

- [HTSeqGenie](./references/HTSeqGenie.md)