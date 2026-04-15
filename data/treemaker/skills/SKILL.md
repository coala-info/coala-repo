---
name: treemaker
description: `treemaker` transforms flat, comma-separated classification strings into hierarchical tree structures. Use when user asks to create hierarchical trees, convert classification strings to Newick or Nexus format, or include internal node labels.
homepage: https://github.com/SimonGreenhill/treemaker
metadata:
  docker_image: "quay.io/biocontainers/treemaker:1.4--pyh9f0ad1d_0"
---

# treemaker

## Overview
`treemaker` is a specialized utility for transforming flat, comma-separated classification strings into hierarchical tree structures. It bridges the gap between human-readable taxonomies—such as those found in linguistic databases like Ethnologue or biological classification schemas—and machine-readable formats like Newick and Nexus used by phylogenetic software.

## Installation
Install via pip or conda:
```bash
pip install treemaker
# OR
conda install bioconda::treemaker
```

## Input Format
The tool expects a text file where each line contains a taxon name followed by its classification string. The classification should be ordered from most specific to most general or vice versa, as long as the hierarchy is consistent.

**Example input file (`data.txt`):**
```text
English Indo-European, Germanic, West
German Indo-European, Germanic, West
French Indo-European, Romance
```

## Command Line Usage
Generate a Newick tree from a classification file:
```bash
treemaker data.txt
```

### Common Options
- `-o <filename>`: Specify an output file (e.g., `output.nwk`).
- `-m {newick,nexus}`: Choose the output format. Default is Newick.
- `--labels`: Include internal node labels (the names of the subgroups/families) in the resulting tree.

**Example with labels and output file:**
```bash
treemaker --labels data.txt -o language_tree.nwk
```

## Python Library Usage
For programmatic tree generation within a Python script, use the `TreeMaker` class:

```python
from treemaker import TreeMaker

t = TreeMaker()

# Add individual taxa: (Name, Classification String)
t.add('Taxon1', 'Family A, Subgroup 1')
t.add('Taxon2', 'Family A, Subgroup 2')

# Add from a list of tuples
taxa_list = [
    ('Taxon3', 'Family B, Subgroup 1'),
    ('Taxon4', 'Family B, Subgroup 1')
]
t.add_from(taxa_list)

# Generate the Newick string
print(t.write())
```

## Best Practices
- **Consistent Delimiters**: Ensure classification strings use consistent comma separators. The tool parses these to determine the nesting levels of the tree.
- **Preserving Hierarchy**: Use the `--labels` flag if you need to visualize or analyze the names of the clades (internal nodes) rather than just the leaf taxa.
- **Nexus for Downstream Tools**: Use `-m nexus` when the output is intended for software that requires the NEXUS block structure (e.g., FigTree, PAUP*, or MrBayes).

## Reference documentation
- [treemaker GitHub Repository](./references/github_com_SimonGreenhill_treemaker.md)
- [Bioconda treemaker Overview](./references/anaconda_org_channels_bioconda_packages_treemaker_overview.md)