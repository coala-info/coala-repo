---
name: r-tidyverse
description: "The 'tidyverse' is a set of packages that work in harmony     because they share common data representations and 'API' design. This     package is designed to make it easy to install and load multiple     'tidyverse' packages in a single step."
homepage: https://cloud.r-project.org/web/packages/tidyverse/index.html
---

# r-tidyverse

name: r-tidyverse
description: Expert guidance for using the 'tidyverse' ecosystem in R. Use this skill when you need to perform data science tasks including data import (readr, readxl), tidying (tidyr), transformation (dplyr), visualization (ggplot2), and functional programming (purrr). It provides the "tidy tools manifesto" principles and workflows for the core packages.

## Overview

The tidyverse is a collection of R packages designed for data science that share a common design philosophy, grammar, and data structures. The core packages (ggplot2, dplyr, tidyr, readr, purrr, tibble, stringr, and forcats) provide a complete workflow for importing, cleaning, transforming, and visualizing data.

## Installation

To install the complete tidyverse:

```r
install.packages("tidyverse")
```

To load the core packages and check for conflicts:

```r
library(tidyverse)
```

## Core Principles

When writing R code with the tidyverse, follow the "Tidy Tools Manifesto":
1. **Reuse existing data structures**: Work with data frames or tibbles.
2. **Compose with the pipe**: Use `%>%` (magrittr) or `|>` (base R) to chain simple functions.
3. **Embrace functional programming**: Use `purrr` map functions instead of for-loops; keep functions pure.
4. **Design for humans**: Use evocative, verb-based function names and favor explicit naming over brevity.

## Common Workflows

### Data Import & Tidying
- **Import**: Use `read_csv()` (readr) for flat files or `read_excel()` (readxl) for spreadsheets.
- **Tidy**: Use `pivot_longer()` and `pivot_wider()` (tidyr) to ensure every column is a variable and every row is an observation.

### Transformation (dplyr)
- `filter()`: Pick observations by values.
- `mutate()`: Create new variables.
- `select()`: Pick variables by name.
- `summarise()`: Collapse many values down to a single summary.
- `group_by()`: Change the scope of each function from operating on the entire dataset to operating on it group-by-group.

### Visualization (ggplot2)
Create plots by mapping variables to aesthetics (`aes`) and adding layers:
```r
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
```

### Programming (purrr & tibble)
- Use `tibble()` for a modern data frame that prints better and doesn't change variable types.
- Use `map()`, `map_dbl()`, etc., to apply functions to elements of a list or vector.

## Tips for Success
- **Conflicts**: `library(tidyverse)` will warn you if functions like `filter` conflict with other packages (e.g., `stats`). Use `dplyr::filter()` to be explicit.
- **Type Stability**: Tidyverse functions are generally type-stable, meaning they return predictable output types.
- **Non-Standard Evaluation**: When writing functions that take column names as arguments, use tidy evaluation (e.g., the "curly-curly" `{{ }}` operator).

## Reference documentation

- [The tidy tools manifesto](./references/manifesto.Rmd)
- [Welcome to the Tidyverse](./references/paper.Rmd)