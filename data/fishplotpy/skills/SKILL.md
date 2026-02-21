---
name: fishplotpy
description: The `fishplotpy` skill provides a Python-based workflow for generating professional clonal evolution visualizations.
homepage: https://github.com/Sayitobar/fishplotpy
---

# fishplotpy

## Overview
The `fishplotpy` skill provides a Python-based workflow for generating professional clonal evolution visualizations. It translates clonal fraction data and parent-child relationships into area-based plots where the width of a "fish" body represents the frequency of a clone at a specific timepoint. This tool is essential for researchers needing to illustrate how sub-clones emerge from founders and compete within a population.

## Core Usage Pattern

To generate a plot, follow this three-step procedural sequence:

1.  **Data Initialization**: Define your timepoints, a 2D array of clonal fractions (clones as rows, timepoints as columns), and a list of parent indices.
    *   **Parent Indices**: Use `0` for founder clones. For sub-clones, use the 1-based index of the parent clone in your fraction table.
2.  **Layout Calculation**: Instantiate `FishPlotData` and call `layout_clones()`. This step calculates the vertical nesting and coordinates.
3.  **Visualization**: Use the `fishplot()` function to draw the data onto a Matplotlib axis.

### Basic Implementation Example
```python
import matplotlib.pyplot as plt
import numpy as np
from fishplotpy import FishPlotData, fishplot

# 1. Setup Data
timepoints = [0, 50, 100]
# Rows: Clone A (Founder), Clone B (Child of A)
frac_table = np.array([
    [100, 50, 20], 
    [0, 40, 70]
])
parents = [0, 1] # Clone 1 is founder, Clone 2's parent is index 1

# 2. Process Layout
fp_data = FishPlotData(frac_table, parents, timepoints)
fp_data.layout_clones()

# 3. Render
fig, ax = plt.subplots()
fishplot(fp_data, ax=ax, shape="spline")
plt.show()
```

## Expert Tips and Best Practices

### Visual Refinement
*   **Shape Selection**: Always prefer `shape="spline"` for publication-quality figures. The `polygon` shape is useful for strictly linear transitions, while `bezier` provides an alternative smoothing that may differ slightly from the original R implementation.
*   **Handling Multiple Founders**: If your data contains multiple independent lineages (multiple clones with parent `0`), set `separate_independent_clones=True` during the `layout_clones()` call to ensure they do not overlap visually.
*   **Backgrounds**: Use `bg_type="gradient"` with a list of three colors in `bg_col` to create a professional depth effect behind the clones.

### Annotation and Labeling
*   **Mutation Mapping**: Use the `clone_annots` parameter in `FishPlotData` to label specific clones with their defining mutations.
*   **Contrast**: Set `use_annot_outline=True` in the `fishplot()` call to add a white border around text labels, ensuring they remain legible against dark clone colors.
*   **Legend Control**: Use `draw_legend(fp_data, ax=ax)` for automatic legend generation. You can control the layout using standard Matplotlib-style arguments like `ncol` and `loc`.

### Data Integrity
*   **Validation**: The tool strictly validates that child clone fractions do not exceed the available fraction of the parent at any timepoint.
*   **Disappearing Clones**: If a clone's frequency drops to zero and then increases again, use `fix_missing_clones=True`. Note that this can sometimes lead to unexpected visual artifacts if the underlying data is inconsistent.

## Reference documentation
- [fishplotpy GitHub Repository](./references/github_com_Sayitobar_fishplotpy.md)
- [fishplotpy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fishplotpy_overview.md)