---
name: bioconductor-plyxp
description: This tool enables tidy data manipulation for SummarizedExperiment objects using dplyr-like verbs and rlang data masking. Use when user asks to apply mutate, filter, select, or summarize operations directly to SummarizedExperiment, SingleCellExperiment, or DESeqDataSet objects while maintaining their S4 structure.
homepage: https://bioconductor.org/packages/release/bioc/html/plyxp.html
---

# bioconductor-plyxp

name: bioconductor-plyxp
description: Tidy data manipulation for SummarizedExperiment objects using rlang data masks. Use this skill when you need to apply dplyr verbs (mutate, select, filter, summarize, arrange) directly to SummarizedExperiment, SingleCellExperiment, or DESeqDataSet objects without converting them to data frames.

## Overview

The `plyxp` package enables a "tidy" workflow for Bioconductor's `SummarizedExperiment` class. It uses `rlang` data-masking to allow users to evaluate unquoted expressions across different contexts (assays, rowData, and colData) simultaneously. The primary advantage is maintaining the S4 object integrity (endomorphism) while using familiar `dplyr` syntax.

## Core Workflow

1.  **Initialization**: Convert a `SummarizedExperiment` to a `plyxp` object using `new_plyxp()`.
2.  **Contextual Operations**: Use `mutate()`, `filter()`, etc., with helper functions `rows()` and `cols()` to target specific slots.
3.  **Extraction**: Use `se()` to return the modified `SummarizedExperiment` object if needed.

```r
library(plyxp)
library(dplyr)

# Initialize
xp <- new_plyxp(se_object)

# Basic Mutation across contexts
xp <- xp |>
  mutate(
    # Default context is assays
    log_counts = log1p(counts),
    # Target colData
    cols(is_treated = condition == "treatment"),
    # Target rowData
    rows(gene_symbol = toupper(gene_name))
  )
```

## Contextual Pronouns and Helpers

`plyxp` uses pronouns to access data outside the current evaluation context:

*   **`.assays` / `.assays_asis`**: Access assay matrices.
*   **`.rows` / `.rows_asis`**: Access `rowData`.
*   **`.cols` / `.cols_asis`**: Access `colData`.

The `_asis` suffix returns the raw underlying data, while the standard pronoun reshapes data to fit the current context (e.g., replicating a colData vector to match assay dimensions).

### Cross-Context Calculation Example
To scale counts by a size factor stored in `colData`:
```r
xp |> mutate(scaled = counts / .cols$sizeFactor)
```

## Supported Verbs

*   **`mutate()`**: Add or modify variables in any context.
*   **`summarize()`**: Aggregate data. Returns a `SummarizedExperiment` with collapsed dimensions.
*   **`filter()` / `arrange()`**: Restricted to `rows()` or `cols()` contexts to preserve object structure.
*   **`select()`**: Pick specific variables from the active context.
*   **`group_by()`**: Contextual grouping. Groups in `rows()` are independent of groups in `cols()`.

## Special Variables

*   **`.features`**: Access or rename `rownames` within a `rows()` context.
*   **`.samples`**: Access or rename `colnames` within a `cols()` context.

```r
# Renaming example
xp |> mutate(rows(.features = new_gene_ids))
```

## Best Practices

*   **Minimize Verb Calls**: Creating data masks is computationally expensive. Combine multiple operations into a single `mutate()` call rather than chaining multiple `mutate()` pipes.
*   **Printing**: To view the object as a tibble abstraction, use `use_show_tidy()` or set `options("show_SummarizedExperiment_as_tibble_abstraction" = TRUE)`. Use `use_show_default()` to revert.
*   **Object Integrity**: `plyxp` prevents operations in the assay context that would break the `SummarizedExperiment` structure (like filtering individual assay cells).

## Reference documentation

- [plyxp Usage Guide](./references/plyxp.md)
- [plyxp RMarkdown Source](./references/plyxp.Rmd)