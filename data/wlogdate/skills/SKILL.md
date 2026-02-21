---
name: wlogdate
description: wLogDate is a specialized tool for estimating divergence times in phylogenetic trees.
homepage: https://github.com/uym2/wLogDate
---

# wlogdate

## Overview
wLogDate is a specialized tool for estimating divergence times in phylogenetic trees. It operates by minimizing the variance of mutation rates across the tree in a logarithmic scale. This approach is particularly effective for dating trees where sampling times are known (such as in viral outbreaks) or where specific internal nodes have known calibration points. If no timing information is provided, the tool can still be used to produce a unit ultrametric tree where the root-to-tip distance is fixed to 1.

## Command Line Usage

The primary interface for the tool is the `launch_wLogDate.py` script.

### Basic Syntax
```bash
launch_wLogDate.py -i <INPUT_TREE> -o <OUTPUT_TREE> [OPTIONS]
```

### Common Use Cases

**1. Generating a Unit Ultrametric Tree**
If you have a phylogeny but no calibration data, wLogDate will produce an ultrametric tree with a total depth of 1.
```bash
launch_wLogDate.py -i input.nwk -o output.nwk
```

**2. Dating with Sampling Times (Phylodynamics)**
To date a tree using sampling times for leaves (common in virus studies), provide a tab-delimited text file.
```bash
launch_wLogDate.py -i input.nwk -t sampling_times.txt -o dated_tree.nwk
```

**3. Using Internal Node Calibrations**
If your tree has unique labels for internal nodes, you can provide calibrations for those specific nodes. You must use the `-k` flag to tell the tool to respect existing internal labels.
```bash
launch_wLogDate.py -i input.nwk -t calibrations.txt -k -o calibrated_tree.nwk
```

## Input File Specifications

### Sampling/Calibration Time File (`-t`)
The time file must be a tab-delimited text file with two columns:
1.  **Node Name**: The name of the leaf or the label of the internal node.
2.  **Time**: The numerical time value.

**Important Time Convention**: wLogDate assumes **forward time**. Smaller values are closer to the root, and larger values are closer to the tips. The top of the branch above the root is considered time 0.

### Internal Node Labels (`-k`)
When dating internal nodes, ensure your Newick file contains unique identifiers for those nodes. Without the `-k` (or `--keep`) flag, wLogDate may ignore or overwrite internal labels required for matching the calibration file.

## Expert Tips and Best Practices

*   **Partial Sampling**: You do not need sampling times for every leaf. wLogDate can handle missing data as long as at least two leaves have different sampling times to provide a temporal scale.
*   **Output Annotations**: The output Newick file includes divergence time annotations for internal nodes using the `[t=X.XXX]` notation. These can be parsed by most phylogenetic visualization tools (like FigTree or Archaeopteryx).
*   **Log-Scale Advantage**: Because the algorithm optimizes in log-scale, it is generally more robust to high rate variation across branches compared to simple least-squares methods.
*   **Windows Usage**: If using the Windows executable version, use the command `launch_wLogDate` (omitting the `.py` extension).

## Reference documentation
- [wLogDate GitHub Repository](./references/github_com_uym2_wLogDate.md)
- [Bioconda wLogDate Overview](./references/anaconda_org_channels_bioconda_packages_wlogdate_overview.md)