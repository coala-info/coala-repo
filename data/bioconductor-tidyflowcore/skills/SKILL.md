---
name: bioconductor-tidyflowcore
description: This tool performs tidy data analysis on flow cytometry data by applying tidyverse verbs directly to flowCore S4 objects. Use when user asks to transform marker intensities, count cell populations, nest or unnest flow sets, and visualize cytometry data using ggplot2.
homepage: https://bioconductor.org/packages/release/bioc/html/tidyFlowCore.html
---


# bioconductor-tidyflowcore

name: bioconductor-tidyflowcore
description: Use this skill to perform tidy data analysis on flow cytometry data using the tidyFlowCore R package. This skill is ideal for applying tidyverse verbs (dplyr, tidyr, ggplot2) directly to flowCore S4 objects like flowFrame and flowSet, enabling seamless data transformation, cell counting, and visualization within a functional programming paradigm.

## Overview
`tidyFlowCore` acts as a bridge between the `flowCore` package and the `tidyverse`. It allows users to treat cytometry data structures (`flowFrame` and `flowSet`) as if they were tibbles or data frames. This eliminates the need for complex S4 slot extraction or manual matrix manipulation, allowing for more readable and maintainable cytometry analysis pipelines.

## Core Workflows

### 1. Data Transformation
Instead of using `flowCore::transformList`, you can use `dplyr::mutate` with `across` to transform marker intensities.

```r
library(tidyFlowCore)
library(dplyr)

# Apply arcsinh transformation to all columns except IDs
transformed_fs <- bcr_flowset |>
  mutate(across(-ends_with("_id"), ~asinh(.x / 5)))
```

### 2. Summarization and Counting
Perform cell population statistics directly on the `flowSet` or `flowFrame`.

```r
# Count cells per population
bcr_flowset |> 
  count(population_id)

# Grouped counting using metadata identifiers
bcr_flowset |> 
  count(.tidyFlowCore_identifier, population_id)
```

### 3. Nesting and Unnesting
`tidyFlowCore` uses `ungroup()` or `unnest()` to convert a `flowSet` (a collection of experiments) into a single `flowFrame` (concatenated data), and `group_by()` or `nest()` to go back.

```r
# Concatenate all samples into one flowFrame for global analysis
combined_frame <- bcr_flowset |> ungroup()

# Calculate mean expression per population across the whole set
combined_frame |>
  group_by(population_id) |>
  summarize(mean_marker = mean(`CD4(Nd145)Dd`))
```

### 4. Visualization with ggplot2
You can pipe `flowCore` objects directly into `ggplot2` functions.

```r
library(ggplot2)

bcr_flowset |>
  mutate(across(c(`CD20(Sm147)Dd`, `CD4(Nd145)Dd`), ~asinh(.x / 5))) |>
  ggplot(aes(x = `CD20(Sm147)Dd`, y = `CD4(Nd145)Dd`)) +
  geom_point(size = 0.1, alpha = 0.1) +
  facet_wrap(~population_id)
```

## Key Pronouns and Functions
- `.tidyFlowCore_identifier`: A special pronoun used to access the sample/experiment names within a `flowSet` during tidy operations.
- `mutate()`: Add or transform channels.
- `filter()`: Subset cells based on expression or metadata.
- `select()`: Choose specific channels or metadata columns.
- `summarize()`: Calculate population-level statistics.

## Tips for Success
- **Column Names**: Cytometry channel names often contain special characters (e.g., `CD4(Nd145)Dd`). Always wrap these in backticks (`` ` ``) when using them in tidy verbs.
- **Metadata**: Use `flowCore::pData(flowset)` to see available metadata columns that can be used for grouping and faceting.
- **Performance**: While `tidyFlowCore` is convenient, for extremely large datasets (millions of cells), standard `flowCore` matrix operations may be faster for simple transformations.

## Reference documentation
- [tidyFlowCore Vignette (Rmd)](./references/tidyFlowCore.Rmd)
- [tidyFlowCore Vignette (Markdown)](./references/tidyFlowCore.md)