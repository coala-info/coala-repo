---
name: simba_pbg
description: The `simba_pbg` skill facilitates the use of a customized PyTorch-BigGraph (PBG) package specifically modified for the SIMBA analysis suite.
homepage: https://github.com/pinellolab/simba_pbg
---

# simba_pbg

## Overview

The `simba_pbg` skill facilitates the use of a customized PyTorch-BigGraph (PBG) package specifically modified for the SIMBA analysis suite. It is designed to learn graph embeddings for massive datasets—potentially containing billions of entities and trillions of edges—that are too large to fit into standard memory. This tool transforms biological interaction graphs into low-dimensional feature vectors (embeddings) by partitioning the graph and using multi-threaded asynchronous SGD. Use this skill when you need to initialize, partition, or train graph models as part of a SIMBA workflow.

## Installation

The recommended way to install the customized package is via Bioconda:

```bash
conda install -c bioconda simba_pbg
```

For GPU support, the package must be compiled from source with the C++ kernels enabled:

```bash
PBG_INSTALL_CPP=1 pip install .
```

## Core Workflow and CLI Patterns

### 1. Data Preparation (TSV to PBG Format)
PBG requires input data to be converted from raw TSV files into a partitioned binary format. The `torchbiggraph_import_from_tsv` command handles entity identifier assignment and shuffling.

**Standard Pattern:**
```bash
torchbiggraph_import_from_tsv \
  --lhs-col=0 --rel-col=1 --rhs-col=2 \
  <config_file.py> \
  <input_train.txt> \
  <input_valid.txt> \
  <input_test.txt>
```

*   `--lhs-col`, `--rel-col`, `--rhs-col`: Specify the zero-indexed columns for the source node, relation type, and target node.
*   The output is stored in the directory specified by the `entity_path` in your configuration file.

### 2. Training the Model
Training is executed using the `torchbiggraph_train` command. While parameters are defined in a Python configuration file, you can override them dynamically.

**Standard Pattern:**
```bash
torchbiggraph_train <config_file.py> -p edge_paths=<path_to_partitioned_edges>
```

**Common Overrides:**
*   `-p` or `--param`: Use this to change parameters without editing the config file (e.g., `-p epochs=10` or `-p checkpoint_path=./new_checkpoints`).

### 3. GPU Training
If the package was installed with C++ support, use the specific GPU training command:
```bash
torchbiggraph_train_gpu <config_file.py>
```

## Expert Tips and Best Practices

*   **Graph Scale:** PBG is optimized for massive graphs. If your graph has fewer than 100,000 nodes, standard embedding methods (like ComplEx via KBC) may produce higher quality results with less overhead.
*   **Memory Management:** Use **graph partitioning** to handle datasets that exceed RAM. This allows PBG to load only specific "buckets" of edges and entities at a time.
*   **Hardware Optimization:** PBG is highly multi-threaded. Ensure you are running on a machine with a high core count. For distributed execution across multiple machines, a high-bandwidth interconnect (10 Gbps+) is recommended for checkpointing and synchronization.
*   **Negative Sampling:** PBG uses batched negative sampling to achieve high throughput. If training is slow, check if your `num_negatives` parameter is balanced against your hardware's processing power.
*   **SIMBA Specifics:** This version of PBG includes a `load_config_simba()` function and a `FixOperator` for handling specific node training scenarios unique to the SIMBA biological graph construction.

## Reference documentation

- [simba_pbg Overview](./references/anaconda_org_channels_bioconda_packages_simba_pbg_overview.md)
- [simba_pbg GitHub Repository](./references/github_com_pinellolab_simba_pbg.md)