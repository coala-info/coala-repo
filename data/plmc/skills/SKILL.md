---
name: plmc
description: The `plmc` tool implements a maximum a posteriori (MAP) estimation approach to infer the parameters of a Potts model (or Ising model for binary data) from biological sequence data.
homepage: https://github.com/debbiemarkslab/plmc
---

# plmc

## Overview
The `plmc` tool implements a maximum a posteriori (MAP) estimation approach to infer the parameters of a Potts model (or Ising model for binary data) from biological sequence data. By analyzing covariation in a multiple sequence alignment, it identifies direct evolutionary couplings, which are often strong indicators of physical proximity in 3D structures. This skill provides the necessary command-line patterns to process alignments, tune regularization, and select appropriate alphabets for different biological systems.

## Core CLI Patterns

### Basic Coupling Inference
To calculate coupling scores from a protein alignment:
```bash
plmc -c output.couplings input_alignment.fasta
```

### Protein Model with Regularization
For protein families, it is standard practice to use specific L2 regularization values for fields ($h_i$) and couplings ($e_{ij}$):
```bash
plmc -o model.params -le 16.0 -lh 0.01 -m 100 -g -f FOCUS_SEQ_ID alignment.a2m
```
*   `-le 16.0`: Sets the L2 lambda for couplings (higher values prevent overfitting in small alignments).
*   `-lh 0.01`: Sets the L2 lambda for fields.
*   `-m 100`: Limits the maximum number of iterations for the L-BFGS optimizer.
*   `-g`: Ignores gaps (models only the coding portions).
*   `-f`: Focus mode; select a specific sequence ID to define the coordinate system and filter columns.

### RNA Coupling Inference
When working with RNA, you must override the default protein alphabet:
```bash
plmc -c output.couplings -a .ACGU -le 20.0 -lh 0.01 -m 50 alignment.fasta
```
*   `-a .ACGU`: Defines the RNA alphabet (including the gap character).

## Expert Tips and Best Practices

### Focus Mode Requirements
When using the `-f` (focus) option, ensure the alignment contains only columns that are present in the focus sequence. If the alignment includes columns that are gaps in the focus sequence, the output offsets will be incorrect. In focus mode, lowercase letters in the focus sequence are discarded.

### Performance Optimization
*   **Multithreading**: Use `-n <number>` or `-n max` to specify the number of CPU cores for OpenMP acceleration.
*   **Fast Mode**: Use `--fast` to enable stochastic gradient descent and faster weight calculations, which is useful for extremely large alignments.
*   **Precision**: If memory is a bottleneck, use a version of `plmc` compiled with single precision (32-bit), which halves memory requirements compared to the default double precision.

### Sequence Weighting
`plmc` automatically weights sequences to account for phylogenetic bias (clustering of similar sequences).
*   `-t <value>`: Sets the theta parameter (neighborhood divergence). Default is typically 0.2 (80% identity).
*   `-s <value>`: Sets the scale for neighborhood weights.
*   `--save-weights <file>`: Use this to export the calculated weights for downstream analysis.

### Output Formats
1.  **Couplings File (`-c`)**: A 6-column text file. The 6th column contains the APC-corrected Frobenius norm scores, which are the standard metric for predicting contacts.
2.  **Parameter File (`-o`)**: A binary file containing the full model parameters ($h_i$ and $e_{ij}$). This is required for mutational effect prediction but can be very large ($10^6$ to $10^8$ parameters).

## Reference documentation
- [plmc GitHub Repository](./references/github_com_debbiemarkslab_plmc.md)
- [Bioconda plmc Package](./references/anaconda_org_channels_bioconda_packages_plmc_overview.md)