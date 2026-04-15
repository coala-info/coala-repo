---
name: grampa
description: GRAMPA reconciles gene trees with species trees using MUL-trees to analyze gene duplications and losses in polyploid species. Use when user asks to identify polyploidy events, perform gene-tree reconciliation with subgenomes, or test specific hypotheses for parental lineages.
homepage: https://github.com/gwct/grampa
metadata:
  docker_image: "quay.io/biocontainers/grampa:1.4.4--pyhdfd78af_0"
---

# grampa

## Overview
GRAMPA (Gene-tree Reconciliation Algorithm with MUL-trees for Polyploid Analysis) is a specialized tool for evolutionary biology designed to handle the complexities of polyploid species. Unlike standard reconciliation methods that assume a single lineage for each species, GRAMPA utilizes MUL-trees—where a single species can appear multiple times—to represent subgenomes resulting from polyploidy. This allows for more accurate counting of gene duplications and losses and provides a framework for identifying the most likely placement of polyploidy events on a species tree.

## Installation and Setup
The most efficient way to install grampa is via Bioconda:

```bash
conda install bioconda::grampa
# OR
mamba install grampa
```

If installed from source, invoke it using the Python interpreter: `python /path/to/grampa.py`.

## Core CLI Usage

### Basic Reconciliation Search
To perform a full search for the optimal (lowest-scoring) MUL-tree placement on a species tree:
```bash
grampa -s species_tree.tre -g gene_trees.tre -o output_dir/
```

### Hypothesis Testing (Specific Placements)
If you have specific hypotheses about which clade is polyploid and which lineages are the parents, use the `-h1` and `-h2` flags:
- `-h1`: The node(s) to consider as the polyploid clade.
- `-h2`: The node(s) to consider as parental lineages.

```bash
grampa -s species.tre -g genes.tre -h1 Node1 -h2 Node2 Node3 -o output_dir/
```

### Working with Existing MUL-trees
If your input species tree is already formatted as a MUL-tree, you must set the appropriate flag:
```bash
grampa -s mul_species.tre -g genes.tre --multree -o output_dir/
```

## Expert Tips and Best Practices

### Data Requirements
- **Rooting**: Both species and gene trees must be rooted.
- **Bifurcation**: Trees must be bifurcating. GRAMPA will automatically remove gene trees containing polytomies from the dataset.
- **Format**: Trees must be in Newick format.

### Performance Optimization
- **Parallelization**: Use the `-p` flag to specify the number of processes for faster reconciliation across large gene tree datasets.
- **Complexity Management**: For gene trees with many possible mappings, use `-c` (default 8, max 18) to set the maximum number of initial groups considered.
- **Filtering**: Use `--st-only` if you only want to reconcile against the singly-labeled species tree, or `--no-st` to skip the singly-labeled tree and only test MUL-trees.

### Detailed Output
To obtain the specific node maps for every reconciliation (useful for downstream analysis of specific gene families), include the `--maps` flag:
```bash
grampa -s species.tre -g genes.tre --maps -o output_dir/
```

### Utility Commands
- **Count MUL-trees**: To see how many possible MUL-trees exist for a given species tree and constraints without running the full analysis:
  ```bash
  grampa -s species.tre --numtrees
  ```
- **Build MUL-trees**: To generate the MUL-tree files themselves:
  ```bash
  grampa -s species.tre -h1 Node1 -h2 Node2 --buildmultrees
  ```

## Reference documentation
- [Anaconda Bioconda grampa Overview](./references/anaconda_org_channels_bioconda_packages_grampa_overview.md)
- [GRAMPA GitHub Repository](./references/github_com_gwct_grampa.md)