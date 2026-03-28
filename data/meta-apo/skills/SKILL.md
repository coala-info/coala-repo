---
name: meta-apo
description: Meta-Apo is a machine-learning tool that calibrates predicted metagenomes from 16S data to better match shotgun metagenomic profiles. Use when user asks to train a calibration model using paired WGS and amplicon samples or calibrate functional gene profiles of amplicon microbiomes.
homepage: https://github.com/qibebt-bioinfo/meta-apo
---


# meta-apo

## Overview
Meta-Apo (Metagenomic Apochromat) is a machine-learning tool designed to minimize the discrepancy between predicted metagenomes (derived from 16S data via tools like PICRUSt2) and actual shotgun metagenomes (processed via tools like HUMAnN2). It uses a small training set of paired samples—where each sample has both 16S and WGS data—to build a calibration model. This model is then applied to large-scale amplicon datasets to produce functional profiles that are more biologically representative of WGS-based diversity patterns.

## Execution Workflow

### 1. Model Training
The training step requires paired functional profiles. The samples in the WGS input must exactly match the order of samples in the amplicon input.

**Using Abundance Tables:**
Use this pattern when you have consolidated TSV/tab-delimited files.
```bash
meta-apo-train -T training.wgs.ko.abd -t training.16s.ko.abd -o meta-apo.model
```
*   `-T`: Relative abundance table of training WGS samples.
*   `-t`: Relative abundance table of training amplicon samples.

**Using Sample Lists:**
Use this pattern if samples are stored in individual files.
```bash
meta-apo-train -L training.wgs.list -l training.16s.list -o meta-apo.model
```
*   `-L`: File containing paths to individual WGS KO profiles.
*   `-l`: File containing paths to individual amplicon KO profiles.

### 2. Profile Calibration
Once the model is generated, apply it to your target amplicon dataset.

**Calibrating a Table:**
```bash
meta-apo-calibrate -t 16s.ko.abd -m meta-apo.model -o 16s.ko.calibrated.abd
```

**Calibrating a List:**
```bash
meta-apo-calibrate -l 16s.ko.list -m meta-apo.model -o 16s.ko.calibrated.out
```

## Tool-Specific Best Practices

*   **Annotation Consistency**: Meta-Apo currently requires functional gene profiles to be annotated using KEGG Ontology (KO). Ensure both your training and target datasets use the same KO version.
*   **Sample Pairing**: In the training phase, the order of samples in the WGS table/list must be identical to the order in the amplicon table/list. The tool relies on positional matching for pairing.
*   **Input Formatting**: 
    *   Abundance tables should have samples as rows and KO IDs (e.g., K00001) as columns.
    *   Individual profile files (for list-based input) should be two-column files: `#KO` and `Count`.
*   **Training Set Size**: While the tool can function with as few as 15 pairs, ensure these pairs are representative of the environment or community type found in your larger dataset for optimal calibration.
*   **Environment Setup**: Ensure the `MetaApo` environment variable is set to the installation directory and the `bin` folder is added to your `PATH` to call the binaries directly.



## Subcommands

| Command | Description |
|---------|-------------|
| meta-apo-calibrate | Calibration of predicted gene profiles of amplicon microbiomes |
| meta-apo-train | Model training using gene profiles of paired WGS-amplicon microbiomes |

## Reference documentation
- [Meta-Apo GitHub README](./references/github_com_qibebt-bioinfo_meta-apo_blob_master_README.md)
- [Meta-Apo Installation Guide](./references/github_com_qibebt-bioinfo_meta-apo_blob_master_install.sh.md)