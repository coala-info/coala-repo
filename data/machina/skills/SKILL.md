---
name: machina
description: MACHINA is a specialized suite of tools designed to reconstruct the metastatic history of tumors using DNA sequencing data.
homepage: https://github.com/raphael-group/machina
---

# machina

## Overview

MACHINA is a specialized suite of tools designed to reconstruct the metastatic history of tumors using DNA sequencing data. It models the movement of cancer cell clones between a primary tumor and various metastatic sites by solving the Parsimonious Migration History (PMH) problem. The framework is particularly useful for researchers looking to distinguish between different seeding patterns (e.g., monoclonal vs. polyclonal) and to infer the most likely sequence of migration events that led to a patient's current disease state.

## Core CLI Commands

The machina package provides several executables for different stages of the analysis pipeline:

| Command | Purpose |
| :--- | :--- |
| `cluster` | Clusters mutations using a binomial distribution model for variant read counts. |
| `generatemigrationtrees` | Generates all possible migration trees given anatomical site labels. |
| `pmh_sankoff` | Enumerates all minimum-migration vertex labelings for a fixed clone tree. |
| `pmh` | Solves the PMH problem with specific migration pattern restrictions. |
| `pmh_tr` | Solves PMH with Polytomy Resolution (PMH-PR) for unresolved clone trees. |
| `pmh_ti` | Solves PMH and Tree Inference (PMH-TI) simultaneously using mutation frequencies. |
| `visualizeclonetree` | Generates DOT files to visualize clone trees and vertex labelings. |
| `visualizemigrationgraph` | Generates DOT files to visualize the resulting migration graph. |

## Input Format Specifications

### Clone Tree (.tree)
A simple edge list where each line represents a parent-child relationship:
```text
ParentNode ChildNode
A A1
A A2
```

### Leaf Labeling (.labeling)
Maps clone tree leaves to anatomical sites:
```text
LeafID SiteName
A1 Liver
A2 Lung
```

### Frequency File (.tsv)
A tab-separated file with a specific header structure:
1. Line 1: Number of anatomical sites.
2. Line 2: Number of samples.
3. Line 3: Number of mutation clusters.
4. Line 4: Header (ignored by tool).
5. Subsequent lines: `sample_index sample_label site_index site_label cluster_index cluster_label freq_lb freq_ub`

## Common Workflows

### 1. Basic Migration Inference
When you have a fixed clone tree and want to find the most parsimonious labeling:
```bash
pmh -p primary_site -m migration_pattern_file tree_file labeling_file
```

### 2. Handling Unresolved Trees (Polytomies)
If your clone tree has nodes with more than two children that need resolution:
```bash
pmh_tr -p primary_site -m migration_pattern_file tree_file labeling_file
```

### 3. Simultaneous Tree and Migration Inference
When starting from mutation frequencies rather than a fixed tree:
```bash
pmh_ti -p primary_site -m migration_pattern_file mutation_tree_file frequency_file
```

## Expert Tips & Best Practices

*   **Solver Dependency**: Most MACHINA solvers require Gurobi. Ensure your `GRB_LICENSE_KEY` environment variable is correctly set and the Gurobi libraries are in your `LD_LIBRARY_PATH` (Linux) or `DYLD_LIBRARY_PATH` (macOS).
*   **Visualization**: The visualization tools output `.dot` files. Use the Graphviz `dot` command to convert these to images:
    ```bash
    visualizeclonetree patient.tree patient.labeling > output.dot
    dot -Tpng output.dot -o tree.png
    ```
*   **Migration Restrictions**: Use `generatemigrationtrees` to define the search space for migration patterns if you have prior biological knowledge about which sites can seed others.
*   **Conda Installation**: The easiest way to manage dependencies (Boost, LEMON) is via Bioconda:
    ```bash
    conda install -c bioconda machina
    ```

## Reference documentation
- [MACHINA GitHub Repository](./references/github_com_raphael-group_machina.md)
- [MACHINA Overview and Installation](./references/anaconda_org_channels_bioconda_packages_machina_overview.md)