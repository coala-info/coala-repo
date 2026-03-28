---
name: phylodeep
description: PhyloDeep uses deep learning to estimate epidemiological parameters and select transmission models from phylogenetic tree structures. Use when user asks to perform model adequacy checks, select the best-fitting epidemiological model, or infer parameters like R0 and infectious periods from a tree.
homepage: https://github.com/evolbioinfo/phylodeep
---

# phylodeep

## Overview
PhyloDeep leverages deep learning to extract epidemiological information from the structure of phylogenetic trees. It is particularly useful for analyzing the transmission dynamics of epidemics where traditional likelihood-based methods might be computationally intensive or difficult to implement. The tool supports three primary models: Birth-Death (BD), Birth-Death-Exposed-Infectious (BDEI), and Birth-Death with Superspreading (BDSS).

## Core Workflow

### 1. Model Adequacy Check (A Priori)
Before performing inference, always verify if your input tree falls within the distribution of the simulations used to train the neural networks.

```bash
# Check adequacy for different models
checkdeep -t tree.trees -m BD -o BD_check.png
checkdeep -t tree.trees -m BDEI -o BDEI_check.png
checkdeep -t tree.trees -m BDSS -o BDSS_check.png
```
**Expert Tip:** If the red star (your data) in the output PNG is outside the warm-colored density cloud, the model may not be appropriate for your data.

### 2. Model Selection
Determine which epidemiological model best explains your tree structure.

```bash
# -p: presumed sampling probability (0.0 to 1.0)
# -v: vector representation (CNN_FULL_TREE is generally preferred for accuracy)
modeldeep -t tree.trees -p 0.25 -v CNN_FULL_TREE -o model_selection.csv
```

### 3. Parameter Inference
Estimate specific values like $R_0$, infectious period, and superspreading fractions.

```bash
# Basic inference
paramdeep -t tree.trees -p 0.25 -m BDSS -v CNN_FULL_TREE -o results.csv

# Inference with 95% Confidence Intervals (recommended)
paramdeep -t tree.trees -p 0.25 -m BDSS -v CNN_FULL_TREE -o results_with_ci.csv -c
```

## Model Definitions
- **BD (Birth-Death):** Basic model with constant transmission and recovery rates.
- **BDEI (Birth-Death-Exposed-Infectious):** Includes an incubation period (exposed but not yet infectious).
- **BDSS (Birth-Death-Superspreading):** Accounts for individuals with significantly higher transmission rates.

## Python API Usage
For integration into scripts, use the following pattern:

```python
from phylodeep import BDSS, FULL
from phylodeep.paramdeep import paramdeep

# Returns a dictionary of estimated parameters
results = paramdeep(
    path_to_tree='./my_tree.trees',
    sampling_proba=0.25,
    model=BDSS,
    vector_representation=FULL,
    ci_computation=True
)
```

## Best Practices
- **Sampling Probability:** The accuracy of results is highly dependent on providing a realistic sampling probability (`-p`).
- **Tree Scaling:** Time-related parameters (infectious/incubation periods) are returned in the same units as the input tree's branch lengths (e.g., years or days).
- **Representation Choice:** Use `CNN_FULL_TREE` (or `FULL` in Python) for maximum information extraction from the tree topology. Use `FFNN_SUMSTATS` only if computational resources are extremely limited or for comparison.



## Subcommands

| Command | Description |
|---------|-------------|
| checkdeep | A priori model adequacy check of phylogenetic trees for phylodynamic models. Recommended to perform before selecting phylodynamic models and estimating parameters. |
| modeldeep | Model selection for phylodynamics using pretrained neural networks. |
| paramdeep | Parameter inference for phylodynamics using pretrained neural networks. |

## Reference documentation
- [PhyloDeep GitHub README](./references/github_com_evolbioinfo_phylodeep_blob_main_README.md)
- [PhyloDeep PyPI Documentation](./references/github_com_evolbioinfo_phylodeep_blob_main_README_PYPI.md)