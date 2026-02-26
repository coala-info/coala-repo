---
name: plotly
description: Plotly creates interactive, browser-based data visualizations and statistical charts using a declarative Python API. Use when user asks to create interactive plots, build dashboards, generate standalone HTML reports, or visualize large datasets with WebGL acceleration.
homepage: https://github.com/plotly/plotly.py
---


# plotly

## Overview
The `plotly` skill enables the creation of declarative, interactive visualizations using the `plotly.py` library. It transforms data into browser-based charts that support complex scientific and statistical representations. Use this skill to move beyond static plots and provide users with exploratory data tools, standalone HTML reports, or components for interactive dashboards.

## Installation and Setup
To use the library, ensure the core package and its optional dependencies for image export or geographic data are installed:

```bash
# Core library
pip install plotly

# For Jupyter widget support
pip install jupyter anywidget

# For static image export (PNG, JPEG, SVG, PDF)
pip install -U kaleido

# For extended geographic shape files (e.g., county choropleths)
pip install plotly-geo==1.0.0
```

## Core Usage Patterns

### Plotly Express (High-Level API)
Always prefer `plotly.express` (px) for rapid prototyping and standard chart types. It handles tidy data (DataFrames) efficiently.

```python
import plotly.express as px

# Quick bar chart
fig = px.bar(data_frame=df, x="column_a", y="column_b", color="column_c")
fig.show()

# Scatter plot with trendlines and marginal distributions
fig = px.scatter(df, x="gdp", y="life_exp", size="pop", color="continent",
                 hover_name="country", log_x=True, size_max=60,
                 marginal_x="histogram", trendline="ols")
fig.show()
```

### Graph Objects (Low-Level API)
Use `plotly.graph_objects` (go) when you require granular control over traces, complex subplots, or non-standard chart combinations.

```python
import plotly.graph_objects as go

fig = go.Figure(data=[go.Bar(x=['A', 'B'], y=[10, 20])])
fig.update_layout(title_text="Manual Graph Object")
fig.show()
```

## Expert Tips and Best Practices

*   **Renderers**: If working in specific environments like VS Code, Colab, or headless servers, use `fig.show(renderer="colab")` or `fig.show(renderer="browser")` to ensure the plot displays correctly.
*   **Performance**: For very large datasets (100k+ points), use `go.Scattergl` instead of `go.Scatter` to leverage WebGL for hardware-accelerated rendering.
*   **Theming**: Apply consistent styling across all plots using `template` arguments (e.g., `template="plotly_dark"`, `"ggplot2"`, or `"seaborn"`).
*   **Static Export**: Use `fig.write_image("output.png")` for reports. This requires the `kaleido` engine.
*   **Standalone HTML**: Use `fig.write_html("path/to/file.html")` to create an interactive file that can be shared and opened in any web browser without a Python backend.

## Reference documentation
- [GitHub - plotly/plotly.py](./references/github_com_plotly_plotly.py.md)