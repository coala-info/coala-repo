---
name: oarfish
description: Oarfish is a high-performance tool designed for fast and accurate transcript quantification from long-read RNA-seq data using a probabilistic expectation-maximization algorithm. Use when user asks to quantify transcripts from Nanopore or PacBio reads, handle multi-mapping reads in long-read datasets, or perform single-cell RNA-seq quantification.
homepage: https://github.com/COMBINE-lab/oarfish
metadata:
  docker_image: "quay.io/biocontainers/oarfish:0.9.3--h5ca1c30_0"
---

# oarfish

## Overview
Oarfish is a high-performance tool written in Rust designed for fast and accurate transcript quantification from long-read RNA-seq technologies, including Nanopore (cDNA and direct RNA) and PacBio. It effectively handles multi-mapping reads using a probabilistic expectation-maximization (EM) algorithm. Unlike many tools that require pre-aligned BAM files, oarfish can also perform its own mapping using an internal minimap2 integration, making it a versatile choice for both alignment-based and read-based workflows.

## Installation
The most efficient way to install oarfish is via Bioconda:
```bash
conda install -c bioconda oarfish
```
Alternatively, use the helper script for the latest binary:
```bash
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/COMBINE-lab/oarfish/releases/latest/download/oarfish-installer.sh | sh
```

## Common CLI Patterns

### 1. Quantification from Aligned Reads (BAM)
Use this mode when you already have reads aligned to the transcriptome.
```bash
oarfish --alignments input.bam --output output_prefix
```

### 2. Quantification from Raw Reads (Mapping-based)
Oarfish can map reads directly to a reference transcriptome (e.g., GENCODE) and quantify in one step.
```bash
oarfish --reads reads.fastq.gz --annotated transcriptome.fa --seq-tech ont-cdna -o output_prefix
```
*Supported `--seq-tech` values: `ont-cdna`, `ont-drna`, `pac-bio`, `pac-bio-hifi`.*

### 3. Single-Cell Quantification
For single-cell data, oarfish requires a BAM file where cell barcodes are stored in the `CB:z` tag.
```bash
oarfish --alignments sc_input.bam --single-cell --threads 4 -o sc_output
```

### 4. Advanced Accuracy Features
To improve quantification accuracy, especially for long reads with non-uniform coverage, enable the coverage model and bootstrapping.
```bash
oarfish -a input.bam -o output --model-coverage --num-bootstraps 100
```

## Expert Tips and Best Practices

- **Coverage Modeling**: Always consider using the `--model-coverage` flag. It uses coverage profiles derived from aligned reads to better inform the EM algorithm, which is particularly helpful for long-read data that may have 3' or 5' biases.
- **Filtering**: By default, oarfish applies minimal filters. To use the standard filters established by NanoCount, use `--filter-group nanocount-filters`.
- **Indexing**: If you frequently map against the same transcriptome, use `--index-out <PATH>` during your first run to save the minimap2 index. In subsequent runs, provide this index using `--index <PATH>` to skip the indexing phase.
- **Thread Management**: Oarfish is multi-threaded. Note that bulk quantification requires at least 2 threads, and single-cell mode requires at least 3 due to dedicated parsing threads. Use `-j` or `--threads` to scale performance.
- **Memory Buffers**: When mapping raw reads, you can tune the memory used for alignment buffers with `--thread-buff-size` (default is 1GB).
- **Output Formats**: Oarfish produces a `.quant` file. If you need to inspect the probability of a read belonging to a specific transcript, use `--write-assignment-probs`.

## Reference documentation
- [oarfish Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_oarfish_overview.md)
- [oarfish GitHub Repository and Documentation](./references/github_com_COMBINE-lab_oarfish.md)