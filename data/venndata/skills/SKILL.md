---
name: venndata
description: The `venndata` tool creates Venn diagrams for an arbitrary number of sets, visualizing complex set relationships from pandas DataFrames. Use when user asks to create Venn diagrams, visualize set overlaps, or plot relationships between multiple sets.
homepage: https://github.com/mandalsubhajit/venndata
metadata:
  docker_image: "quay.io/biocontainers/venndata:0.1.0--pyhdfd78af_0"
---

# venndata

## Overview

The `venndata` skill enables the creation of Venn diagrams for an arbitrary number of sets, overcoming the common 3-set limitation found in many plotting libraries. It uses an optimization-based approach to approximate set overlaps in 2D space. The tool is designed to work seamlessly with pandas DataFrames, where each column represents a set and each row represents an observation's membership (1 for member, 0 for non-member). This skill is best applied when you need a quick, meaningful visualization of complex set relationships that cannot be easily represented by standard Euler diagrams.

## Core Workflow

To generate a Venn diagram from a membership DataFrame, follow this two-step process:

1. **Calculate Overlaps**: Use `venn.df2areas()` to process the DataFrame and extract the necessary geometric data (radii and intersection sizes).
2. **Render Plot**: Use `venn.venn()` to generate the Matplotlib figure.

### Implementation Pattern

```python
from venndata import venn
import matplotlib.pyplot as plt

# 1. Calculate areas from a binary membership DataFrame
# fineTune=False is recommended for speed; use True if overlaps look inaccurate
labels, radii, actualOverlaps, disjointOverlaps = venn.df2areas(df, fineTune=False)

# 2. Generate the plot
fig, ax = venn.venn(radii, actualOverlaps, disjointOverlaps, 
                    labels=labels, 
                    labelsize='auto', 
                    cmap=None, 
                    fineTune=False)

plt.savefig('venn_diagram.png', dpi=300)
plt.show()
```

## Expert Tips and Best Practices

### Optimization with fineTune
* **Default (False)**: Use `fineTune=False` for most exploratory tasks. It is significantly faster and usually provides a sufficient approximation.
* **High Accuracy (True)**: If the resulting circles do not appear to represent the overlap sizes correctly (especially with many sets), set `fineTune=True`. Note that this can take several minutes as it runs a more intensive optimization to find better circle coordinates.

### Data Structure Requirements
* The input DataFrame must consist of indicator columns (0 and 1).
* Each row represents a unique observation.
* If your data is in a list-of-lists or set format, convert it to a binary matrix using `pandas.get_dummies()` or a similar transformation before passing it to `venndata`.

### Handling Visualization Anomalies
* Because a perfect 2D solution for many overlapping sets does not always exist, `venndata` uses an approximate method.
* **Disjoint Sets**: If sets are completely disjoint or one is a perfect subset of another, the visualization may show slight gaps or overlaps that don't exist in the raw data.
* **Labeling**: Use `labelsize='auto'` to let the tool scale text based on circle size, or provide an integer for consistent font sizing across all sets.

### Output Customization
* The `venn.venn()` function returns standard Matplotlib `fig` and `ax` objects. You can perform further customization (titles, legends, annotations) using standard Matplotlib commands before calling `plt.show()`.

## Reference documentation

- [venndata - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_venndata_overview.md)
- [GitHub - mandalsubhajit/venndata](./references/github_com_mandalsubhajit_venndata.md)