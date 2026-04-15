---
name: braid-mrf
description: braid-mrf predicts protein complexes by modeling protein-protein interaction networks using a Markov Random Field approach. Use when user asks to predict protein complexes from bait-prey data, cluster protein interaction networks, or generate SIF files for Cytoscape visualization.
homepage: https://github.com/wasineer-dev/braid.git
metadata:
  docker_image: "quay.io/biocontainers/braid-mrf:1.0.9--pyhfa5458b_0"
---

# braid-mrf

## Overview
braid-mrf is a specialized tool for predicting protein complexes by modeling protein-protein interaction (PPI) networks using a Markov Random Field approach. It transforms raw bait-prey experimental data into structured clusters, outputting results in both tabular formats and Simple Interaction Files (SIF) for visualization in tools like Cytoscape.

## Installation
The tool is available via Bioconda. It is recommended to use a Conda environment to manage dependencies like `numba` and `numpy`.
```bash
conda install bioconda::braid-mrf
```

## Input Format
The tool requires a CSV file (`-f`) where each line represents a bait-prey experiment.
- The first protein on each line is treated as the **bait**.
- Subsequent proteins on the same line are treated as **preys**.

## Command Line Usage
The primary execution script is `main.py`.

### Basic Execution
```bash
python main.py -f input_data.csv -psi 3.4 -k 500
```

### Working with BioPlex Data
When using BioPlex 2.0 or 3.0 datasets, you must include the `-bp` flag:
```bash
python main.py -bp bioplex_data.csv -psi 3.4 -k 800
```

## Parameter Optimization
The accuracy of the MRF model depends heavily on the `psi` and `k` parameters.

| Dataset | Recommended `-psi` | Recommended `-k` |
| :--- | :--- | :--- |
| **Gavin 2002** | 3.4 | 500 - 600 |
| **Gavin 2006** | 3.4 | 700 - 1000 |
| **E. coli (Babu 2018)** | 0.1 | 800 |
| **BioPlex** | 3.4 | 500+ |

- **-psi**: Represents the log-ratio of the false negative rate to the false positive rate.
- **-k**: Sets the maximum possible number of clusters.

## Output Files
After a successful run, the tool generates two primary files:
1. **out.tab**: A tab-separated file containing cluster annotations for each protein (one protein per line).
2. **out.sif**: A Simple Interaction File format. This is the standard format for importing the predicted complexes into **Cytoscape** for network analysis.

## Expert Tips
- **Large Datasets**: For human datasets with >10,000 proteins (like BioPlex 3.0), ensure you are using the latest version of the tool which supports GPU acceleration via TensorFlow if available.
- **Environment**: If installing via `pip` from source, always run `conda install anaconda` first to ensure complex dependencies like `numba` are correctly linked.

## Reference documentation
- [braid-mrf GitHub Repository](./references/github_com_wasineer-dev_braid.md)
- [braid-mrf Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_braid-mrf_overview.md)