---
name: ezcharts
description: ezcharts is a Python library for creating interactive web-based visualizations and HTML reports using eCharts or Bokeh backends. Use when user asks to generate genomic analysis plots, build interactive eCharts visualizations, or render comprehensive HTML reports for bioinformatics data.
homepage: https://github.com/epi2me-labs/ezcharts
---


# ezcharts

## Overview
ezcharts is a specialized Python library designed to simplify the creation of interactive web-based visualizations and comprehensive HTML reports. It provides a Pythonic interface that mirrors the eCharts Option API, allowing for deep customization without leaving the Python environment. Additionally, it supports Bokeh as an alternative backend and includes a suite of pre-built components tailored for genomic analysis, such as sequence composition plots, UpSet plots, and QC status banners.

## Core Usage Patterns

### eCharts Plot Construction
The `Plot` class is the primary interface for eCharts. Its attribute hierarchy mirrors the eCharts [Option API](https://echarts.apache.org/en/option.html).

*   **Attribute Assignment**: Set attributes using dictionaries. ezcharts performs runtime type checking to ensure the configuration matches the eCharts schema.
*   **Dataset Management**: Use the `dataset` attribute for data handling rather than embedding data directly in `series`. This enables the use of data transforms (filtering, sorting).
*   **Convenience Methods**: Use `.add_dataset()` and `.add_series()` to append configurations safely with type validation.

### Bokeh Integration
For users preferring the Bokeh backend, use the `BokehPlot` wrapper.
*   Access the underlying Bokeh figure object via the `._fig` attribute to use standard Bokeh glyph methods (e.g., `plt._fig.vbar(...)`).

### Generating Reports
To render a plot into a standalone HTML file, use the `ComponentReport` class:
```python
from ezcharts.components.reports.comp import ComponentReport
ComponentReport.from_plot(plt, "output_report.html")
```

## Specialized Bioinformatics Components
ezcharts includes high-level components for common bioinformatics tasks:
*   **UpSetPlot**: Visualizes set intersections with bar charts and dot matrices.
*   **SeqSummary**: Generates read length, accuracy, and coverage histograms.
*   **BaseComposition**: Provides interactive sequence analysis with synchronized zooming across coverage and quality panels.
*   **QCStatusBanner**: Displays pass/fail status for workflow checkpoints.
*   **Sankey Plots**: Useful for taxonomic classification or flow-based data.

## Expert Tips and Best Practices
*   **Avoid Direct Attribute Mutation**: You cannot set child attributes (e.g., `plt.xAxis.name = "X"`) without first initializing the parent attribute with a dictionary.
*   **JSON Encoding**: If you encounter JSON encoding errors during rendering, ensure your data types are standard Python types (lists, dicts) or NumPy types supported by the internal encoder.
*   **Layout Customization**: ezcharts uses `dominate` for its layout system. You can create complex, multi-column reports by nesting components within a declarative HTML structure.
*   **Responsive Design**: Sankey plots and other complex components are designed to scale down to 800px before enabling horizontal scrolling to maintain readability on smaller screens.



## Subcommands

| Command | Description |
|---------|-------------|
| ezcharts | ezcharts: A tool for generating plots and reports from various bioinformatics tool outputs. |
| ezcharts | A tool for generating charts and reports from various bioinformatics data sources. |

## Reference documentation
- [ezcharts README](./references/github_com_epi2me-labs_ezcharts_blob_master_README.md)
- [ezcharts Changelog and Component List](./references/github_com_epi2me-labs_ezcharts_blob_master_CHANGELOG.md)