---
name: renet2
description: RENET2 is a deep learning framework designed to extract gene-disease relationships from full-text scientific articles. Use when user asks to identify gene-disease associations, train custom relation extraction models, or evaluate performance using cross-validation on annotated biomedical text.
homepage: https://github.com/sujunhao/RENET2
---


# renet2

## Overview
RENET2 is a deep learning framework designed to identify and extract relationships between genes and diseases from scientific text. While many tools are limited to processing abstracts or single sentences, RENET2 is specifically optimized for full-text articles. It utilizes section filtering to focus on the most informative parts of a document and employs iterative training data expansion to handle the scarcity of labeled full-text data. This makes it an essential tool for researchers building biomedical knowledge bases or performing systematic literature mining.

## Installation and Setup
Before running RENET2, the environment must be configured and the pre-trained models must be downloaded.

1. **Environment**: Activate the environment using `conda activate renet2-env`.
2. **Resource Acquisition**: Pre-trained models and datasets are not included in the base installation. Use the provided utility script to download them:
   ```bash
   # Define the download URL
   RENET2_DATA_S_URL=https://raw.githubusercontent.com/sujunhao/RENET2/main/src/renet2/download_renet2_data.sh
   # Download and execute
   curl -s ${RENET2_DATA_S_URL} | bash -s .
   # Set the directory variable for subsequent commands
   export R2_DIR=$(pwd)
   ```

## Common CLI Patterns

### Predicting Gene-Disease Associations
To extract associations from full-text data using pre-trained models:
```bash
renet2 predict \
  --raw_data_dir ${R2_DIR}/data/ft_data/ \
  --model_dir ${R2_DIR}/models/ft_models/ \
  --gda_fn_d ${R2_DIR}/data/ft_gda/ \
  --models_number 2 \
  --batch_size 60 \
  --use_cuda
```
*   `--is_sensitive_mode`: Enable this flag to use "RENET2-Sensitive" mode, which prioritizes higher recall.
*   `--no_cache_file`: Use this to bypass cached processed data and force a fresh run.
*   `--max_doc_num`: Limits the number of documents processed (useful for quick testing).

### Training Custom Models
To train the model on a specific annotated dataset:
```bash
renet2 train \
  --raw_data_dir ${R2_DIR}/data/ft_data/ \
  --annotation_info_dir ${R2_DIR}/data/ft_info \
  --model_dir ./output_models \
  --pretrained_model_p ${R2_DIR}/models/Bst_abs_10 \
  --epochs 10 \
  --models_number 10 \
  --use_cuda
```

### Performance Evaluation
To run a 5-fold cross-validation on an annotated dataset:
```bash
renet2 evaluate_renet2_ft_cv \
  --raw_data_dir ${R2_DIR}/data/ft_data/ \
  --annotation_info_dir ${R2_DIR}/data/ft_info/ \
  --epochs 10 \
  --use_cuda
```

## Expert Tips
- **Hardware Optimization**: Always use the `--use_cuda` flag if a GPU is available. Relation extraction on full-text articles is computationally expensive and significantly slower on CPUs.
- **Memory Management**: If you encounter "Out of Memory" (OOM) errors, reduce the `--batch_size`. For full-text processing on standard GPUs, a batch size between 8 and 16 is often safer than the default.
- **Data Preparation**: RENET2 relies on section filtering. Ensure your input data format preserves section boundaries (e.g., Introduction, Methods, Results) to allow the model to filter out less relevant sections effectively.
- **Output Files**: The primary output is `gda_rst.tsv`. This tab-separated file contains the predicted gene-disease pairs and their associated confidence scores.



## Subcommands

| Command | Description |
|---------|-------------|
| download_data.py | download abstrcts/full-text pubtator/json file from Pubtator |
| evaluate_renet2_ft_cv.py | RENET2 training models [assemble, full-text] and testing |
| normalize_ann.py | normalize annotation ID |
| parse_data.py | parse abstracts/full-text pubtator/json file to RENET2 input format |
| predict.py | RENET2 testing models [assemble, full-text] |
| train.py | RENET2 training models [assemble, full-text] and testing |

## Reference documentation
- [RENET2 README](./references/github_com_sujunhao_RENET2_blob_main_README.md)
- [RENET2 Setup and Entry Points](./references/github_com_sujunhao_RENET2_blob_main_setup.py.md)