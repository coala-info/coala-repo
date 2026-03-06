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
> Bar Charts

[Suggest an edit to this page](https://github.com/plotly/plotly.py/edit/doc-prod/doc/python/bar-charts.md)

# Bar Charts in Python

How to make Bar Charts in Python with Plotly.

Plotly Studio: Transform any dataset into an interactive data application in minutes with AI. [Try Plotly Studio now.](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=sidebar)

### Bar chart with Plotly Express[¶](#Bar-chart-with-Plotly-Express)

[Plotly Express](/python/plotly-express/) is the easy-to-use, high-level interface to Plotly, which [operates on a variety of types of data](/python/px-arguments/) and produces [easy-to-style figures](/python/styling-plotly-express/).

With `px.bar`, **each row of the DataFrame is represented as a rectangular mark**. To aggregate multiple data points into the same rectangular mark, please refer to the [histogram documentation](/python/histograms).

In the example below, there is only a single row of data per year, so a single bar is displayed per year.

In [1]:

```
import plotly.express as px
data_canada = px.data.gapminder().query("country == 'Canada'")
fig = px.bar(data_canada, x='year', y='pop')
fig.show()
```

#### Bar charts with Long Format Data[¶](#Bar-charts-with-Long-Format-Data)

Long-form data has one row per observation, and one column per variable. This is suitable for storing and displaying multivariate data i.e. with dimension greater than 2. This format is sometimes called "tidy".

To learn more about how to provide a specific form of column-oriented data to 2D-Cartesian Plotly Express functions such as `px.bar`, see the [Plotly Express Wide-Form Support in Python
documentation](https://plotly.com/python/wide-form/).

For detailed column-input-format documentation, see the [Plotly Express Arguments documentation](https://plotly.com/python/px-arguments/).

In [2]:

```
import plotly.express as px

long_df = px.data.medals_long()

fig = px.bar(long_df, x="nation", y="count", color="medal", title="Long-Form Input")
fig.show()
```

In [3]:

```
long_df
```

Out[3]:

|  | nation | medal | count |
| --- | --- | --- | --- |
| 0 | South Korea | gold | 24 |
| 1 | China | gold | 10 |
| 2 | Canada | gold | 9 |
| 3 | South Korea | silver | 13 |
| 4 | China | silver | 15 |
| 5 | Canada | silver | 12 |
| 6 | South Korea | bronze | 11 |
| 7 | China | bronze | 8 |
| 8 | Canada | bronze | 12 |

#### Bar charts with Wide Format Data[¶](#Bar-charts-with-Wide-Format-Data)

Wide-form data has one row per value of one of the first variable, and one column per value of the second variable. This is suitable for storing and displaying 2-dimensional data.

In [4]:

```
import plotly.express as px

wide_df = px.data.medals_wide()

fig = px.bar(wide_df, x="nation", y=["gold", "silver", "bronze"], title="Wide-Form Input")
fig.show()
```

In [5]:

```
wide_df
```

Out[5]:

|  | nation | gold | silver | bronze |
| --- | --- | --- | --- | --- |
| 0 | South Korea | 24 | 13 | 11 |
| 1 | China | 10 | 15 | 8 |
| 2 | Canada | 9 | 12 | 12 |

### Bar charts in Dash[¶](#Bar-charts-in-Dash)

[Dash](https://plotly.com/dash/) is the best way to build analytical apps in Python using Plotly figures. To run the app below, run `pip install dash`, click "Download" to get the code and run `python app.py`.

Get started with [the official Dash docs](https://dash.plotly.com/installation) and **learn how to effortlessly [style](https://plotly.com/dash/design-kit/) & publish apps like this with [Dash Enterprise](https://plotly.com/dash/) or [Plotly Cloud](https://plotly.com/cloud/).**

Out[6]:

**Sign up for Dash Club** → Free cheat sheets plus updates from Chris Parmer and Adam Schroeder delivered to your inbox every two months. Includes tips and tricks, community apps, and deep dives into the Dash architecture.
[Join now](https://go.plotly.com/dash-club?utm_source=Dash+Club+2022&utm_medium=graphing_libraries&utm_content=inline).

### Colored Bars[¶](#Colored-Bars)

The bar plot can be customized using keyword arguments, for example to use [continuous color](https://plotly.com/python/colorscales/), as below, or [discrete color](/python/discrete-color/), as above.

In [7]:

```
import plotly.express as px

df = px.data.gapminder().query("country == 'Canada'")
fig = px.bar(df, x='year', y='pop',
             hover_data=['lifeExp', 'gdpPercap'], color='lifeExp',
             labels={'pop':'population of Canada'}, height=400)
fig.show()
```

In [8]:

```
import plotly.express as px

df = px.data.gapminder().query("continent == 'Oceania'")
fig = px.bar(df, x='year', y='pop',
             hover_data=['lifeExp', 'gdpPercap'], color='country',
             labels={'pop':'population of Oceania'}, height=400)
fig.show()
```

### Stacked vs Grouped Bars[¶](#Stacked-vs-Grouped-Bars)

When several rows share the same value of `x` (here Female or Male), the rectangles are stacked on top of one another by default.

In [9]:

```
import plotly.express as px
df = px.data.tips()
fig = px.bar(df, x="sex", y="total_bill", color='time')
fig.show()
```

The default stacked bar chart behavior can be changed to grouped (also known as clustered) using the `barmode` argument:

In [10]:

```
import plotly.express as px
df = px.data.tips()
fig = px.bar(df, x="sex", y="total_bill",
             color='smoker', barmode='group',
             height=400)
fig.show()
```

### Aggregating into Single Colored Bars[¶](#Aggregating-into-Single-Colored-Bars)

As noted above `px.bar()` will result in **one rectangle drawn per row of input**. This can sometimes result in a striped look as in the examples above. To combine these rectangles into one per color per position, you can use `px.histogram()`, which has [its own detailed documentation page](/python/histogram).

> `px.bar` and `px.histogram` are designed to be nearly interchangeable in their call signatures, so as to be able to switch between aggregated and disaggregated bar representations.

In [11]:

```
import plotly.express as px
df = px.data.tips()
fig = px.histogram(df, x="sex", y="total_bill",
             color='smoker', barmode='group',
             height=400)
fig.show()
```

`px.histogram()` will aggregate `y` values by summing them by default, but the `histfunc` argument can be used to set this to `avg` to create what is sometimes called a "barplot" which summarizes the central tendency of a dataset, rather than visually representing the totality of the dataset.

> Warning: when using `histfunc`s other than `"sum"` or `"count"` it can be very misleading to use a `barmode` other than `"group"`, as stacked bars in effect represent the sum of the bar heights, and summing averages is rarely a reasonable thing to visualize.

In [12]:

```
import plotly.express as px
df = px.data.tips()
fig = px.histogram(df, x="sex", y="total_bill",
             color='smoker', barmode='group',
             histfunc='avg',
             height=400)
fig.show()
```

### Bar Charts with Text[¶](#Bar-Charts-with-Text)

*New in v5.5*

You can add text to bars using the `text_auto` argument. Setting it to `True` will display the values on the bars, and setting it to a `d3-format` formatting string will control the output format.

In [13]:

```
import plotly.express as px
df = px.data.medals_long()

fig = px.bar(df, x="medal", y="count", color="nation", text_auto=True)
fig.show()
```

The `text` argument can be used to display arbitrary text on the bars:

In [14]:

```
import plotly.express as px
df = px.data.medals_long()

fig = px.bar(df, x="medal", y="count", color="nation", text="nation")
fig.show()
```

By default, Plotly will scale and rotate text labels to maximize the number of visible labels, which can result in a variety of text angles and sizes and positions in the same figure. The `textfont`, `textposition` and `textangle` trace attributes can be used to control these.

Here is an example of the default behavior:

In [15]:

```
import plotly.express as px

df = px.data.gapminder().query("continent == 'Europe' and year == 2007 and pop > 2.e6")
fig = px.bar(df, y='pop', x='country', text_auto='.2s',
            title="Default: various text sizes, positions and angles")
fig.show()
```

Here is the same data with less variation in text formatting. Note that `textfont_size` will set the *maximum* size. The `layout.uniformtext` attribute can be used to guarantee that all text labels are the same size. See the [documentation on text and annotations](/python/text-and-annotations/) for details.

The `cliponaxis` attribute is set to `False` in the example below to ensure that the outside text on the tallest bar is allowed to render outside of the plotting area.

In [16]:

```
import plotly.express as px

df = px.data.gapminder().query("continent == 'Europe' and year == 2007 and pop > 2.e6")
fig = px.bar(df, y='pop', x='country', text_auto='.2s',
            title="Controlled text sizes, positions and angles")
fig.update_traces(textfont_size=12, textangle=0, textposition="outside", cliponaxis=False)
fig.show()
```

### Pattern Fills[¶](#Pattern-Fills)

*New in v5.0*

Bar charts afford the use of [patterns (also known as hatching or texture)](/python/pattern-hatching-texture/) in addition to color:

In [17]:

```
import plotly.express as px
df = px.data.medals_long()

fig = px.bar(df, x="medal", y="count", color="nation",
             pattern_shape="nation", pattern_shape_sequence=[".", "x", "+"])
fig.show()
```

### Facetted subplots[¶](#Facetted-subplots)

Use the keyword arguments `facet_row` (resp. `facet_col`) to create facetted subplots, where different rows (resp. columns) correspond to different values of the dataframe column specified in `facet_row`.

In [18]:

```
import plotly.express as px
df = px.data.tips()
fig = px.bar(df, x="sex", y="total_bill", color="smoker", barmode="group",
             facet_row="time", facet_col="day",
             category_orders={"day": ["Thur", "Fri", "Sat", "Sun"],
                              "time": ["Lunch", "Dinner"]})
fig.show()
```

#### Basic Bar Charts with plotly.graph\_objects[¶](#Basic-Bar-Charts-with-plotly.graph_objects)

If Plotly Express does not provide a good starting point, it is also possible to use [the more generic `go.Bar` class from `plotly.graph_objects`](/python/graph-objects/).

In [19]:

```
import plotly.graph_objects as go
animals=['giraffes', 'orangutans', 'monkeys']

fig = go.Figure([go.Bar(x=animals, y=[20, 14, 23])])
fig.show()
```

#### Grouped Bar Chart[¶](#Grouped-Bar-Chart)

Customize the figure using `fig.update`.

In [20]:

```
import plotly.graph_objects as go
animals=['giraffes', 'orangutans', 'monkeys']

fig = go.Figure(data=[
    go.Bar(name='SF Zoo', x=animals, y=[20, 14, 23]),
    go.Bar(name='LA Zoo', x=animals, y=[12, 18, 29])
])
# Change the bar mode
fig.update_layout(barmode='group')
fig.show()
```

### Stacked Bar Chart[¶](#Stacked-Bar-Chart)

In [21]:

```
import plotly.graph_objects as go
animals=['giraffes', 'orangutans', 'monkeys']

fig = go.Figure(data=[
    go.Bar(name='SF Zoo', x=animals, y=[20, 14, 23]),
    go.Bar(name='LA Zoo', x=animals, y=[12, 18, 29])
])
# Change the bar mode
fig.update_layout(barmode='stack')
fig.show()
```

### Bar Chart with Relative Barmode[¶](#Bar-Chart-with-Relative-Barmode)

With "relative" barmode, the bars are stacked on top of one another, with negative values
below the axis and positive values above.

In [22]:

```
import plotly.graph_objects as go
x = [1, 2, 3, 4]

fig = go.Figure()
fig.add_trace(go.Bar(x=x, y=[1, 4, 9, 16]))
fig.add_trace(go.Bar(x=x, y=[6, -8, -4.5, 8]))
fig.add_trace(go.Bar(x=x, y=[-15, -3, 4.5, -8]))
fig.add_trace(go.Bar(x=x, y=[-1, 3, -3, -4]))

fig.update_layout(barmode='relative', title_text='Relative Barmode')
fig.show()
```

### Grouped Stacked Bar Chart[¶](#Grouped-Stacked-Bar-Chart)

*Supported in Plotly.py 6.0.0 and later*

Use the `offsetgroup` property with `barmode="stacked"` or `barmode="relative"` to create grouped stacked bar charts. Bars that have the same `offsetgroup` will share the same position on the axis. Bars with no `offsetgroup` set will also share the same position on the axis. In the following example, for each quarter, the value for cities that belong to the same `offsetgroup` are stacked together.

In [23]:

```
import plotly.graph_objects as go

data = [
    go.Bar(
        x=['Q1', 'Q2', 'Q3', 'Q4'],
        y=[150, 200, 250, 300],
        name='New York',
        offsetgroup="USA"
    ),
    go.Bar(
        x=['Q1', 'Q2', 'Q3', 'Q4'],
        y=[180, 220, 270, 320],
        name='Boston',
        offsetgroup="USA"
    ),
    go.Bar(
        x=['Q1', 'Q2', 'Q3', 'Q4'],
        y=[130, 170, 210, 260],
        name='Montreal',
        offsetgroup="Canada"
    ),
    go.Bar(
        x=['Q1', 'Q2', 'Q3', 'Q4'],
        y=[160, 210, 260, 3