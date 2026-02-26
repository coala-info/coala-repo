---
name: drevalpy
description: DrEvalPy is a toolkit for benchmarking and evaluating cancer drug response prediction models against established baselines. Use when user asks to evaluate model performance, compare custom models to baselines, or perform cross-validation using leave-cell-line-out, leave-drug-out, or leave-tissue-out strategies.
homepage: https://github.com/daisybio/drevalpy
---


# drevalpy

## Overview
DrEvalPy is a specialized toolkit designed to bring statistical rigor and reproducibility to cancer drug response prediction. It provides a unified interface to compare custom models against a catalog of established baselines using standardized preprocessing and evaluation workflows. By using this skill, you can automate the benchmarking process, perform ablation studies with permutation tests, and analyze how well models generalize across different studies or unseen biological entities.

## Installation and Setup
Install the core package via pip or conda. For parallel hyperparameter tuning, include the multiprocessing extra.

```bash
# Standard installation
pip install drevalpy

# With parallel tuning support
pip install drevalpy[multiprocessing]

# Via Bioconda
conda install bioconda::drevalpy
```

## CLI Usage Patterns

### Running Benchmarks
The primary entry point is the `drevalpy` command. You must provide a unique run ID, specify the models to evaluate, and select a dataset.

```bash
# Basic evaluation of baseline models on a toy dataset
drevalpy --run_id experiment_01 --models NaiveTissueMeanPredictor NaiveDrugMeanPredictor --dataset TOYv1 --test_mode LCO
```

### Generating Reports
After a run completes, use `drevalpy-report` to generate an interactive HTML visualization of the results.

```bash
# Generate report for a specific run
drevalpy-report --run_id experiment_01 --dataset TOYv1
```

### Advanced Experiment Configuration
You can chain multiple models and specify the evaluation metric (measure).

```bash
# Evaluate complex models using LN_IC50 on CTRPv2
drevalpy --run_id deep_eval --models SimpleNeuralNetwork ElasticNet RandomForest --dataset CTRPv2 --test_mode LCO --measure LN_IC50
```

## Expert Tips and Best Practices

### Selecting the Right Test Mode
The `test_mode` parameter determines how data is split, which is critical for understanding model generalization:
- **LCO (Leave-Cell-Line-Out)**: Use this to evaluate how well the model predicts responses for entirely new cancer cell lines.
- **LDO (Leave-Drug-Out)**: Use this to test generalization to new chemical compounds.
- **LTO (Leave-Tissue-Out)**: Use this to see if the model can generalize across different primary sites/tissues.
- **LPO (Leave-Pair-Out)**: The standard setting where specific drug-cell line pairs are held out.

### Baseline Comparison
Always include `NaiveMeanEffectsPredictor` or `NaivePredictor` in your `--models` list. If your sophisticated model cannot significantly outperform these "mean-response" baselines, it likely hasn't captured meaningful biological or chemical signals.

### Data Management
By default, DrEvalPy downloads datasets to a `data/` directory and outputs to `results/`. You can override these using:
- `--path_data <path>`: Custom location for downloaded datasets.
- `--path_out <path>`: Custom location for experiment results.

### Hyperparameter Tuning
If using the Python API instead of the CLI, the `drug_response_experiment` function enables hyperparameter tuning by default (`hyperparameter_tuning=True`). When using the CLI for production runs, ensure you have installed the `[multiprocessing]` dependencies to handle the computational load of tuning.

## Reference documentation
- [DrEvalPy GitHub Repository](./references/github_com_daisybio_drevalpy.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_drevalpy_overview.md)