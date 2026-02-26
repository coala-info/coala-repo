---
name: bioconductor-ccplotr
description: Bioconductor-ccplotr visualizes cell-cell interactions predicted from single-cell RNA-seq data using various plot types like heatmaps, network diagrams, and circos plots. Use when user asks to visualize ligand-receptor interactions, generate interaction heatmaps or dotplots, and create network or chord diagrams from tools like Liana, CellPhoneDB, or NATMI.
homepage: https://bioconductor.org/packages/release/bioc/html/CCPlotR.html
---


# bioconductor-ccplotr

name: bioconductor-ccplotr
description: Visualization of cell-cell interactions predicted from scRNA-seq data. Use this skill to generate heatmaps, dotplots, network diagrams, circos plots, and chord diagrams representing ligand-receptor interactions between cell types. It is compatible with outputs from tools like Liana, CellPhoneDB, and NATMI.

# bioconductor-ccplotr

## Overview
CCPlotR is a lightweight R package designed to visualize cell-cell interaction (CCI) results. While many CCI prediction tools (e.g., CellPhoneDB, Liana, NATMI) provide raw tables of ligand-receptor pairs and scores, they often lack flexible or unified visualization options. CCPlotR provides a suite of functions to transform these tables into publication-quality figures using a consistent input format.

## Input Data Format
The package requires a specific dataframe structure for interactions and an optional dataframe for gene expression.

### Interaction Data (`toy_data`)
A dataframe with at least these five columns:
- `source`: Sending cell type.
- `target`: Receiving cell type.
- `ligand`: Ligand gene name.
- `receptor`: Receptor gene name.
- `score`: Numerical value for ranking (e.g., probability, -log10 p-value).

### Expression Data (`toy_exp`)
Required for specific plot options (e.g., `cc_circos` option "C" or `cc_arrow` option "B"):
- `cell_type`: Name of the cell type.
- `gene`: Gene name.
- `mean_exp`: Mean expression value.

## Core Functions and Workflows

### 1. Heatmaps and Dotplots
Used to show the frequency of interactions or specific top-scoring pairs.
- `cc_heatmap(data, option = "A")`: Option "A" shows total interaction counts between cell types. Option "B" shows specific ligand-receptor pairs. Use `option = "CellPhoneDB"` for tool-specific styles.
- `cc_dotplot(data, option = "B", n_top_ints = 10)`: Visualizes scores and/or p-values. Use `option = "Liana"` to mimic Liana's default output.

### 2. Network Diagrams
- `cc_network(data, option = "A")`: Nodes are cell types; edge weight represents the number of interactions.
- `cc_network(data, option = "B")`: Nodes are specific ligands and receptors, colored by the cell type expressing them.

### 3. Circos Plots
- `cc_circos(data, option = "A")`: Chord diagram showing interaction counts between cell types.
- `cc_circos(data, option = "B", n_top_ints = 10)`: Shows specific top interactions.
- `cc_circos(data, option = "C", exp_df = exp_data)`: Includes an outer ring representing mean expression levels.

### 4. Specialized Plots
- `cc_arrow(data, cell_types = c("CellA", "CellB"))`: Shows directed interactions between a specific pair of cell types.
- `cc_sigmoid(data, n_top_ints = 20)`: Uses sigmoid curves to connect ligands in source cells to receptors in target cells.

## Customization
Most CCPlotR functions (except `cc_circos`) return `ggplot2` objects. You can extend them using standard ggplot2 syntax:
- **Colours**: Use `scale_fill_manual()` or the `colours` argument within functions.
- **Themes**: Add `theme_bw()`, `theme_minimal()`, etc.
- **Labels**: Use `labs(title = "...")`.
- **Palettes**: The package includes `paletteMartin()` for a 15-color colourblind-friendly palette.

For `cc_circos`, customization is handled via the `circlize` package parameters (e.g., `cex`, `cell_cols`).

## Reference documentation
- [Generating visualisations of cell-cell interactions with CCPlotR](./references/CCPlotR_visualisations.md)
- [Generating visualisations of cell-cell interactions with CCPlotR (RMarkdown)](./references/CCPlotR_visualisations.Rmd)