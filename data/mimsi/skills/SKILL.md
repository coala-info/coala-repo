---
name: mimsi
description: MiMSI is a deep learning tool that predicts microsatellite instability phenotypes from tumor-normal BAM pairs using multiple instance learning. Use when user asks to classify MSI status, predict MSI phenotypes from NGS data, or process tumor-normal pairs for microsatellite analysis.
homepage: https://github.com/mskcc/mimsi
---


# mimsi

## Overview

MiMSI (Microsatellite Instability Classification using Multiple Instance Learning) is a deep learning-based tool designed to predict MSI phenotypes from tumor-normal BAM pairs. While traditional methods rely on statistical tests of nucleotide deletion lengths—which often fail in low-purity or low-coverage clinical scenarios—MiMSI encodes aligned reads into vectors and uses a trained MIL model to maintain high sensitivity and specificity across varying sample qualities.

## Installation

The tool is available via Bioconda (recommended) or source.

```bash
# Conda installation
conda install -c bioconda mimsi

# Verify installation
evaluate_sample --version
```

## Core Workflow

MiMSI operates in two stages: NGS Vector creation (encoding reads) and Evaluation (classification). These are typically executed together using the `analyze` command.

### Single Sample Analysis
To process an individual tumor-normal pair, provide the BAM files and a microsatellite site list.

```bash
analyze \
  --tumor-bam /path/to/tumor.bam \
  --normal-bam /path/to/normal.bam \
  --case-id unique-sample-id \
  --microsatellites-list ./utils/microsatellites_impact_only.list \
  --model ./model/mi_msi_v0_4_0_200x_attn.model \
  --save-location /path/to/output/ \
  --use-attention \
  --save
```

### Batch Processing
For multiple samples, create a tab-separated (TSV) file with the following headers: `Tumor_ID`, `Tumor_Bam`, `Normal_Bam`, `Normal_ID`, and `Label`.

*   **Note**: The `_` character is prohibited in `Tumor_ID` and `Normal_ID` values.
*   **Label**: Use `-1` for unknown cases during evaluation.

## Expert Tips and Best Practices

### Model Selection
MiMSI provides pre-trained models optimized for different sequencing depths and pooling mechanisms:
*   **Coverage**: The default model is 200x (combined tumor/normal). For lower coverage data, use the 100x models by passing `--coverage 50`.
*   **Pooling**: If using a model with the `_attn` suffix, you **must** include the `--use-attention` flag in your command.

### Microsatellite Site Lists
The tool requires a list of regions to inspect. 
*   For MSK-IMPACT assays, use `utils/microsatellites_impact_only.list`.
*   For custom panels, generate a site list using the `scan` functionality from **MSISensor**.

### Output Files
The tool generates `.npy` files during the vector creation stage:
*   `{case-id}_data_{label}.npy`: Contains the N x coverage x 40 x 3 vector.
*   `{case-id}_locations_{label}.npy`: Contains the genomic coordinates.
*   **Warning**: The `analyze` command will delete existing `*_locations.npy` and `*_data.npy` files in the specified `--save-location`.

### Performance
On a standard machine, building vectors and evaluating a sample via `pip` or `conda` typically takes less than 2 minutes, depending on the number of microsatellite sites and read depth.

## Reference documentation
- [MiMSI GitHub Repository](./references/github_com_mskcc_mimsi.md)
- [MiMSI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mimsi_overview.md)