---
name: wisecondorx
description: WisecondorX detects copy number variations in shallow whole-genome sequencing data by comparing test samples against a normalized reference model. Use when user asks to convert aligned reads to binned counts, create a reference from control samples, predict genomic aberrations, or determine sample gender.
homepage: https://github.com/CenterForMedicalGeneticsGhent/wisecondorX
---


# wisecondorx

## Overview
WisecondorX is an optimized suite for detecting copy number variations in shallow whole-genome sequencing data. It improves upon the original WISECONDOR algorithm by increasing processing speed, supporting sex chromosome analysis, and utilizing a more robust normalization approach. It is particularly effective for clinical and diagnostic applications where consistent normalization across samples is critical.

## Core Workflow

### 1. Convert Aligned Reads
Transform BAM or CRAM files into compressed NumPy (`.npz`) files containing binned read counts.
- **Command**: `WisecondorX convert input.bam output.npz [options]`
- **Key Options**:
  - `--binsize <int>`: Set bin size in bp (default: 5000). Smaller bins increase resolution but require more memory/time.
  - `--reference <fasta>`: Required when using CRAM input.
  - `--normdup`: Use this flag to keep duplicate reads (default is removal).

### 2. Create a Reference
Combine multiple negative control `.npz` files into a single reference model.
- **Command**: `WisecondorX newref reference_samples/*.npz reference_output.npz [options]`
- **Best Practices**:
  - **Sample Size**: Use at least 50 negative control samples. Diminishing returns occur after 500 samples.
  - **Consistency**: Ensure all reference samples used the same sequencer, mapper, and reference genome as your test cases.
  - **Gender Modeling**: If using fewer than 20 samples, automated gender prediction may fail. Manually adjust the `--yfrac` parameter if necessary.

### 3. Predict Aberrations
Compare a test sample against the reference to identify CNVs.
- **Command**: `WisecondorX predict test_sample.npz reference.npz output_prefix [options]`
- **Output**: Generates segments and ratios used for downstream clinical interpretation.

## Expert Tips and Best Practices
- **Mapping**: Use `bowtie2` for optimal results.
- **No Pre-filtering**: Do **not** perform read quality filtering before running `convert`. WisecondorX requires low-quality reads to accurately distinguish informative bins from non-informative ones.
- **Environment Management**: If working within the source repository, use `pixi run` (e.g., `pixi run test`) to ensure all R dependencies and Python packages are correctly scoped.
- **Data Contracts**: The `.npz` files have strict internal key structures. If scripting custom data injections, verify compatibility against `tests/test_predict_contract.py`.
- **R Integration**: WisecondorX calls R scripts for Circular Binary Segmentation (CBS) and plotting. Ensure R is in your PATH and necessary BioConductor packages are installed if not using the Conda/Pixi distribution.



## Subcommands

| Command | Description |
|---------|-------------|
| newref | Create a new reference using healthy reference samples |
| wisecondorx gender | Returns the gender of a .npz resulting from convert, based on a Gaussian mixture model trained during the newref phase |
| wisecondorx predict | Find copy number aberrations |
| wisecondorx_convert | Convert and filter a aligned reads to .npz |

## Reference documentation
- [WisecondorX README](./references/github_com_CenterForMedicalGeneticsGhent_WisecondorX_blob_master_README.md)
- [WisecondorX Agent Guidelines](./references/github_com_CenterForMedicalGeneticsGhent_WisecondorX_blob_master_AGENTS.md)