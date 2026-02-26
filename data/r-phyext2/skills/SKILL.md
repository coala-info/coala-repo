---
name: r-phyext2
description: The r-phyext2 package provides specialized classes and methods for handling and manipulating branch-annotated phylogenetic trees. Use when user asks to manage tree objects with branch-level metadata, manipulate node identifiers, or provide the underlying architecture for SigTree analysis.
homepage: https://cran.r-project.org/web/packages/phyext2/index.html
---


# r-phyext2

## Overview
The `phyext2` package is an extension of the `phylobase` package. It provides specialized classes and methods designed to handle branch-annotated trees. It is primarily used as a dependency for the `SigTree` package but can be used independently to manipulate tree objects where data is associated with specific branches or nodes in a way that extends standard `phylo4` or `phylo4d` objects.

## Installation
To install the package from CRAN:
```R
install.packages("phyext2")
```

## Core Classes and Methods
The package introduces and extends S4 classes to better handle tree data:

### Classes
- `phylo4`: Inherited from `phylobase`, representing a basic tree.
- `phylo4d`: Inherited from `phylobase`, representing a tree with data.
- `phyext2` specific methods often focus on the internal representation of these objects to ensure compatibility with `SigTree` workflows.

### Key Functions
- `nodeId`: Retrieve or manipulate node identifiers within the tree structure.
- `getTree`: Extract tree structures from complex objects.
- `ancestor`: Find ancestral nodes for specific tips or internal nodes.
- `descendants`: Identify all descendant nodes for a given branch.

## Common Workflows

### Enhancing phylobase Objects
When working with `phylobase`, you can use `phyext2` to perform more granular manipulations of the tree's internal structure, especially when preparing data for significance testing in phylogenetics.

```R
library(phyext2)
library(phylobase)

# Example: Accessing node information in a phylo4 object
# (Assuming 'tree' is a phylo4 or phylo4d object)
nodes <- nodeId(tree, "all")
```

### Integration with SigTree
`phyext2` is most commonly triggered when a user is performing "Signal Tree" analysis. It provides the underlying architecture that allows `SigTree` to map p-values or other statistics onto specific branches of a phylogenetic tree.

## Tips
- **Namespace Conflicts**: Since `phyext2` extends `phylobase`, ensure `phylobase` is loaded.
- **Branch Annotation**: Use this package when you need to maintain data integrity while pruning or reordering trees that have complex branch-level metadata.
- **Legacy Support**: This package replaces the older, unmaintained `phyext` package. If working with legacy code referencing `phyext`, update the calls to use `phyext2`.

## Reference documentation
- [phyext2 Home Page](./references/home_page.md)