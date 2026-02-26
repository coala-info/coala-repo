---
name: dinf
description: "Performs discriminator-based inference for population genetics using neural networks. Use when you ask to infer population genetic parameters by comparing a target dataset to simulated data or when working with the dinf Python API."
homepage: https://github.com/RacimoLab/dinf
---


# dinf

Performs discriminator-based inference for population genetics using neural networks.
  Use when you need to infer population genetic parameters by comparing a target dataset
  to simulated data, or when working with the dinf Python API for simulation model creation
  and CLI for training and inference.
---
## Overview

The `dinf` tool is designed for population genetics research, enabling inference of genetic parameters through a process of discriminator-based comparison between observed (target) and simulated datasets. It leverages neural networks to achieve this, finding simulation parameters that best match the target data. The tool offers both a Python API for defining simulation models and a command-line interface (CLI) for training discriminators and performing inference.

## Usage

The `dinf` tool can be used via its Python API or its command-line interface.

### Command-Line Interface (CLI)

The CLI is primarily used for training discriminators and performing inference.

**General Structure:**

```bash
dinf <command> [options]
```

**Key Commands and Options:**

*   **`train`**: Trains a discriminator model.
    *   `--target-data <path>`: Path to the target dataset.
    *   `--sim-params <path>`: Path to a file defining simulation parameters.
    *   `--output-dir <path>`: Directory to save the trained discriminator.
    *   `--epochs <int>`: Number of training epochs.
    *   `--batch-size <int>`: Batch size for training.

*   **`infer`**: Performs inference using a trained discriminator.
    *   `--discriminator <path>`: Path to the trained discriminator model.
    *   `--target-data <path>`: Path to the target dataset.
    *   `--sim-params <path>`: Path to a file defining simulation parameters to search over.
    *   `--output-file <path>`: File to save the inference results.
    *   `--optimizer <str>`: The optimization algorithm to use (e.g., 'adam', 'sgd').
    *   `--learning-rate <float>`: Learning rate for the optimizer.

**Example Workflow:**

1.  **Prepare your data:** Ensure your target dataset and simulation parameter definitions are in the correct format (refer to the project documentation for specifics).
2.  **Train a discriminator:**
    ```bash
    dinf train --target-data path/to/your/target_data.tsv --sim-params path/to/simulation_params.yaml --output-dir ./trained_discriminator
    ```
3.  **Perform inference:**
    ```bash
    dinf infer --discriminator ./trained_discriminator/discriminator.pth --target-data path/to/your/target_data.tsv --sim-params path/to/simulation_params.yaml --output-file ./inference_results.csv --optimizer adam --learning-rate 0.001
    ```

### Python API

The Python API allows for programmatic creation of simulation models and integration into custom workflows.

**Key Components:**

*   **`dinf.models`**: Contains modules for defining simulation models.
*   **`dinf.training`**: Utilities for training discriminators.
*   **`dinf.inference`**: Tools for performing inference.

**Example Snippet (Conceptual):**

```python
import dinf.models as models
import dinf.training as training
import dinf.inference as inference

# Define a simulation model
my_model = models.MySimulationModel(...)

# Train a discriminator
discriminator = training.train_discriminator(
    target_data=...,
    simulation_model=my_model,
    sim_params=...,
    epochs=100
)

# Perform inference
results = inference.run_inference(
    discriminator=discriminator,
    target_data=...,
    sim_params=...
)
```

**Best Practices:**

*   **Data Formatting:** Always consult the official documentation for the expected format of input data files (e.g., `.tsv`, `.yaml`).
*   **Parameter Tuning:** Experiment with different `epochs`, `batch-size`, `optimizer`, and `learning-rate` values to achieve optimal results.
*   **Output Interpretation:** Understand the output of the `infer` command, which typically includes inferred parameter values and their confidence intervals.

## Reference documentation

- [GitHub - RacimoLab/dinf: Dinf is discriminator-based inference for population genetics](./references/github_com_RacimoLab_dinf.md)
- [Anaconda.org channels bioconda packages dinf overview](./references/anaconda_org_channels_bioconda_packages_dinf_overview.md)