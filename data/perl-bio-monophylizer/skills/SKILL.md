---
name: perl-bio-monophylizer
description: This tool assesses taxonomic consistency in phylogenetic trees by verifying the monophyly of defined groups. Use when user asks to verify monophyly, check taxonomic consistency in a tree, or identify potential misidentifications in phylogenetic reconstructions.
homepage: https://metacpan.org/pod/Bio::Monophylizer
---


# perl-bio-monophylizer

## Overview
The `perl-bio-monophylizer` tool provides a systematic way to verify taxonomic consistency in phylogenetic reconstructions. It automates the process of checking whether all members of a defined group (e.g., a genus or family) descend from a common ancestor and include all descendants of that ancestor within a given tree. This is essential for quality control in large-scale phylogenomics and for identifying potential misidentifications or horizontal gene transfers.

## Usage Guidelines

### Core Inputs
- **Phylogenetic Tree**: A file in Newick format.
- **Taxonomy Map**: A tab-delimited file mapping leaf nodes (sequence IDs) to their respective taxonomic groups.

### Common CLI Patterns
The tool is typically invoked via the `monophylizer.pl` script (or similar executable name depending on the environment).

```bash
# Basic monophyly assessment
monophylizer.pl -t tree_file.nwk -m taxonomy_map.txt -o output_prefix
```

### Key Parameters
- `-t <file>`: Input phylogenetic tree (Newick).
- `-m <file>`: Mapping file (Format: `Sequence_ID [TAB] Taxonomic_Group`).
- `-o <string>`: Prefix for output files.
- `-v`: Enable verbose output for debugging tree traversal.

### Best Practices
- **Leaf Label Matching**: Ensure that the IDs in your Newick tree exactly match the first column of your taxonomy map. Discrepancies will result in taxa being ignored.
- **Rooting**: Monophyly assessments are highly sensitive to tree rooting. Ensure your tree is appropriately rooted (e.g., using an outgroup) before running the tool.
- **Handling Polyphyly**: When the tool identifies a group as non-monophyletic, examine the output logs to identify which "intruder" taxa are nesting within the group or which members are branching elsewhere.

## Reference documentation
- [Bio::Monophylizer Documentation](./references/metacpan_org_pod_Bio__Monophylizer.md)