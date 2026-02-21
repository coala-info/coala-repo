---
name: bioconductor-iseepathways
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/iSEEpathways.html
---

# bioconductor-iseepathways

## Overview

`iSEEpathways` is a Bioconductor package that extends the `iSEE` (Interactive SummarizedExperiment Explorer) ecosystem to support pathway analysis results. It provides specialized panels to visualize gene set enrichment, browse pathway tables, and link pathway selections to feature-level visualizations (like Volcano plots or Heatmaps). It is particularly designed to work with `fgsea` results but can be adapted for other pathway analysis frameworks.

## Core Workflow

### 1. Prepare Data and Run Pathway Analysis
Before using `iSEEpathways`, you typically perform a differential expression analysis and a gene set enrichment analysis (GSEA).

```r
library(iSEEpathways)
library(fgsea)
library(SummarizedExperiment)

# Assume 'se' is your SummarizedExperiment and 'stats' is a named vector of gene scores
# 'pathways_list' is a list of gene sets (e.g., from MSigDB or GO)
fgseaRes <- fgsea(pathways = pathways_list, stats = stats, minSize = 15, maxSize = 500)
fgseaRes <- fgseaRes[order(pval), ]
```

### 2. Embed Results into the Object
Use `embedPathwaysResults` to store the enrichment data within the `SummarizedExperiment` object's metadata.

```r
se <- embedPathwaysResults(
    fgseaRes, 
    se, 
    name = "my_fgsea_results", 
    class = "fgsea", 
    pathwayType = "GO", 
    pathwaysList = pathways_list, 
    featuresStats = stats
)
```

### 3. Configure Interactive Panels
`iSEEpathways` provides specific panel classes:
- `PathwaysTable()`: Displays a searchable table of enrichment results.
- `FgseaEnrichmentPlot()`: Displays the classic GSEA "mountain" plot for a selected pathway.

```r
library(iSEE)

initial_state <- list(
    PathwaysTable(ResultName = "my_fgsea_results", Selected = "GO:0046324", PanelWidth = 6L),
    FgseaEnrichmentPlot(ResultName = "my_fgsea_results", PathwayId = "GO:0046324", PanelWidth = 6L)
)

app <- iSEE(se, initial = initial_state)
```

## Advanced Integration and Optimization

### Mapping Pathways to Features
To allow a selection in a `PathwaysTable` to filter genes in other panels (e.g., a `VolcanoPlot`), you must register a mapping function.

```r
# Example using a list stored in metadata for speed
metadata(se)[["pathways"]] <- list(GO = pathways_list)

map_fun <- function(pathway_id, se) {
    pathway_list <- metadata(se)[["pathways"]][["GO"]]
    pathway_list[[pathway_id]]
}

se <- registerAppOptions(se, Pathways.map.functions = list(GO = map_fun))
```

### Customizing Pathway Details
You can define a function to display rich HTML metadata (like GO definitions) when a pathway is selected in the UI.

```r
library(shiny)
library(GO.db)

go_details <- function(x) {
    info <- select(GO.db, x, c("TERM", "DEFINITION"), "GOID")
    tagList(
        p(strong(info$GOID), ": ", info$TERM),
        p(info$DEFINITION)
    )
}

se <- registerAppOptions(se, PathwaysTable.select.details = go_details)
```

## Tips for Performance
- **Pre-sort results**: Sort your `fgseaRes` by p-value before embedding to define the default app view.
- **Memory vs. Speed**: Storing the `pathwaysList` directly in the `SummarizedExperiment` metadata and using a simple list-lookup function is significantly faster than querying SQLite databases (like `org.Hs.eg.db`) inside the Shiny app.

## Reference documentation

- [Working with the Gene Ontology](./references/gene-ontology.md)
- [Introduction to iSEEpathways](./references/iSEEpathways.md)
- [Integration with other panels](./references/integration.md)