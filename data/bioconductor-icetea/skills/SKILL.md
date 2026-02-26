---
name: bioconductor-icetea
description: This tool analyzes transcript 5'-profiling data such as CAGE, RAMPAGE, and MAPCap to identify transcription start sites and perform differential expression analysis. Use when user asks to demultiplex 5' end sequencing data, filter PCR duplicates using UMIs, detect transcription start sites, or conduct differential TSS expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/icetea.html
---


# bioconductor-icetea

name: bioconductor-icetea
description: Analysis of transcript 5'-profiling data (CAGE, RAMPAGE, MAPCap) using the icetea R package. Use this skill to process multiplexed 5' end sequencing data, perform TSS (Transcription Start Site) detection, filter PCR duplicates using UMIs, and conduct differential TSS expression analysis.

# bioconductor-icetea

## Overview
The `icetea` (Integrating Cap Expression and Termini Annotation) package is designed for the analysis of 5'-profiling data. It is particularly optimized for paired-end, multiplexed protocols like MAPCap and RAMPAGE, but also supports conventional CAGE data. The package provides a unified workflow for demultiplexing, mapping, PCR duplicate removal, TSS calling via local enrichment of genomic windows, and differential expression analysis.

## Core Workflow: The CapSet Object
The analysis centers around the `CapSet` object, which tracks file paths and processing statistics through the pipeline.

### 1. Initialization
Create a `CapSet` object from raw or processed files.
```r
library(icetea)

# From raw multiplexed FASTQ
cs <- newCapSet(expMethod = 'MAPCap',
                fastq_R1 = "path/to/R1.fastq.gz",
                fastq_R2 = "path/to/R2.fastq.gz",
                idxList = c("barcode1", "barcode2"),
                sampleNames = c("sample1", "sample2"))

# Or from existing BAM files if already mapped/filtered
cs <- newCapSet(expMethod = 'MAPCap',
                filtered_file = c("s1.bam", "s2.bam"),
                sampleNames = c("s1", "s2"))
```

### 2. Pre-processing
If starting from raw FASTQ, follow these steps:
```r
# Demultiplexing
cs <- demultiplexFASTQ(cs, outdir = "split_fastq", ncores = 4)

# Mapping (requires Rsubread index)
cs <- mapCaps(cs, subread_index = "genome_idx", outdir = "mapped_bam")

# PCR Duplicate Filtering (uses UMIs/random barcodes in read headers)
cs <- filterDuplicates(cs, outdir = "dedup_bam")
```

### 3. TSS Detection
`icetea` uses a sliding-window approach to detect TSS based on local enrichment.
```r
# Detect TSS across groups
cs <- detectTSS(cs, 
                groups = c("ctrl", "ctrl", "treat", "treat"),
                outfile_prefix = "results/TSS_calls")

# Export results to BED
exportTSS(cs, merged = TRUE, outfile_prefix = "results/TSS_calls")
```

## Differential TSS Expression
Differential analysis is performed using `edgeR` integration. It requires biological replicates.

```r
# 1. Fit the model
csfit <- fitDiffTSS(cs, 
                    groups = c("ctrl", "ctrl", "treat", "treat"),
                    normalization = "windowTMM")

# 2. Detect differences
de_tss <- detectDiffTSS(csfit, 
                        testGroup = "treat", 
                        contGroup = "ctrl",
                        TSSfile = "results/TSS_calls_merged.bed")

# de_tss is a GRanges object containing logFC and adjusted p-values (score)
```

## Visualization and QC
- **Read Statistics**: `plotReadStats(cs, plotValue = "numbers")` shows reads remaining after each step.
- **TSS Precision**: `plotTSSprecision(reference = txdb_obj, detectedTSS = "tss.bed")` evaluates how close detected TSS are to known annotations.
- **Annotation**: `annotateTSS(tssBED = "tss.bed", txdb = txdb_obj)` provides distribution across genomic features (promoter, exon, intron, etc.).

## Tips and Best Practices
- **Memory Management**: For very large datasets, perform mapping and de-duplication outside R and initialize the `CapSet` using `filtered_file`.
- **Sample Info**: Use `sampleInfo(cs)` to view or update the metadata table containing file paths and read counts.
- **Gene Counts**: Use `getGeneCounts(cs, annotation_granges)` to summarize TSS-level data to gene-level counts for standard RNA-seq style downstream analysis.
- **Spike-ins**: If using spike-in controls, calculate factors with `getNormFactors` and pass them to the `normFactors` argument in `fitDiffTSS`.

## Reference documentation
- [Analysing transcript 5'-profiling data using icetea](./references/mapcap_analysis.Rmd)
- [Analysing transcript 5'-profiling data using icetea](./references/mapcap_analysis.md)