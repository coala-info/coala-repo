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
> [Basic Charts](/python/basic-charts)
> Scatter Plots

[Suggest an edit to this page](https://github.com/plotly/plotly.py/edit/doc-prod/doc/python/line-and-scatter.md)

# Scatter Plots in Python

How to make scatter plots in Python with Plotly.

Plotly Studio: Transform any dataset into an interactive data application in minutes with AI. [Try Plotly Studio now.](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=sidebar)

## Scatter plots with Plotly Express[¶](#Scatter-plots-with-Plotly-Express)

[Plotly Express](/python/plotly-express/) is the easy-to-use, high-level interface to Plotly, which [operates on a variety of types of data](/python/px-arguments/) and produces [easy-to-style figures](/python/styling-plotly-express/).

With `px.scatter`, each data point is represented as a marker point, whose location is given by the `x` and `y` columns.

In [1]:

```
# x and y given as array_like objects
import plotly.express as px
fig = px.scatter(x=[0, 1, 2, 3, 4], y=[0, 1, 4, 9, 16])
fig.show()
```

In [2]:

```
# x and y given as DataFrame columns
import plotly.express as px
df = px.data.iris() # iris is a pandas DataFrame
fig = px.scatter(df, x="sepal_width", y="sepal_length")
fig.show()
```

#### Setting size and color with column names[¶](#Setting-size-and-color-with-column-names)

Scatter plots with variable-sized circular markers are often known as [bubble charts](https://plotly.com/python/bubble-charts/). Note that `color` and `size` data are added to hover information. You can add other columns to hover data with the `hover_data` argument of `px.scatter`.

In [3]:

```
import plotly.express as px
df = px.data.iris()
fig = px.scatter(df, x="sepal_width", y="sepal_length", color="species",
                 size='petal_length', hover_data=['petal_width'])
fig.show()
```

Color can be [continuous](https://plotly.com/python/colorscales/) as follows, or [discrete/categorical](https://plotly.com/python/discrete-color/) as above.

In [4]:

```
import plotly.express as px
df = px.data.iris()
fig = px.scatter(df, x="sepal_width", y="sepal_length", color='petal_length')
fig.show()
```

The `symbol` argument can be mapped to a column as well. A [wide variety of symbols](https://plotly.com/python/marker-style/) are available.

In [5]:

```
import plotly.express as px
df = px.data.iris()
fig = px.scatter(df, x="sepal_width", y="sepal_length", color="species", symbol="species")
fig.show()
```

## Scatter plots in Dash[¶](#Scatter-plots-in-Dash)

[Dash](https://plotly.com/dash/) is the best way to build analytical apps in Python using Plotly figures. To run the app below, run `pip install dash`, click "Download" to get the code and run `python app.py`.

Get started with [the official Dash docs](https://dash.plotly.com/installation) and **learn how to effortlessly [style](https://plotly.com/dash/design-kit/) & publish apps like this with [Dash Enterprise](https://plotly.com/dash/) or [Plotly Cloud](https://plotly.com/cloud/).**

Out[6]:

**Sign up for Dash Club** → Free cheat sheets plus updates from Chris Parmer and Adam Schroeder delivered to your inbox every two months. Includes tips and tricks, community apps, and deep dives into the Dash architecture.
[Join now](https://go.plotly.com/dash-club?utm_source=Dash+Club+2022&utm_medium=graphing_libraries&utm_content=inline).

### Scatter plots and Categorical Axes[¶](#Scatter-plots-and-Categorical-Axes)

Scatter plots can be made using any type of cartesian axis, including [linear](https://plotly.com/python/axes/), [logarithmic](https://plotly.com/python/log-plot/), [categorical](https://plotly.com/python/categorical-axes/) or [date](https://plotly.com/python/time-series/) axes.

Scatter plots where one axis is categorical are often known as [dot plots](https://plotly.com/python/dot-plots/).

In [7]:

```
import plotly.express as px
df = px.data.medals_long()

fig = px.scatter(df, y="nation", x="count", color="medal", symbol="medal")
fig.update_traces(marker_size=10)
fig.show()
```

### Grouped Scatter Points[¶](#Grouped-Scatter-Points)

*New in 5.12*

By default, scatter points at the same location are overlayed. We can see this in the previous example, with the values for Canada for bronze and silver. Set `scattermode='group'` to plot scatter points next to one another, centered around the shared location.

In [8]:

```
import plotly.express as px

df = px.data.medals_long()

fig = px.scatter(df, y="count", x="nation", color="medal")
fig.update_traces(marker_size=10)
fig.update_layout(scattermode="group")
fig.show()
```

*New in 5.12*

You can configure the gap between groups of scatter points using `scattergap`. Here we set it to `0.75`, which brings the points closer together by allocating more space to the gap between groups. If you don't set `scattergap`, a default value of `0` is used, unless you have `bargap` set. If you have `bargap` set, the `scattergap` defaults to that value.

In [9]:

```
import plotly.express as px

df = px.data.medals_long()

fig = px.scatter(df, y="count", x="nation", color="medal")
fig.update_traces(marker_size=10)
fig.update_layout(scattermode="group", scattergap=0.75)
fig.show()
```

### Error Bars[¶](#Error-Bars)

Scatter plots support [error bars](https://plotly.com/python/error-bars/).

In [10]:

```
import plotly.express as px
df = px.data.iris()
df["e"] = df["sepal_width"]/100
fig = px.scatter(df, x="sepal_width", y="sepal_length", color="species",
                 error_x="e", error_y="e")
fig.show()
```

### Marginal Distribution Plots[¶](#Marginal-Distribution-Plots)

Scatter plots support [marginal distribution plots](https://plotly.com/python/marginal-plots/)

In [11]:

```
import plotly.express as px
df = px.data.iris()
fig = px.scatter(df, x="sepal_length", y="sepal_width", marginal_x="histogram", marginal_y="rug")
fig.show()
```

### Facetting[¶](#Facetting)

Scatter plots support [faceting](https://plotly.com/python/facet-plots/).

In [12]:

```
import plotly.express as px
df = px.data.tips()
fig = px.scatter(df, x="total_bill", y="tip", color="smoker", facet_col="sex", facet_row="time")
fig.show()
```

### Linear Regression and Other Trendlines[¶](#Linear-Regression-and-Other-Trendlines)

Scatter plots support [linear and non-linear trendlines](https://plotly.com/python/linear-fits/).

In [13]:

```
import plotly.express as px

df = px.data.tips()
fig = px.scatter(df, x="total_bill", y="tip", trendline="ols")
fig.show()
```

## Line plots with Plotly Express[¶](#Line-plots-with-Plotly-Express)

In [14]:

```
import plotly.express as px
import numpy as np

t = np.linspace(0, 2*np.pi, 100)

fig = px.line(x=t, y=np.cos(t), labels={'x':'t', 'y':'cos(t)'})
fig.show()
```

In [15]:

```
import plotly.express as px
df = px.data.gapminder().query("continent == 'Oceania'")
fig = px.line(df, x='year', y='lifeExp', color='country')
fig.show()
```

The `markers` argument can be set to `True` to show markers on lines.

In [16]:

```
import plotly.express as px
df = px.data.gapminder().query("continent == 'Oceania'")
fig = px.line(df, x='year', y='lifeExp', color='country', markers=True)
fig.show()
```

The `symbol` argument can be used to map a data field to the marker symbol. A [wide variety of symbols](https://plotly.com/python/marker-style/) are available.

In [17]:

```
import plotly.express as px
df = px.data.gapminder().query("continent == 'Oceania'")
fig = px.line(df, x='year', y='lifeExp', color='country', symbol="country")
fig.show()
```

### Line plots on Date axes[¶](#Line-plots-on-Date-axes)

Line plots can be made on using any type of cartesian axis, including [linear](https://plotly.com/python/axes/), [logarithmic](https://plotly.com/python/log-plot/), [categorical](https://plotly.com/python/categorical-axes/) or date axes. Line plots on date axes are often called [time-series charts](https://plotly.com/python/time-series/).

Plotly auto-sets the axis type to a date format when the corresponding data are either ISO-formatted date strings or if they're a [date pandas column](https://pandas.pydata.org/pandas-docs/stable/user_guide/timeseries.html) or [datetime NumPy array](https://docs.scipy.org/doc/numpy/reference/arrays.datetime.html).

In [18]:

```
import plotly.express as px

df = px.data.stocks()
fig = px.line(df, x='date', y="GOOG")
fig.show()
```

### Data Order in Scatter and Line Charts[¶](#Data-Order-in-Scatter-and-Line-Charts)

Plotly line charts are implemented as [connected scatterplots](https://www.data-to-viz.com/graph/connectedscatter.html) (see below), meaning that the points are plotted and connected with lines **in the order they are provided, with no automatic reordering**.

This makes it possible to make charts like the one below, but also means that it may be required to explicitly sort data before passing it to Plotly to avoid lines moving "backwards" across the chart.

In [19]:

```
import plotly.express as px
import pandas as pd

df = pd.DataFrame(dict(
    x = [1, 3, 2, 4],
    y = [1, 2, 3, 4]
))
fig = px.line(df, x="x", y="y", title="Unsorted Input")
fig.show()

df = df.sort_values(by="x")
fig = px.line(df, x="x", y="y", title="Sorted Input")
fig.show()
```

### Connected Scatterplots[¶](#Connected-Scatterplots)

In a connected scatterplot, two continuous variables are plotted against each other, with a line connecting them in some meaningful order, usually a time variable. In the plot below, we show the "trajectory" of a pair of countries through a space defined by GDP per Capita and Life Expectancy. Botswana's life expectancy

In [20]:

```
import plotly.express as px

df = px.data.gapminder().query("country in ['Canada', 'Botswana']")

fig = px.line(df, x="lifeExp", y="gdpPercap", color="country", text="year")
fig.update_traces(textposition="bottom right")
fig.show()
```

### Swarm (or Beeswarm) Plots[¶](#Swarm-(or-Beeswarm)-Plots)

Swarm plots show the distribution of values in a column by giving each entry one dot and adjusting the y-value so that dots do not overlap and appear symmetrically around the y=0 line. They complement [histograms](https://plotly.com/python/histograms/), [box plots](https://plotly.com/python/box-plots/), and [violin plots](https://plotly.com/python/violin/). This example could be generalized to implement a swarm plot for multiple categories by adjusting the y-coordinate for each category.

In [21]:

```
import pandas as pd
import plotly.express as px
import collections

def negative_1_if_count_is_odd(count):
    # if this is an odd numbered entry in its bin, make its y coordinate negative
    # the y coordinate of the first entry is 0, so entries 3, 5, and 7 get
    # negative y coordinates
    if count % 2 == 1:
        return -1
    else:
        return 1

def swarm(
    X_series,
    fig_title,
    point_size=16,
    fig_width=800,
    gap_multiplier=1.2,
    bin_fraction=0.95,  # slightly undersizes the bins to avoid collisions
):
    # sorting will align columns in attractive c-shaped arcs rather than having
    # columns that vary unpredictably in the x-dimension.
    # We also exploit the fact that sorting means we see bins sequentially when
    # we add collision prevention offsets.
    X_series = X_series.copy().sort_values()

    # we need to reason in terms of the marker size that is measured in px
    # so we need to think about each x-coordinate as being a fraction of the way from the
    # minimum X value to the maximum X value
    min_x = min(X_series)
    max_x = max(X_series)

    list_of_rows = []
    # we will count the number of points in each "bin" / vertical strip of the graph
    # to be able to assign a y-coordinate that avoids overlapping
    bin_counter = collections.Counter()

    for x_val in X_series:
        # assign this x_value to bin number
        # each bin is a vertical strip slightly narrower than one marker
        bin = (((fig_width*bin_fraction*(x_val-min_x))/(max_x-min_x)) // point_size)

        # update the count of dots in that strip
        bin_counter.update([bin])

        # remember the "y-slot" which tells us the number of points in this bin and is sufficient to compute the y coordinate unless there's a collision with the point to its left
        list_of_rows.append(
            {"x": x_val, "y_slot": bin_counter[bin], "bin": bin})

    # iterate through the points and "offset" any that are colliding with a
    # point to their left apply the offsets to all subsequent points in the same bin.
    # this arranges points in an attractive swarm c-curve where the points
    # toward the edges are (weakly) further right.
    bin = 0
    offset = 0
    for row in list_of_rows:
        if bin != row["bin"]:
            # we have moved to a new bin, so we need to reset the offset
            bin = row["bin"]
            offset = 0
        # see if we need to "look l