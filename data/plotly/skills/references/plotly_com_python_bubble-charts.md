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
> Bubble Charts

[Suggest an edit to this page](https://github.com/plotly/plotly.py/edit/doc-prod/doc/python/bubble-charts.md)

# Bubble Charts in Python

How to make bubble charts in Python with Plotly.

Plotly Studio: Transform any dataset into an interactive data application in minutes with AI. [Try Plotly Studio now.](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=sidebar)

## Bubble chart with plotly.express[¶](#Bubble-chart-with-plotly.express)

A [bubble chart](https://en.wikipedia.org/wiki/Bubble_chart) is a scatter plot in which a third dimension of the data is shown through the size of markers. For other types of scatter plot, see the [scatter plot documentation](https://plotly.com/python/line-and-scatter/).

We first show a bubble chart example using Plotly Express. [Plotly Express](/python/plotly-express/) is the easy-to-use, high-level interface to Plotly, which [operates on a variety of types of data](/python/px-arguments/) and produces [easy-to-style figures](/python/styling-plotly-express/). The size of markers is set from the dataframe column given as the `size` parameter.

In [1]:

```
import plotly.express as px
df = px.data.gapminder()

fig = px.scatter(df.query("year==2007"), x="gdpPercap", y="lifeExp",
	         size="pop", color="continent",
                 hover_name="country", log_x=True, size_max=60)
fig.show()
```

## Bubble Chart with plotly.graph\_objects[¶](#Bubble-Chart-with-plotly.graph_objects)

If Plotly Express does not provide a good starting point, it is also possible to use [the more generic `go.Scatter` class from `plotly.graph_objects`](/python/graph-objects/), and define the size of markers to create a bubble chart. All of the available options are described in the scatter section of the reference page: <https://plotly.com/python/reference#scatter>.

### Simple Bubble Chart[¶](#Simple-Bubble-Chart)

In [2]:

```
import plotly.graph_objects as go

fig = go.Figure(data=[go.Scatter(
    x=[1, 2, 3, 4], y=[10, 11, 12, 13],
    mode='markers',
    marker_size=[40, 60, 80, 100])
])

fig.show()
```

### Setting Marker Size and Color[¶](#Setting-Marker-Size-and-Color)

In [3]:

```
import plotly.graph_objects as go

fig = go.Figure(data=[go.Scatter(
    x=[1, 2, 3, 4], y=[10, 11, 12, 13],
    mode='markers',
    marker=dict(
        color=['rgb(93, 164, 214)', 'rgb(255, 144, 14)',
               'rgb(44, 160, 101)', 'rgb(255, 65, 54)'],
        opacity=[1, 0.8, 0.6, 0.4],
        size=[40, 60, 80, 100],
    )
)])

fig.show()
```

### Scaling the Size of Bubble Charts[¶](#Scaling-the-Size-of-Bubble-Charts)

To scale the bubble size, use the attribute `sizeref`. We recommend using the following formula to calculate a `sizeref` value:
`sizeref = 2. * max(array of size values) / (desired maximum marker size ** 2)`
Note that setting 'sizeref' to a value greater than 1, decreases the rendered marker sizes, while setting 'sizeref' to less than 1, increases the rendered marker sizes. See <https://plotly.com/python/reference/scatter/#scatter-marker-sizeref> for more information.
Additionally, we recommend setting the sizemode attribute: <https://plotly.com/python/reference/scatter/#scatter-marker-sizemode> to area.

In [4]:

```
import plotly.graph_objects as go

size = [20, 40, 60, 80, 100, 80, 60, 40, 20, 40]
fig = go.Figure(data=[go.Scatter(
    x=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    y=[11, 12, 10, 11, 12, 11, 12, 13, 12, 11],
    mode='markers',
    marker=dict(
        size=size,
        sizemode='area',
        sizeref=2.*max(size)/(40.**2),
        sizemin=4
    )
)])

fig.show()
```

### Hover Text with Bubble Charts[¶](#Hover-Text-with-Bubble-Charts)

In [5]:

```
import plotly.graph_objects as go

fig = go.Figure(data=[go.Scatter(
    x=[1, 2, 3, 4], y=[10, 11, 12, 13],
    text=['A<br>size: 40', 'B<br>size: 60', 'C<br>size: 80', 'D<br>size: 100'],
    mode='markers',
    marker=dict(
        color=['rgb(93, 164, 214)', 'rgb(255, 144, 14)',  'rgb(44, 160, 101)', 'rgb(255, 65, 54)'],
        size=[40, 60, 80, 100],
    )
)])

fig.show()
```

### Bubble Charts with Colorscale[¶](#Bubble-Charts-with-Colorscale)

In [6]:

```
import plotly.graph_objects as go

fig = go.Figure(data=[go.Scatter(
    x=[1, 3.2, 5.4, 7.6, 9.8, 12.5],
    y=[1, 3.2, 5.4, 7.6, 9.8, 12.5],
    mode='markers',
    marker=dict(
        color=[120, 125, 130, 135, 140, 145],
        size=[15, 30, 55, 70, 90, 110],
        showscale=True
        )
)])

fig.show()
```

### Categorical Bubble Charts[¶](#Categorical-Bubble-Charts)

In [7]:

```
import plotly.graph_objects as go
import plotly.express as px
import pandas as pd
import math

# Load data, define hover text and bubble size
data = px.data.gapminder()
df_2007 = data[data['year']==2007]
df_2007 = df_2007.sort_values(['continent', 'country'])

hover_text = []
bubble_size = []

for index, row in df_2007.iterrows():
    hover_text.append(('Country: {country}<br>'+
                      'Life Expectancy: {lifeExp}<br>'+
                      'GDP per capita: {gdp}<br>'+
                      'Population: {pop}<br>'+
                      'Year: {year}').format(country=row['country'],
                                            lifeExp=row['lifeExp'],
                                            gdp=row['gdpPercap'],
                                            pop=row['pop'],
                                            year=row['year']))
    bubble_size.append(math.sqrt(row['pop']))

df_2007['text'] = hover_text
df_2007['size'] = bubble_size
sizeref = 2.*max(df_2007['size'])/(100**2)

# Dictionary with dataframes for each continent
continent_names = ['Africa', 'Americas', 'Asia', 'Europe', 'Oceania']
continent_data = {continent:df_2007.query("continent == '%s'" %continent)
                              for continent in continent_names}

# Create figure
fig = go.Figure()

for continent_name, continent in continent_data.items():
    fig.add_trace(go.Scatter(
        x=continent['gdpPercap'], y=continent['lifeExp'],
        name=continent_name, text=continent['text'],
        marker_size=continent['size'],
        ))

# Tune marker appearance and layout
fig.update_traces(mode='markers', marker=dict(sizemode='area',
                                              sizeref=sizeref, line_width=2))

fig.update_layout(
    title=dict(text='Life Expectancy v. Per Capita GDP, 2007'),
    xaxis=dict(
        title=dict(text='GDP per capita (2000 dollars)'),
        gridcolor='white',
        type='log',
        gridwidth=2,
    ),
    yaxis=dict(
        title=dict(text='Life Expectancy (years)'),
        gridcolor='white',
        gridwidth=2,
    ),
    paper_bgcolor='rgb(243, 243, 243)',
    plot_bgcolor='rgb(243, 243, 243)',
)
fig.show()
```

### Reference[¶](#Reference)

See <https://plotly.com/python/reference/scatter/> for more information and chart attribute options!

### What About Dash?[¶](#What-About-Dash?)

[Dash](https://dash.plot.ly/) is an open-source framework for building analytical applications, with no Javascript required, and it is tightly integrated with the Plotly graphing library.

Learn about how to install Dash at <https://dash.plot.ly/installation>.

Everywhere in this page that you see `fig.show()`, you can display the same figure in a Dash application by passing it to the `figure` argument of the [`Graph` component](https://dash.plot.ly/dash-core-components/graph) from the built-in `dash_core_components` package like this:

```
import plotly.graph_objects as go # or plotly.express as px
fig = go.Figure() # or any Plotly Express function e.g. px.bar(...)
# fig.add_trace( ... )
# fig.update_layout( ... )

from dash import Dash, dcc, html

app = Dash()
app.layout = html.Div([
    dcc.Graph(figure=fig)
])

app.run(debug=True, use_reloader=False)  # Turn off reloader if inside Jupyter
```

[![](/all_static/images/plotly-studio.png)](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_content=python_footer)

* ###### JOIN OUR MAILING LIST

  + Sign up to stay in the loop with all things Plotly — from Dash Club to product
    updates, webinars, and more!

    [Subscribe](https://plotly.com/newsletter/?utm_source=graphing_libraries&utm_medium=documentation&utm_content=footer)
* ###### Products

  + [Plotly Studio](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=footer)
  + [Plotly Cloud](https://plotly.com/cloud?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=footer)
  + [Dash Enterprise](https://plotly.com/dash/?utm_source=graphing_libraries&utm_medium=documentation&utm_content=footer)
  + [New Releases →](https://plotly.com/whats-new/?utm_source=graphing_libraries&utm_medium=documentation&utm_content=footer)
* ###### Pricing

  + [Studio and Cloud Pricing](https://plotly.com/pricing?utm_source=graphing_libraries&utm_medium=documentation&utm_content=footer)
  + [Dash Enterprise Pricing](https://plotly.com/get-pricing?utm_source=graphing_libraries&utm_medium=documentation&utm_content=footer)
* ###### About Us

  + [Careers](https://plotly.com/careers?utm_source=graphing_libraries&utm_medium=documentation&utm_content=footer)
  + [Resources](https://plotly.com/resources/?utm_source=graphing_libraries&utm_medium=documentation&utm_content=footer)
  + [Blog](https://plotly.com/blog/?utm_source=graphing_libraries&utm_medium=documentation&utm_content=footer)
* ###### Support

  + [Community Support](https://community.plot.ly/)
  + [Documentation](https://plotly.com/graphing-libraries)

Copyright © 2026 Plotly. All rights reserved.

[Terms of Service](https://community.plotly.com/tos)

[Privacy Policy](https://plotly.com/privacy/)

×