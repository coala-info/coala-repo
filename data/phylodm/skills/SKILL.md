---
name: phylodm
description: PhyloDM is a high-performance library written in Rust with a Python API designed to convert phylogenetic trees into pairwise distance matrices (PDM).
homepage: https://github.com/aaronmussig/PhyloDM
---

# phylodm

## Overview
PhyloDM is a high-performance library written in Rust with a Python API designed to convert phylogenetic trees into pairwise distance matrices (PDM). It is engineered for extreme efficiency, utilizing significantly less memory and processing time compared to standard libraries like DendroPy. Use this tool when working with large-scale genomic data where traditional distance matrix calculation methods fail due to resource constraints.

## Installation
Install the package via PyPI or Bioconda:
```bash
# Via pip
python -m pip install phylodm

# Via conda
conda install -c bioconda phylodm
```

## Core Python Usage
PhyloDM is primarily used as a Python library. The core workflow involves loading a tree, calculating the matrix, and retrieving taxa labels.

### 1. Loading a Tree
You can load trees from a Newick file path or directly from a DendroPy tree object.
```python
from phylodm import PhyloDM

# Load from a Newick file
pdm = PhyloDM.load_from_newick_path('path/to/tree.nwk')

# Load from an existing DendroPy tree
import dendropy
tree = dendropy.Tree.get(path='path/to/tree.nwk', schema='newick')
pdm = PhyloDM.load_from_dendropy(tree)
```

### 2. Calculating the Distance Matrix
The `.dm()` method returns a symmetrical NumPy matrix.
```python
# Calculate raw distance matrix
dm = pdm.dm(norm=False)

# Calculate normalized matrix (normalized by the sum of all edges in the tree)
dm_norm = pdm.dm(norm=True)
```

### 3. Accessing Taxa and Distances
The matrix indices correspond to the order of taxa returned by the `.taxa()` method.
```python
labels = pdm.taxa()

# Get distance between two specific taxa by name
idx_a = labels.index('Taxon_A')
idx_b = labels.index('Taxon_B')
distance = dm[idx_a, idx_b]
```

## Expert Tips and Best Practices
- **Memory Management**: For trees with >30,000 taxa, expect memory usage around 14GB. Ensure your environment has sufficient RAM for the resulting NumPy matrix, which grows quadratically with the number of taxa.
- **DendroPy Integration**: While PhyloDM is faster for matrix calculation, use DendroPy for complex tree manipulations (rerooting, pruning) before passing the final tree to PhyloDM for distance calculation.
- **Reproducibility**: PhyloDM orders taxa before calculating the distance matrix to ensure consistent indexing across different runs.
- **Single Pair Distances**: If you only need the distance between a few specific pairs rather than a full matrix, use the `.distance()` method (available in v2.2.0+) to save computation time.
- **Nearest Taxa**: Use `.get_nearest_taxa()` (available in v3.2.0+) for rapid identification of closely related sequences without manually searching the entire matrix.

## Reference documentation
- [PhyloDM GitHub Repository](./references/github_com_aaronmussig_PhyloDM.md)
- [PhyloDM Overview (Bioconda)](./references/anaconda_org_channels_bioconda_packages_phylodm_overview.md)