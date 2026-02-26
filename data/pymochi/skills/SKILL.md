---
name: pymochi
description: pymochi models the non-linear relationship between mutational data and underlying biophysical traits using neural networks. Use when user asks to infer free energy changes from deep mutational scanning experiments, model complex phenotypes as a function of multiple traits, or decompose genetic interactions into energetic couplings.
homepage: https://github.com/lehner-lab/MoCHI
---


# pymochi

## Overview

MoCHI (Molecular Characterization of Heterogeneous Interactions) is a specialized tool designed to bridge the gap between high-throughput mutational data and biophysical reality. It uses neural networks to model "global epistasis"—the non-linear relationship between a protein's underlying physical properties (additive traits) and the observed experimental phenotype (e.g., fluorescence, growth rate, or binding enrichment). 

Use this skill to:
1. Infer free energy changes ($\Delta\Delta G$) from DMS experiments.
2. Model complex phenotypes as a function of multiple underlying traits (e.g., binding affinity that depends on both folding and interaction energy).
3. Decompose genetic interactions into specific energetic couplings.

## Native Command Line Usage

The primary interface for standard workflows is the `run_mochi.py` script.

### Standard Execution
To run a model fit, you must provide a model design file:
```bash
run_mochi.py --model_design path/to/model_design.txt
```

### Testing the Installation
Verify the environment and tool functionality using the built-in demo (approx. 10-minute runtime):
```bash
demo_mochi.py
```

### Help and Parameters
Access all available command-line arguments, including hyperparameter overrides and hardware settings:
```bash
run_mochi.py -h
```

## Model Design Configuration

MoCHI requires a **tab-separated** plain text file (not YAML) to define the model architecture. This file maps experimental measurements to biophysical traits.

### Required Columns
1.  **trait**: One or more additive trait names (e.g., `Folding` or `Binding`).
2.  **transformation**: The mathematical shape of the global epistatic trend.
3.  **phenotype**: A unique name for the measured experimental value (e.g., `Abundance`).
4.  **file**: Path to the input data (DiMSum `.RData` or plain text fitness/error estimates).

### Available Transformations
*   **Linear**: No non-linear transformation.
*   **ReLU / SiLU / Sigmoid**: Standard neural network activation functions.
*   **TwoStateFractionFolded**: Specifically for protein abundance/stability data.
*   **ThreeStateFractionBound**: For binding data where the protein must be folded to bind.
*   **SumOfSigmoids**: For complex, multi-state transitions.

## Python API Workflow

For custom analyses, use the `pymochi` package directly in Python.

### 1. Data Initialization
Load data and define cross-validation groups (typically 10-fold).
```python
from pymochi.data import MochiData
from pymochi.models import MochiTask

mochi_task = MochiTask(
    directory = 'output_dir',
    data = MochiData(
        model_design = my_model_design_df,
        k_folds = 10)
)
```

### 2. Optimization and Fitting
Perform a grid search to find optimal hyperparameters before fitting the final model.
```python
# Find best hyperparameters
mochi_task.grid_search()

# Fit the model for each fold
for i in range(10):
    mochi_task.fit_best(fold = i + 1)
```

### 3. Extracting Biophysical Energies
Convert model weights into physical energy units using the gas constant ($R$) and temperature ($T$).
```python
from pymochi.report import MochiReport

# RT calculation for 30 degrees Celsius
RT = (273 + 30) * 0.001987 

# Generate reports and extract energies
mochi_report = MochiReport(task = mochi_task, RT = RT)
energies = mochi_task.get_additive_trait_weights(RT = RT)
mochi_task.save()
```

## Expert Tips

*   **Input Formats**: MoCHI accepts nucleotide or amino acid sequences. Ensure your input files include both fitness estimates and associated error (standard deviation) for proper weighting during training.
*   **Temperature Calibration**: Always specify the correct temperature used in the original DMS experiment when extracting weights to ensure $\Delta G$ values are physically accurate.
*   **Output Structure**: After execution, check the `report/` subfolder for diagnostic plots, `predictions/` for variant-level model fits, and `weights/` for the inferred biophysical parameters.
*   **Hardware**: For large DMS datasets (e.g., >100,000 variants), ensure you are running in an environment with sufficient RAM, as one-hot encoding of sequences can be memory-intensive.

## Reference documentation
- [MoCHI GitHub Repository](./references/github_com_lehner-lab_MoCHI.md)
- [pymochi Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pymochi_overview.md)