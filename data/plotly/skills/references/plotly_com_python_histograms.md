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
> [Statistical Charts](/python/statistical-charts)
> Histograms

[Suggest an edit to this page](https://github.com/plotly/plotly.py/edit/doc-prod/doc/python/histograms.md)

# Histograms in Python

How to make Histograms in Python with Plotly.

Plotly Studio: Transform any dataset into an interactive data application in minutes with AI. [Try Plotly Studio now.](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=sidebar)

In statistics, a [histogram](https://en.wikipedia.org/wiki/Histogram) is representation of the distribution of numerical data, where the data are binned and the count for each bin is represented. More generally, in Plotly a histogram is an aggregated bar chart, with several possible aggregation functions (e.g. sum, average, count...) which can be used to visualize data on categorical and date axes as well as linear axes.

Alternatives to histogram plots for visualizing distributions include [violin plots](https://plotly.com/python/violin/), [box plots](https://plotly.com/python/box-plots/), [ECDF plots](https://plotly.com/python/ecdf-plots/) and [strip charts](https://plotly.com/python/strip-charts/).

> If you're looking instead for bar charts, i.e. representing *raw, unaggregated* data with rectangular
> bar, go to the [Bar Chart tutorial](/python/bar-charts/).

## Histograms with Plotly Express[¶](#Histograms-with-Plotly-Express)

[Plotly Express](/python/plotly-express/) is the easy-to-use, high-level interface to Plotly, which [operates on a variety of types of data](/python/px-arguments/) and produces [easy-to-style figures](/python/styling-plotly-express/).

In [1]:

```
import plotly.express as px
df = px.data.tips()
fig = px.histogram(df, x="total_bill")
fig.show()
```

In [2]:

```
import plotly.express as px
df = px.data.tips()
# Here we use a column with categorical data
fig = px.histogram(df, x="day")
fig.show()
```

#### Choosing the number of bins[¶](#Choosing-the-number-of-bins)

By default, the number of bins is chosen so that this number is comparable to the typical number of samples in a bin. This number can be customized, as well as the range of values.

In [3]:

```
import plotly.express as px
df = px.data.tips()
fig = px.histogram(df, x="total_bill", nbins=20)
fig.show()
```

### Histograms on Date Data[¶](#Histograms-on-Date-Data)

Plotly histograms will automatically bin date data in addition to numerical data:

In [4]:

```
import plotly.express as px

df = px.data.stocks()
fig = px.histogram(df, x="date")
fig.update_layout(bargap=0.2)
fig.show()
```

### Histograms on Categorical Data[¶](#Histograms-on-Categorical-Data)

Plotly histograms will automatically bin numerical or date data but can also be used on raw categorical data, as in the following example, where the X-axis value is the categorical "day" variable:

In [5]:

```
import plotly.express as px
df = px.data.tips()
fig = px.histogram(df, x="day", category_orders=dict(day=["Thur", "Fri", "Sat", "Sun"]))
fig.show()
```

#### Histograms in Dash[¶](#Histograms-in-Dash)

[Dash](https://plotly.com/dash/) is the best way to build analytical apps in Python using Plotly figures. To run the app below, run `pip install dash`, click "Download" to get the code and run `python app.py`.

Get started with [the official Dash docs](https://dash.plotly.com/installation) and **learn how to effortlessly [style](https://plotly.com/dash/design-kit/) & publish apps like this with [Dash Enterprise](https://plotly.com/dash/) or [Plotly Cloud](https://plotly.com/cloud/).**

Out[6]:

**Sign up for Dash Club** → Free cheat sheets plus updates from Chris Parmer and Adam Schroeder delivered to your inbox every two months. Includes tips and tricks, community apps, and deep dives into the Dash architecture.
[Join now](https://go.plotly.com/dash-club?utm_source=Dash+Club+2022&utm_medium=graphing_libraries&utm_content=inline).

#### Accessing the counts (y-axis) values[¶](#Accessing-the-counts-(y-axis)-values)

JavaScript calculates the y-axis (count) values on the fly in the browser, so it's not accessible in the `fig`. You can manually calculate it using `np.histogram`.

In [7]:

```
import plotly.express as px
import numpy as np

df = px.data.tips()
# create the bins
counts, bins = np.histogram(df.total_bill, bins=range(0, 60, 5))
bins = 0.5 * (bins[:-1] + bins[1:])

fig = px.bar(x=bins, y=counts, labels={'x':'total_bill', 'y':'count'})
fig.show()
```

#### Type of normalization[¶](#Type-of-normalization)

The default mode is to represent the count of samples in each bin. With the `histnorm` argument, it is also possible to represent the percentage or fraction of samples in each bin (`histnorm='percent'` or `probability`), or a density histogram (the sum of all bar areas equals the total number of sample points, `density`), or a probability density histogram (the sum of all bar areas equals 1, `probability density`).

In [8]:

```
import plotly.express as px
df = px.data.tips()
fig = px.histogram(df, x="total_bill", histnorm='probability density')
fig.show()
```

#### Aspect of the histogram plot[¶](#Aspect-of-the-histogram-plot)

In [9]:

```
import plotly.express as px
df = px.data.tips()
fig = px.histogram(df, x="total_bill",
                   title='Histogram of bills',
                   labels={'total_bill':'total bill'}, # can specify one label per df column
                   opacity=0.8,
                   log_y=True, # represent bars with log scale
                   color_discrete_sequence=['indianred'] # color of histogram bars
                   )
fig.show()
```

#### Several histograms for the different values of one column[¶](#Several-histograms-for-the-different-values-of-one-column)

In [10]:

```
import plotly.express as px
df = px.data.tips()
fig = px.histogram(df, x="total_bill", color="sex")
fig.show()
```

#### Aggregating with other functions than `count`[¶](#Aggregating-with-other-functions-than-count)

For each bin of `x`, one can compute a function of data using `histfunc`. The argument of `histfunc` is the dataframe column given as the `y` argument. Below the plot shows that the average tip increases with the total bill.

In [11]:

```
import plotly.express as px
df = px.data.tips()
fig = px.histogram(df, x="total_bill", y="tip", histfunc='avg')
fig.show()
```

The default `histfunc` is `sum` if `y` is given, and works with categorical as well as binned numeric data on the `x` axis:

In [12]:

```
import plotly.express as px
df = px.data.tips()
fig = px.histogram(df, x="day", y="total_bill", category_orders=dict(day=["Thur", "Fri", "Sat", "Sun"]))
fig.show()
```

*New in v5.0*

Histograms afford the use of [patterns (also known as hatching or texture)](/python/pattern-hatching-texture/) in addition to color:

In [13]:

```
import plotly.express as px

df = px.data.tips()
fig = px.histogram(df, x="sex", y="total_bill", color="sex", pattern_shape="smoker")
fig.show()
```

#### Visualizing the distribution[¶](#Visualizing-the-distribution)

With the `marginal` keyword, a [marginal](https://plotly.com/python/marginal-plots/) is drawn alongside the histogram, visualizing the distribution. See [the distplot page](https://plotly.com/python/distplot/) for more examples of combined statistical representations.

In [14]:

```
import plotly.express as px
df = px.data.tips()
fig = px.histogram(df, x="total_bill", color="sex", marginal="rug", # can be `box`, `violin`
                         hover_data=df.columns)
fig.show()
```

### Adding text labels[¶](#Adding-text-labels)

*New in v5.5*

You can add text to histogram bars using the `text_auto` argument. Setting it to `True` will display the values on the bars, and setting it to a `d3-format` formatting string will control the output format.

In [15]:

```
import plotly.express as px
df = px.data.tips()
fig = px.histogram(df, x="total_bill", y="tip", histfunc="avg", nbins=8, text_auto=True)
fig.show()
```

## Histograms with go.Histogram[¶](#Histograms-with-go.Histogram)

If Plotly Express does not provide a good starting point, it is also possible to use [the more generic `go.Histogram` class from `plotly.graph_objects`](/python/graph-objects/). All of the available histogram options are described in the histogram section of the reference page: <https://plotly.com/python/reference#histogram>.

### Basic Histogram[¶](#Basic-Histogram)

In [16]:

```
import plotly.graph_objects as go

import numpy as np
np.random.seed(1)

x = np.random.randn(500)

fig = go.Figure(data=[go.Histogram(x=x)])
fig.show()
```

### Normalized Histogram[¶](#Normalized-Histogram)

In [17]:

```
import plotly.graph_objects as go

import numpy as np

x = np.random.randn(500)
fig = go.Figure(data=[go.Histogram(x=x, histnorm='probability')])

fig.show()
```

### Horizontal Histogram[¶](#Horizontal-Histogram)

In [18]:

```
import plotly.graph_objects as go

import numpy as np

y = np.random.randn(500)
# Use `y` argument instead of `x` for horizontal histogram

fig = go.Figure(data=[go.Histogram(y=y)])
fig.show()
```

### Overlaid Histogram[¶](#Overlaid-Histogram)

In [19]:

```
import plotly.graph_objects as go

import numpy as np

x0 = np.random.randn(500)
# Add 1 to shift the mean of the Gaussian distribution
x1 = np.random.randn(500) + 1

fig = go.Figure()
fig.add_trace(go.Histogram(x=x0))
fig.add_trace(go.Histogram(x=x1))

# Overlay both histograms
fig.update_layout(barmode='overlay')
# Reduce opacity to see both histograms
fig.update_traces(opacity=0.75)
fig.show()
```

### Stacked Histograms[¶](#Stacked-Histograms)

In [20]:

```
import plotly.graph_objects as go

import numpy as np

x0 = np.random.randn(2000)
x1 = np.random.randn(2000) + 1

fig = go.Figure()
fig.add_trace(go.Histogram(x=x0))
fig.add_trace(go.Histogram(x=x1))

# The two histograms are drawn on top of another
fig.update_layout(barmode='stack')
fig.show()
```

### Styled Histogram[¶](#Styled-Histogram)

In [21]:

```
import plotly.graph_objects as go

import numpy as np
x0 = np.random.randn(500)
x1 = np.random.randn(500) + 1

fig = go.Figure()
fig.add_trace(go.Histogram(
    x=x0,
    histnorm='percent',
    name='control', # name used in legend and hover labels
    xbins=dict( # bins used for histogram
        start=-4.0,
        end=3.0,
        size=0.5
    ),
    marker_color='#EB89B5',
    opacity=0.75
))
fig.add_trace(go.Histogram(
    x=x1,
    histnorm='percent',
    name='experimental',
    xbins=dict(
        start=-3.0,
        end=4,
        size=0.5
    ),
    marker_color='#330C73',
    opacity=0.75
))

fig.update_layout(
    title_text='Sampled Results', # title of plot
    xaxis_title_text='Value', # xaxis label
    yaxis_title_text='Count', # yaxis label
    bargap=0.2, # gap between bars of adjacent location coordinates
    bargroupgap=0.1 # gap between bars of the same location coordinates
)

fig.show()
```

### Histogram Bar Text[¶](#Histogram-Bar-Text)

You can add text to histogram bars using the `texttemplate` argument. In this example we add the x-axis values as text following the format `%{variable}`. We also adjust the size of the text using `textfont_size`.

In [22]:

```
import plotly.graph_objects as go

numbers = ["5", "10", "3", "10", "5", "8", "5", "5"]

fig = go.Figure()
fig.add_trace(go.Histogram(x=numbers, name="count", texttemplate="%{x}", textfont_size=20))

fig.show()
```

### Cumulative Histogram[¶](#Cumulative-Histogram)

In [23]:

```
import plotly.graph_objects as go

import numpy as np

x = np.random.randn(500)
fig = go.Figure(data=[go.Histogram(x=x, cumulative_enabled=True)])

fig.show()
```

### Specify Aggregation Function[¶](#Specify-Aggregation-Function)

In [24]:

```
import plotly.graph_objects as go

x = ["Apples","Apples","Apples","Oranges", "Bananas"]
y = ["5","10","3","10","5"]

fig = go.Figure()
fig.add_trace(go.Histogram(histfunc="count", y=y, x=x, name="count"))
fig.add_trace(go.Histogram(histfunc="sum", y=y, x=x, name="sum"))

fig.show()
```

### Custom Binning[¶](#Custom-Binning)

For custom binning along x-axis, use the attribute [`nbinsx`](https://plotly.com/python/reference/histogram/#histogram-nbinsx). Please note that the autobin algorithm will choose a 'nice' round bin size that may result in somewhat fewer than `nbinsx` total bins. Alternatively, you can set the exact values for [`xbins`](https://plotly.com/python/reference/histogram/#histogram-xbins) along with `autobinx = False`.

In [25]:

```
import plotly.graph_objects as go
from plotly.subplots import make_subplots

x = ['1970-01-01', '1970-01-01', '1970-02-01', '1970-04-01', '1970-01-02',
     '1972-01-31', '1970-02-13', '1971-04-19']

fig = make_subplots(rows=3, cols=2)

trace0 = go.Histogram(x=x, nbinsx=4)
trace1 = go.Histogram(x=x, nbinsx = 8)
trace2 = go.Histogram(x=x, nbinsx=10)
trace3 = go.Histogram(x=x,
                      xbins=dict(
         