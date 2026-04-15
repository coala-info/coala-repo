---
name: chopin2
description: chopin2 is a supervised learning tool that uses Hyperdimensional Computing to perform classification and feature selection on complex datasets. Use when user asks to build classification models, perform backward variable selection, or scale machine learning tasks using GPUs and Apache Spark.
homepage: https://github.com/cumbof/chopin2
metadata:
  docker_image: "quay.io/biocontainers/chopin2:1.0.9.post1"
---

# chopin2

## Overview
chopin2 is a supervised learning tool based on the architecture of Hyperdimensional Computing. It transforms input data into high-dimensional vectors to perform classification tasks. You should use this skill when you need to build robust classification models for complex datasets, especially when traditional machine learning approaches are computationally prohibitive or when you need to identify the most significant features through backward variable selection. It is highly scalable, offering native support for multi-processing, NVIDIA GPUs, and Apache Spark.

## Installation and Setup
chopin2 can be installed via standard Python package managers:

```bash
# Via pip
pip install chopin2

# Via conda
conda install -c conda-forge chopin2
```

## Core Command Line Usage
The basic syntax for running a classification task involves defining the model dimensions and the input dataset.

### Standard Classification
To run a basic model on a dataset (e.g., a CSV file):
```bash
chopin2 --dataset data.csv --fieldsep "," --dimensionality 10000 --levels 100 --psplit_training 80 --verbose
```

### Using Pickled Data
If you have a pre-processed `.pkl` file, use the `--pickle` flag to bypass raw text parsing:
```bash
chopin2 --pickle dataset.pkl --dimensionality 10000 --retrain 10 --dump
```

## Advanced Execution Modes

### GPU Acceleration
For large-scale datasets on NVIDIA hardware, use the `--gpu` flag. Note that this ignores the `--spark` and `--nproc` arguments.
```bash
chopin2 --dataset data.csv --gpu --tblock 128 --dimensionality 10000
```

### Distributed Computing with Spark
To scale across a cluster using Apache Spark:
```bash
chopin2 --dataset data.csv --spark --master local[*] --slices 10 --memory 4096m
```

## Feature Selection
chopin2 supports backward variable selection to identify the most significant features in your dataset. This is computationally intensive but highly effective for biomarker discovery.

```bash
chopin2 --dataset data.csv --select_features --features feature_list.txt --accuracy_threshold 75.0 --group_min 5
```
*   `--features`: A file with a single column containing the subset of features to evaluate.
*   `--accuracy_threshold`: Stops the process if accuracy drops below this value.

## Expert Tips and Best Practices
*   **Dimensionality:** A value of 10,000 is standard for HDC. Increasing this can improve accuracy but increases memory usage and computation time.
*   **Retraining:** Use `--retrain` (e.g., 10-20 iterations) to refine the model. Combine this with `--stop` to exit early if the error rate stabilizes.
*   **Level Hypervectors:** The `--levels` parameter defines how continuous values are discretized into the HD space. For high-precision biological data, higher levels (e.g., 100+) are often necessary.
*   **Reproducibility:** Always specify a `--seed` (default is 0) to ensure that the random sampling for training and test sets is consistent across runs.
*   **Cleanup:** Use `--cleanup` to delete the model after producing accuracy results if you are only interested in performance metrics and not the model itself.

## Reference documentation
- [chopin2 GitHub Repository](./references/github_com_cumbof_chopin2.md)