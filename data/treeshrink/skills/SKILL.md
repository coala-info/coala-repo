---
name: treeshrink
description: TreeShrink is a specialized tool designed to detect and remove abnormally long branches in phylogenetic trees.
homepage: https://github.com/uym2/TreeShrink
---

# treeshrink

## Overview

TreeShrink is a specialized tool designed to detect and remove abnormally long branches in phylogenetic trees. It works by identifying leaves that contribute disproportionately to the tree diameter (the maximum distance between any two leaves). While it can process single trees, its primary strength lies in analyzing collections of trees (e.g., gene trees) where it can use the distribution of branch lengths across the entire dataset to perform robust statistical outlier detection.

Use this skill to:
- Filter out "long-branch" outliers that can cause systematic errors in phylogenetic inference.
- Clean sequence alignments by removing taxa associated with identified outlier branches.
- Automate the pruning of large-scale phylogenomic datasets.

## Installation and Environment

TreeShrink requires both Python (with the `Dendropy` package) and R (with the `BMS` package).

- **Conda (Recommended):** `conda install -c smirarab treeshrink`
- **R Compatibility:** TreeShrink is known to have compatibility issues with R 4.0+. It is recommended to use R 3.4 or 3.5. If using a newer R version, you may need to rebuild the `BMS` package using the provided `install_BMS.sh` script in the source repository.

## Common CLI Patterns

The primary executable is `run_treeshrink.py`.

### Basic Pruning
Run with default settings (False Positive Rate α = 0.05):
```bash
run_treeshrink.py -t input_trees.newick
```

### Adjusting Sensitivity
The α (alpha) threshold controls the false positive tolerance. A lower α is more conservative (removes fewer taxa).
```bash
# Test multiple alpha values simultaneously
run_treeshrink.py -t input.trees -q "0.01 0.05 0.10" -o output_dir
```

### Filtering Alignments
If you provide the corresponding alignments, TreeShrink will produce "shrunk" versions of those alignments with the outlier sequences removed.
```bash
run_treeshrink.py -t input.trees -a path/to/alignments/folder
```

### Customizing Output
```bash
run_treeshrink.py -t input.trees -o results_folder -O prefix_name
```

## Expert Tips and Best Practices

- **Per-Species Mode (-b):** Since version 1.2.0, the `-b` option (default 5%) prevents species from being removed if they don't significantly impact the tree diameter. If you find TreeShrink is being too aggressive in removing taxa that don't look like extreme outliers, increase this value (e.g., `-b 20`).
- **Scaling k (-s):** The parameter `k` represents the maximum number of species that can be removed. By default, this is calculated as `min(n/5, 2*sqrt(n))`. Use the `-s` flag to adjust the scaling if the default heuristic is too restrictive or too loose for your specific taxon sampling.
- **Interpreting Results:**
    - `output.txt`: Contains the list of removed species for each tree. Empty lines indicate no species were removed for that specific tree.
    - `output.trees`: Contains the resulting trees with outlier leaves pruned.
- **Multi-gene Advantage:** When processing a file containing multiple gene trees, TreeShrink performs a "per-species" test across all trees, which is significantly more powerful than testing each tree in isolation.

## Reference documentation
- [TreeShrink GitHub Repository](./references/github_com_uym2_TreeShrink.md)
- [Bioconda TreeShrink Overview](./references/anaconda_org_channels_bioconda_packages_treeshrink_overview.md)