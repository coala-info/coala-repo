---
name: doebase
description: doebase is a framework that applies Optimal Design of Experiments to select statistically optimized subsets of genetic part combinations for synthetic biology. Use when user asks to define a genetic design space, generate an optimal experimental library, or calculate a representative subset of constructs from a full factorial.
homepage: https://github.com/pablocarb/doebase
metadata:
  docker_image: "quay.io/biocontainers/doebase:v2.0.2"
---

# doebase

## Overview
doebase (also known as OptBioDes) is a specialized framework for applying Optimal Design of Experiments to synthetic biology. It automates the selection of genetic part combinations to ensure that the resulting experimental library is statistically optimized. This is particularly valuable when the total number of possible combinations (the full factorial) is too large to build, and a representative "optimal" subset is required to characterize the system's behavior.

## Core Workflow

### 1. Define the Design Space
The design space is defined by a dictionary of "factors," where each key represents a position in the genetic construct. Each position contains a `doebase.spec` object defining the available parts (levels).

```python
from doebase import makeDoeOptDes

# Define specifications for each position
fact = {
    'P1': spec(positional=None, component='promoter', levels=['J23100', 'J23106', '-']),
    'G1': spec(positional=1.0, component='gene', levels=['crtE_v1', 'crtE_v2']),
    'G2': spec(positional=1.0, component='gene', levels=['crtB_v1', 'crtB_v2']),
    'O1': spec(positional=None, component='origin', levels=['pMB1', 'BBR1'])
}
```

### 2. Generate the Optimal Design
Use the `makeDoeOptDes` function to calculate the library.

```python
factors, fnames, diagnostics = makeDoeOptDes(
    fact, 
    size=24,           # Desired number of constructs to build
    starts=1040,       # Number of iterations for the optimization algorithm
    alpha=0.05,        # Statistical significance level
    verbose=True
)
```

## Key Parameters and Best Practices

### Handling Genetic Parts
- **Promoters**: To include "knock-out" or empty positions in your design, include `'-'` as a level in the promoter list.
- **Permutation Classes**: Set `positional=1.0` for gene coding regions if the parts can be rearranged across different positions (e.g., swapping the order of genes in an operon).
- **Origins**: Levels should represent different plasmid copy numbers or specific replication origins.

### Optimization Tuning
- **Library Size**: The `size` parameter determines your experimental budget. If `makeFullFactorial=True`, the tool ignores `size` and generates every possible combination.
- **Algorithm Starts**: The `starts` parameter (default 1040) controls how many times the search algorithm restarts to find the global optimum. Increase this value for complex designs with many factors to ensure a truly optimal result.
- **Random Baseline**: Set `random=True` to generate a random subset instead of an optimal one. This is useful for creating control groups to validate the benefit of the optimal design.

### Input Data Formats
While the Python API is the primary interface, doebase can process specifications provided in tabular form (`.csv` or `.xlsx`). Ensure your tables include these mandatory columns:
- **DoE position**: The sequence position in the construct.
- **DoE permutation class**: Use `1` for parts that can be rearranged.
- **DoE designation**: The part type (`origin`, `resistance`, `promoter`, or `gene`).
- **Part number**: The unique identifier for the part (e.g., SynBioHub or ICE ID).

## Reference documentation
- [OptBioDes: an optimal design of experiments (DoE) base package for synthetic biology](./references/github_com_pablocarb_doebase.md)