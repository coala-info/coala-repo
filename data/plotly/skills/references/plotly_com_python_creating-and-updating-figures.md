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
> Creating and Updating Figures

[Suggest an edit to this page](https://github.com/plotly/plotly.py/edit/doc-prod/doc/python/creating-and-updating-figures.md)

# Creating and Updating Figures in Python

Creating and Updating Figures with Plotly's Python graphing library

Plotly Studio: Transform any dataset into an interactive data application in minutes with AI. [Try Plotly Studio now.](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=sidebar)

The `plotly` Python package exists to create, manipulate and [render](/python/renderers/) graphical figures (i.e. charts, plots, maps and diagrams) represented by [data structures also referred to as figures](/python/figure-structure/). The rendering process uses the [Plotly.js JavaScript library](https://plotly.com/javascript/) under the hood although Python developers using this module very rarely need to interact with the Javascript library directly, if ever. Figures can be represented in Python either as dicts or as instances of the `plotly.graph_objects.Figure` class, and are serialized as text in [JavaScript Object Notation (JSON)](https://json.org/) before being passed to Plotly.js.

> Note: the recommended entry-point into the plotly package is the [high-level plotly.express module, also known as Plotly Express](/python/plotly-express/), which consists of Python functions which return fully-populated `plotly.graph_objects.Figure` objects. This page exists to document the structure of the data structure that these objects represent for users who wish to understand more about how to customize them, or assemble them from other `plotly.graph_objects` components.

### Figures As Dictionaries[¶](#Figures-As-Dictionaries)

At a low level, figures can be represented as dictionaries and displayed using functions from the `plotly.io` module. The `fig` dictionary in the example below describes a figure. It contains a single `bar` trace and a title.

In [1]:

```
fig = dict({
    "data": [{"type": "bar",
              "x": [1, 2, 3],
              "y": [1, 3, 2]}],
    "layout": {"title": {"text": "A Figure Specified By Python Dictionary"}}
})

# To display the figure defined by this dict, use the low-level plotly.io.show function
import plotly.io as pio

pio.show(fig)
```

### Figures as Graph Objects[¶](#Figures-as-Graph-Objects)

The [`plotly.graph_objects` module provides an automatically-generated hierarchy of classes](https://plotly.com/python-api-reference/plotly.graph_objects.html) called ["graph objects"](/python/graph-objects/) that may be used to represent figures, with a top-level class `plotly.graph_objects.Figure`.

> Note that the *recommended alternative* to working with Python dictionaries is to [create entire figures at once using Plotly Express](/python/plotly-express/) and to manipulate the resulting `plotly.graph_objects.Figure` objects as described in this page, wherever possible, rather than to assemble figures bottom-up from underlying graph objects. See ["When to use Graph Objects"](/python/graph-objects/).

Graph objects have several benefits compared to plain Python dictionaries.

1. Graph objects provide precise data validation. If you provide an invalid property name or an invalid property value as the key to a graph object, an exception will be raised with a helpful error message describing the problem. This is not the case if you use plain Python dictionaries and lists to build your figures.
2. Graph objects contain descriptions of each valid property as Python docstrings, with a [full API reference available](https://plotly.com/python-api-reference/). You can use these docstrings in the development environment of your choice to learn about the available properties as an alternative to consulting the online [Full Reference](/python/reference/index/).
3. Properties of graph objects can be accessed using both dictionary-style key lookup (e.g. `fig["layout"]`) or class-style property access (e.g. `fig.layout`).
4. Graph objects support higher-level convenience functions for making updates to already constructed figures (`.update_layout()`, `.add_trace()` etc) as described below.
5. Graph object constructors and update methods accept "magic underscores" (e.g. `go.Figure(layout_title_text="The Title")` rather than `dict(layout=dict(title=dict(text="The Title")))`) for more compact code, as described below.
6. Graph objects support attached rendering (`.show()`) and exporting functions (`.write_image()`) that automatically invoke the appropriate functions from [the `plotly.io` module](https://plotly.com/python-api-reference/plotly.io.html).

Below you can find an example of one way that the figure in the example above could be specified using a graph object instead of a dictionary.

In [2]:

```
import plotly.graph_objects as go

fig = go.Figure(
    data=[go.Bar(x=[1, 2, 3], y=[1, 3, 2])],
    layout=go.Layout(
        title=go.layout.Title(text="A Figure Specified By A Graph Object")
    )
)

fig.show()
```

You can also create a graph object figure from a dictionary representation by passing the dictionary to the `go.Figure` constructor.

In [3]:

```
import plotly.graph_objects as go

dict_of_fig = dict({
    "data": [{"type": "bar",
              "x": [1, 2, 3],
              "y": [1, 3, 2]}],
    "layout": {"title": {"text": "A Figure Specified By A Graph Object With A Dictionary"}}
})

fig = go.Figure(dict_of_fig)

fig.show()
```

##### Converting Graph Objects To Dictionaries and JSON[¶](#Converting-Graph-Objects-To-Dictionaries-and-JSON)

Graph objects can be turned into their Python dictionary representation using the `fig.to_dict()` method. You can also retrieve the JSON string representation of a graph object using the `fig.to_json()` method.

In [4]:

```
import plotly.graph_objects as go

fig = go.Figure(
    data=[go.Bar(x=[1, 2, 3], y=[1, 3, 2])],
    layout=go.Layout(height=600, width=800)
)

fig.layout.template = None # to slim down the output

print("Dictionary Representation of A Graph Object:\n\n" + str(fig.to_dict()))
print("\n\n")
print("JSON Representation of A Graph Object:\n\n" + str(fig.to_json()))
print("\n\n")
```

```
Dictionary Representation of A Graph Object:

{'data': [{'x': [1, 2, 3], 'y': [1, 3, 2], 'type': 'bar'}], 'layout': {'height': 600, 'width': 800}}

JSON Representation of A Graph Object:

{"data":[{"x":[1,2,3],"y":[1,3,2],"type":"bar"}],"layout":{"height":600,"width":800}}
```

### Representing Figures in Dash[¶](#Representing-Figures-in-Dash)

[Dash](https://plotly.com/dash/) is the best way to build analytical apps in Python using Plotly figures. To run the app below, run `pip install dash`, click "Download" to get the code and run `python app.py`.

Get started with [the official Dash docs](https://dash.plotly.com/installation) and **learn how to effortlessly [style](https://plotly.com/dash/design-kit/) & publish apps like this with [Dash Enterprise](https://plotly.com/dash/) or [Plotly Cloud](https://plotly.com/cloud/).**

Out[5]:

**Sign up for Dash Club** → Free cheat sheets plus updates from Chris Parmer and Adam Schroeder delivered to your inbox every two months. Includes tips and tricks, community apps, and deep dives into the Dash architecture.
[Join now](https://go.plotly.com/dash-club?utm_source=Dash+Club+2022&utm_medium=graphing_libraries&utm_content=inline).

### Creating Figures[¶](#Creating-Figures)

This section summarizes several ways to create new graph object figures with the `plotly.py` graphing library.

> The *recommended way* to create figures and populate them is to use [Plotly Express](/python/plotly-express/) but this page documents various other options for completeness

#### Plotly Express[¶](#Plotly-Express)

[Plotly Express](https://plot.ly/python/plotly-express/) (included as the `plotly.express` module) is a high-level data visualization API that produces fully-populated graph object figures in single function-calls.

In [6]:

```
import plotly.express as px

df = px.data.iris()
fig = px.scatter(df, x="sepal_width", y="sepal_length", color="species", title="A Plotly Express Figure")

# If you print the figure, you'll see that it's just a regular figure with data and layout
# print(fig)

fig.show()
```

#### Graph Objects `Figure` Constructor[¶](#Graph-Objects-Figure-Constructor)

As demonstrated above, you can build a complete figure by passing trace and layout specifications to the `plotly.graph_objects.Figure` constructor. These trace and layout specifications can be either dictionaries or graph objects.

In the following example, the traces are specified using graph objects and the layout is specified as a dictionary.

In [7]:

```
import plotly.graph_objects as go

fig = go.Figure(
    data=[go.Bar(x=[1, 2, 3], y=[1, 3, 2])],
    layout=dict(title=dict(text="A Figure Specified By A Graph Object"))
)

fig.show()
```

#### Figure Factories[¶](#Figure-Factories)

[Figure factories](/python/figure-factories) (included in `plotly.py` in the `plotly.figure_factory` module) are functions that produce graph object figures, often to satisfy the needs of specialized domains. Here's an example of using the `create_quiver()` figure factory to construct a graph object figure that displays a 2D quiver plot.

In [8]:

```
import numpy as np
import plotly.figure_factory as ff

x1,y1 = np.meshgrid(np.arange(0, 2, .2), np.arange(0, 2, .2))
u1 = np.cos(x1)*y1
v1 = np.sin(x1)*y1

fig = ff.create_quiver(x1, y1, u1, v1)

fig.show()
```

#### Make Subplots[¶](#Make-Subplots)

The `plotly.subplots.make_subplots()` function produces a graph object figure that is preconfigured with a grid of subplots that traces can be added to. The `add_trace()` function will be discussed more below.

In [9]:

```
import plotly.graph_objects as go
from plotly.subplots import make_subplots

fig = make_subplots(rows=1, cols=2)

fig.add_trace(go.Scatter(y=[4, 2, 1], mode="lines"), row=1, col=1)
fig.add_trace(go.Bar(y=[2, 1, 3]), row=1, col=2)

fig.show()
```

### Updating Figures[¶](#Updating-Figures)

Regardless of how a graph object figure was constructed, it can be updated by adding additional traces to it and modifying its properties.

#### Adding Traces[¶](#Adding-Traces)

New traces can be added to a graph object figure using the `add_trace()` method. This method accepts a graph object trace (an instance of `go.Scatter`, `go.Bar`, etc.) and adds it to the figure. This allows you to start with an empty figure, and add traces to it sequentially. The `append_trace()` method does the same thing, although it does not return the figure.

In [10]:

```
import plotly.graph_objects as go

fig = go.Figure()

fig.add_trace(go.Bar(x=[1, 2, 3], y=[1, 3, 2]))

fig.show()
```

You can also add traces to a figure produced by a figure factory or Plotly Express.

In [11]:

```
import plotly.express as px

df = px.data.iris()

fig = px.scatter(df, x="sepal_width", y="sepal_length", color="species",
                 title="Using The add_trace() method With A Plotly Express Figure")

fig.add_trace(
    go.Scatter(
        x=[2, 4],
        y=[4, 8],
        mode="lines",
        line=go.scatter.Line(color="gray"),
        showlegend=False)
)
fig.show()
```

#### Adding Traces To Subplots[¶](#Adding-Traces-To-Subplots)

If a figure was created using `plotly.subplots.make_subplots()`, then supplying the `row` and `col` arguments to `add_trace()` can be used to add a trace to a particular subplot.

In [12]:

```
import plotly.graph_objects as go
from plotly.subplots import make_subplots

fig = make_subplots(rows=1, cols=2)

fig.add_trace(go.Scatter(y=[4, 2, 1], mode="lines"), row=1, col=1)
fig.add_trace(go.Bar(y=[2, 1, 3]), row=1, col=2)

fig.show()
```

This also works for figures created by Plotly Express using the `facet_row` and or `facet_col` arguments.

In [13]:

```
import plotly.express as px
import plotly.graph_objects as go

df = px.data.iris()

fig = px.scatter(df, x="sepal_width", y="sepal_length", color="species", facet_col="species",
                 title="Adding Traces To Subplots Within A Plotly Express Figure")

reference_line = go.Scatter(x=[2, 4],
                            y=[4, 8],
                            mode="lines",
                            line=go.scatter.Line(color="gray"),
                            showlegend=False)

fig.add_trace(reference_line, row=1, col=1)
fig.add_trace(reference_line, row=1, col=2)
fig.add_trace(reference_line, row=1, col=3)

fig.show()
```

#### Add Trace Convenience Methods[¶](#Add-Trace-Convenience-Methods)

As an alternative to the `add_trace()` method, graph object figures have a family of methods of the form `add_{trace}` (where `{trace}` is the name of a trace type) for constructing and adding traces of each trace type.

Here is the previous subplot example, ad