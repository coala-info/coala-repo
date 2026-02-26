---
name: meta-apo
description: Meta-Apo is a machine-learning tool that calibrates 16S-amplicon functional predictions to align with shotgun metagenomic profiles. Use when user asks to train a calibration model using paired samples or apply a model to adjust KO abundance tables for consistency with WGS data.
homepage: https://github.com/qibebt-bioinfo/meta-apo
---


# meta-apo

## Overview

Meta-Apo (Metagenomic Apochromat) is a machine-learning tool designed to bridge the gap between 16S-amplicon functional predictions and shotgun metagenomic (WGS) profiles. It uses a small training set of paired samples (sequenced via both methods) to learn the systematic biases in amplicon-based predictions and applies a calibration to larger datasets. This ensures that functional diversity patterns derived from amplicons are more consistent with WGS-based strategies.

## Command Line Usage

Meta-Apo operates in two distinct phases: **Training** and **Calibration**. All functional profiles must be annotated using KEGG Ontology (KO).

### 1. Training for KO Abundance Calibration

The training step requires a small number of paired samples (e.g., 15) that have both WGS and amplicon data.

**Using Abundance Tables:**
Use this method if you have consolidated tables where rows are samples and columns are KO terms.
```bash
meta-apo-train -T training.wgs.ko.abd -t training.16s.ko.abd -o meta-apo.model
```
*   `-T`: Relative abundance table of training WGS samples.
*   `-t`: Relative abundance table of training amplicon samples.
*   **Note**: The order of samples must be identical in both tables.

**Using Sample Lists:**
Use this method if your data is stored in individual files per sample.
```bash
meta-apo-train -L training.wgs.list -l training.16s.list -o meta-apo.model
```
*   `-L`: File list of training WGS samples.
*   `-l`: File list of training amplicon samples.
*   **List Format**: Each line should contain `SampleName /path/to/sample.ko.out`.

### 2. Calibration for KO Abundance

Once the model is generated, use it to calibrate your large-scale amplicon dataset.

**Calibrating an Abundance Table:**
```bash
meta-apo-calibrate -t 16s.ko.abd -m meta-apo.model -o 16s.ko.calibrated.abd
```

**Calibrating a Sample List:**
```bash
meta-apo-calibrate -l 16s.ko.list -m meta-apo.model -o 16s.ko.calibrated.out
```
*   The output folder will contain individual calibrated profiles and a master list file.

## Best Practices and Expert Tips

*   **Pre-processing Consistency**: For optimal results, use **HUMAnN2** for WGS functional profiling and **PICRUSt2** for amplicon functional prediction. Ensure the same KO version is used for both.
*   **Training Set Size**: While the tool can work with as few as 15 pairs, ensure these pairs represent the biological diversity of your larger dataset to avoid model over-fitting or bias.
*   **Input Formatting**: 
    *   Abundance tables should have a header starting with `Sample` followed by KO IDs (e.g., `K00001`).
    *   Individual KO files in a list should have two columns: `#KO` and `Count`.
*   **Environment Setup**: If using the manual installation, ensure the `MetaApo` environment variable is set and the `bin` directory is in your `PATH` to call the scripts globally.

## Reference documentation
- [Meta-Apo GitHub Repository](./references/github_com_qibebt-bioinfo_meta-apo.md)
- [Meta-Apo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_meta-apo_overview.md)