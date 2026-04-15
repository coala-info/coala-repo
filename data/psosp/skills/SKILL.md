---
name: psosp
description: PSOSP classifies prophages as SOS-dependent, SOS-independent, or SOS-uncertain by analyzing LexA protein binding sites and their Heterology Index. Use when user asks to predict prophage induction mechanisms, identify SOS boxes in bacterial genomes, or determine if a prophage requires the SOS response for induction.
homepage: https://github.com/mujiezhang/PSOSP
metadata:
  docker_image: "quay.io/biocontainers/psosp:1.1.2--pyhdfd78af_2"
---

# psosp

## Overview
PSOSP (Prophage SOS-dependency Predictor) is a bioinformatics tool designed to classify prophages based on their induction mechanisms. By analyzing the Heterology Index (HI) of LexA protein binding sites within prophage promoter regions, the tool determines whether a prophage is SOS-dependent (SdP), SOS-independent (SiP), or SOS-uncertain (SuP). This is particularly useful for researchers studying phage-host interactions, lysogeny maintenance, and the triggers for the viral lytic cycle.

## Usage Guidelines

### Core Workflow
The tool operates through a four-step automated process:
1. **LexA Identification**: Scans the host genome for the LexA protein and canonical SOS boxes (CSBs) upstream of the *lexA* gene.
2. **HI Calculation**: Identifies potential SOS boxes (PSBs) across the bacterial genome and calculates their Heterology Index to establish classification thresholds.
3. **Prophage Scanning**: Searches for PSBs specifically within the promoter regions of the prophage.
4. **Categorization**: Compares the minimum HI found in the prophage (*HImin*) against the calculated thresholds (*HIc1* and *HIc2*).

### Classification Logic
*   **SdP (SOS-dependent)**: *HImin* ≤ *HIc1*. Indicates strong LexA binding; induction requires the SOS response.
*   **SiP (SOS-independent)**: *HImin* ≥ *HIc2*. Indicates weak or no LexA binding; induction occurs via other mechanisms.
*   **SuP (SOS-uncertain)**: *HIc1* < *HImin* < *HIc2*.

### Installation and Environment
PSOSP is available via Bioconda and requires a Python environment. It relies on `find_packages` and `include_package_data` for its internal data files (including `.dmnd` and `.txt` reference files).

### Best Practices
*   **Input Quality**: Ensure host genomes are provided in standard FASTA/FNA format.
*   **Prophage Coordinates**: For accurate promoter scanning, ensure prophage regions are correctly identified within the host genome or provided as distinct sequences with known promoter locations.
*   **Thresholding**: Allow the tool to calculate dynamic thresholds (*HIc1*/*HIc2*) based on the specific host's LexA binding profile for higher accuracy.



## Subcommands

| Command | Description |
|---------|-------------|
| psosp | A tool for host-virus sequence analysis (psosp) |
| psosp predict | Predict virus-host interactions using psosp |

## Reference documentation
- [PSOSP: Prophage SOS-dependency Predictor](./references/github_com_mujiezhang_PSOSP_blob_main_README.md)
- [PSOSP: 原噬菌体SOS依赖性预测器 (Chinese Tutorial)](./references/github_com_mujiezhang_PSOSP_blob_main_README-Chinese.md)
- [PSOSP Package Setup](./references/github_com_mujiezhang_PSOSP_blob_main_setup.py.md)