---
name: flair
description: FLAIR is a computational suite that processes long-read RNA-seq data to identify, correct, and quantify high-confidence transcript isoforms. Use when user asks to align long reads to a reference, correct splice junctions, collapse reads into isoforms, quantify transcript expression, or detect gene fusions.
homepage: https://github.com/BrooksLabUCSC/flair
---

# flair

## Overview

FLAIR is a computational suite designed to transform noisy long-read RNA-seq data into high-confidence transcript models. Because long reads (particularly from Nanopore) often contain errors at splice junctions, FLAIR uses orthogonal data—such as short-read splice junctions or reference annotations—to "correct" alignments. It then collapses these corrected reads into a set of representative isoforms, quantifies their expression across samples, and provides modules for differential splicing and expression analysis.

## Core Workflow and CLI Patterns

### 1. Alignment (flair align)
Aligns raw long reads to a reference genome.
- **Basic usage**: `flair align -g genome.fa -r reads.fastq [options]`
- **Output**: Produces a filtered BED file of alignments and a BAM file.

### 2. Correction (flair correct)
Refines splice junctions using short-read data or annotations.
- **Junction Inputs**: In v3.0.0+, specify the junction source explicitly:
  - Use `--junction_bed` for BED format junctions.
  - Use `--junction_tab` for STAR-style `SJ.out.tab` files.
- **Long-read Junctions**: You can now detect junctions directly from long reads using `intronProspector` and pass them to `flair correct` via `--junction_bed`.
- **Optimization**: The `-g genome` option is no longer required in v3.0.0+, significantly increasing processing speed.

### 3. Isoform Definition (flair collapse)
Collapses corrected reads into a high-confidence transcriptome.
- **Basic usage**: `flair collapse -g genome.fa -r reads.fastq -q corrected.bed [options]`
- **CDS Prediction**: Use `--predictCDS` to include coding sequence prediction during the collapse step.
- **Internal Priming**: To remove potential artifacts, use `--remove_internal_priming` along with `--intprimingthreshold`.
- **Output**: Generates `isoforms.bed`, `isoforms.gtf`, `isoforms.fa`, and `isoform.read.map.txt`.

### 4. Quantification (flair quantify)
Quantifies isoform usage across multiple samples.
- **Manifest File**: Requires a TSV manifest linking sample names to their respective read files.
- **Basic usage**: `flair quantify -r manifest.tsv -i isoforms.fa [options]`
- **Efficiency**: v3.0.0+ features improved memory handling for large multi-sample datasets.

### 5. Streamlined Workflow (flair transcriptome)
A modern module that combines `correct` and `collapse` into a single step.
- **Input**: Runs directly from an aligned BAM file.
- **Parallelization**: Supports effective parallel processing via `--parallelmode`.

## Advanced Modules

- **flair fusion**: Detects gene fusions and fusion-specific isoforms with high accuracy.
- **flair variants**: Identifies variant-aware transcripts by clustering reads with shared variants (e.g., from Longshot).
- **flair combine**: Merges transcriptomes generated from different samples or combines fusion isoforms with standard collapsed isoforms.

## Expert Tips and Best Practices

- **MAPQ Filtering**: The default minimum MAPQ is 0 in recent versions. This allows more reads to contribute to isoform models without significantly sacrificing accuracy.
- **Annotation Parsing**: Ensure GTF files are well-formatted; v3.0.0+ has improved robustness for unsorted or complex annotation files.
- **Memory Management**: When running `quantify` on many samples, ensure your manifest is correctly formatted to take advantage of the improved multi-sample processing speed.
- **Version 3.0.0+ Changes**: Note that dependencies on `pandas` and `rpy2` have been removed, and the tool now produces sorted output files by default.



## Subcommands

| Command | Description |
|---------|-------------|
| diffsplice | Differential splicing analysis using DRIMSeq, taking isoforms and count matrices as input. |
| flair align | FLAIR align outputs an unfiltered bam file and a filtered bed file for use in the downstream pipeline |
| flair collapse | take bed file of corrected reads and generate confident collapsed isoform models |
| flair combine | Combine transcriptomes from multiple samples based on a manifest file. |
| flair correct | take bed file of long RNA-seq reads and filter out those with anomalous splice junctions correct remaining to nearest orthogonally supported splice site |
| flair diffexp | Differential expression analysis of isoforms using flair. It performs parallel DRIMSeq and filters isoforms based on expression thresholds. |
| flair fusion | FLAIR fusion detection module for identifying gene fusions from transcriptomic data. |
| flair transcriptome | Defines isoforms from genomic alignments and optional short-read junction support. |
| quantify | takes in many long-read RNA-seq reads files and quantifies them against a single transcriptome. A stringent, full-read-match-based approach |
| variants | FLAIR variants module for calling variants from isoform data. |

## Reference documentation
- [github_com_BrooksLabUCSC_flair_blob_master_README.md](./references/github_com_BrooksLabUCSC_flair_blob_master_README.md)
- [github_com_BrooksLabUCSC_flair_blob_master_CHANGELOG.md](./references/github_com_BrooksLabUCSC_flair_blob_master_CHANGELOG.md)