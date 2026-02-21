---
name: r-structssi
description: R package structssi (documentation from project home).
homepage: https://cran.r-project.org/web/packages/structssi/index.html
---

# r-structssi

name: r-structssi
description: Perform multiple testing corrections for hypotheses with hierarchical or group structures using the structSSI R package. Use this skill when analyzing data where hypotheses are organized in a tree (e.g., phylogeny, taxonomy) or pre-defined groups, requiring Hierarchical FDR (HFDR) or Group Benjamini-Hochberg (GBH) procedures to control the False Discovery Rate while accounting for dependency structures.

# r-structssi

## Overview
The `structSSI` package implements specialized multiple testing procedures that exploit the structural relationships between hypotheses. It is particularly useful in fields like genomics (phylogenetic trees) or clinical trials (grouped endpoints) where hypotheses are not independent but follow a hierarchical or grouped arrangement. The package provides two primary methodologies:
1.  **Hierarchical FDR (HFDR)**: Controls FDR across a tree structure, ensuring that a child node is only tested if its parent is significant.
2.  **Group Benjamini-Hochberg (GBH)**: Adjusts p-values within pre-defined groups to improve power while maintaining FDR control.

## Installation
To install the package from CRAN:
```R
install.packages("structSSI")
```

## Core Workflows

### Hierarchical FDR (HFDR)
Use this when hypotheses are nodes in a tree (e.g., an `igraph` object or a `phyloseq` tree).

1.  **Prepare Data**: You need a vector of p-values named according to the nodes in your graph.
2.  **Define Structure**: Create an `igraph` object representing the hierarchy.
3.  **Execute HFDR**:
    ```R
    library(structSSI)
    # pvals: named vector of p-values
    # g: igraph object
    result <- hfdr(pvals, g, alpha = 0.05)
    summary(result)
    ```
4.  **Visualize**: Use `plot(result)` to see significant nodes within the tree structure.

### Group Benjamini-Hochberg (GBH)
Use this when hypotheses are partitioned into disjoint groups.

1.  **Prepare Data**: A vector of p-values and a corresponding vector of group assignments.
2.  **Execute GBH**:
    ```R
    # groups: factor or vector indicating group membership
    gbh_result <- gbh(pvals, groups, alpha = 0.05)
    print(gbh_result)
    ```

## Key Functions
- `hfdr()`: Performs the Hierarchical False Discovery Rate procedure. Requires p-values and a graph structure.
- `gbh()`: Performs the Group Benjamini-Hochberg procedure. Requires p-values and group labels.
- `Adaptive.GBH()`: An adaptive version of the GBH procedure that estimates the proportion of true null hypotheses within groups.
- `PlotHFDR()`: Specialized plotting function for visualizing hierarchical testing results.

## Tips for Success
- **Node Naming**: Ensure that the names in your p-value vector exactly match the vertex names in the `igraph` object when using `hfdr`.
- **Tree Direction**: For `hfdr`, the graph should be a directed tree starting from a root.
- **Phyloseq Integration**: `structSSI` works well with `phyloseq` objects. You can extract the tree structure directly for use in hierarchical testing of OTUs/taxa.
- **Alpha Level**: The `alpha` parameter represents the target FDR level (e.g., 0.05).

## Reference documentation
- [structSSI README](./references/README.html.md)
- [structSSI Home Page](./references/home_page.md)