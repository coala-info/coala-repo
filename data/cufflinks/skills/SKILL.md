---
name: cufflinks
description: Cufflinks connects Pandas DataFrames to Plotly to create interactive web-ready visualizations with minimal code. Use when user asks to generate interactive plots from DataFrames, create financial charts with technical analysis, or use the iplot method for rapid data exploration.
homepage: https://github.com/santosjorge/cufflinks
---


# cufflinks

## Overview
Cufflinks is a productivity tool that bridges the gap between the data manipulation power of Pandas and the interactive visualization capabilities of Plotly. It extends Pandas DataFrames with a native `.iplot()` method, allowing for the generation of interactive, web-ready charts with a single line of code. It is particularly powerful for financial time-series data through its `QuantFig` class and built-in technical analysis studies.

## Core Usage Patterns

### Initialization and Environment
Before plotting, configure the rendering mode. For most local development and notebook environments, use offline mode:
```python
import cufflinks as cf
cf.go_offline()
```

### Basic Plotting
Use the `.iplot()` method directly on a DataFrame. The `kind` parameter determines the chart type:
- **Line/Scatter**: `df.iplot(kind='scatter', mode='lines+markers')`
- **Bar**: `df.iplot(kind='bar', barmode='stack')`
- **Histogram**: `df.iplot(kind='histogram', bins=20)`
- **Box**: `df.iplot(kind='box')`
- **Heatmap**: `df.iplot(kind='heatmap', colorscale='spectral')`

### Financial Charting with QuantFig
For financial data (Open, High, Low, Close), use the `QuantFig` class for persistent chart objects that allow incremental updates:
```python
qf = cf.QuantFig(df, title='Financial Analysis', legend='top', name='Ticker')
qf.add_bollinger_bands(periods=20, boll_std=2)
qf.add_sma([10, 20], width=2)
qf.add_volume()
qf.add_macd()
qf.iplot()
```

### Technical Analysis (TA) Plots
Apply technical studies directly to time-series DataFrames using `ta_plot`:
- **Moving Averages**: `df.ta_plot(study='sma', periods=[13, 21, 55])`
- **RSI**: `df.ta_plot(study='rsi', periods=14)`
- **Bollinger Bands**: `df.ta_plot(study='boll', periods=14)`

## Expert Tips

- **Layout Customization**: Use `layout_update` to pass a dictionary of Plotly layout parameters directly through `iplot`.
- **Secondary Axes**: For multi-series plots with different scales, use `fig.set_axis('column_name', side='right')` on a figure object before calling `iplot`.
- **Subplots**: Create subplots automatically by setting `subplots=True`. Control the layout with `shape=(rows, cols)` and `shared_xaxes=True`.
- **Annotations**: Add context to specific dates or values using the `annotations` parameter, which supports both simple date-string mapping and explicit coordinate dictionaries.
- **Themes**: Set a global aesthetic using `cf.set_config_file(theme='pearl')`. Common themes include 'ggplot', 'solar', and 'space'.

## Reference documentation
- [Cufflinks Main Documentation](./references/github_com_santosjorge_cufflinks.md)