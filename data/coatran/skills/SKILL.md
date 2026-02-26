---
name: coatran
description: CoaTran simulates evolutionary trees that are consistent with a specific transmission history and respect host bottleneck constraints. Use when user asks to simulate coalescent trees within a transmission network, generate phylogenies for epidemiological modeling, or model lineage evolution across transmission events.
homepage: https://github.com/niemasd/CoaTran
---


# coatran

## Overview
CoaTran (Coalescent Transmission) is a high-performance tool designed to simulate evolutionary trees that are consistent with a specific transmission history. Unlike general coalescent simulators, CoaTran ensures that lineages only coalesce within the same host or at the moment of transmission between hosts. This is essential for epidemiological modeling where the phylogeny must respect the "bottleneck" constraints of transmission events.

## Installation and Setup
The tool is available via Bioconda or can be compiled from source.

```bash
# Installation via Conda
conda install bioconda::coatran

# Manual compilation
git clone https://github.com/niemasd/CoaTran.git
cd CoaTran && make
```

## Core CLI Usage
CoaTran provides different executables based on the desired population dynamics model. All modes require a transmission network and sample times in FAVITES format.

### Constant Effective Population Size
Use this for standard neutral simulations within hosts.
```bash
coatran_constant <trans_network> <sample_times> <eff_pop_size>
```

### Transmission Tree Mode
Simulates a tree where coalescence happens exactly at the time of infection (the latest possible time).
```bash
coatran_transtree <trans_network> <sample_times>
```

### Infection Time Mode
Simulates a tree where coalescence happens at the time the infector was originally infected (the earliest possible time).
```bash
coatran_inftime <trans_network> <sample_times>
```

## Expert Tips and Best Practices

### Reproducibility
Always set the random seed via the environment variable to ensure simulations are deterministic and reproducible.
```bash
export COATRAN_RNG_SEED=42
```

### Handling Unifurcations
CoaTran outputs Newick strings containing unifurcations (nodes with a single child) to represent infection events. If your downstream analysis tools do not support unifurcations, use a Python script with `treeswift` to clean the output:

```python
from treeswift import read_tree_newick
tree = read_tree_newick("coatran_output.nwk")
tree.suppress_unifurcations()
print(tree.newick())
```

### Model Limitations
*   **Exponential Growth**: Note that `coatran_expgrowth` is currently flagged as non-functional in the documentation. Stick to `coatran_constant` for population-based simulations.
*   **Input Format**: Ensure your transmission network and sample times strictly follow the FAVITES specification, as the tool is optimized for speed and may not provide verbose error messages for malformed inputs.

## Reference documentation
- [CoaTran GitHub Repository](./references/github_com_niemasd_CoaTran.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_coatran_overview.md)