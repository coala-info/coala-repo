---
name: nim-abif
description: nim-abif is a high-performance suite of utilities for processing, converting, and visualizing Applied Biosystems Information Format (ABIF) Sanger sequencing trace files. Use when user asks to convert ABI files to FASTQ or FASTA, perform quality trimming, merge overlapping forward and reverse reads, extract or edit metadata tags, or generate SVG chromatograms.
homepage: https://github.com/quadram-institute-bioscience/nim-abif
metadata:
  docker_image: "quay.io/biocontainers/nim-abif:0.2.0--h7b50bb2_0"
---

# nim-abif

## Overview
The `nim-abif` suite provides high-performance utilities for handling Applied Biosystems Information Format (ABIF) files. It is particularly useful for bioinformatics workflows involving Sanger capillary sequencing. The toolset allows for sophisticated quality trimming, metadata extraction, and Smith-Waterman based merging of overlapping trace files.

## Core CLI Tools

### 1. abi2fq: Conversion and Trimming
Use `abi2fq` to transform binary trace files into standard sequence formats. It supports a sliding window approach for quality trimming.

*   **Basic Conversion**: `abi2fq input.ab1 output.fq`
*   **Quality Trimming**: Use `--window` (default 10) and `--quality` (default 20) to remove low-quality ends.
    *   Example: `abi2fq --window=15 --quality=25 trace.ab1 output.fq`
*   **FASTA Output**: Use `--fasta` to skip quality scores.
*   **Ambiguous Bases**: Use `--split` to handle IUPAC ambiguity codes by generating two separate sequences.

### 2. abimerge: Paired-End Merging
Use `abimerge` to combine forward and reverse reads. It uses local alignment to find the optimal overlap.

*   **Standard Merge**: `abimerge forward.ab1 reverse.ab1 merged.fq`
*   **Strict Overlap**: Increase requirements for high-confidence merges.
    *   Example: `abimerge --min-overlap=30 --pct-id=90 fwd.ab1 rev.ab1`
*   **Gap Handling**: If no overlap is found, use `-j [N]` to join sequences with a specific number of 'N' bases.
    *   Example: `abimerge -j 10 fwd.ab1 rev.ab1`

### 3. abimetadata: Metadata Management
Use `abimetadata` to inspect or modify the internal tags of an ABIF file.

*   **List All Tags**: `abimetadata input.ab1`
*   **View Specific Tag**: `abimetadata input.ab1 -t SMPL1`
*   **Edit Tag Value**: Currently supports modifying string-type tags.
    *   Example: `abimetadata input.ab1 -t SMPL1 -v "New_Sample_ID" -o modified.ab1`

### 4. abichromatogram: Visualization
Render the trace data into a visual format.

*   **SVG Export**: `abichromatogram input.ab1 -o trace.svg`
*   **Sub-region Rendering**: Use `-s` (start) and `-e` (end) to focus on specific base positions.
    *   Example: `abichromatogram input.ab1 -s 500 -e 1000 --width 1600`

## Expert Tips & Best Practices
*   **Quality Control**: When converting to FASTQ, always prefer trimming (`--window` and `--quality`) unless you intend to perform downstream trimming with a specialized tool like Trimmomatic.
*   **Tag Reference**: Common ABIF tags include `PBAS2` (Base calls), `PQCV1` (Quality values), and `SMPL1` (Sample name). Use `abimetadata` to verify these if automated parsers fail.
*   **Alignment Tuning**: If `abimerge` fails to find an overlap in known overlapping reads, try lowering `--min-score` or adjusting the penalty scores (`--score-mismatch`, `--score-gap`).



## Subcommands

| Command | Description |
|---------|-------------|
| abi2fq | Convert ABI files to FASTQ with quality trimming |
| abichromatogram | Generates an SVG chromatogram from an ABIF trace file, displaying the four fluorescence channels with base calls. |
| abimerge | Merge forward and reverse AB1 trace files |

## Reference documentation
- [abi2fq Tool Details](./references/corebio_info_nim-abif_abi2fq.html.md)
- [abimerge Tool Details](./references/corebio_info_nim-abif_abimerge.html.md)
- [abimetadata Tool Details](./references/corebio_info_nim-abif_abimetadata.html.md)
- [Library Overview and Tags](./references/github_com_quadram-institute-bioscience_nim-abif_blob_main_README.md)