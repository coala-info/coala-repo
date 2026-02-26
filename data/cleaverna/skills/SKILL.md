---
name: cleaverna
description: CleaveRNA predicts the cleavage efficiency of DNAzymes on target RNA sequences using machine learning and structural features. Use when user asks to predict DNAzyme cleavage sites, evaluate candidate site accessibility, or train custom models using experimental cleavage data.
homepage: https://github.com/reyhaneh-tavakoli/CleaveRNA
---


# cleaverna

## Overview
CleaveRNA is a machine learning-powered computational tool designed to predict the cleavage efficiency of DNAzymes on target RNA sequences. It evaluates candidate sites by analyzing structural and thermodynamic features, such as site accessibility. This skill should be used when designing or validating DNAzymes for gene silencing or RNA processing, allowing users to either leverage pre-trained models for immediate prediction or train custom models using their own experimental cleavage data.

## Installation and Dependencies
CleaveRNA is available via Bioconda and requires specific secondary structure prediction tools to function:
- **Conda Install**: `conda install bioconda::cleaverna`
- **Core Dependencies**: Ensure `IntaRNA` and `RNAplfold` (from ViennaRNA) are installed and available in your PATH.

## Input Requirements
To ensure successful execution, follow these strict formatting rules:
- **Target Sequences**: Must be in FASTA format.
- **Sequence Length**: Minimum length of 150 nucleotides.
- **Header Matching**: The FASTA header must match the filename (e.g., `BCL-1.fasta` must have the header `>BCL-1`).
- **Parameter Files**: A CSV file (e.g., `test_default.csv`) containing five specific columns:
  1. `LA`: Left binding arm length.
  2. `RA`: Right binding arm length.
  3. `CS`: Cleavage site dinucleotide.
  4. `Tem`: Reaction temperature.
  5. `CA`: Catalytic core sequence.

## Command Line Workflows

### Training Mode
Use this mode to generate a `pre_train` file from experimental data.
```bash
# Example training command structure
python CleaveRNA.py \
  --targets sequence1.fasta sequence2.fasta \
  --feature_mode default \
  --params parameters.csv \
  --output_dir ./output \
  --model_name "MY_MODEL"
```
*Note: This generates a `[model_name]_user_merged_num.csv` file used for subsequent predictions.*

### Prediction Mode (Default)
Use this to score cleavage sites on new target sequences using a pre-trained model.
```bash
python CleaveRNA.py \
  --targets target_seq.fasta \
  --feature_mode default \
  --params parameters.csv \
  --prediction_mode MY_MODEL_user_merged_num.csv \
  --ML_target MY_MODEL_target.csv \
  --model_name "PREDICTION_RUN" \
  --output_dir ./results
```

## Expert Tips and Best Practices
- **Model Selection**: If you do not have custom experimental data, use the default training files provided in the repository, which are based on established DNAzyme cleavage datasets.
- **Environment Setup**: When using the provided `run.sh` script, always verify that the conda environment paths (lines 3–14) are updated to match your local system.
- **Output Interpretation**:
  - **Prediction_score**: Indicates the model's confidence in the site's cleavage potential.
  - **Decision_score**: The raw model output used for classification.
  - **CS_Index**: Use this to map the predicted site back to the exact nucleotide position on your target RNA.

## Reference documentation
- [CleaveRNA GitHub README](./references/github_com_reyhaneh-tavakoli_CleaveRNA.md)
- [Bioconda CleaveRNA Overview](./references/anaconda_org_channels_bioconda_packages_cleaverna_overview.md)