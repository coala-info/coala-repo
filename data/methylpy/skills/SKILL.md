---
name: methylpy
description: Methylpy is a high-performance Python pipeline designed for the end-to-end analysis of bisulfite sequencing data.
homepage: https://github.com/yupenghe/methylpy
---

# methylpy

## Overview

Methylpy is a high-performance Python pipeline designed for the end-to-end analysis of bisulfite sequencing data. It transforms raw sequencing reads (FASTQ) or alignments (BAM) into methylation readouts and statistical comparisons. Key capabilities include support for single-end and paired-end data, PCR duplicate removal, and a robust DMR calling algorithm that performs well even with low-coverage data by aggregating information from adjacent cytosines. It is compatible with both standard WGBS and specialized protocols like NOMe-seq or PBAT.

## Core Workflows and CLI Patterns

### 1. Reference Genome Preparation
Before alignment, the reference genome must be indexed. Methylpy supports Bowtie, Bowtie2, and Minimap2.

```bash
# Build reference for a specific aligner (e.g., bowtie2)
methylpy build-reference \
    --input-files genome.fa \
    --output-prefix genome_pre \
    --aligner bowtie2
```
*Note: Methylpy only processes cytosines that are in uppercase in the FASTA file. Ensure your reference is not soft-masked if you intend to analyze those regions.*

### 2. Processing Reads to Methylation State
The `call-methylation-state` function handles trimming, alignment, and methylation extraction.

```bash
# Standard pipeline from FASTQ to ALLC (methylation state) file
methylpy call-methylation-state \
    --input-fastq sample_R1.fastq.gz sample_R2.fastq.gz \
    --paired-end True \
    --sample sample_name \
    --ref-fasta genome.fa \
    --aligner bowtie2 \
    --path-to-output ./output/
```

**Expert Tips for Processing:**
- **Aligner Choice:** Use `--aligner minimap2` for faster processing in newer versions (v1.3+).
- **PBAT Data:** If using Post-Bisulfite Adaptor Tagging, include the `--pbat True` flag.
- **Duplicate Removal:** Use `--remove-duplicate True` and provide the path to Picard tools via `--picard-path`.
- **Memory Management:** Processing large datasets generates significant temporary data. Always set the `TMPDIR` environment variable to a high-capacity drive: `export TMPDIR=/path/to/large/scratch/space/`.

### 3. Differential Methylation Region (DMR) Calling
DMR finding requires ALLC files as input and identifies regions with significant methylation differences between samples.

```bash
# Identify DMRs across multiple samples
methylpy DMRfind \
    --allc-files sample1.allc.tsv.gz sample2.allc.tsv.gz \
    --samples sample1 sample2 \
    --mc-type "CGN" \
    --output-prefix dmr_results
```

**DMR Best Practices:**
- **Context:** Specify the cytosine context using `--mc-type` (e.g., "CGN" for CpG, "CHN" for non-CpG).
- **Statistical Test:** Ensure the `run_rms_tests.out` executable (compiled from `rms.cpp`) is in your PATH or the methylpy installation directory, as it is required for the root-mean-square tests used in DMR calling.
- **Low Coverage:** If data is sparse, methylpy's default behavior of combining adjacent cytosines helps maintain statistical power.

### 4. Utility Functions
- **BigWig Conversion:** Use `methylpy allc-to-bigwig` to generate browser-compatible tracks for visualization in IGV or UCSC.
- **Filtering:** Use `methylpy filter-allc` to subset data by coverage or specific genomic regions before downstream analysis.

## Reference documentation
- [github_com_yupenghe_methylpy.md](./references/github_com_yupenghe_methylpy.md)
- [anaconda_org_channels_bioconda_packages_methylpy_overview.md](./references/anaconda_org_channels_bioconda_packages_methylpy_overview.md)