---
name: plotly
description: Plotly creates interactive, browser-based visualizations and graphs from data using high-level or low-level interfaces. Use when user asks to create interactive charts, customize figure layouts, render plots in Jupyter notebooks, or export visualizations to static images and HTML files.
homepage: https://github.com/plotly/plotly.py
metadata:
  docker_image: "quay.io/biocontainers/plotly:3.1.1"
---

# plotly

## Overview
Plotly is a versatile visualization library that transforms data into interactive, browser-based graphs. It provides two main interfaces: **Plotly Express**, a high-level API for rapid data exploration, and **Graph Objects**, a lower-level API for detailed customization. This skill guides the creation, modification, and rendering of figures across various environments like Jupyter, web apps, and static reports.

## Core Usage Patterns

### 1. Rapid Prototyping with Plotly Express
Always prefer `plotly.express` (px) for standard charts when working with tidy DataFrames.
- **Bar Chart**: `px.bar(df, x='column_a', y='column_b', color='column_c')`
- **Scatter Plot**: `px.scatter(df, x='x_col', y='y_col', size='size_col', hover_name='label_col')`
- **Faceting**: Use `facet_row` or `facet_col` to create subplots automatically based on data categories.

### 2. Fine-grained Control with Graph Objects
Use `plotly.graph_objects` (go) when building complex figures from scratch or combining multiple trace types.
- **Manual Traces**: `fig.add_trace(go.Scatter(x=x, y=y, mode='lines+markers'))`
- **Layout Customization**: `fig.update_layout(title_text="Title", showlegend=False)`

### 3. Figure Modification
Instead of recreating figures, use "magic" update methods to modify existing objects:
- `fig.update_traces()`: Modify properties of all traces (e.g., marker size, line color) at once.
- `fig.update_xaxes()` / `fig.update_yaxes()`: Change axis titles, ranges, or grid lines.
- `fig.add_hline()` / `fig.add_vline()`: Add reference lines without defining a new trace.

## Environment & Exporting

### Rendering in Jupyter
For interactive widgets in Jupyter Lab or Notebook, ensure `anywidget` is installed. Use `fig.show()` to render the plot in the default browser or notebook cell.

### Static Image Export
To save figures as PNG, JPEG, SVG, or PDF, the `kaleido` engine is required:
```bash
pip install -U kaleido
```
**Command**: `fig.write_image("output.png")`

### Standalone HTML
To share interactive plots without a Python backend, export to HTML:
`fig.write_html("path/to/file.html")`

## Expert Tips
- **Performance**: For datasets with >10,000 points, use `go.Scattergl` instead of `go.Scatter` to leverage WebGL rendering for smoother interaction.
- **Theming**: Use the `template` parameter (e.g., `template="plotly_dark"`) in `update_layout` for instant professional styling.
- **Subplots**: Use `plotly.subplots.make_subplots` to define a grid before adding traces via `fig.add_trace(..., row=i, col=j)`.
- **JSON Schema**: Plotly figures are internally represented as JSON. You can view this structure using `fig.show("json")` to debug complex attribute paths.

## Reference documentation
- [Getting Started](./references/plotly_com_python_getting-started.md)
- [Plotly Express](./references/plotly_com_python_plotly-express.md)
- [Figure Structure](./references/plotly_com_python_figure-structure.md)
- [Renderers](./references/plotly_com_python_renderers.md)
- [Creating and Updating Figures](./references/plotly_com_python_creating-and-updating-figures.md)