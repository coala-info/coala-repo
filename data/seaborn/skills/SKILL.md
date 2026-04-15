---
name: seaborn
description: Seaborn is a Python library for creating attractive and informative statistical data visualizations built on top of matplotlib. Use when user asks to create statistical graphics, visualize complex datasets using pandas, or generate plots like scatterplots, histograms, and boxplots.
homepage: https://github.com/mwaskom/seaborn
metadata:
  docker_image: "quay.io/biocontainers/seaborn:0.13.2"
---

# seaborn

## Overview
Seaborn is a high-level Python visualization library built on top of matplotlib that is designed for creating attractive and informative statistical graphics. It provides a sophisticated interface for visualizing complex datasets, integrating deeply with pandas data structures. This skill covers the setup, core plotting interfaces, and development workflows for seaborn, including its newer "objects" interface and traditional functional API.

## Installation and Setup
Seaborn requires Python 3.8+ and several core dependencies.

- **Standard Installation**:
  `pip install seaborn`
- **With Statistical Dependencies**:
  For advanced functionality (scipy/statsmodels), use:
  `pip install seaborn[stats]`
- **Conda Installation**:
  `conda install seaborn` (use `-c conda-forge` for the latest releases)

## Core Plotting Interfaces
Seaborn provides two primary ways to interact with data:

### 1. Functional Interface (Traditional)
Use these high-level functions for quick statistical summaries:
- **Relational**: `relplot`, `scatterplot`, `lineplot`
- **Distributions**: `displot`, `histplot`, `kdeplot`, `ecdfplot`, `rugplot`
- **Categorical**: `catplot`, `boxplot`, `violinplot`, `stripplot`, `swarmplot`, `pointplot`, `barplot`, `countplot`
- **Regression**: `lmplot`, `regplot`
- **Multi-plot Grids**: `jointplot`, `pairplot`

### 2. Objects Interface (`seaborn.objects`)
A newer, more flexible declarative API for building plots:
- Use `so.Plot(data, x, y, color, ...)` to initialize.
- Chain methods like `.add(so.Bar())` or `.facet(col="column_name")`.
- Use for complex layouts where the functional API is too restrictive.

## Development and Testing
If you are contributing to or testing the seaborn library itself:
- **Run Tests**: Execute `make test` in the source directory (requires `pytest`).
- **Linting**: Use `make lint` to check code style (enforced via `flake8`).
- **Dev Dependencies**: Install with `pip install .[dev]`.

## Expert Tips
- **Pandas Integration**: Always prefer passing entire DataFrames and using column names as strings for the `x`, `y`, and `hue` parameters to leverage automatic axis labeling.
- **Statistical Estimation**: Many plots (like `barplot` or `lineplot`) perform automatic aggregation and show error bars; use the `errorbar` parameter to customize this behavior.
- **Theming**: Use `sns.set_theme()` to quickly apply aesthetically pleasing defaults that improve upon standard matplotlib styles.

## Reference documentation
- [seaborn: statistical data visualization](./references/github_com_mwaskom_seaborn.md)
- [Frequently Asked Questions (FAQs)](./references/github_com_mwaskom_seaborn_wiki.md)