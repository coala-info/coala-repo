---
name: r-corbi
description: R package corbi (documentation from project home).
homepage: https://cran.r-project.org/web/packages/corbi/index.html
---

# r-corbi

name: r-corbi
description: Specialized bioinformatics analysis using the Corbi R package. Use this skill for differential expression analysis, biomarker identification, network querying, network alignment, and subnetwork extraction or search within R.

# r-corbi

## Overview
The `corbi` package (Collection of Rudimentary Bioinformatics Tools) provides a suite of fundamental tools for computational biology. It is particularly useful for researchers working with biological networks and gene expression data, offering optimized algorithms for network alignment and subnetwork analysis.

## Installation
To install the stable version from CRAN:
```R
install.packages("Corbi")
```

## Main Functions and Workflows

### Network Querying and Alignment
Corbi provides tools to search for specific patterns or align multiple biological networks.
- Use `net_query` to search for a query network within a larger target network.
- Use `net_align` for global or local alignment of two networks to identify conserved modules.

### Subnetwork Extraction
Extracting functional modules or specific neighborhoods from large-scale interactomes:
- `get_subnetwork`: Extracts a subnetwork based on a set of seed nodes.
- `search_subnetwork`: Searches for high-scoring subnetworks within a weighted graph, often used in integrative analysis of expression data and PPI networks.

### Biomarker Identification
Identify significant biological markers from high-throughput data:
- Use the package's built-in methods for differential expression analysis to find genes that vary significantly across conditions.
- Apply biomarker selection functions to rank and validate potential candidates.

### Data Handling
- The package typically works with adjacency matrices or graph objects.
- Ensure your network data is formatted as a matrix or a data frame of edges before passing to alignment functions.

## Tips for Success
- **Network Size**: Network alignment is computationally intensive. For large networks, consider filtering edges with low confidence scores before running `net_align`.
- **Seed Selection**: When extracting subnetworks, the choice of seed nodes significantly impacts the biological relevance of the output. Use nodes with high differential expression or known disease associations.
- **Documentation**: Access detailed help for any function using the standard R help syntax, e.g., `?net_align`.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)