---
name: mimsi
description: MiMSI identifies microsatellite instability phenotypes from tumor-normal BAM pairs using a deep learning approach. Use when user asks to classify MSI status, analyze tumor-normal BAM files for microsatellite instability, or run multiple instance learning models on genomic data.
homepage: https://github.com/mskcc/mimsi
---


# mimsi

## Overview

MiMSI (Multiple Instance learning based classifier for Microsatellite Instability) is a specialized bioinformatics tool that identifies MSI phenotypes from tumor-normal BAM pairs. Unlike traditional methods that rely on statistical tests of deletion length distributions, MiMSI uses a deep learning approach (Multiple Instance Learning) to maintain accuracy in samples with low tumor content. The workflow involves encoding aligned reads into NGS vectors and then evaluating those vectors against pre-trained models to produce a classification probability.

## Installation and Setup

MiMSI is available via Bioconda or source. It requires Python 3.6, 3.7, or 3.8.

```bash
# Installation via Conda
conda install mimsi -c bioconda

# Installation from source
git clone https://github.com/mskcc/mimsi.git
cd mimsi
pip install .
```

## Core Workflow: Running Analysis

The `analyze` command handles both vector creation and model evaluation.

### Single Sample Analysis
To process an individual tumor/normal pair, provide the BAM paths and a microsatellite loci list.

```bash
analyze \
  --tumor-bam /path/to/tumor.bam \
  --normal-bam /path/to/normal.bam \
  --case-id tumor_sample_001 \
  --norm-case-id normal_sample_001 \
  --microsatellites-list ./utils/microsatellites_impact_only.list \
  --model ./model/mi_msi_v0_4_0_200x_attn.model \
  --use-attention \
  --save-location ./results/ \
  --save
```

### Bulk Processing
For batch runs, use a tab-separated case list file with headers: `Tumor_ID`, `Tumor_Bam`, `Normal_Bam`, `Normal_ID`, and `Label`.

```bash
analyze --case-list /path/to/samples.tsv --microsatellites-list ./utils/microsatellites.list --save-location ./output/
```

## Expert Tips and Best Practices

### Model Selection and Coverage
MiMSI provides models optimized for different sequencing depths and pooling mechanisms. Match your parameters to the pre-trained model filename:
- **Coverage**: The default is 200x. For 100x combined coverage, use `--coverage 50`.
- **Pooling**: If using a model with the `_attn` suffix, you **must** include the `--use-attention` flag.
- **Default**: The 200x attention model is generally recommended for standard clinical panels.

### Input Requirements
- **Loci List**: Use the provided `microsatellites_impact_only.list` for MSK-IMPACT assays or generate a custom list using MSISensor's scan functionality.
- **Naming Constraints**: Do **not** use underscores (`_`) in `Tumor_ID` or `Normal_ID` values, as this character is used as a delimiter in internal file naming.
- **Output Handling**: The tool repeats evaluation 10x per sample to allow for confidence interval generation. Use the `--save` flag to ensure the classification score is written to disk rather than just standard output.

### File Management
The `save-location` directory is sensitive. MiMSI will automatically delete existing files matching `*_locations.npy` and `*_data.npy` in that directory to prevent data mixing. Always use a dedicated output folder per run or per sample.



## Subcommands

| Command | Description |
|---------|-------------|
| analyze | MiMSI Analysis |
| evaluate_sample | MiMSI Sample(s) Evalution Utility |

## Reference documentation
- [MiMSI Main Repository](./references/github_com_mskcc_mimsi_blob_master_README.md)
- [Analysis Script Details](./references/github_com_mskcc_mimsi_blob_master_analyze.py.md)