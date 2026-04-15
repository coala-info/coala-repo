---
name: bioconductor-flowgraph
description: The flowGraph package identifies independent biomarker cell populations in flow cytometry data by accounting for dependencies between parent and child populations using the SpecEnr statistic. Use when user asks to identify driver cell populations, calculate specific enrichment statistics, or visualize significant phenotypes within a cell hierarchy.
homepage: https://bioconductor.org/packages/release/bioc/html/flowGraph.html
---

# bioconductor-flowgraph

## Overview

The `flowGraph` package identifies candidate biomarkers in flow cytometry data by accounting for dependencies between cell populations. Traditional analysis often flags many redundant populations because if a parent population changes, all its children appear to change as well. `flowGraph` uses a **SpecEnr** (Specific Enrichment) statistic to isolate "driver" populations whose abundance changes significantly and independently of their expected proportions based on their parents.

## Core Workflow

### 1. Initialization
The primary entry point is the `flowGraph()` constructor. It requires a sample-by-cell-population matrix of counts.

```r
library(flowGraph)

# Load example data
data(fg_data_pos2)

# Initialize flowGraph object
# count: matrix where rows are samples, columns are phenotypes (e.g., "A+B-")
# meta: data frame with sample metadata (must have an 'id' column)
fg <- flowGraph(fg_data_pos2$count, 
                meta = fg_data_pos2$meta, 
                no_cores = 1)
```

### 2. Naming Conventions
Phenotypes must follow specific naming rules:
- Use `+` or `-` for markers (e.g., `CD3+CD4-`).
- Markers must not contain underscores, dashes, or pluses in their names.
- Underscores can be used as separators (e.g., `A+_B+`), but will be normalized internally.

### 3. Calculating Summary Statistics
Use `fg_summary` to compare groups (e.g., control vs. experimental). The default test is a Wilcoxon signed-rank test with `byLayer` p-value adjustment.

```r
# Calculate summary for SpecEnr node feature
fg <- fg_summary(fg, 
                 class = "class", 
                 label1 = "control", 
                 label2 = "exp", 
                 node_features = "SpecEnr",
                 test_name = "t_diminish")
```

### 4. Accessing Data
Use `fg_get_` functions to retrieve internal data without direct slot access.

```r
# Get sample metadata
meta <- fg_get_meta(fg)

# Get feature matrices (node or edge)
counts <- fg_get_feature(fg, type = "node", feature = "count")
specenr <- fg_get_feature(fg, type = "node", feature = "SpecEnr")

# Get summary results
summary_res <- fg_get_summary(fg, type = "node", index = 1)
p_values <- summary_res$values
```

### 5. Visualization
`flowGraph` provides several plotting functions to interpret results.

```r
# 1. Cell Hierarchy Plot (identifies significant nodes in the graph)
gr <- fg_plot(fg, index = 1, p_thres = 0.05, show_bgedges = TRUE)
plot_gr(gr)

# 2. QQ Plot (check p-value distribution)
fg_plot_qq(fg, type = "node", index = 1)

# 3. Boxplot (view specific phenotype distribution across classes)
fg_plot_box(fg, type = "node", index = 1, node_edge = "A+B+")

# 4. Volcano-like Plot (p-value vs feature difference)
fg_plot_pVSdiff(fg, type = "node", index = 1)
```

## Advanced Usage

### Fast Processing for Large Datasets
If you have >10,000 cell populations and only one set of class labels, use `flowGraphSubset`. It only calculates features for populations with significant parents.

```r
fg_fast <- flowGraphSubset(fg_data_pos2$count, 
                           meta = fg_data_pos2$meta,
                           summary_pars = flowGraphSubset_summary_pars())
```

### Saving and Loading
Because `flowGraph` objects can be large, use the dedicated save/load functions which store features as CSVs in a directory.

```r
fg_save(fg, "my_flowgraph_results")
fg <- fg_load("my_flowgraph_results")
```

## Reference documentation
- [flowGraph: Identifying differential cell populations in flow cytometry data](./references/flowGraph.md)
- [flowGraph Vignette Source](./references/flowGraph.Rmd)