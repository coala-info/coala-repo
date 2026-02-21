---
name: phynteny
description: Phynteny is a specialized tool designed to address the high proportion of "hypothetical" genes found in bacteriophage genomes.
homepage: https://github.com/susiegriggo/Phynteny
---

# phynteny

## Overview
Phynteny is a specialized tool designed to address the high proportion of "hypothetical" genes found in bacteriophage genomes. By utilizing a Long Short-Term Memory (LSTM) model trained on phage synteny—the conserved order of genes—it predicts the likely function of unknown proteins. It maps these proteins to PHROG (Phage Risk Group) categories and provides confidence metrics to assist in genome refinement.

## Installation and Setup
Before running predictions, the tool and its pre-trained models must be initialized:

1. **Install via Conda**:
   ```bash
   conda create -n phynteny -c bioconda phynteny
   conda activate phynteny
   ```
2. **Download Models**:
   You must download the pre-trained LSTM models before the first use.
   ```bash
   install_models
   ```
   To specify a custom directory for the models:
   ```bash
   install_models -o /path/to/model_database
   ```

## Core Workflow

### 1. Input Preparation
Phynteny requires a Genbank (.gbk) file that already contains PHROG annotations. 
* **Tip**: If you only have a FASTA file, use **pharokka** first to generate the required PHROG-annotated Genbank file.

### 2. Running Annotation
The standard command generates a Genbank file and a summary table of predictions.
```bash
phynteny input_phage.gbk -o output_prefix
```

### 3. Custom Model Usage
If using a custom-trained model or specific confidence estimates:
```bash
phynteny input.gbk -o output_dir -m /path/to/custom_models -t confidence_dict.pkl
```

## Technical Constraints and Best Practices
* **Gene Limit**: This version of Phynteny is optimized for phages with **120 genes or fewer**. Genomes exceeding this limit may not be processed correctly due to the LSTM architecture.
* **Scoring**: Each prediction includes a 'phynteny score' (1-10) and a recalibrated confidence score. High-confidence annotations should be prioritized for downstream analysis.
* **GPU Support**: While standard annotation runs well on CPUs, training new models requires GPU support (CUDA/cuDNN) and is best installed via `pip` rather than Conda.

## Reference documentation
- [Phynteny Overview](./references/anaconda_org_channels_bioconda_packages_phynteny_overview.md)
- [Phynteny GitHub Repository](./references/github_com_susiegriggo_Phynteny.md)