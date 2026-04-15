---
name: coatran
description: CoaTran simulates coalescent trees that are topologically and temporally constrained by a provided transmission network. Use when user asks to simulate viral phylogenies within a transmission history, generate trees with constant effective population sizes, or create transmission trees where coalescence occurs at infection times.
homepage: https://github.com/niemasd/CoaTran
metadata:
  docker_image: "quay.io/biocontainers/coatran:0.0.4--h503566f_1"
---

# coatran

## Overview
CoaTran (Coalescent-Transmission) is a high-performance tool designed to simulate coalescent trees that are topologically and temporally constrained by a provided transmission network. It is significantly faster than previous solutions like VirusTreeSimulator and is essential for researchers creating synthetic datasets where the underlying transmission history is known. It supports different models of effective population size ($N_e$) to reflect various within-host viral dynamics.

## Command Line Usage

CoaTran provides specialized executables based on the desired population growth model. All commands require a transmission network and sample times in FAVITES format.

### Constant Effective Population Size
Use `coatran_constant` when assuming a stable viral population within each host.
```bash
coatran_constant <trans_network> <sample_times> <eff_pop_size>
```
*   **eff_pop_size**: A constant value representing the within-host effective population size.

### Transmission Tree Mode
Use `coatran_transtree` to generate a phylogeny where coalescence occurs at the latest possible moment (the time of infection). This makes the phylogeny equivalent to the transmission tree.
```bash
coatran_transtree <trans_network> <sample_times>
```

### Infection Time Mode
Use `coatran_inftime` to force coalescence at the earliest possible moment (the time the infector was infected).
```bash
coatran_inftime <trans_network> <sample_times>
```

### Exponential Growth (Experimental)
Note: The `coatran_expgrowth` mode is currently flagged as non-functional in the source documentation. If attempted, the syntax is:
```bash
coatran_expgrowth <trans_network> <sample_times> <init_eff_pop_size> <eff_pop_growth>
```

## Expert Tips and Best Practices

### Reproducibility
To ensure deterministic results across different runs, set the random number generator seed via an environment variable before execution:
```bash
export COATRAN_RNG_SEED=42
```

### Handling Unifurcations
CoaTran outputs Newick trees that include unifurcations (internal nodes with a single child) at the exact times of infection. While these provide valuable metadata about transmission events, many phylogenetic tools cannot parse them. 

If your downstream tools fail, use a Python script with `TreeSwift` to clean the output:
```python
from treeswift import read_tree_newick

tree = read_tree_newick("coatran_output.nwk")
tree.suppress_unifurcations()
print(tree.newick())
```

### Input Formats
*   **Transmission Network**: Must be in FAVITES format (typically a list of transmission events: `Source Target Time`).
*   **Sample Times**: Must be in FAVITES format (typically `NodeID Time`).



## Subcommands

| Command | Description |
|---------|-------------|
| coatran_constant | CoaTran (constant effective population size) |
| coatran_expgrowth | CoaTran (exponential effective population size growth) |
| coatran_inftime | CoaTran v0.0.4 (time of infection) |
| coatran_transtree | CoaTran (time of transmission) - tool for analyzing transmission networks and sample times |

## Reference documentation
- [CoaTran GitHub Overview](./references/github_com_niemasd_CoaTran.md)
- [Constant Effective Population Size Wiki](./references/github_com_niemasd_CoaTran_wiki_Constant-Effective-Population-Size.md)
- [Constrained Coalescence Theory](./references/github_com_niemasd_CoaTran_wiki_Constrained-Coalescence.md)