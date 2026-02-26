---
name: cmaple
description: Cmaple provides a high-performance implementation of the MAPLE algorithm for inferring phylogenetic trees from massive genomic alignments. Use when user asks to infer phylogenetic trees, optimize branch lengths, or perform subtree pruning and regrafting searches on large-scale sequence data with low divergence.
homepage: https://github.com/iqtree/cmaple
---


# cmaple

## Overview
The `cmaple` skill enables the use of a high-performance C++ implementation of the MAPLE algorithm. It is optimized for processing massive genomic alignments, such as those generated during viral pandemics (e.g., SARS-CoV-2). Use this skill to infer phylogenetic trees, optimize branch lengths, and handle large-scale sequence data where traditional maximum likelihood methods may be computationally prohibitive.

## Installation
The tool is primarily distributed via Bioconda.
```bash
conda install bioconda::cmaple
```

## Common CLI Patterns
While specific command-line arguments often follow the patterns of IQ-TREE, `cmaple` uses specialized flags for its parsimonious likelihood approach.

### Basic Inference
To run a standard tree inference on an alignment:
```bash
cmaple -s alignment.fasta -t starting_tree.treefile
```

### Multithreading
`cmaple` supports OpenMP for parallel execution. Use the `-T` flag to specify the number of threads:
```bash
cmaple -s alignment.fasta -T 8
```
*Note: Recent updates suggest the tool is moving toward standard GNU CLI conventions, but `-T 4` or `-T 4` are generally accepted.*

### Branch Length and SPR Search
The tool includes specific options for Subtree Pruning and Regrafting (SPR) and branch length optimization:
- `--sprta-zero-branch`: Use this to handle zero-length branch support.
- `--sprta-other-places`: Use this to explore alternative SPR placements.
- `--out-mul-tree`: Enable this to output multifurcating trees (though note this is a frequently updated feature in the current development branch).

## Expert Tips and Best Practices
- **Pandemic-Scale Data**: `cmaple` is specifically designed for datasets with very low sequence divergence (short branch lengths). If your data has high divergence, traditional maximum likelihood tools like IQ-TREE might be more appropriate.
- **Memory Management**: For extremely large trees, monitor memory consumption. The tool is optimized, but the "LengthType" used during compilation can affect the maximum sequence length supported versus memory overhead.
- **Input Consistency**: Ensure that sequence names in your alignment file exactly match the leaf names in your input starting tree.
- **Branch Length Scaling**: If the inferred tree has unexpected branch lengths, consider using the branch length scaling factor options (if available in your specific version) to calibrate against known evolutionary rates.

## Reference documentation
- [CMAPLE GitHub Repository](./references/github_com_iqtree_cmaple.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cmaple_overview.md)
- [CMAPLE Wiki and User Manual](./references/github_com_iqtree_cmaple_wiki.md)