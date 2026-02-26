---
name: ezcharts
description: ezcharts is a Python library for creating interactive web-based visualizations and structured HTML reports using eCharts, Bokeh, and Seaborn-style APIs. Use when user asks to create interactive charts, generate comprehensive data analysis reports, or build multi-section HTML layouts with embedded plots and tables.
homepage: https://github.com/epi2me-labs/ezcharts
---


# ezcharts

## Overview

ezcharts is a Python library designed to simplify the creation of interactive web-based visualizations and comprehensive HTML reports. It provides a high-level API that mirrors Seaborn for quick plotting, while also allowing low-level access to the eCharts and Bokeh engines for fine-grained control. Beyond individual plots, ezcharts includes a declarative layout system based on the `dominate` library, enabling the assembly of complex, multi-section reports suitable for data analysis pipelines.

## Core Plotting Patterns

### eCharts API (Low-level)
The `Plot` class mirrors the eCharts Option API. Attributes are set using dictionaries and are runtime type-checked.

```python
from ezcharts.plots import Plot
from ezcharts.components.reports.comp import ComponentReport

plt = Plot()
plt.xAxis = dict(name="Category", type="category")
plt.yAxis = dict(type="value")
plt.dataset = [dict(
    dimensions=['Item', 'Value'],
    source=[['A', 10], ['B', 20], ['C', 15]]
)]
plt.series = [dict(type='bar')]

# Quick render to standalone HTML
ComponentReport.from_plot(plt, "chart.html")
```

### Seaborn-style API (High-level)
Use the top-level `ezcharts` module for common plot types without manual configuration.

```python
import ezcharts as ezc
import seaborn as sns

df = sns.load_dataset("tips")
# Supports x, y, and hue mapping
plt = ezc.scatterplot(data=df, x="total_bill", y="tip", hue="day")
```

### Bokeh Backend
For specialized Bokeh visualizations, use the `BokehPlot` wrapper.

```python
from ezcharts.plots import BokehPlot
plt = BokehPlot(title="Bokeh Chart", x_axis_label="X", y_axis_label="Y")
plt._fig.line([1, 2, 3], [4, 5, 6])
```

## Building HTML Reports

ezcharts uses a "with" context pattern for building structured reports.

```python
import ezcharts as ezc
from ezcharts.components.ezchart import EZChart
from ezcharts.layout.snippets import DataTable, Tabs
from ezcharts.components.reports.labs import BasicReport

report = BasicReport("Analysis Report")

with report.add_section("Visualizations", "viz_section"):
    tabs = Tabs()
    with tabs.add_tab("Scatter Plot"):
        # Plots must be wrapped in EZChart() to render in reports
        EZChart(plt)
    with tabs.add_tab("Raw Data"):
        DataTable.from_pandas(df)

report.write("report.html")
```

## Expert Tips and Best Practices

- **Type Safety**: Always use `.add_dataset()` and `.add_series()` convenience methods instead of directly appending to lists. This ensures the provided dictionaries are validated against the eCharts schema.
- **Data Transforms**: Leverage the eCharts `dataset` attribute for filtering or transforming data within the chart itself rather than pre-processing in Python.
- **Parent-Child Constraint**: You cannot set a child attribute (e.g., `plt.xAxis.name`) without first initializing the parent (e.g., `plt.xAxis = dict(...)`).
- **Bioinformatics Components**: Check `ezcharts.components` for domain-specific report elements like sequencing summary tables or QC status banners.
- **Debug Mode**: If a plot fails to render in a report, set the environment variable `EZCHARTS_DEBUG=1` to see the error message directly in the HTML output.

## Reference documentation
- [ezcharts README](./references/github_com_epi2me-labs_ezcharts.md)
- [ezcharts Installation](./references/anaconda_org_channels_bioconda_packages_ezcharts_overview.md)