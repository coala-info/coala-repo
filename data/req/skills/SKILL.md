---
name: req
description: The req tool calculates confidence values for internal branches of a phylogenetic tree using a distance-based quartet approach. Use when user asks to assess branch support for distance-based trees, evaluate phylogenetic confidence without bootstrapping, or analyze large phylogenies where character-based resampling is computationally prohibitive.
homepage: https://research.pasteur.fr/fr/tool/r%CE%B5q-assessing-branch-supports-o%C6%92-a-distance-based-phylogenetic-tree-with-the-rate-o%C6%92-elementary-quartets/
---


# req

## Overview
The `req` tool provides a fast, non-parametric alternative to bootstrapping for assessing the confidence of internal branches in a phylogenetic tree. It calculates the proportion of four-leaf subtrees (quartets) induced by a branch that satisfy the four-point condition based on the original distance matrix. A REQ value close to 1 indicates strong support from the underlying evolutionary distances.

## Usage Guidelines

### Input Requirements
To run `req`, you must provide two specific files:
1.  **Distance Matrix**: A file in PHYLIP format (either square or lower-triangular).
2.  **Phylogenetic Tree**: A tree file in Newick format, typically inferred from the same distance matrix using methods like Neighbor-Joining, BioNJ, or FastME.

### Basic Command Pattern
Since `req` is implemented in Java and distributed via Bioconda, it is typically invoked through a wrapper or directly via the JAR file:

```bash
# Standard execution via bioconda-installed wrapper
req -m <distance_matrix> -t <newick_tree> [options]

# Direct Java execution (if wrapper is unavailable)
java -jar req.jar -m <distance_matrix> -t <newick_tree>
```

### Best Practices
- **Large Datasets**: Use `req` for large phylogenies where bootstrapping is computationally prohibitive; it can process 500 taxa in approximately 5 seconds.
- **Alignment-Free Phylogeny**: Prioritize this tool when your tree is built from k-mer distances or other alignment-free methods where character-based resampling (bootstrap) is not applicable.
- **Interpretation**: Treat REQ values as confidence indices. Unlike bootstrap values, these are deterministic and based on the geometric properties of the distance space.

## Reference documentation
- [REQ: Assessing branch supports of a distance-based phylogenetic tree](./references/research_pasteur_fr_fr_tool_r_CE_B5q-assessing-branch-supports-o_C6_92-a-distance-based-phylogenetic-tree-with-the-rate-o_C6_92-elementary-quartets.md)
- [Bioconda req package overview](./references/anaconda_org_channels_bioconda_packages_req_overview.md)