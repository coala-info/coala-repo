---
name: bioconductor-ctc
description: This tool converts hierarchical clustering data between R and external software like Cluster, TreeView, and Xcluster. Use when user asks to export hclust objects to Newick, GTR, ATR, or CDT formats, or import external clustering results into R.
homepage: https://bioconductor.org/packages/release/bioc/html/ctc.html
---


# bioconductor-ctc

name: bioconductor-ctc
description: Export and import data for hierarchical clustering analysis between R and external software like Xcluster, Cluster, TreeView, and Freeview. Use this skill when you need to convert R hclust objects to Newick, GTR, ATR, or CDT formats, or when importing Xcluster/Cluster output into R.

# bioconductor-ctc

## Overview

The `ctc` (Cluster and Tree Conversion) package is a utility for Bioconductor users who need to interface R's hierarchical clustering results with external visualization and clustering software. It provides specialized functions to convert R `hclust` objects into formats compatible with Eisen's Cluster/TreeView, Sherlock's Xcluster, and Newick-compatible tools.

## Core Workflows

### 1. Exporting R Data to External Cluster Formats
To use external clustering engines like Xcluster or Cluster, first export your data frame or matrix:

```R
library(ctc)
data(USArrests)

# Export to Xcluster format
r2xcluster(USArrests, file='data_xcluster.txt')

# Export to Cluster format
r2cluster(USArrests, file='data_cluster.txt')
```

### 2. Importing External Cluster Results
If you have performed clustering outside of R, use `xcluster2r` to bring the results back into R as an `hclust` compatible object:

```R
# Import Xcluster output (.gtr file)
# labels=TRUE assumes the labels are in the file
h.xcl <- xcluster2r('data_xcluster.gtr', labels=TRUE)
plot(h.xcl)
```

### 3. Exporting R hclust Objects for Visualization
To visualize R-generated clusters in TreeView or Freeview, convert the `hclust` objects to specific file extensions (.gtr, .atr, .cdt):

```R
hr <- hclust(dist(USArrests))
hc <- hclust(dist(t(USArrests)))

# Export row and column dendrograms
r2gtr(hr, file="cluster.gtr")
r2atr(hc, file="cluster.atr")

# Export the data table linked to the clusters
r2cdt(hr, hc, USArrests, file="cluster.cdt")

# Shortcut: Perform clustering and export all files at once
hclust2treeview(USArrests, file="cluster.cdt")
```

### 4. Newick Format Conversion
For phylogenetic or general tree visualization tools that support the Newick standard:

```R
hr <- hclust(dist(USArrests))
newick_string <- hc2Newick(hr)
write(newick_string, file='cluster.newick')
```

## Tips and Best Practices
- **File Extensions**: Ensure you use the correct extensions (.gtr for row trees, .atr for column trees, .cdt for data) as external software like TreeView relies on these to link the files.
- **Xcluster Dependency**: The `xcluster()` function in R is a wrapper that requires the `Xcluster` executable to be installed on your system path.
- **Comparison**: Note that hierarchical clustering results from Xcluster may differ slightly from R's native `hclust` due to implementation differences.

## Reference documentation
- [Ctc Package](./references/ctc.md)