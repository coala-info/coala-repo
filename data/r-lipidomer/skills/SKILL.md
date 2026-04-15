---
name: r-lipidomer
description: This tool creates integrative heatmaps for the statistical visualization of lipidomics data to identify patterns across lipid classes and species. Use when user asks to visualize lipidome-wide associations, create lipidomic heatmaps, or map statistical results onto lipid structures.
homepage: https://cran.r-project.org/web/packages/lipidomer/index.html
---

# r-lipidomer

name: r-lipidomer
description: Statistical visualization of lipidomics data using the lipidomeR R package. Use this skill to create integrative heatmaps of lipidome-wide associations, identify patterns across lipid classes, and visualize results from clinical or omics studies.

## Overview
The `lipidomeR` package is designed for the lipidome-wide visualization of statistical associations. It generates integrative heatmaps that represent patterns across the entire measured lipidome, helping researchers identify how lipid classes and individual species relate to clinical variables, disease progression, or experimental conditions.

## Installation
Install the package from CRAN:
```R
install.packages("lipidomeR")
library(lipidomeR)
```

## Core Workflow
The typical workflow involves taking results from statistical models (such as linear regression or Cox proportional hazards) and mapping them onto the lipidome structure for visualization.

1.  **Prepare Data**: Create a data frame where one column contains lipid names (e.g., "PC(34:1)", "SM(d41:1)") and other columns contain statistical values like regression coefficients (estimates) and p-values.
2.  **Map the Lipidome**: Use the `map_lipidome()` function to organize the statistical results into a format suitable for the package's visualization engine.
3.  **Create Heatmap**: Use the `heatmap_lipidome()` function to generate the final integrative heatmap.

## Key Functions
- `map_lipidome(data, ...)`: Formats statistical results for visualization. It automatically parses lipid names to identify classes, carbon chain lengths, and unsaturation levels.
- `heatmap_lipidome(map, ...)`: Produces a ggplot2-based heatmap. You can specify which statistical value to use for the color scale (e.g., "estimate") and which to use for significance filtering.
- `list_lipid_classes()`: Returns a list of lipid classes currently supported by the package's parsing logic.

## Usage Tips
- **Lipid Nomenclature**: For the best results, ensure lipid names follow standard abbreviations (e.g., PC, PE, TG, SM, CE) followed by the carbon and double-bond count in parentheses, such as `PC(16:0/18:1)` or `PC(34:1)`.
- **Statistical Input**: The package is agnostic to the model used; as long as you have a coefficient/effect size and a lipid name, you can visualize the association.
- **Visual Interpretation**: Use these heatmaps to identify systemic changes, such as the depletion of sphingomyelins (SM) in liver fibrosis or changes in triacylglycerol (TG) saturation levels in diabetes progression.

## Reference documentation
- [lipidomeR: Lipidome-Wide Visualization of Statistical Associations](./references/home_page.md)