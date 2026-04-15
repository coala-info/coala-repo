---
name: univariate
description: This tool performs univariate time series forecasting using the N-BEATS neural network model. Use when user asks to initialize the environment, prepare datasets, validate metrics, build experiment configurations, train a model, extract trend and seasonality, or calculate performance statistics.
homepage: https://github.com/ServiceNow/N-BEATS
metadata:
  docker_image: "biocontainers/univariate:phenomenal-v2.2.6_cv1.3.32"
---

# univariate

## Overview
N-BEATS (Neural Basis Expansion Analysis for Interpretable Time Series) is a specialized neural network model designed for univariate forecasting. This skill facilitates the end-to-end workflow of the ServiceNow implementation, which uses a block-based architecture to process historical windows and generate future predictions. It is particularly effective for large-scale datasets like M4 and provides two distinct modes: a generic architecture for maximum accuracy and an interpretable architecture that decomposes signals into human-readable components.

## Environment Setup
The implementation relies on Docker and a Makefile to manage dependencies and execution environments.

- **Initialize Environment**: Run `make init` to build the required Docker image.
- **Data Preparation**: Run `make dataset` to download and prepare standard datasets (stored in `./storage/datasets`).
- **Validation**: Run `make test` to verify metrics calculation and dataset integrity.

## Experiment Workflow
Training and forecasting are managed through a two-step process: building the experiment configuration and then running the generated commands.

### 1. Build the Experiment
Generate the directory structure and command files for an ensemble:
```bash
make build config=experiments/m4/interpretable.gin
```
*Note: Replace `interpretable.gin` with `generic.gin` for the non-interpretable version.*

### 2. Execute Training
Run a specific model from the generated ensemble. The command path typically includes parameters like repeat index, lookback period, and loss function:
- **CPU Execution**:
  ```bash
  make run command=storage/experiments/[experiment_name]/repeat=0,lookback=2,loss=MAPE/command
  ```
- **GPU Execution**:
  ```bash
  make run command=storage/experiments/[experiment_name]/repeat=0,lookback=2,loss=MAPE/command gpu=0
  ```

## Expert Tips and Best Practices
- **Ensemble Optimization**: The default configuration uses 10 repeats (up to 180 models). For faster iteration with minimal performance loss, set `build.repeats = 1` in the `.gin` configuration files to create a "light" ensemble.
- **Interpretable Mode**: Use the interpretable configuration when you need to extract trend and seasonality. This mode uses specific basis functions (polynomials for trend, harmonics for seasonality) instead of generic ReLU layers.
- **Lookback Windows**: Experiment with different lookback factors (e.g., `lookback=2` to `lookback=7`). The lookback period is a multiple of the forecast horizon.
- **Parallelization**: If multiple GPUs are available, execute different `command` files in parallel by specifying different `gpu-id` values.
- **Results Analysis**: Use `make notebook port=<port>` to launch JupyterLab and run the provided evaluation notebooks in the `notebooks/` directory to calculate final performance statistics.

## Reference documentation
- [N-BEATS Main Repository](./references/github_com_ServiceNow_N-BEATS.md)