---
name: readucks
description: readucks is a high-performance demultiplexer for Nanopore sequencing data that uses SIMD-accelerated alignment for precise barcode assignment. Use when user asks to demultiplex raw reads, sort sequences into barcode-specific files, or generate detailed barcode annotation CSVs.
homepage: https://github.com/artic-network/readucks
metadata:
  docker_image: "quay.io/biocontainers/readucks:0.0.3--py_0"
---

# readucks

## Overview
readucks is a specialized demultiplexer for Nanopore sequencing data that prioritizes speed and accuracy. By utilizing the parasail library for SIMD-accelerated pairwise alignment, it offers significant performance improvements over older tools like porechop. It is designed for workflows where adapter trimming is not required, but precise barcode assignment—including dual-end validation—is critical. Use this skill to automate the sorting of raw reads into barcode-specific files or to generate detailed annotation CSVs for downstream analysis.

## Installation and Setup
Ensure the environment has `biopython` and `parasail` installed.
```bash
# Installation via Conda
conda install -c bioconda readucks

# Manual installation
pip install biopython parasail
git clone https://github.com/artic-network/readucks.git
cd readucks && python setup.py install
```

## Common CLI Patterns

### Basic Demultiplexing (Binning)
To sort reads into separate files based on native barcodes:
```bash
readucks -i input_reads.fastq -o output_dir/ -b --native_barcodes
```

### Generating Annotations
To create a CSV mapping every read ID to a barcode without splitting the actual sequence files:
```bash
readucks -i input_reads.fastq -a -e
```
*Note: `-e` provides extended alignment information (scores and identity percentages).*

### Targeted Barcode Search
If you know exactly which barcodes were used (e.g., 1, 3, and 12), limit the search to increase speed and reduce false positives:
```bash
readucks -i input_reads.fastq -b --native_barcodes --limit_barcodes_to 1 3 12
```

### Single vs. Double Barcoding
*   **Double (Default):** Requires matching barcodes at both ends. Use for high-specificity requirements.
*   **Single:** Use `--single` if barcodes are only expected at one end (e.g., certain ligation kits or rapid kits).

## Expert Tips and Best Practices

### Tuning Sensitivity and Specificity
*   **Primary Threshold (`--threshold`):** Default is 90.0. Lower this (e.g., to 80.0) if you have high error rates or poor quality scores, but expect more "unassigned" reads if kept high.
*   **Secondary Threshold (`--secondary_threshold`):** Default is 70.0. In double-barcoding mode, the "other" end must meet this lower threshold. Adjusting this allows for a trade-off between recovery (lower value) and purity (higher value).

### Performance Optimization
*   **Threading:** Use `-t` to specify CPU cores. By default, it attempts to detect cores automatically, but in HPC environments, explicitly setting `-t` to match your allocation is recommended.
*   **Scoring Schemes:** You can customize the alignment via `--scoring_scheme "match,mismatch,gap_open,gap_extend"`. The default is `3,-6,-5,-2`.

### Output Management
*   The output directory specified by `-o` must exist before running the command.
*   Use `-p` to add a prefix to all generated files, which is helpful when processing multiple flow cells into a single aggregate directory.

## Reference documentation
- [readucks GitHub Repository](./references/github_com_artic-network_readucks.md)
- [readucks Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_readucks_overview.md)