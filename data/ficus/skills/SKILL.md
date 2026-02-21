---
name: ficus
description: The `ficus` library provides a streamlined way to handle matplotlib figures by wrapping the standard boilerplate into a context manager.
homepage: https://github.com/camillescott/ficus
---

# ficus

## Overview
The `ficus` library provides a streamlined way to handle matplotlib figures by wrapping the standard boilerplate into a context manager. It is designed to solve the common friction in Jupyter notebooks where users want precise control over when figures are displayed, saved to disk, and closed to free up memory, without having to manually call multiple pyplot methods for every plot.

## Usage Instructions

### Basic Figure Management
Use `FigureManager` to create a single figure and axes. The context manager automatically handles the setup and teardown.

```python
from ficus import FigureManager
import numpy as np

X = np.arange(0, 10, .1)
Y = np.exp(X)

# Automatically creates fig/ax, saves to file, shows inline, and closes
with FigureManager(filename='plot.png', show=True) as (fig, ax):
    ax.plot(X, Y)
    ax.set_title('Exponential Growth')
```

### Working with Subplots
`FigureManager` uses `pyplot.subplots()` internally. You can pass grid dimensions directly to manage multiple axes.

```python
# Returns an array of axes (ax_mat) for grids
with FigureManager(nrows=2, ncols=2, figsize=(10, 10), show=True) as (fig, ax_mat):
    for i, row in enumerate(ax_mat):
        for j, ax in enumerate(row):
            ax.plot(X, X**(i+j))
```

### Configuration for Jupyter Notebooks
To get the most out of `ficus` in a notebook environment, disable the automatic closing of figures by the Inline backend. This allows `ficus` to take full responsibility for the figure lifecycle.

```python
%config InlineBackend.close_figures = False
```

## Best Practices and Tips
- **Keyword Arguments**: Any argument accepted by `matplotlib.pyplot.subplots` (like `sharex`, `sharey`, `gridspec_kw`) can be passed directly into `FigureManager`.
- **Memory Management**: Always use the `with` statement. `ficus` ensures `plt.close(fig)` is called upon exiting the block, preventing memory leaks when generating many plots in a single session.
- **Conditional Saving**: If `filename` is omitted, the tool will still manage the display and closing of the figure without attempting to write to disk.
- **Format Support**: The `filename` extension determines the output format (PNG, PDF, SVG, etc.), leveraging matplotlib's standard backend logic.

## Reference documentation
- [github_com_camillescott_ficus.md](./references/github_com_camillescott_ficus.md)
- [anaconda_org_channels_bioconda_packages_ficus_overview.md](./references/anaconda_org_channels_bioconda_packages_ficus_overview.md)