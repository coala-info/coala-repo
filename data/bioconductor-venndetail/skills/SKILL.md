---
name: bioconductor-venndetail
description: VennDetail is an R package for visualizing multi-set intersections and extracting the specific elements within overlapping or disjoint subsets. Use when user asks to visualize intersections with Venn diagrams or UpSet plots, extract elements from specific set overlaps, or annotate intersection results with metadata.
homepage: https://bioconductor.org/packages/release/bioc/html/VennDetail.html
---

# bioconductor-venndetail

## Overview

VennDetail is an R package designed for visualizing and extracting the details of multi-set intersections. While many tools provide visualization, VennDetail excels at allowing users to programmatically extract the specific elements (e.g., genes) within disjoint or overlapping subsets and merge them with additional metadata (like fold-change or p-values) for downstream analysis.

## Core Workflow

### 1. Data Preparation and Object Creation
Input data must be a named list of vectors.

```r
library(VennDetail)

# Create a list of vectors (e.g., Entrez IDs or Gene Symbols)
set_list <- list(A = c(1, 2, 3, 4), B = c(3, 4, 5, 6), C = c(4, 6, 7, 8))

# Initialize the Venn object
ven <- venndetail(set_list)
```

### 2. Visualization
The `plot` function is the primary interface for visualization, supporting three main types.

```r
# Traditional Venn Diagram
plot(ven, type = "venn")

# Venn-Pie Chart (useful for showing subset proportions)
plot(ven, type = "vennpie")

# UpSet Plot (best for more than 3-5 sets)
plot(ven, type = "upset")

# Bar plot of subset sizes
dplot(ven, order = TRUE)
```

### 3. Inspecting and Extracting Subsets
Use these functions to see what subsets exist and retrieve the elements within them.

```r
# Show subset names and sizes
detail(ven)

# Extract specific subsets (e.g., the "Shared" intersection or unique to "A")
# Use detail(ven) to find the exact names of the subsets
subsets <- getSet(ven, subset = c("Shared", "A"))

# Export all results in long format (Subset, Detail)
res_long <- result(ven)

# Export all results in wide format (Binary matrix of presence/absence)
res_wide <- result(ven, wide = TRUE)
```

### 4. Annotating Results
`getFeature` allows you to map the intersection results back to your original data frames containing metadata.

```r
# rlist should be a list of data frames where row names or a column match the Venn input
annotated_res <- getFeature(ven, subset = "Shared", rlist = list_of_dataframes)
```

## Advanced Usage

### Venn-Pie Customization
The `vennpie` function provides granular control over highlighting specific groups of subsets.

```r
# Highlight subsets present in exactly 1 group
vennpie(ven, any = 1, revcolor = "lightgrey")

# Highlight subsets present in at least 4 groups (for large multi-set analyses)
vennpie(ven, min = 4)

# Use log scale for better visualization of small subsets
vennpie(ven, log = TRUE)
```

### Merging Venn Objects
If you have processed different groups separately, you can combine them.

```r
ven_combined <- merge(ven1, ven2)
```

## Tips for Success
- **Subset Naming**: VennDetail automatically names subsets based on the input list names (e.g., "A_B" for the intersection of A and B). Always run `detail(ven)` first to confirm the exact strings needed for `getSet` or `getFeature`.
- **Large Datasets**: For more than 5 sets, traditional Venn diagrams become unreadable; prefer `type = "upset"` or `type = "vennpie"`.
- **Input Types**: Ensure the vectors in your list are of the same type (e.g., all character or all numeric) to avoid matching issues.

## Reference documentation
- [The VennDetail package](./references/VennDetail.Rmd)
- [The VennDetail package](./references/VennDetail.md)