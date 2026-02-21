---
name: floco
description: Floco (flow + copy) is a bioinformatics tool designed to call individual node copy numbers on (pan)genome graphs.
homepage: https://github.com/hugocarmaga/floco
---

# floco

## Overview

Floco (flow + copy) is a bioinformatics tool designed to call individual node copy numbers on (pan)genome graphs. It leverages sequence-to-graph alignment information and formulates the copy number estimation as an Integer Linear Programming (ILP) problem using network flow. This approach allows for precise determination of whether specific segments of a graph represent deletions (CN0), haploid states (CN1), diploid states (CN2), or higher-order duplications.

## Installation and Requirements

Floco requires a **Gurobi License** to solve the underlying ILP problem. Ensure Gurobi is installed and your license is active before running the tool.

*   **Conda (Recommended):** `conda install -c bioconda floco`
*   **Manual:** `pip install .` from the source repository.

## Core Workflow

To use floco, you must provide a graph and its corresponding alignments.

1.  **Graph (GFA):** Must contain sequences and be sorted (all node lines 'S' must appear before edge lines 'L').
2.  **Alignments (GAF):** Sequence-to-graph alignments. It is highly recommended to use **GraphAligner** to generate these files.

### Basic Command Pattern

```bash
floco -g graph.gfa -a alignments.gaf -o results.csv -p 2
```

## Command-Line Best Practices

### Handling Background Ploidy
Use the `-p` or `--bg-ploidy` flag to define the expected most common copy number in your dataset. You can provide multiple values if the background is mixed.
*   **Haploid organism:** `-p 1`
*   **Diploid organism:** `-p 2` (Default is `1 2`)

### Optimization and Performance
*   **Complexity Levels (`-c`):** Adjust the model complexity from 1 to 3. Higher values (3) are more accurate but significantly slower and more memory-intensive. Use `1` for quick scans and `2` (default) for standard production runs.
*   **Pickle Dumps for Iteration:** Parsing large GAF files is time-consuming. Use `--debug` to generate a `dump-{filename}.tmp.pkl` file. In subsequent runs with the same data (e.g., testing different ploidy settings), provide this file using `-d` to skip the alignment parsing phase:
    ```bash
    floco -g graph.gfa -d dump-data.tmp.pkl -o new_results.csv -p 1
    ```

### Debugging and Advanced Output
Running with `--debug` produces several auxiliary files useful for validation:
*   `stats_concordance-*.csv`: Shows the raw CN probabilities before the network flow optimization.
*   `ilp_results-*.csv`: Contains the raw ILP variable results.
*   `model_*.lp`: The actual ILP model definition for manual inspection in Gurobi.

### Tuning Penalties
If the model is incorrectly jumping between copy number states or failing to use available edges:
*   **`-S` (Expensive Penalty):** Controls the probability of using "super edges" when standard edges are available.
*   **`-s` (Cheap Penalty):** Controls the probability of using "super edges" when no other path exists.

## Reference documentation
- [Floco GitHub Repository](./references/github_com_hugocarmaga_floco.md)
- [Bioconda Floco Package](./references/anaconda_org_channels_bioconda_packages_floco_overview.md)