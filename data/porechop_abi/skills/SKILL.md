---
name: porechop_abi
description: Porechop_ABI discovers and trims adapter sequences from Oxford Nanopore reads using an ab initio approach based on k-mer counting and graph assembly. Use when user asks to infer adapter sequences, perform automated trimming of ONT reads, or identify novel adapters without a reference database.
homepage: https://github.com/bonsai-team/Porechop_ABI
metadata:
  docker_image: "quay.io/biocontainers/porechop_abi:0.5.1--py310h275bdba_0"
---

# porechop_abi

## Overview

Porechop_ABI is an extension of the original Porechop tool designed to handle Oxford Nanopore Technologies (ONT) reads using an "ab initio" approach. Unlike standard trimming tools that rely on a fixed database of known adapter sequences, Porechop_ABI discovers adapters by analyzing the reads themselves through approximate k-mer counting and graph assembly.

This skill provides the necessary command-line patterns to infer adapter sequences, perform automated trimming, and troubleshoot common warnings related to signal reliability in ONT datasets.

## Common CLI Patterns

### Automated Adapter Discovery and Trimming
The most common use case is to let the tool guess the adapters and immediately proceed to trimming.
```bash
porechop_abi -abi -i input_reads.fastq -o output_reads.fastq
```

### Adapter Inference Only (Dry Run)
Use the `-go` (guess only) flag to identify adapter sequences without modifying the original reads. This is useful for validating library prep or checking if a dataset has already been trimmed.
```bash
porechop_abi -abi --guess_adapter_only -i input_reads.fastq -o /dev/null
```

### Processing Large or Simulated Datasets
When working with simulated data or when you want to ignore the built-in Porechop database entirely to ensure only novel adapters are found, use the `-ddb` flag.
```bash
porechop_abi -abi -go -ddb -i input.fasta -tmp /tmp/pabi_temp -o /dev/null
```

## Advanced Configuration

### Managing Temporary Files
Porechop_ABI generates k-mer count files and temporary FASTA files. For large datasets, specify a high-performance temporary directory to avoid disk space issues or slow I/O.
- `-tmp /path/to/fast_disk/`

### Custom Algorithm Tuning
If the default discovery parameters are not capturing your adapters, you can provide a custom configuration file for the ab initio phase.
- `-abc /path/to/custom_config.ini`

## Troubleshooting and Best Practices

### Interpreting Warnings
- **Low frequency warning**: Indicates that the k-mers used to build adapters are not significantly over-represented. This often happens if the reads are already trimmed or if the adapter signal is extremely weak.
- **Poor consensus warning**: Occurs when the tool finds multiple distinct start/end adapters, but none are present in more than 30% of the reads. This suggests a highly heterogeneous mix or poor sequencing quality at the ends.

### Limitations
- **Barcodes**: Porechop_ABI is not designed for demultiplexing barcoded sequences. Use standard Porechop commands or specialized demultiplexers for barcode-based workflows.
- **Input Formats**: Supports both FASTQ and FASTA, including gzipped files (`.gz`).

## Reference documentation
- [Porechop_ABI GitHub Repository](./references/github_com_bonsai-team_Porechop_ABI.md)
- [Porechop_ABI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_porechop_abi_overview.md)