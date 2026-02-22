---
name: renet2
description: RENET2 is a deep learning-based relation extraction tool specifically optimized for identifying links between genes and diseases in complex biomedical texts.
homepage: https://github.com/sujunhao/RENET2
---

# renet2

## Overview

RENET2 is a deep learning-based relation extraction tool specifically optimized for identifying links between genes and diseases in complex biomedical texts. While many tools are restricted to sentence-level or abstract-only analysis, RENET2 is designed to handle full-text articles by utilizing section filtering and ambiguous relation modeling. It allows users to predict associations using pre-trained models, train custom models on annotated datasets, and evaluate performance through cross-validation.

## Installation and Setup

The most efficient way to deploy RENET2 is via Bioconda:

```bash
conda create -n renet2-env -c bioconda renet2
conda activate renet2-env
```

Before running predictions, you must download the required pre-trained models and data:

```bash
# Download the data script from the source
RENET2_DATA_S_URL=https://raw.githubusercontent.com/sujunhao/RENET2/main/src/renet2/download_renet2_data.sh
curl -s ${RENET2_DATA_S_URL} | bash -s .
export R2_DIR=$(pwd)
```

## Common CLI Patterns

### Predicting Gene-Disease Associations
To extract relations from a directory of processed text files:

```bash
renet2 predict \
    --raw_data_dir ${R2_DIR}/data/ft_data/ \
    --model_dir ${R2_DIR}/models/ft_models/ \
    --gda_fn_d ${R2_DIR}/data/output_dir/ \
    --models_number 4 \
    --batch_size 64 \
    --use_cuda
```

### Training a Custom Model
To fine-tune or train a new model using annotated full-text data:

```bash
renet2 train \
    --raw_data_dir ${R2_DIR}/data/ft_data/ \
    --annotation_info_dir ${R2_DIR}/data/ft_info \
    --model_dir ./my_custom_model \
    --pretrained_model_p ${R2_DIR}/models/Bst_abs_10 \
    --epochs 10 \
    --batch_size 60 \
    --use_cuda
```

### Performance Evaluation
To run a 5-fold cross-validation on the full-text dataset:

```bash
renet2 evaluate_renet2_ft_cv \
    --raw_data_dir ${R2_DIR}/data/ft_data/ \
    --annotation_info_dir ${R2_DIR}/data/ft_info/ \
    --pretrained_model_p ${R2_DIR}/models/Bst_abs_10 \
    --use_cuda
```

## Expert Tips and Best Practices

- **GPU Acceleration**: Always include the `--use_cuda` flag if a GPU is available, as deep learning inference on full-text data is computationally expensive.
- **Sensitive Mode**: Use the `--is_sensitive_mode` flag during prediction if your workflow prioritizes recall (finding as many potential associations as possible) over precision.
- **Memory Management**: If you encounter Out-of-Memory (OOM) errors, reduce the `--batch_size` (default is often 60-64) to a lower value like 8 or 16.
- **Cache Handling**: Use `--no_cache_file` if you are iterating on data preprocessing steps and want to ensure the tool doesn't load stale intermediate representations.
- **Output Interpretation**: The primary output is `gda_rst.tsv`. This tab-separated file contains the extracted gene-disease pairs along with confidence scores.

## Reference documentation
- [RENET2 GitHub Repository](./references/github_com_sujunhao_RENET2.md)
- [RENET2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_renet2_overview.md)