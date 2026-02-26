---
name: pyham
description: "pyham is a Python library for the functional and evolutionary analysis of Hierarchical Orthologous Groups. Use when user asks to map orthoXML files to species trees, identify gene evolutionary events like gains and losses, generate taxonomic profiles, or visualize gene lineage histories."
homepage: https://github.com/DessimozLab/pyham
---


# pyham

## Overview
pyham is a specialized Python library and toolset designed to facilitate the functional and evolutionary analysis of Hierarchical Orthologous Groups (HOGs). It transforms static orthology data into a dynamic model by mapping orthoXML files onto species trees. This allows users to query specific evolutionary points, generate taxonomic profiles of gene families, and visualize the history of gene lineages.

## Installation and Setup
Install pyham via bioconda or pip:
```bash
# Using Conda
conda install bioconda::pyham

# Using Pip
pip install pyham
```

## Core Functional Patterns

### 1. Initializing the Ham Object
The entry point for most analyses is the `Ham` object, which requires a species tree and an orthoXML file.
```python
import pyham

# Initialize with a Newick tree and orthoXML data
ham_obj = pyham.Ham(newick_tree_file, orthoxml_file)
```

### 2. Standard Analysis Scripts
pyham provides several built-in scripts for common tasks. These are typically found in the `example` directory of the repository:
- **HOG Queries**: Use `run_hog_queries.py` to extract specific orthologous groups based on taxonomic levels or gene IDs.
- **Tree Profiling**: Use `run_treeProfile.py` to generate a summary of gene evolutionary events (gains, losses, duplications) across the species tree.
- **Visualization**: Use `run_iHam.py` to generate interactive visualizations of HOGs.

### 3. Working with HOGs
Once the `Ham` object is initialized, you can programmatically interact with the evolutionary data:
- **Get HOG by ID**: Retrieve a specific group to inspect its members.
- **Identify Evolutionary Events**: Determine where in the species tree a gene was duplicated or lost.
- **Ancestral Genome Reconstruction**: Query the state of a gene family at a specific ancestral node in the tree.

## Best Practices
- **Input Validation**: Ensure that the species names in your Newick tree exactly match the species names defined in the orthoXML file. Discrepancies will cause mapping failures.
- **Resource Compatibility**: pyham is highly compatible with HOGs inferred from the OMA browser, OMA standalone, Ensembl, and HieranoidDB.
- **Large Datasets**: For large orthoXML files, use the `tqdm` progress bar integration (if available in your version) to monitor parsing progress.
- **Tree Formats**: While Newick is standard, ensure your tree is rooted correctly to allow pyham to accurately determine the direction of evolutionary events.

## Reference documentation
- [pyham GitHub Repository](./references/github_com_DessimozLab_pyham.md)
- [Bioconda pyham Package](./references/anaconda_org_channels_bioconda_packages_pyham_overview.md)