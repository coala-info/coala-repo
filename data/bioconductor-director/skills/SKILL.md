---
name: bioconductor-director
description: This tool generates interactive Sankey diagrams to visualize multi-level biological regulatory networks and molecular flows. Use when user asks to visualize miRNA-mRNA-gene interactions, create web-based Sankey diagrams for biological data, or map expression values to directional network paths.
homepage: https://bioconductor.org/packages/3.6/bioc/html/Director.html
---

# bioconductor-director

name: bioconductor-director
description: Create interactive, web-based Sankey diagrams for multi-level biological data (e.g., miRNA-mRNA-gene interactions). Use this skill when you need to visualize directional flows of regulatory or co-expressed molecules where path widths and colors represent quantitative values like fold-change or correlation.

# bioconductor-director

## Overview
The `Director` package specializes in visualizing complex, multi-level molecular interactions using dynamic Sankey diagrams. It transforms R data frames into interactive HTML files powered by D3.js. Key features include the ability to map quantitative values (like expression levels) to both node and path colors, handling of positive/negative values via gradient scales, and automatic detection/handling of feedback loops.

## Standard Workflow

### 1. Initialization
Before creating any diagrams, you must initialize the environment to generate the necessary JavaScript and CSS dependencies.
```r
library(Director)
# Generates template for dynamic HTML and D3 dependencies
initSankey(pathOpacity = 0.2, font = "Arial", fontsize = 12)
```

### 2. Data Preparation
`Director` requires source-target pairs with associated values. You can provide data in two formats using `createList()`:

**Option A: Single Table**
A data frame containing `source`, `target`, `value` (path strength), `sourcefc` (source node value), and `targetfc` (target node value).
```r
df <- data.frame(
  source = c("miR-1", "miR-1"),
  target = c("GeneA", "GeneB"),
  value = c(-0.7, -0.4),
  sourcefc = c(1.5, 1.5),
  targetfc = c(-1.7, -2.6),
  stringsAsFactors = FALSE
)
tempList <- createList(df)
```

**Option B: Separate Tables**
One table for interactions (paths) and one for node values.
```r
interactions <- data.frame(source="miR-1", target="GeneA", value=-0.7)
node_values <- data.frame(genes=c("miR-1", "GeneA"), foldChange=c(1.5, -1.7))
tempList <- createList(interactions, node_values)
```

### 3. Filtering and Processing
To avoid "noisy" diagrams, filter the data before visualization.
*   `filterNumeric()`: Filter by min/max/absolute values.
*   `filterSubset()`: Filter by qualitative names (grep).
*   `filterRelation()`: Filter for specific correlations (e.g., only inverse relationships).
*   `append2List()`: Combine multiple levels (e.g., Drug -> miRNA and miRNA -> mRNA).

### 4. Generating the Diagram
The visualization process follows a three-step functional chain:
```r
# 1. Calculate drawing values and assign colors
# Use averagePath=TRUE to propagate upstream values to downstream paths
sankey_obj <- makeSankey(tempList, averagePath = FALSE, 
                         nodeMin = "blue", nodeMax = "red")

# 2. Create the HTML object
sankey_html <- drawSankey(sankey_obj, caption = "My Regulatory Network",
                          height = 800, width = 1000)

# 3. Save to local directory
writeSankey(sankey_html, directory = getwd())
```

## Key Parameters and Tips
*   **Feedback Loops**: Sankey diagrams are strictly directional. If a loop is detected (e.g., GeneA -> GeneB -> GeneA), `Director` will automatically rename the terminal node (e.g., `Loop_GeneA`) to allow the diagram to render.
*   **averagePath**: When `TRUE` in `makeSankey`, downstream path colors are determined by the average of incoming upstream paths. This is useful for showing the "cascading" effect of a drug or treatment.
*   **Interactivity**: The resulting HTML allows users to drag nodes, mouseover for quantitative details, and click nodes to highlight specific pathways.
*   **Large Datasets**: If the diagram doesn't appear, the number of nodes may exceed the default height. Increase `height` in `drawSankey` or apply stricter filters.

## Reference documentation
- [Director Vignette](./references/vignette.md)