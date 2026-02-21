---
name: isoncorrect
description: isONcorrect is a specialized tool for error-correcting ONT cDNA reads.
homepage: https://github.com/ksahlin/isONcorrect
---

# isoncorrect

## Overview
isONcorrect is a specialized tool for error-correcting ONT cDNA reads. Unlike genomic error-correctors, it is designed to handle the unique challenges of transcriptomics, such as alternative splicing and extreme differences in transcript abundance. It leverages shared exon regions across different isoforms to correct low-abundance transcripts using information from high-abundance ones. This skill provides guidance on running the standalone corrector and the recommended multi-step pipeline.

## Installation and Setup
The tool is primarily distributed via Bioconda. It requires `spoa` as a critical dependency.

```bash
# Recommended installation via Conda
conda create -n isoncorrect python=3.9
conda activate isoncorrect
conda install -c bioconda isoncorrect spoa
```

## Core Usage Patterns

### Single Cluster Correction
Use the base command when you have a specific set of reads (e.g., from a single gene cluster) that needs correction.

```bash
isONcorrect --fastq input_cluster.fastq --outfolder ./output_dir --t 8
```

### Batch Processing (Recommended)
For full datasets, use `run_isoncorrect` to process multiple fastq files (clusters) in parallel.

```bash
run_isoncorrect --t 16 --fastq_folder ./clustered_fastq_dir/ --outfolder ./corrected_output/
```

## Recommended Pipeline Workflow
For raw ONT cDNA reads, the author recommends a specific upstream pipeline before running isONcorrect:

1.  **Full-length Identification**: Use `pychopper` (cdna_classifier.py) to identify full-length reads.
2.  **Clustering**: Use `isONclust` to group reads into gene-level clusters.
3.  **Fastq Generation**: Use `isONclust write_fastq` to create individual files for each cluster.
4.  **Correction**: Run `run_isoncorrect` on the folder containing the cluster files.

## Expert Tips and Parameters

### Accuracy vs. Performance
Since version 0.0.8, default parameters prioritize speed and memory efficiency.
*   **Default (Fast)**: `--k 9 --w 20 --max_seqs 2000` (98.5-99.3% accuracy).
*   **High Accuracy (Paper Settings)**: `--k 9 --w 10 --max_seqs 1000` (98.9-99.6% accuracy).

### Handling Large Clusters
If your data contains targeted sequences or extremely high-abundance genes, `isONclust` may produce a few massive clusters that bottleneck the process.
*   **Optimization**: Add the `--split_wrt_batches` flag to `run_isoncorrect` to improve load balancing across cores for uneven cluster sizes.

### Output Structure
The tool generates one `corrected_reads.fastq` file per input cluster. To create a final dataset for downstream analysis (like mapping or isoform collapse), concatenate these files:
```bash
cat ./corrected_output/*/corrected_reads.fastq > all_corrected_reads.fq
```

## Reference documentation
- [isONcorrect GitHub Repository](./references/github_com_ksahlin_isONcorrect.md)
- [Bioconda isoncorrect Overview](./references/anaconda_org_channels_bioconda_packages_isoncorrect_overview.md)