---
name: bioconductor-heatplus
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/Heatplus.html
---

# bioconductor-heatplus

## Overview
The `Heatplus` package extends R's heatmap capabilities by providing a flexible framework for "annotated heatmaps." Unlike standard heatmaps, `Heatplus` allows for multiple layers of clinical or experimental metadata (covariates) to be displayed alongside the main data matrix and dendrograms. It is particularly useful for Bioconductor `ExpressionSet` objects but works with any numerical matrix.

## Core Functions

### 1. regHeatmap (Regular Heatmaps)
Used for standard heatmaps without annotations but with improved legend and layout control.
```r
library(Heatplus)
# Basic usage
reg1 <- regHeatmap(exprs(myExpressionSet))
plot(reg1)

# Customizing appearance
reg2 <- regHeatmap(exprs(myExpressionSet), 
                   legend = 2,           # Position: 1=bottom, 2=left, 3=top, 4=right
                   col = heat.colors, 
                   breaks = -3:3)
plot(reg2)
```

### 2. annHeatmap (Annotated Heatmaps)
The primary function for adding sample-level annotations (columns).
```r
# Using an ExpressionSet (automatically pulls pData)
ann1 <- annHeatmap(myExpressionSet)
plot(ann1)

# Using a matrix and a data frame of annotations
ann2 <- annHeatmap(myMatrix, annotation = myAnnotationDataFrame)
plot(ann2)

# Cutting the dendrogram into clusters
ann3 <- annHeatmap(myMatrix, annotation = myAnnDF, 
                   cluster = list(cuth = 5000)) # Cut at specific height
plot(ann3)
```

### 3. annHeatmap2 (Double-Annotated Heatmaps)
The most flexible function, allowing for both Row (feature) and Column (sample) annotations.
```r
ann4 <- annHeatmap2(exprs(myExSet),
                    ann = list(Col = list(data = pData(myExSet)), 
                               Row = list(data = featureAnnDF)),
                    labels = list(Row = list(nrow = 7), 
                                  Col = list(nrow = 2)))
plot(ann4)
```

## Typical Workflow

1.  **Data Preparation**: Ensure your main data is a numerical matrix. Annotations should be data frames where row names match the matrix column names (for samples) or row names (for features).
2.  **Clustering Customization**: You can pass custom distance and clustering functions via the `dendrogram` list argument.
    ```r
    corrdist <- function(x) as.dist(1-cor(t(x)))
    hclust.avl <- function(x) hclust(x, method="average")
    reg3 <- regHeatmap(myMatrix, 
                       dendrogram = list(clustfun=hclust.avl, distfun=corrdist))
    ```
3.  **Annotation Processing**: Use `convAnnData` if you need to manually convert data frames into the binary/numeric format used by the internal `picketPlot`.
4.  **Visualization**: The `plot` method for `annHeatmap` objects accepts `widths` and `heights` vectors to control the relative size of the heatmap, dendrograms, and annotations.
    ```r
    plot(ann4, widths = c(2, 5, 1), heights = c(2, 5, 1))
    ```

## Tips and Best Practices
*   **Scale**: Use the `scale` argument (`"row"`, `"col"`, or `"none"`) within `annHeatmap2` to standardize data. Gene expression is typically scaled by row.
*   **Colors**: `g2r.colors` is a provided palette that goes from green to red through black, ideal for log-fold change data.
*   **Legend**: If the legend is too crowded, try changing the `legend` position (1-4) or adjusting the `breaks` to be more inclusive.
*   **Missing Values**: The package handles `NA` values in annotations by displaying them as a neutral gray in picket plots.

## Reference documentation
- [Creating heatmaps using package Heatplus](./references/annHeatmap.md)
- [Commented source code for regular and annotated heatmaps](./references/annHeatmapCommentedSource.md)
- [Superseded functions in package Heatplus](./references/oldHeatplus.md)