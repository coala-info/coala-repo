---
name: wisecondorx
description: WisecondorX is an advanced tool for detecting copy number aberrations, optimized for low-coverage sequencing (0.1x - 1x).
homepage: https://github.com/CenterForMedicalGeneticsGhent/wisecondorX
---

# wisecondorx

## Overview
WisecondorX is an advanced tool for detecting copy number aberrations, optimized for low-coverage sequencing (0.1x - 1x). It improves upon the original WISECONDOR by adding support for sex chromosomes, increasing processing speed, and providing more robust normalization. The workflow follows a three-stage process: converting alignment files to a proprietary format, building a reference set from healthy controls, and predicting aberrations in test samples.

## Core Workflow

### 1. Convert Alignments
Convert BAM or CRAM files into `.npz` format.
```bash
wisecondorx convert input.bam output.npz --binsize 5000
```
- **Best Practice**: Do not perform read quality filtering before this step; the algorithm uses low-quality reads to distinguish informative bins.
- **CRAM files**: Use `--reference path/to/genome.fasta`.
- **Duplicates**: Use `--normdup` if you wish to skip duplicate removal.

### 2. Create Reference
Build a reference model from a directory of control `.npz` files.
```bash
wisecondorx newref reference_dir/*.npz reference_output.npz --binsize 100000 --nipt
```
- **Sample Size**: Use at least 50 samples; 500+ is ideal for maximum normalization quality.
- **Consistency**: Ensure all reference samples used the same sequencer, mapper, and reference genome as your test cases.
- **NIPT**: Always include the `--nipt` flag for non-invasive prenatal testing data.
- **Gender**: If the reference set is small (<20 samples), gender prediction may fail. Use `--plotyfrac` to visualize the distribution and manually set `--yfrac` if needed.

### 3. Predict Aberrations
Compare a test sample against the reference to call CNVs.
```bash
wisecondorx predict test_sample.npz reference.npz output_prefix --bed --plot
```
- **Output**: You must specify at least `--bed` (tab-delimited results) or `--plot` (visualizations).
- **Sensitivity**: 
    - Adjust `--zscore` (default 5) for calling segments.
    - Use `--beta` (0 to 1) instead of z-score if the sample purity (e.g., fetal fraction or tumor fraction) is known.
- **Gender Overrides**: If gender prediction is incorrect (common in Y-chromosome loss), force it with `--gender M` or `--gender F`.
- **Blacklisting**: Use `--blacklist path/to/blacklist.bed` to mask problematic regions like centromeres if the reference set is too small to auto-mask them.

## Expert Tips
- **Mapping**: `bowtie2` is the recommended mapper for optimal results with WisecondorX.
- **Resolution**: The `--binsize` in the `convert` step should be a multiple of the `--binsize` used in `newref`.
- **Visualization**: Use `--ylim [-2,2]` to standardize the y-axis across multiple plots for easier comparison.
- **Custom Regions**: Use `--regions path/to/genes.bed` to highlight specific loci of interest (e.g., known cancer genes) on the output plots.

## Reference documentation
- [WisecondorX GitHub README](./references/github_com_CenterForMedicalGeneticsGhent_WisecondorX.md)
- [WisecondorX Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_wisecondorx_overview.md)