---
name: nanoblaster
description: NanoBLASTer is a specialized alignment tool designed to map high-error Oxford Nanopore long reads to a reference genome using a k-mer and anchor-based approach. Use when user asks to align ONT reads, perform sensitive sequence mapping, or execute fast and exhaustive alignments for noisy long-read data.
homepage: https://github.com/ruhulsbu/NanoBLASTer
metadata:
  docker_image: "quay.io/biocontainers/nanoblaster:0.16--h9948957_8"
---

# nanoblaster

## Overview
NanoBLASTer is a specialized alignment tool designed to handle the high error rates (historically ~65% accuracy) associated with Oxford Nanopore Technologies (ONT) long reads. It utilizes a k-mer and anchor-based approach to identify clusters of similarity before performing banded alignment. This skill provides the necessary command-line patterns to execute alignments ranging from fast, low-sensitivity runs to exhaustive, highly sensitive searches.

## Installation and Setup
The tool must be compiled from source on a Linux x64 system:
1. Navigate to the source directory: `cd NanoBLASTer/nano_src`
2. Build the executable: `make`
3. The resulting binary `./nanoblaster` is used for all operations.

## Core CLI Usage
The basic syntax requires a reference file, an input reads file, and an output prefix.

### Standard Alignment Patterns
*   **Fast Mode**: Best for quick checks or high-quality data.
    `./nanoblaster -C10 -r reference.fa -i reads.fa -o output_prefix`
*   **Sensitive Mode**: Balanced performance for standard ONT data.
    `./nanoblaster -C25 -r reference.fa -i reads.fa -o output_prefix`
*   **Highly Sensitive Mode**: Maximum discovery at the cost of runtime.
    `./nanoblaster -C50 -s -r reference.fa -i reads.fa -o output_prefix`

### Parameter Reference
| Flag | Description | Notes |
|------|-------------|-------|
| `-r` | Reference file | Must be in FASTA format. |
| `-i` | Reads file | Must be in FASTA format. |
| `-o` | Output prefix | Prefix for generated alignment files. |
| `-C` | Sensitivity Preset | Options: `-C10` (Fast), `-C25` (Sensitive), `-C50` (High). |
| `-s` | High Sensitivity | Boolean flag to further increase sensitivity. |
| `-X` | Single Index | Use for low-memory environments. |
| `-k` | KMER size | Default is 11 or 13 depending on mode. |
| `-a` | Anchor size | Default is 40 or 45 depending on mode. |
| `-g` | Gap length | Interval between KMERs (e.g., `-g 4`). |
| `-n` | Read count | Limit alignment to the first N reads. |

## Expert Tips and Optimization

### Handling Higher Accuracy Data
The default presets are optimized for ~65% accuracy. If working with newer ONT chemistry (e.g., R10.4.1) or basecallers yielding ~85%+ accuracy:
*   Increase the **KMER size** (`-k`) and **ANCHOR size** (`-a`) to improve runtime performance without losing significant sensitivity.

### Memory Management
If the system is constrained by RAM, always include the `-X` flag. This configures NanoBLASTer to use a single index, significantly reducing the memory footprint at a slight cost to speed.

### Manual Tuning
For specific biological contexts, you can override preset behaviors by adding parameters *after* the `-C` flag:
*   To force a specific cluster limit on a sensitive run: `./nanoblaster -C25 -l 15 ...`
*   To adjust gap intervals for speed: `./nanoblaster -C10 -g 4 ...`

### Alignment Scoring
Scoring parameters (Gap penalties, Mismatch weights, Identity match percentages) are hardcoded in `constant.h`. If the CLI parameters do not yield the desired alignment quality, the source code must be edited and recompiled. Key constants include `GAP`, `MISMATCH`, `WEIGHT`, and `KBAND_PERCENT_MATCH`.

## Reference documentation
- [NanoBLASTer Main Documentation](./references/github_com_ruhulsbu_NanoBLASTer.md)