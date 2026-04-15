---
name: bioconductor-tidysummarizedexperiment
description: This tool enables the manipulation and visualization of Bioconductor SummarizedExperiment objects using tidyverse principles and syntax. Use when user asks to perform data wrangling with dplyr, reshape data with tidyr, or create plots with ggplot2 while maintaining the SummarizedExperiment structure.
homepage: https://bioconductor.org/packages/release/bioc/html/tidySummarizedExperiment.html
---

# bioconductor-tidysummarizedexperiment

name: bioconductor-tidysummarizedexperiment
description: Specialized workflow for using the tidySummarizedExperiment R package to manipulate Bioconductor SummarizedExperiment objects using tidyverse principles. Use this skill when a user needs to perform data wrangling (filtering, selecting, mutating), exploratory data analysis, or visualization (ggplot2) on SummarizedExperiment objects while maintaining the underlying Bioconductor data structure.

# bioconductor-tidysummarizedexperiment

## Overview

The `tidySummarizedExperiment` package provides a bridge between the Bioconductor `SummarizedExperiment` container and the `tidyverse` ecosystem. It allows users to treat `SummarizedExperiment` objects as tibbles for manipulation with `dplyr`, `tidyr`, and `ggplot2` without losing the specialized metadata and assay slots required for Bioconductor workflows.

## Core Concepts

- **Tidy View**: The object is displayed as a tibble where each row represents a feature-sample combination (long format).
- **Dual Nature**: It remains a valid `SummarizedExperiment` object. You can still use `assays()`, `colData()`, and `rowData()`.
- **Special Columns**:
    - `.feature`: Represents the row names (e.g., Gene IDs).
    - `.sample`: Represents the column names (e.g., Sample IDs).
    - Assay names (e.g., `counts`) appear as columns containing the numeric data.

## Typical Workflows

### Initialization and Inspection

```r
library(tidySummarizedExperiment)
library(dplyr)

# Load example data
data(pasilla, package = "tidySummarizedExperiment")
pasilla_tidy <- pasilla

# View as tibble
pasilla_tidy

# Access assays (standard Bioconductor)
assays(pasilla_tidy)
```

### Data Wrangling (dplyr)

You can use standard `dplyr` verbs directly on the object:

```r
# Filter samples based on condition
pasilla_tidy %>% filter(condition == "untreated")

# Select specific metadata columns
pasilla_tidy %>% select(.sample, condition, type)

# Add new metadata or transform assays
pasilla_tidy %>% mutate(log_counts = log1p(counts))

# Aggregate data
pasilla_tidy %>% 
    group_by(.sample) %>% 
    summarise(total_counts = sum(counts))
```

### Reshaping and Combining (tidyr)

```r
# Combine metadata columns
pasilla_tidy %>% unite("group", c(condition, type))

# Combine multiple objects by samples (tidy equivalent of cbind)
combined <- append_samples(subset1, subset2)
```

### Visualization (ggplot2)

Because the object behaves like a tibble, it can be piped directly into `ggplot2`:

```r
library(ggplot2)

pasilla_tidy %>%
    ggplot(aes(x = counts + 1, group = .sample, color = type)) +
    geom_density() +
    scale_x_log10() +
    theme_bw()
```

## Tips for Success

- **Column Prefixes**: Use the `.` prefix (e.g., `.feature`, `.sample`) to refer to the intrinsic dimensions of the SummarizedExperiment to avoid conflicts with user-defined metadata.
- **Performance**: For very large datasets, remember that the "tidy" view is an abstraction. Operations like `group_by` and `summarise` on millions of rows may be memory-intensive.
- **Conversion**: If you need a standard tibble for a non-compatible function, use `as_tibble()`.
- **Compatibility**: This package is part of the "tidyomics" ecosystem. It works seamlessly with `tidybulk` for bioinformatics-specific analyses.

## Reference documentation

- [Overview of the tidySummarizedExperiment package](./references/introduction.Rmd)
- [Introduction to tidySummarizedExperiment](./references/introduction.md)