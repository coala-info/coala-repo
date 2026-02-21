---
name: phylodeep
description: PhyloDeep is a specialized tool for extracting epidemiological insights from the branching patterns of phylogenetic trees.
homepage: https://github.com/evolbioinfo/phylodeep
---

# phylodeep

## Overview
PhyloDeep is a specialized tool for extracting epidemiological insights from the branching patterns of phylogenetic trees. It leverages pre-trained deep learning models to bypass the computational intensity of traditional likelihood-based methods. You should use this skill to assess model adequacy, determine the most likely transmission model for a given tree, and infer specific parameters such as the basic reproduction number (R0), infectious period, and superspreading fractions.

## Core Workflows

### 1. Model Adequacy Check (A Priori)
Before performing inference, always verify if your input tree falls within the space of the simulations used to train the deep learners. This prevents "garbage-in, garbage-out" scenarios.

```bash
# Check adequacy for the standard Birth-Death model
checkdeep -t path/to/tree.trees -m BD -o BD_adequacy.png

# Check adequacy for the Superspreading model
checkdeep -t path/to/tree.trees -m BDSS -o BDSS_adequacy.png
```
*Expert Tip: If the red star (your data) is outside the colored cloud in the output PCA plot, the model is not adequate for your data.*

### 2. Model Selection
Compare different epidemiological scenarios to find the best fit for your tree.

```bash
# Compare BD vs BDEI vs BDSS
modeldeep -t path/to/tree.trees -p 0.25 -v CNN_FULL_TREE -o selection_results.csv
```
*   `-p`: Presumed sampling probability (0.0 to 1.0).
*   `-v`: Vector representation. `CNN_FULL_TREE` is generally recommended for maximum information extraction.

### 3. Parameter Inference
Once a model is selected, estimate the specific transmission parameters.

```bash
# Estimate parameters for BDSS with 95% Confidence Intervals
paramdeep -t path/to/tree.trees -p 0.25 -m BDSS -v CNN_FULL_TREE -c -o inference_results.csv
```
*   `-m`: The model (BD, BDEI, or BDSS).
*   `-c`: Flag to compute 95% Confidence Intervals (highly recommended).

## CLI Reference Summary
| Command | Purpose | Key Arguments |
| :--- | :--- | :--- |
| `checkdeep` | Model adequacy | `-t` (tree), `-m` (model), `-o` (plot) |
| `modeldeep` | Select best model | `-t` (tree), `-p` (sampling prob), `-v` (representation) |
| `paramdeep` | Infer parameters | `-t` (tree), `-m` (model), `-p` (sampling prob), `-c` (CI) |

## Best Practices
*   **Sampling Probability**: The accuracy of R0 and other estimates is highly sensitive to the sampling probability (`-p`). Ensure this value is as accurate as possible based on surveillance data.
*   **Time Units**: Parameter estimates for time-related variables (like infectious period) will be in the same units as your tree's branch lengths (e.g., years or days).
*   **Representation Selection**: 
    *   `CNN_FULL_TREE`: Best for capturing complex patterns in the tree topology.
    *   `FFNN_SUMSTATS`: Faster, uses summary statistics; useful for very large trees where CNN might be memory-intensive.

## Reference documentation
- [PhyloDeep GitHub Repository](./references/github_com_evolbioinfo_phylodeep.md)
- [PhyloDeep Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phylodeep_overview.md)