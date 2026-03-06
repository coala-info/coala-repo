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
> Pie Charts

[Suggest an edit to this page](https://github.com/plotly/plotly.py/edit/doc-prod/doc/python/pie-charts.md)

# Pie Charts in Python

How to make Pie Charts.

Plotly Studio: Transform any dataset into an interactive data application in minutes with AI. [Try Plotly Studio now.](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=sidebar)

A pie chart is a circular statistical chart, which is divided into sectors to illustrate numerical proportion.

If you're looking instead for a multilevel hierarchical pie-like chart, go to the
[Sunburst tutorial](/python/sunburst-charts/).

### Pie chart with plotly express[¶](#Pie-chart-with-plotly-express)

[Plotly Express](/python/plotly-express/) is the easy-to-use, high-level interface to Plotly, which [operates on a variety of types of data](/python/px-arguments/) and produces [easy-to-style figures](/python/styling-plotly-express/).

In `px.pie`, data visualized by the sectors of the pie is set in `values`. The sector labels are set in `names`.

In [1]:

```
import plotly.express as px
df = px.data.gapminder().query("year == 2007").query("continent == 'Europe'")
df.loc[df['pop'] < 2.e6, 'country'] = 'Other countries' # Represent only large countries
fig = px.pie(df, values='pop', names='country', title='Population of European continent')
fig.show()
```

### Pie chart with repeated labels[¶](#Pie-chart-with-repeated-labels)

Lines of the dataframe with the same value for `names` are grouped together in the same sector.

In [2]:

```
import plotly.express as px
# This dataframe has 244 lines, but 4 distinct values for `day`
df = px.data.tips()
fig = px.pie(df, values='tip', names='day')
fig.show()
```

### Pie chart in Dash[¶](#Pie-chart-in-Dash)

[Dash](https://plotly.com/dash/) is the best way to build analytical apps in Python using Plotly figures. To run the app below, run `pip install dash`, click "Download" to get the code and run `python app.py`.

Get started with [the official Dash docs](https://dash.plotly.com/installation) and **learn how to effortlessly [style](https://plotly.com/dash/design-kit/) & publish apps like this with [Dash Enterprise](https://plotly.com/dash/) or [Plotly Cloud](https://plotly.com/cloud/).**

Out[3]:

**Sign up for Dash Club** → Free cheat sheets plus updates from Chris Parmer and Adam Schroeder delivered to your inbox every two months. Includes tips and tricks, community apps, and deep dives into the Dash architecture.
[Join now](https://go.plotly.com/dash-club?utm_source=Dash+Club+2022&utm_medium=graphing_libraries&utm_content=inline).

### Setting the color of pie sectors with px.pie[¶](#Setting-the-color-of-pie-sectors-with-px.pie)

In [4]:

```
import plotly.express as px
df = px.data.tips()
fig = px.pie(df, values='tip', names='day', color_discrete_sequence=px.colors.sequential.RdBu)
fig.show()
```

### Using an explicit mapping for discrete colors[¶](#Using-an-explicit-mapping-for-discrete-colors)

For more information about discrete colors, see the [dedicated page](/python/discrete-color).

In [5]:

```
import plotly.express as px
df = px.data.tips()
fig = px.pie(df, values='tip', names='day', color='day',
             color_discrete_map={'Thur':'lightcyan',
                                 'Fri':'cyan',
                                 'Sat':'royalblue',
                                 'Sun':'darkblue'})
fig.show()
```

### Customizing a pie chart created with px.pie[¶](#Customizing-a-pie-chart-created-with-px.pie)

In the example below, we first create a pie chart with `px,pie`, using some of its options such as `hover_data` (which columns should appear in the hover) or `labels` (renaming column names). For further tuning, we call `fig.update_traces` to set other parameters of the chart (you can also use `fig.update_layout` for changing the layout).

In [6]:

```
import plotly.express as px
df = px.data.gapminder().query("year == 2007").query("continent == 'Americas'")
fig = px.pie(df, values='pop', names='country',
             title='Population of American continent',
             hover_data=['lifeExp'], labels={'lifeExp':'life expectancy'})
fig.update_traces(textposition='inside', textinfo='percent+label')
fig.show()
```

### Basic Pie Chart with go.Pie[¶](#Basic-Pie-Chart-with-go.Pie)

If Plotly Express does not provide a good starting point, it is also possible to use [the more generic `go.Pie` class from `plotly.graph_objects`](/python/graph-objects/).

In `go.Pie`, data visualized by the sectors of the pie is set in `values`. The sector labels are set in `labels`. The sector colors are set in `marker.colors`.

If you're looking instead for a multilevel hierarchical pie-like chart, go to the
[Sunburst tutorial](/python/sunburst-charts/).

In [7]:

```
import plotly.graph_objects as go

labels = ['Oxygen','Hydrogen','Carbon_Dioxide','Nitrogen']
values = [4500, 2500, 1053, 500]

fig = go.Figure(data=[go.Pie(labels=labels, values=values)])
fig.show()
```

### Styled Pie Chart[¶](#Styled-Pie-Chart)

Colors can be given as RGB triplets or hexadecimal strings, or with [CSS color names](https://www.w3schools.com/cssref/css_colors.asp) as below.

In [8]:

```
import plotly.graph_objects as go
colors = ['gold', 'mediumturquoise', 'darkorange', 'lightgreen']

fig = go.Figure(data=[go.Pie(labels=['Oxygen','Hydrogen','Carbon_Dioxide','Nitrogen'],
                             values=[4500,2500,1053,500])])
fig.update_traces(hoverinfo='label+percent', textinfo='value', textfont_size=20,
                  marker=dict(colors=colors, line=dict(color='#000000', width=2)))
fig.show()
```

### Controlling text fontsize with uniformtext[¶](#Controlling-text-fontsize-with-uniformtext)

If you want all the text labels to have the same size, you can use the `uniformtext` layout parameter. The `minsize` attribute sets the font size, and the `mode` attribute sets what happens for labels which cannot fit with the desired fontsize: either `hide` them or `show` them with overflow. In the example below we also force the text to be inside with `textposition`, otherwise text labels which do not fit are displayed outside of pie sectors.

In [9]:

```
import plotly.express as px

df = px.data.gapminder().query("continent == 'Asia'")
fig = px.pie(df, values='pop', names='country')
fig.update_traces(textposition='inside')
fig.update_layout(uniformtext_minsize=12, uniformtext_mode='hide')
fig.show()
```

#### Controlling text orientation inside pie sectors[¶](#Controlling-text-orientation-inside-pie-sectors)

The `insidetextorientation` attribute controls the orientation of text inside sectors. With
"auto" the texts may automatically be rotated to fit with the maximum size inside the slice. Using "horizontal" (resp. "radial", "tangential") forces text to be horizontal (resp. radial or tangential)

For a figure `fig` created with plotly express, use `fig.update_traces(insidetextorientation='...')` to change the text orientation.

In [10]:

```
import plotly.graph_objects as go

labels = ['Oxygen','Hydrogen','Carbon_Dioxide','Nitrogen']
values = [4500, 2500, 1053, 500]

fig = go.Figure(data=[go.Pie(labels=labels, values=values, textinfo='label+percent',
                             insidetextorientation='radial'
                            )])
fig.show()
```

### Donut Chart[¶](#Donut-Chart)

In [11]:

```
import plotly.graph_objects as go

labels = ['Oxygen','Hydrogen','Carbon_Dioxide','Nitrogen']
values = [4500, 2500, 1053, 500]

# Use `hole` to create a donut-like pie chart
fig = go.Figure(data=[go.Pie(labels=labels, values=values, hole=.3)])
fig.show()
```

### Pulling sectors out from the center[¶](#Pulling-sectors-out-from-the-center)

For a "pulled-out" or "exploded" layout of the pie chart, use the `pull` argument. It can be a scalar for pulling all sectors or an array to pull only some of the sectors.

In [12]:

```
import plotly.graph_objects as go

labels = ['Oxygen','Hydrogen','Carbon_Dioxide','Nitrogen']
values = [4500, 2500, 1053, 500]

# pull is given as a fraction of the pie radius
fig = go.Figure(data=[go.Pie(labels=labels, values=values, pull=[0, 0, 0.2, 0])])
fig.show()
```

### Pie Charts in subplots[¶](#Pie-Charts-in-subplots)

In [13]:

```
import plotly.graph_objects as go
from plotly.subplots import make_subplots

labels = ["US", "China", "European Union", "Russian Federation", "Brazil", "India",
          "Rest of World"]

# Create subplots: use 'domain' type for Pie subplot
fig = make_subplots(rows=1, cols=2, specs=[[{'type':'domain'}, {'type':'domain'}]])
fig.add_trace(go.Pie(labels=labels, values=[16, 15, 12, 6, 5, 4, 42], name="GHG Emissions"),
              1, 1)
fig.add_trace(go.Pie(labels=labels, values=[27, 11, 25, 8, 1, 3, 25], name="CO2 Emissions"),
              1, 2)

# Use `hole` to create a donut-like pie chart
fig.update_traces(hole=.4, hoverinfo="label+percent+name")

fig.update_layout(
    title_text="Global Emissions 1990-2011",
    # Add annotations in the center of the donut pies.
    annotations=[dict(text='GHG', x=sum(fig.get_subplot(1, 1).x) / 2, y=0.5,
                      font_size=20, showarrow=False, xanchor="center"),
                 dict(text='CO2', x=sum(fig.get_subplot(1, 2).x) / 2, y=0.5,
                      font_size=20, showarrow=False, xanchor="center")])
fig.show()
```

In [14]:

```
import plotly.graph_objects as go
from plotly.subplots import make_subplots

labels = ['1st', '2nd', '3rd', '4th', '5th']

# Define color sets of paintings
night_colors = ['rgb(56, 75, 126)', 'rgb(18, 36, 37)', 'rgb(34, 53, 101)',
                'rgb(36, 55, 57)', 'rgb(6, 4, 4)']
sunflowers_colors = ['rgb(177, 127, 38)', 'rgb(205, 152, 36)', 'rgb(99, 79, 37)',
                     'rgb(129, 180, 179)', 'rgb(124, 103, 37)']
irises_colors = ['rgb(33, 75, 99)', 'rgb(79, 129, 102)', 'rgb(151, 179, 100)',
                 'rgb(175, 49, 35)', 'rgb(36, 73, 147)']
cafe_colors =  ['rgb(146, 123, 21)', 'rgb(177, 180, 34)', 'rgb(206, 206, 40)',
                'rgb(175, 51, 21)', 'rgb(35, 36, 21)']

# Create subplots, using 'domain' type for pie charts
specs = [[{'type':'domain'}, {'type':'domain'}], [{'type':'domain'}, {'type':'domain'}]]
fig = make_subplots(rows=2, cols=2, specs=specs)

# Define pie charts
fig.add_trace(go.Pie(labels=labels, values=[38, 27, 18, 10, 7], name='Starry Night',
                     marker_colors=night_colors), 1, 1)
fig.add_trace(go.Pie(labels=labels, values=[28, 26, 21, 15, 10], name='Sunflowers',
                     marker_colors=sunflowers_colors), 1, 2)
fig.add_trace(go.Pie(labels=labels, values=[38, 19, 16, 14, 13], name='Irises',
                     marker_colors=irises_colors), 2, 1)
fig.add_trace(go.Pie(labels=labels, values=[31, 24, 19, 18, 8], name='The Night Café',
                     marker_colors=cafe_colors), 2, 2)

# Tune layout and hover info
fig.update_traces(hoverinfo='label+percent+name', textinfo='none')
fig.update(layout_title_text='Van Gogh: 5 Most Prominent Colors Shown Proportionally',
           layout_showlegend=False)

fig = go.Figure(fig)
fig.show()
```

#### Plot chart with area proportional to total count[¶](#Plot-chart-with-area-proportional-to-total-count)

Plots in the same `scalegroup` are represented with an area proportional to their total size.

In [15]:

```
import plotly.graph_objects as go
from plotly.subplots import make_subplots

labels = ["Asia", "Europe", "Africa", "Americas", "Oceania"]

fig = make_subplots(1, 2, specs=[[{'type':'domain'}, {'type':'domain'}]],
                    subplot_titles=['1980', '2007'])
fig.add_trace(go.Pie(labels=labels, values=[4, 7, 1, 7, 0.5], scalegroup='one',
                     name="World GDP 1980"), 1, 1)
fig.add_trace(go.Pie(labels=labels, values=[21, 15, 3, 19, 1], scalegroup='one',
                     name="World GDP 2007"), 1, 2)

fig.update_layout(title_text='World GDP')
fig.show()
```

### Pattern Fills[¶](#Pattern-Fills)

*New in 5.15*

Pie charts support [patterns](/python/pattern-hatching-texture/) (also known as hatching or texture) in addition to color.

In [16]:

```
import plotly.graph_objects as go

labels = ["Oxygen", "Hydrogen", "Carbon_Dioxide", "Nitrogen"]
values = [4500, 2500, 1053, 500]
colors = ["gold", "mediumturquoise", "darkorange", "lightgreen"]

fig = go.Figure(
    data=[
        go.Pie(
            labels=labels,
            values=values,
            textfont_size=20,
            marker=dict(colors=colors, pattern=dict(shape=[".", "x", "+", "-"]))
        )
    ]
)

fig.show()
```

### See Also: Sunburst charts[¶](#See-Also:-Sunburst-charts)

For multilevel pie charts representing hierarchical data, you can use the `Sunburst` chart. A simple example is given below, for more information see the [tutorial on Sunburst charts](/python/sunburst-charts/).

In [17]:

```
import pl