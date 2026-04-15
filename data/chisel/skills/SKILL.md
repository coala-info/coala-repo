---
name: chisel
description: CHISEL infers haplotype-specific copy numbers and clusters cells into clones from low-coverage single-cell DNA sequencing data. Use when user asks to call copy numbers, identify genomic alterations in single cells, or perform cell clustering based on haplotype profiles.
homepage: https://github.com/raphael-group/chisel
metadata:
  docker_image: "quay.io/biocontainers/chisel:1.1.4--pyhdfd78af_0"
---

# chisel

## Overview
CHISEL (Copy-number Haplotype Inference in Single-cell by Evolutionary Links) is a computational framework designed to extract high-resolution genomic information from ultra-low coverage (<0.05X per cell) single-cell DNA sequencing. It functions by computing Read Depth Ratios (RDR) and B-Allele Frequencies (BAF) across genomic bins, performing reference-based phasing of germline SNPs, and clustering cells into clones based on their haplotype-specific copy-number profiles. This allows for the detection of subtle genomic alterations that are often invisible to standard single-cell analysis methods.

## Installation and Environment
CHISEL is primarily distributed via Bioconda. It is recommended to use a dedicated environment to manage its dependencies (Python 2.7 based).

```bash
# Create and activate a dedicated environment
conda create -n chisel chisel
source activate chisel
```

## Core Command Line Usage

### The Standard Pipeline
The `chisel_main` command executes the full pipeline, including RDR/BAF computation, clustering, and copy-number calling.

```bash
# Basic execution pattern
chisel_main -x ./output_dir -b ./barcodes.tsv -r ./reference.fa -n ./normal.bam -t ./tumor.bam
```

### Preprocessing Data
Use `chisel_prep` to prepare input files, specifically for handling cell barcodes and alignment data.

```bash
# Preparing 10x Genomics or similar barcoded data
chisel_prep -x ./prep_dir -b ./barcodes.tsv -r ./reference.fa -n ./normal.bam -t ./tumor.bam
```

### Analysis Without a Matched Normal
If a matched normal sample is unavailable, CHISEL provides a specific mode to infer copy numbers using a "pseudo-normal" approach or GC-content normalization.

```bash
# Running in nonormal mode
chisel_nonormal -x ./output_nonormal -b ./barcodes.tsv -r ./reference.fa -t ./tumor.bam
```

### Combining and Refining Calls
For advanced workflows where multiple runs need to be merged or refined, use the `combocall` utilities.

```bash
# Combining results
chisel_combocall -x ./combined_output -i ./input_calls.tsv
```

## Expert Tips and Best Practices
- **Binning Strategy**: CHISEL typically uses 5Mb genomic bins for RDR/BAF computation. If your data has extremely low coverage, consider increasing bin size to improve signal-to-noise ratios.
- **Phasing**: The tool performs reference-based phasing in 50kb haplotype blocks. Ensure your reference genome matches the one used for alignment exactly to avoid phasing errors.
- **Memory Management**: Single-cell datasets can be large. When running `chisel_prep` or `chisel_main`, ensure the environment has sufficient temporary disk space for intermediate BAM processing.
- **Output Interpretation**:
    - `calls/calls.tsv`: Contains the final inferred allele- and haplotype-specific copy numbers.
    - `clones/mapping.tsv`: Provides the cell-to-clone assignments.
    - `plots/`: Always review the generated PNG images to validate the clustering of RDRs and BAFs.

## Reference documentation
- [CHISEL GitHub Repository](./references/github_com_raphael-group_chisel.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_chisel_overview.md)