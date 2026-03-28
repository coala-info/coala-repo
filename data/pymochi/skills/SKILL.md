---
name: pymochi
description: Pymochi infers latent biophysical traits from deep mutational scanning datasets using neural network models of global epistasis. Use when user asks to infer additive traits like folding or binding free energies, model the relationship between protein variants and fitness, or perform thermodynamic analysis of mutational data.
homepage: https://github.com/lehner-lab/MoCHI
---

# pymochi

## Overview
The pymochi skill enables the analysis of deep mutational scanning datasets by inferring underlying additive traits (such as folding or binding free energies) from observed phenotypes. It uses a neural network architecture to model the global epistatic relationship between these latent biophysical traits and the measured fitness values. This tool is essential for researchers looking to move beyond simple fitness scores to a mechanistic understanding of protein stability and molecular interactions.

## Model Design Requirements
Before running pymochi, you must prepare a tab-separated model design file. This file defines the architecture of the biophysical model.

**Required Columns:**
- `trait`: Names of one or more additive traits (e.g., Folding, Binding).
- `transformation`: The mathematical shape of the global epistatic trend. Supported options:
    - `Linear`, `ReLU`, `SiLU`, `Sigmoid`, `SumOfSigmoids`
    - `TwoStateFractionFolded` (Common for abundance data)
    - `ThreeStateFractionBound` (Common for binding data)
- `phenotype`: A unique name for the measured experimental phenotype (e.g., Abundance, KinaseActivity).
- `file`: Path to the input data (DiMSum .RData or plain text fitness files).

## Command Line Usage
The primary interface for standard workflows is the `run_mochi.py` script.

### Basic Execution
To run a model fit using a design file:
```bash
run_mochi.py --model_design path/to/model_design.txt
```

### Common CLI Arguments
- `--project_name`: Specify a name for the output directory.
- `--k_folds`: Set the number of cross-validation groups (default is often 10).
- `--batch_size`: Adjust the number of variants processed per training step.
- `--epochs`: Define the maximum number of training iterations.
- `--learn_rate`: Set the initial learning rate for the optimizer.

## Python API Integration
For custom workflows, use the `pymochi` package components directly.

```python
from pymochi.data import MochiData
from pymochi.models import MochiTask

# Initialize data object
data = MochiData(model_design = my_pd_dataframe)

# Define and run task
task = MochiTask(
    directory = 'output_dir',
    data = data,
    batch_size = 1024
)
task.run()
```

## Best Practices
- **Data Formatting**: Ensure fitness files contain variant sequences (nucleotide or amino acid) along with fitness and error estimates.
- **Transformation Selection**: Use `TwoStateFractionFolded` when modeling protein stability from abundance-seq data, as it correctly represents the thermodynamic relationship between $\Delta G$ and the fraction of folded protein.
- **Cross-Validation**: Always use k-fold cross-validation (typically $k=10$) to ensure the inferred energies generalize well to unseen mutations.
- **Hardware**: For large DMS datasets, ensure a compatible GPU environment is available to accelerate the neural network training process.



## Subcommands

| Command | Description |
|---------|-------------|
| demo_mochi.py | MoCHI Command Line tool. |
| run_mochi.py | MoCHI Command Line tool. |

## Reference documentation
- [MoCHI GitHub Repository](./references/github_com_lehner-lab_MoCHI.md)
- [MoCHI README](./references/github_com_lehner-lab_MoCHI_blob_master_README.md)
- [Model Design Example](./references/github_com_lehner-lab_MoCHI_blob_master_pymochi_data_model_design_example.txt.md)