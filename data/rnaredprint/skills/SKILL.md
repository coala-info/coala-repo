---
name: rnaredprint
description: RNARedPrint is a computational tool that uses Boltzmann sampling and tree-decomposition algorithms to design RNA sequences compatible with multiple target secondary structures. Use when user asks to design RNA sequences for multiple conformations, generate sequences with specific energy profiles across different structures, or perform multi-state RNA design.
homepage: https://github.com/yannponty/RNARedPrint
metadata:
  docker_image: "quay.io/biocontainers/rnaredprint:0.3--h9948957_2"
---

# rnaredprint

## Overview
RNARedPrint is a computational tool for the "positive design" of RNA sequences. It employs a tree-decomposition based dynamic programming algorithm and Boltzmann sampling to generate sequences that are compatible with multiple user-defined secondary structures. This is particularly useful for designing riboswitches or sequences that serve as seeds for negative design workflows where specific energy profiles across multiple conformations are required.

## Installation and Setup
The most efficient way to access the tool is via Bioconda:
```bash
conda install bioconda::rnaredprint
```
Note: High-level scripts require `ViennaRNA`, `numpy`, and `scipy` to be installed in the environment.

## Core CLI Usage
The fundamental `RNARedPrint` engine uses weights to bias the distribution toward specific structures.

### Basic Sampling
To sample 20 sequences for three target structures with specific weights in the stacking energy model:
```bash
RNARedPrint --model 3 --weights 1,2,5 --gcw 0.5 --num 20 "((((....))))" "((((..)))).." "..((((..))))"
```

### Parameters
- `--model`: Choose between `1` (basepairs), `2` (uniform), or `3` (stacking). Stacking is recommended for physical accuracy.
- `--weights`: Comma-separated list of weights corresponding to the input structures.
- `--gcw`: Weight for GC-content bias.
- `--num`: Number of sequences to generate.

## High-Level Design Scripts
Because manual weight adjustment is difficult, use the provided Python scripts for automated multi-dimensional Boltzmann sampling.

### Targeting Specific Energies
Use `design-energyshift.py` when each structural state requires a different target energy (in kcal/mol).
```bash
echo -e "((((...))))\n(...((...)))\n;" | design-energyshift.py --energies="-15.5,-10.2" --gc 0.5 --num 50 --tolerance=1
```

### Balancing Multi-state Energies
Use `design-multistate.py` to generate sequences where all target structures have approximately equal energies.
```bash
echo -e "((((((...))))))\n(((...)))...(((\n;" | design-multistate.py --num 20 --gc 0.6 --tolerance=0.5
```

## Expert Tips and Best Practices
- **Input Termination**: When piping structures into the Python scripts, the input must end with a line containing only a semicolon (`;`) to signal the end of the structure list.
- **Tolerance Settings**: The `--tolerance` flag is critical. For GC content, it defines a relative range. For Turner energy targets, it defines the allowed difference in kcal/mol.
- **Model Selection**: Always prefer `--model 3` (stacking) for biological applications, as it most closely approximates the standard RNA energy models used by ViennaRNA.
- **Pseudoknot Limitation**: RNARedPrint does not support pseudoknotted structures. If your design requires pseudoknots, consider using `RNAsketch` instead.
- **Weight Inference**: If the sampling distribution is not hitting your targets, the high-level scripts automatically attempt to infer the correct weights. If they fail to converge, try increasing the `--tolerance` or adjusting the target `--energies`.

## Reference documentation
- [RNARedPrint Overview](./references/anaconda_org_channels_bioconda_packages_rnaredprint_overview.md)
- [RNARedPrint GitHub Documentation](./references/github_com_yannponty_RNARedPrint.md)