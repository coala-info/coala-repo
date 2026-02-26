---
name: gzip
description: This tool performs text classification by using the gzip compression algorithm to measure similarity between text sequences. Use when user asks to classify text using a parameter-free method, run low-resource text classification, or calculate distance matrices between text samples.
homepage: https://github.com/bazingagin/npc_gzip
---


# gzip

## Overview

The gzip skill implements a "low-resource" text classification method that leverages the principle that similar text sequences compress better together than dissimilar ones. Instead of training a neural network with millions of parameters, this tool uses the gzip compression algorithm to estimate the distance between text samples. It is particularly effective for scenarios with limited training data or when a fast, parameter-free baseline is required.

## Installation and Setup

Install the package via pip to access the core classification functionality:

```bash
pip install npc-gzip
```

For research and benchmarking using the original codebase, clone the repository and install dependencies using poetry:

```bash
poetry install
```

## Core CLI Usage

Use the `main_text.py` script to run classification experiments. The tool supports multiple compressors and standard datasets.

### Basic Classification
Run a classification task using the default settings (100 training/test samples):

```bash
python main_text.py --compressor gzip --dataset AG_NEWS --all_test --all_train
```

### Performance Optimization
For large datasets, use multiprocessing to accelerate the calculation of the distance matrix:

```bash
python main_text.py --compressor gzip --dataset DBpedia --para
```

### Handling Large Datasets
When working with full datasets, record the distance matrix to avoid redundant calculations in future runs:

```bash
# Calculate and save distance matrix
python main_text.py --dataset YahooAnswers --record --output_dir ./results

# Calculate accuracy from a previously recorded distance file
python main_text.py --record --score --distance_fn ./results/distance_matrix.npy
```

## Working with Custom Data

To classify your own data, prepare `train.txt` and `test.txt` files where each line follows the format: `{label}\t{text}`.

Execute the classification using the `custom` dataset flag:

```bash
python main_text.py --dataset custom --data_dir /path/to/data --class_num 5
```

## Expert Tips and Best Practices

- **Sample Scaling**: For very small datasets (like `kinnews`), the default 100-shot setting may exceed the total available data. Manually set `--num_train` and `--num_test` to fit your data size.
- **Compressor Selection**: While `gzip` is the default, the tool also supports `lzma` and `bz2`. Test different compressors as they may yield different accuracy results depending on the text domain.
- **Batching**: Use `--test_idx_start` and `--test_idx_end` to split large test sets into manageable chunks across different machines or processes.
- **Data Formatting**: If your custom dataset uses a different delimiter than a tab, modify the `load_custom_dataset()` function in `data.py` before execution.

## Reference documentation

- [npc_gzip Repository Overview](./references/github_com_bazingagin_npc_gzip.md)