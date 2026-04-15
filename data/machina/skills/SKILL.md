---
name: machina
description: MACHINA is a computational framework that reconstructs the migration history of cancer cells by inferring seeding events between primary tumors and metastases. Use when user asks to infer migration patterns, resolve clone tree polytomies, or visualize clonal migration graphs and trees.
homepage: https://github.com/raphael-group/machina
metadata:
  docker_image: "quay.io/biocontainers/machina:1.2--h21ec9f0_7"
---

# machina

## Overview
MACHINA is a computational framework designed to reconstruct the migration history of cancer cells. By taking clone trees and anatomical site labels as input, it infers the most likely sequence of seeding events between a primary tumor and various metastases. This skill helps navigate the suite of command-line tools provided by MACHINA to process mutation data, generate trees, and solve optimization problems related to clonal migration.

## Core Workflows

### 1. Data Preparation
Before running the optimization algorithms, ensure your input files follow the required formats:
- **Clone Tree (.tree):** An edge list of incident vertices (e.g., `ParentNode ChildNode`).
- **Leaf Labeling (.labeling):** A mapping of leaf nodes to anatomical sites (e.g., `NodeID SiteName`).
- **Frequencies (.tsv):** A tab-separated file containing mutation frequencies across different samples.

### 2. Migration Pattern Inference
The framework provides several specialized tools depending on the level of uncertainty in your input data:

- **Standard PMH (`pmh`):** Use when you have a fixed clone tree and want to find the most parsimonious migration history.
- **Polytomy Resolution (`pmh_tr`):** Use when your clone tree contains polytomies (nodes with more than two children) that need to be resolved to minimize migration events.
- **Tree Inference (`pmh_ti`):** Use when you need to infer the mutation tree and migration history simultaneously from frequency data.
- **Sankoff Enumeration (`pmh_sankoff`):** Use to enumerate all minimum-migration vertex labelings for a given clone tree.

### 3. Visualization and Utilities
- **`visualizeclonetree`**: Generates DOT files to visualize the structure of the inferred clone trees.
- **`visualizemigrationgraph`**: Creates a migration graph showing the seeding patterns between anatomical sites.
- **`generatemigrationtrees`**: Useful for pre-generating valid migration constraints to narrow the search space for the ILP solvers.

## CLI Best Practices
- **Gurobi Environment**: MACHINA relies on the Gurobi ILP solver. Ensure `GRB_LICENSE_KEY` is set in your environment. If Gurobi is in a non-standard location, update `LD_LIBRARY_PATH` (Linux) or `DYLD_LIBRARY_PATH` (macOS) to include the Gurobi `lib` directory.
- **Path Management**: Add the `build` directory to your `PATH` after compilation to access tools like `pmh` and `cluster` globally.
- **Memory and Performance**: For complex trees or large frequency matrices, the ILP solvers (`pmh_tr`, `pmh_ti`) can be resource-intensive. Consider using `generatemigrationtrees` first to restrict the migration patterns if the search space is too large.



## Subcommands

| Command | Description |
|---------|-------------|
| cluster | Cluster mutations based on their co-occurrence patterns. |
| generatemigrationtrees | Generates migration trees for anatomical sites. |
| pmh | Machina PMH tool for phylogenetic analysis. |
| pmh_sankoff | Performs the Sankoff algorithm on a phylogenetic tree with leaf labelings. |
| pmh_ti | Parses mutation trees and migration graphs to infer phylogenetic relationships. |
| pmh_tr | Parses a clone tree and leaf labeling to infer evolutionary scenarios. |
| visualizeclonetree | Visualize a clone tree with optional leaf and vertex labeling, and custom color maps. |
| visualizemigrationgraph | Visualize the migration graph of a clone tree. |

## Reference documentation
- [MACHINA Repository Overview](./references/github_com_raphael-group_machina.md)
- [Installation and Usage Guide](./references/github_com_raphael-group_machina_blob_master_README.md)
- [Build Configuration and Dependencies](./references/github_com_raphael-group_machina_blob_master_CMakeLists.txt.md)