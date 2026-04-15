---
name: bioconductor-wpm
description: This tool generates randomized well-plate layouts for experimental designs to minimize batch effects and spatial biases. Use when user asks to create randomized plate maps, manage spatial constraints in plate-based assays, or visualize experimental layouts for high-throughput screening.
homepage: https://bioconductor.org/packages/release/bioc/html/wpm.html
---

# bioconductor-wpm

name: bioconductor-wpm
description: Specialized for the Bioconductor R package 'wpm' (Well Plate Maker). Use this skill to generate randomized well-plate layouts for experimental designs, manage batch effects through block randomization, and visualize plate maps. It supports input from CSV files, ExpressionSet, MSnSet, and SummarizedExperiment objects.

## Overview

The **Well Plate Maker (WPM)** package provides a robust framework for experimental design in plate-based assays. It uses a backtracking-inspired algorithm to randomly assign samples to wells while adhering to user-defined spatial constraints (e.g., preventing samples from the same group from being adjacent). This is critical for minimizing "plate effects" and other systematic biases in high-throughput experiments.

## Core Workflow

### 1. Data Preparation
WPM requires a specific data structure where samples are associated with grouping factors.

```R
library(wpm)

# From CSV: First column must be Sample names
imported_csv <- wpm::convertCSV("path/to/data.csv")
df <- imported_csv$df_wpm

# From SummarizedExperiment
# se is a SummarizedExperiment object; "Treatment" is a column in colData
df <- wpm::convertSE(se, "Treatment")

# From ExpressionSet or MSnSet
df <- wpm::convertESet(my_msnset, "Environment")
```

### 2. Defining Constraints and Running WPM
The `wrapperWPM` function is the primary engine for generating the layout.

**Key Parameters:**
- `plate_dims`: List of (rows, columns), e.g., `list(8, 12)` for a 96-well plate.
- `nb_plates`: Number of plates to fill.
- `forbidden_wells`: Wells to leave empty (e.g., "A1,A2,H12").
- `fixed_wells`: Wells for specific standards/controls (e.g., "B1,B2").
- `spatial_constraint`: 
    - `"NS"`: No same-group neighbors North-South.
    - `"WE"`: No same-group neighbors West-East.
    - `"NSEW"`: No same-group neighbors in any cardinal direction.
    - `"None"`: Complete randomization.
- `max_iteration`: Number of attempts to find a valid solution (default 20).

```R
wpm_result <- wpm::wrapperWPM(
  user_df = df,
  plate_dims = list(8, 12),
  nb_plates = 1,
  forbidden_wells = "A1,A12,H1,H12",
  spatial_constraint = "NSEW",
  max_iteration = 50
)
```

### 3. Visualization and Export
The result of `wrapperWPM` is a dataframe (or list of dataframes if multiple plates) containing well assignments.

```R
# Generate the plot
drawn_map <- wpm::drawMap(
  df = wpm_result,
  sample_gps = length(unique(df$Group)),
  gp_levels = levels(as.factor(df$Group)),
  plate_lines = 8,
  plate_cols = 12,
  project_title = "My Experiment"
)

# Display and Save
print(drawn_map)
ggplot2::ggsave("plate_layout.png", plot = drawn_map)
```

## Tips for Success
- **Complex Constraints**: If the algorithm fails to find a solution, increase `max_iteration` or relax spatial constraints.
- **Buffer Wells**: While `wrapperWPM` handles forbidden and fixed wells, specific buffer patterns (checkerboard, etc.) are often easier to configure via the Shiny UI (`wpm()`), though they can be passed as coordinates to the command line functions.
- **Multiple Plates**: If `nb_plates > 1`, `wpm_result` is a list. Access individual plates using `wpm_result[[1]]`, `wpm_result[[2]]`, etc., before passing to `drawMap`.

## Reference documentation
- [How to use Well Plate Maker](./references/wpm_vignette.md)
- [Well Plate Maker Source](./references/wpm_vignette.Rmd)