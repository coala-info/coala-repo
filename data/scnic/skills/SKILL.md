---
name: scnic
description: SCNIC (Sparse Cooccurrence Network Investigation for Compositional data) is a specialized tool for building and analyzing positive correlation networks.
homepage: https://github.com/shafferm/SCNIC
---

# scnic

## Overview

SCNIC (Sparse Cooccurrence Network Investigation for Compositional data) is a specialized tool for building and analyzing positive correlation networks. It addresses the inherent biases of compositional data—where the total sum of observations is an artifact of the sequencing depth—by supporting robust metrics like SparCC. The tool facilitates a multi-step workflow: calculating correlations within a single dataset, grouping highly correlated features into functional modules to reduce dimensionality, and identifying relationships between distinct data types (e.g., microbial taxa vs. metabolites).

## Command Line Usage

SCNIC is executed via the `SCNIC_analysis.py` script using three primary modes: `within`, `modules`, and `between`.

### 1. Within-Table Correlations (`within`)
Generates a correlation network from a single BIOM table.

```bash
SCNIC_analysis.py within -i input_table.biom -o within_output/ -m sparcc
```
- **-i**: Input BIOM file.
- **-m**: Correlation metric. `sparcc` is recommended for compositional data; `spearman` and `pearson` are also available.
- **-o**: Output directory containing `correls.txt`.

### 2. Module Identification and Summarization (`modules`)
Groups features that meet a minimum pairwise correlation threshold into modules and creates a collapsed BIOM table.

```bash
SCNIC_analysis.py modules -i within_output/correls.txt -o modules_output/ --min_r .35 --table input_table.biom
```
- **-i**: The `correls.txt` file produced by the `within` step.
- **--min_r**: The minimum correlation coefficient (R-value) to include an edge in a module.
- **--table**: The original BIOM table used to generate the correlations.
- **Outputs**: 
    - A collapsed BIOM table where module members are summed into a single feature.
    - A `.gml` file for visualization in tools like Cytoscape.
    - A list of modules and their constituent features.

### 3. Between-Table Correlations (`between`)
Calculates pairwise correlations between two different BIOM tables (e.g., 16S data and metabolomics).

```bash
SCNIC_analysis.py between -1 table1.biom -2 table2.biom -o between_output/ -m spearman --min_p .05
```
- **-1, -2**: The two BIOM tables to correlate.
- **--min_p**: P-value threshold for reporting correlations.

## Expert Tips and Best Practices

- **SparCC Thresholding**: When using SparCC with 16S data, an R-value threshold between **0.3 and 0.35** is a reliable heuristic. Empirical testing with 1 million bootstraps has shown these values typically correspond to FDR-adjusted p-values of <0.05 and <0.1, respectively.
- **Positive Correlations Only**: SCNIC's module finding and summarization logic focuses exclusively on positive correlations. Negative correlations are excluded from the network outputs used for module generation.
- **Visualization**: The `.gml` files produced by the `modules` step include all observation metadata from the input BIOM file, making them ready for immediate styling in Cytoscape.
- **Environment Setup**: If running on ARM architecture (Apple M1/M2), ensure the environment is configured for `osx-64` compatibility:
  ```bash
  CONDA_SUBDIR=osx-64 mamba env create -n SCNIC --file environment.yml
  ```
- **Dependencies**: Ensure `fastspar` and `parallel` are in your system PATH if you are not using the provided Conda environment, as SCNIC relies on them for efficient SparCC calculations.

## Reference documentation
- [SCNIC GitHub Repository](./references/github_com_lozuponelab_SCNIC.md)
- [SCNIC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scnic_overview.md)