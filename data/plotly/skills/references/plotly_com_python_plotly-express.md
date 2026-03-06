* [Download Studio](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=header)
* [Studio and Cloud Pricing](https://plotly.com/pricing?utm_source=graphing_libraries&utm_medium=documentation&utm_content=header)
* [Dash Enterprise Pricing](https://plotly.com/get-pricing?utm_source=graphing_libraries&utm_medium=documentation&utm_content=header)

[![](/all_static/images/graphing_library_dark.svg)](/python/)
[![](/all_static/images/graphing_library.svg)](/python/)

* Python (v6.6.0)
  + [Python (v6.6.0)](https://plotly.com/python/)
  + [R](https://plotly.com/r/)
  + [Julia](https://plotly.com/julia/)
  + [Javascript (v3.4.0)](https://plotly.com/javascript/)
  + [ggplot2](https://plotly.com/ggplot2/)
  + [MATLAB](https://plotly.com/matlab/)
  + [F#](https://plotly.com/fsharp/)
* [Download Studio](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=header)
* [Studio and Cloud Pricing](https://plotly.com/pricing?utm_source=graphing_libraries&utm_medium=documentation&utm_content=header)
* [Dash Enterprise Pricing](https://plotly.com/get-pricing?utm_source=graphing_libraries&utm_medium=documentation&utm_content=header)

[![](/all_static/images/graphing_library.svg)](/python/)

Quick Reference

* [Getting Started](/python/getting-started)
* [Is Plotly Free?](/python/is-plotly-free)
* [Figure Reference](/python/reference/index/)
* [API Reference](/python-api-reference)
* [Dash](https://dash.plotly.com/tutorial)

* [GitHub](https://github.com/plotly/plotly.py)
* [community.plotly.com](http://community.plotly.com/)

On This Page

[![Sign up for the upcoming webinar: Take Your Power BI Models Beyond the Static Dashboard](https://images.prismic.io/plotly-marketing-website-2/aaHFvsFoBIGEg7rA_power-bi-webinar-square.jpg?auto=format,compress)](https://plotly.com/webinars/power-bi-models-beyond-the-static-dashboard/?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=power-bi-models-beyond-dashboard&utm_content=sidebar)

[Python](/python)
> [Fundamentals](/python/plotly-fundamentals)
> Plotly Express

[Suggest an edit to this page](https://github.com/plotly/plotly.py/edit/doc-prod/doc/python/plotly-express.md)

# Plotly Express in Python

Plotly Express is a terse, consistent, high-level API for creating figures.

Plotly Studio: Transform any dataset into an interactive data application in minutes with AI. [Try Plotly Studio now.](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=sidebar)

### Overview[¶](#Overview)

The `plotly.express` module (usually imported as `px`) contains functions that can create entire figures at once, and is referred to as Plotly Express or PX. Plotly Express is a built-in part of the `plotly` library, and is the recommended starting point for creating most common figures. Every Plotly Express function uses [graph objects](/python/graph-objects/) internally and returns a `plotly.graph_objects.Figure` instance. Throughout the `plotly` documentation, you will find the Plotly Express way of building figures at the top of any applicable page, followed by a section on how to use graph objects to build similar figures. Any figure created in a single function call with Plotly Express could be created using graph objects alone, but with between 5 and 100 times more code.

Plotly Express provides [more than 30 functions for creating different types of figures](https://plotly.com/python-api-reference/plotly.express.html). The API for these functions was carefully designed to be as consistent and easy to learn as possible, making it easy to switch from a scatter plot to a bar chart to a histogram to a sunburst chart throughout a data exploration session. *Scroll down for a gallery of Plotly Express plots, each made in a single function call.*

Here is a talk from the [SciPy 2021 conference](https://www.scipy2021.scipy.org/) that gives a good introduction to Plotly Express and [Dash](https://dash.plotly.com/):

Plotly Express currently includes the following functions:

* **Basics**: [`scatter`](/python/line-and-scatter/), [`line`](/python/line-charts/), [`area`](/python/filled-area-plots/), [`bar`](/python/bar-charts/), [`funnel`](/python/funnel-charts/), [`timeline`](https://plotly.com/python/gantt/)
* **Part-of-Whole**: [`pie`](/python/pie-charts/), [`sunburst`](/python/sunburst-charts/), [`treemap`](/python/treemaps/), [`icicle`](/python/icicle-charts/), [`funnel_area`](/python/funnel-charts/)
* **1D Distributions**: [`histogram`](/python/histograms/), [`box`](/python/box-plots/), [`violin`](/python/violin/), [`strip`](/python/strip-charts/), [`ecdf`](/python/ecdf-plots/)
* **2D Distributions**: [`density_heatmap`](/python/2D-Histogram/), [`density_contour`](/python/2d-histogram-contour/)
* **Matrix or Image Input**: [`imshow`](/python/imshow/)
* **3-Dimensional**: [`scatter_3d`](/python/3d-scatter-plots/), [`line_3d`](/python/3d-line-plots/)
* **Multidimensional**: [`scatter_matrix`](/python/splom/), [`parallel_coordinates`](/python/parallel-coordinates-plot/), [`parallel_categories`](/python/parallel-categories-diagram/)
* **Tile Maps**: [`scatter_map`](/python/tile-scatter-maps/), [`line_map`](/python/lines-on-tile-maps/), [`choropleth_map`](/python/tile-county-choropleth/), [`density_map`](/python/tile-density-heatmaps/)
* **Outline Maps**: [`scatter_geo`](/python/scatter-plots-on-maps/), [`line_geo`](/python/lines-on-maps/), [`choropleth`](/python/choropleth-maps/)
* **Polar Charts**: [`scatter_polar`](/python/polar-chart/), [`line_polar`](/python/polar-chart/), [`bar_polar`](/python/wind-rose-charts/)
* **Ternary Charts**: [`scatter_ternary`](/python/ternary-plots/), [`line_ternary`](/python/ternary-plots/)

### High-Level Features[¶](#High-Level-Features)

The Plotly Express API in general offers the following features:

* **A single entry point into `plotly`**: just `import plotly.express as px` and get access to [all the plotting functions](https://plotly.com/python-api-reference/plotly.express.html), plus [built-in demo datasets under `px.data`](https://plotly.com/python-api-reference/generated/plotly.data.html#module-plotly.data) and [built-in color scales and sequences under `px.color`](https://plotly.com/python-api-reference/generated/plotly.colors.html#module-plotly.colors). Every PX function returns a `plotly.graph_objects.Figure` object, so you can edit it using all the same methods like [`update_layout` and `add_trace`](https://plotly.com/python/creating-and-updating-figures/#updating-figures).
* **Sensible, Overridable Defaults**: PX functions will infer sensible defaults wherever possible, and will always let you override them.
* **Flexible Input Formats**: PX functions [accept input in a variety of formats](/python/px-arguments/), from `list`s and `dict`s to [long-form or wide-form `DataFrame`s](/python/wide-form/) to [`numpy` arrays and `xarrays`](/python/imshow/) to [GeoPandas `GeoDataFrames`](/python/maps/).
* **Automatic Trace and Layout configuration**: PX functions will create one [trace](/python/figure-structure) per animation frame for each unique combination of data values mapped to discrete color, symbol, line-dash, facet-row and/or facet-column. Traces' [`legendgroup` and `showlegend` attributes](https://plotly.com/python/legend/) are set such that only one legend item appears per unique combination of discrete color, symbol and/or line-dash. Traces are automatically linked to a correctly-configured [subplot of the appropriate type](/python/figure-structure).
* **Automatic Figure Labelling**: PX functions [label axes, legends and colorbars](https://plotly.com/python/figure-labels/) based in the input `DataFrame` or `xarray`, and provide [extra control with the `labels` argument](/python/styling-plotly-express/).
* **Automatic Hover Labels**: PX functions populate the hover-label using the labels mentioned above, and provide [extra control with the `hover_name` and `hover_data` arguments](/python/hover-text-and-formatting/).
* **Styling Control**: PX functions [read styling information from the default figure template](/python/styling-plotly-express/), and support commonly-needed [cosmetic controls like `category_orders` and `color_discrete_map`](/python/styling-plotly-express/) to precisely control categorical variables.
* **Uniform Color Handling**: PX functions automatically switch between [continuous](/python/colorscales/) and [categorical color](/python/discrete-color/) based on the input type.
* **Faceting**: the 2D-cartesian plotting functions support [row, column and wrapped facetting with `facet_row`, `facet_col` and `facet_col_wrap` arguments](/python/facet-plots/).
* **Marginal Plots**: the 2D-cartesian plotting functions support [marginal distribution plots](/python/marginal-plots/) with the `marginal`, `marginal_x` and `marginal_y` arguments.
* **A Pandas backend**: the 2D-cartesian plotting functions are available as [a Pandas plotting backend](/python/pandas-backend/) so you can call them via `df.plot()`.
* **Trendlines**: `px.scatter` supports [built-in trendlines with accessible model output](/python/linear-fits/).
* **Animations**: many PX functions support [simple animation support via the `animation_frame` and `animation_group` arguments](/python/animations/).
* **Automatic WebGL switching**: for sufficiently large scatter plots, PX will automatically [use WebGL for hardware-accelerated rendering](https://plotly.com/python/webgl-vs-svg/).

### Plotly Express in Dash[¶](#Plotly-Express-in-Dash)

[Dash](https://plotly.com/dash/) is the best way to build analytical apps in Python using Plotly figures. To run the app below, run `pip install dash`, click "Download" to get the code and run `python app.py`.

Get started with [the official Dash docs](https://dash.plotly.com/installation) and **learn how to effortlessly [style](https://plotly.com/dash/design-kit/) & publish apps like this with [Dash Enterprise](https://plotly.com/dash/) or [Plotly Cloud](https://plotly.com/cloud/).**

Out[2]:

### Gallery[¶](#Gallery)

The following set of figures is just a sampling of what can be done with Plotly Express.

#### Scatter, Line, Area and Bar Charts[¶](#Scatter,-Line,-Area-and-Bar-Charts)

**Read more about [scatter plots](/python/line-and-scatter/) and [discrete color](/python/discrete-color/).**

In [3]:

```
import plotly.express as px
df = px.data.iris()
fig = px.scatter(df, x="sepal_width", y="sepal_length", color="species")
fig.show()
```

**Read more about [trendlines](/python/linear-fits/) and [templates](/python/templates/) and [marginal distribution plots](https://plotly.com/python/marginal-plots/).**

In [4]:

```
import plotly.express as px
df = px.data.iris()
fig = px.scatter(df, x="sepal_width", y="sepal_length", color="species", marginal_y="violin",
           marginal_x="box", trendline="ols", template="simple_white")
fig.show()
```

**Read more about [error bars](/python/error-bars/).**

In [5]:

```
import plotly.express as px
df = px.data.iris()
df["e"] = df["sepal_width"]/100
fig = px.scatter(df, x="sepal_width", y="sepal_length", color="species", error_x="e", error_y="e")
fig.show()
```

**Read more about [bar charts](/python/bar-charts/).**

In [6]:

```
import plotly.express as px
df = px.data.tips()
fig = px.bar(df, x="sex", y="total_bill", color="smoker", barmode="group")
fig.show()
```

In [7]:

```
import plotly.express as px
df = px.data.medals_long()

fig = px.bar(df, x="medal", y="count", color="nation",
             pattern_shape="nation", pattern_shape_sequence=[".", "x", "+"])
fig.show()
```

**Read more about [facet plots](/python/facet-plots/).**

In [8]:

```
import plotly.express as px
df = px.data.tips()
fig = px.bar(df, x="sex", y="total_bill", color="smoker", barmode="group", facet_row="time", facet_col="day",
       category_orders={"day": ["Thur", "Fri", "Sat", "Sun"], "time": ["Lunch", "Dinner"]})
fig.show()
```

**Read more about [scatterplot matrices (SPLOMs)](/python/splom/).**

In [9]:

```
import plotly.express as px
df = px.data.iris()
fig = px.scatter_matrix(df, dimensions=["sepal_width", "sepal_length", "petal_width", "petal_length"], color="species")
fig.show()
```

**Read more about [parallel coordinates](/python/parallel-coordinates-plot/) and [parallel categories](/python/parallel-categories-diagram/), as well as [continuous color](/python/colorscales/).**

In [10]:

```
import plotly.express as px
df = px.data.iris()
fig = px.parallel_coordinates(df, color="species_id", labels={"species_id": "Species",
                  "sepal_width": "Sepal Width", "sepal_length": "Sepal Length",
                  "petal_width": "Petal Width", "petal_length": "Petal Length", },
                    color_continuous_scale=px.colors.diverging.Tealrose, color_continuous_midpoint=2)
fig.show()
```

In [11]:

```
import plotly.express as px
df = px.data.tips()
fig = px.parallel_categories(df, color="size", color_continuous_scale=px.colors.sequential.Inferno)
fig.show()
```

**Read more about [hover labels](/python/hover-text-and-formatting/).**

In [12]:

```
import plotly.express as px
df = px.data.gapminder()
fig = px.scatter(df.query("year==2007"), x="gdpPercap", y="lifeExp", size="pop", color="continent",
           hover_name="country", log_x=True, size_max=60)
fig.show()
```

**Read more about [animations](/python/animations/).**

In [13]:

```
import plotly.express as px
df = px.data.gapminder()
fig = px.scatter(df, x="gdpPercap", y="lifeExp", animation_frame="year", animation_group="country",
           size="pop", color="continent", hover_name="country", facet_col="continent",
           log_x=True, size_max=45, range_x=[100,100000], range_y=[25,90])
fig.show()
```

**Read more about [line charts](/python/line-charts/).**

In [14]:

```
import plotly.express as px
df = px.data.gapminder()
fig = px.line(df, x="year", y="lifeExp", color="continent", line_group="country", hover_name="country",
        line_shape="spline", render_mode="svg")
fig.show()
```

**Read more about [area charts](/python/filled-area-plots/).**

In [15]:

```
import plotly.express as px
df = px.data.gapminder()
fig = px.area(df, x="year", y="pop", color="continent", line_group="country")
fig.show()
```

**Read more about [timeline/Gantt charts](/python/gantt/).**

In [16]:

```
import plotly.express as px
import pandas as pd

df = pd.DataFrame([
    dict(Task="Job A", Start='2009-01-01', Finish='2009-02-28', Resource="Alex"),
    dict(Task="Job B", Start='2009-03-05', Finish='2009-04-15', Resource="Alex"),
    dict(Task="Job C", Start='2009-02-20', Finish='2009-05-30', Resource="Max")
])

fig = px.timeline(df, x_start="Start", x_end="Finish", y="Resource", color="Resource")
fig.show()
```

**Read more about [funnel charts](/python/funnel-charts/).**

In [17]:

```
import plotly.express as px
data = dict(
    number=