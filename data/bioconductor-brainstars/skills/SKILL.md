---
name: bioconductor-brainstars
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/BrainStars.html
---

# bioconductor-brainstars

name: bioconductor-brainstars
description: Access and analyze the BrainStars database, a quantitative expression database of the adult mouse brain with genome-wide profiles across 51 CNS regions. Use this skill to retrieve gene expression data (as ExpressionSet objects), annotations, marker genes, multi-state/one-state gene lists, and high-resolution brain map figures via the BrainStars REST API.

# bioconductor-brainstars

## Overview

The `BrainStars` package is an R wrapper for the BrainStars (B*) database REST API. It allows researchers to query expression profiles from 51 specific regions of the adult mouse brain. The data is derived from Affymetrix GeneChip Mouse Genome 430 2.0 arrays, summarized using the RMA method. This skill facilitates the retrieval of biological analysis results, including marker genes, multi-state expression patterns, and inferred neurohormone/neurotransmitter connections.

## Core Functions

### Data Retrieval

The primary function is `getBrainStars()`, which handles various API types (expression, probeset, search, marker, multistate, onestate, ntnh, genefamily).

*   **Expression Data**: Returns an `ExpressionSet` object.
    ```r
    library(BrainStars)
    # Single probe
    eset <- getBrainStars(query = "1439627_at", type = "expression")
    # Multiple probes
    ids <- c("1439627_at", "1439631_at")
    esets <- getBrainStars(query = ids, type = "expression")
    # Access matrix
    mat <- exprs(esets)
    ```
*   **Annotations**: Retrieve probe metadata.
    ```r
    ann <- getBrainStars(query = "1439627_at", type = "probeset")
    ```

### Visualizations

Use `getBrainStarsFigure()` to download and save images to the local directory.
*   **Types**: `exprgraph` (barplot), `exprmap` (brain map), `switchgraph`, `switchhist`.
*   **Formats**: `png`, `pdf`.
    ```r
    getBrainStarsFigure("1439627_at", "exprmap", "png")
    ```

### Advanced Queries

The `query` argument follows a specific URI-like syntax based on the `type`.

*   **Keyword Search**: `getBrainStars(query = "receptor/1,5", type = "search")`
*   **Marker Genes**: Find genes high/low in specific regions.
    *   Syntax: `{high|low}/(region)/{all|count|(offset,limit)}`
    *   Example: `getBrainStars(query = "high/LS/all", type = "marker")`
*   **Multi-state Genes**: Genes with multi-modal expression.
    *   Syntax: `{high|up|low|down}/(region)/all`
    *   Example: `getBrainStars(query = "low/SCN/all", type = "multistate")`
*   **Gene Families**: Retrieve by category (e.g., `tf`, `gpcr`, `channel`).
    *   Example: `getBrainStars(query = "tf/terminal/all", type = "genefamily")`
*   **CNS Connections (ntnh)**: Inferred connections based on ligand/receptor expression.
    *   Example: `getBrainStars(query = "high/SCN/ME/all", type = "ntnh")`

## Workflow Tips

1.  **Region Names**: Use standard BrainStars abbreviations (e.g., `SCN` for Suprachiasmatic nucleus, `LS` for Lateral septum, `ME` for Median eminence).
2.  **Count Queries**: To check the number of results before downloading a large list, append `/count` to your query string.
3.  **Data Integration**: Since `getBrainStars` returns `ExpressionSet` objects, the output is immediately compatible with other Bioconductor tools like `limma` or `Biobase`.
4.  **API Limits**: Use the `(offset,limit)` syntax (e.g., `1,20`) to paginate large search results.

## Reference documentation

- [Using the BrainStars package](./references/BrainStars.md)