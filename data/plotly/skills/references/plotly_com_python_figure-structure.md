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
> The Figure Data Structure

[Suggest an edit to this page](https://github.com/plotly/plotly.py/edit/doc-prod/doc/python/figure-structure.md)

# The Figure Data Structure in Python

The structure of a figure - data, traces and layout explained.

Plotly Studio: Transform any dataset into an interactive data application in minutes with AI. [Try Plotly Studio now.](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=sidebar)

### Overview[¶](#Overview)

The `plotly` Python package exists to [create, manipulate](/python/creating-and-updating-figures/) and [render](/python/renderers/) graphical figures (i.e. charts, plots, maps and diagrams) represented by data structures also referred to as figures. The rendering process uses the [Plotly.js JavaScript library](https://plotly.com/javascript/) under the hood although Python developers using this module very rarely need to interact with the Javascript library directly, if ever. Figures can be represented in Python either as dicts or as instances of the `plotly.graph_objects.Figure` class, and are serialized as text in [JavaScript Object Notation (JSON)](https://json.org/) before being passed to Plotly.js.

> Note: the recommended entry-point into the plotly package is the [high-level plotly.express module, also known as Plotly Express](/python/plotly-express/), which consists of Python functions which return fully-populated `plotly.graph_objects.Figure` objects. This page exists to document the architecture of the data structure that these objects represent, for users who wish to understand more about how to customize them, or assemble them from [other `plotly.graph_objects` components](/python/graph-objects/).

Viewing the underlying data structure for any `plotly.graph_objects.Figure` object, including those returned by Plotly Express, can be done via `print(fig)` or, in JupyterLab, with the special `fig.show("json")` renderer. Figures also support `fig.to_dict()` and `fig.to_json()` methods. `print()`ing the figure will result in the often-verbose `layout.template` key being represented as ellipses `'...'` for brevity.

In [1]:

```
import plotly.express as px

fig = px.line(x=["a","b","c"], y=[1,3,2], title="sample figure")
print(fig)
fig.show()
```

```
Figure({
    'data': [{'hovertemplate': 'x=%{x}<br>y=%{y}<extra></extra>',
              'legendgroup': '',
              'line': {'color': '#636efa', 'dash': 'solid'},
              'marker': {'symbol': 'circle'},
              'mode': 'lines',
              'name': '',
              'orientation': 'v',
              'showlegend': False,
              'type': 'scatter',
              'x': array(['a', 'b', 'c'], dtype=object),
              'xaxis': 'x',
              'y': {'bdata': 'AQMC', 'dtype': 'i1'},
              'yaxis': 'y'}],
    'layout': {'legend': {'tracegroupgap': 0},
               'template': '...',
               'title': {'text': 'sample figure'},
               'xaxis': {'anchor': 'y', 'domain': [0.0, 1.0], 'title': {'text': 'x'}},
               'yaxis': {'anchor': 'x', 'domain': [0.0, 1.0], 'title': {'text': 'y'}}}
})
```

### Accessing figure structures in Dash[¶](#Accessing-figure-structures-in-Dash)

[Dash](https://plotly.com/dash/) is the best way to build analytical apps in Python using Plotly figures. To run the app below, run `pip install dash`, click "Download" to get the code and run `python app.py`.

Get started with [the official Dash docs](https://dash.plotly.com/installation) and **learn how to effortlessly [style](https://plotly.com/dash/design-kit/) & publish apps like this with [Dash Enterprise](https://plotly.com/dash/) or [Plotly Cloud](https://plotly.com/cloud/).**

Out[2]:

**Sign up for Dash Club** → Free cheat sheets plus updates from Chris Parmer and Adam Schroeder delivered to your inbox every two months. Includes tips and tricks, community apps, and deep dives into the Dash architecture.
[Join now](https://go.plotly.com/dash-club?utm_source=Dash+Club+2022&utm_medium=graphing_libraries&utm_content=inline).

### Figures as Trees of Attributes[¶](#Figures-as-Trees-of-Attributes)

Plotly.js supports inputs adhering to a well-defined schema, whose overall architecture is explained in this page and which is exhaustively documented in the [Figure Reference](/python/reference/index/) (which is itself generated from a [machine-readable JSON representation of the schema](https://raw.githubusercontent.com/plotly/plotly.js/master/dist/plot-schema.json)). Figures are represented as trees with named nodes called "attributes". The root node of the tree has three top-level attributes: `data`, `layout` and `frames` (see below).

Attributes are referred to in text and in the [Figure Reference](/python/reference/index/) by their full "path" i.e. the dot-delimited concatenation of their parents. For example `"layout.width"` refers to the attribute whose key is `"width"` inside a dict which is the value associated with a key `"layout"` at the root of the figure. If one of the parents is a list rather than a dict, a set of brackets is inserted in the path when referring to the attribute in the abstract, e.g. `"layout.annotations[].text"`. Finally, as explained below, the top-level "data" attribute defines a list of typed objects called "traces" with the schema dependent upon the type, and these attributes' paths are listed in the [Figure Reference](/python/reference/index/) as `"data[type=scatter].name"`.

The [`plotly.graph_objects` module contains an automatically-generated hierarchy of Python classes](/python/graph-objects/) which represent non-leaf attributes in the figure schema and provide a Pythonic API for them. When [manipulating a `plotly.graph_objects.Figure` object](/python/creating-and-updating-figures/), attributes can be set either directly using Python object attributes e.g. `fig.layout.title.font.family="Open Sans"` or using [update methods and "magic underscores"](/python/creating-and-updating-figures/#magic-underscore-notation) e.g. `fig.update_layout(title_font_family="Open Sans")`

When building a figure, it is *not necessary to populate every attribute* of every object. At render-time, [the JavaScript layer will compute default values](/python/figure-introspection/) for each required unspecified attribute, depending upon the ones that are specified, as documented in the [Figure Reference](/python/reference/index/). An example of this would be `layout.xaxis.range`, which may be specified explicitly, but if not will be computed based on the range of `x` values for every trace linked to that axis. The JavaScript layer will ignore unknown attributes or malformed values, although the `plotly.graph_objects` module provides Python-side validation for attribute values. Note also that if [the `layout.template` key is present (as it is by default)](/python/templates/) then default values will be drawn first from the contents of the template and only if missing from there will the JavaScript layer infer further defaults. The built-in template can be disabled by setting `layout.template="none"`.

### The Top-Level `data` Attribute[¶](#The-Top-Level-data-Attribute)

The first of the three top-level attributes of a figure is `data`, whose value must be a list of dicts referred to as "traces".

* Each trace has one of more than 40 possible types (see below for a list organized by subplot type, including e.g. [`scatter`](/python/line-and-scatter/), [`bar`](/python/bar-charts/), [`pie`](/python/pie-charts/), [`surface`](/python/3d-surface-plots/), [`choropleth`](/python/choropleth-maps/) etc), and represents a set of related graphical marks in a figure. Each trace must have a `type` attribute which defines the other allowable attributes.
* Each trace is drawn on a single [subplot](/python/subplots/) whose type must be compatible with the trace's type, or is its own subplot (see below).
* Traces may have a single [legend](/python/legend/) entry, with the exception of pie and funnelarea traces (see below).
* Certain trace types support [continuous color, with an associated colorbar](/python/colorscales/), which can be controlled by attributes either within the trace, or within the layout when using the [coloraxis attribute](/python/colorscales/).

### The Top-Level `layout` Attribute[¶](#The-Top-Level-layout-Attribute)

The second of the three top-level attributes of a figure is `layout`, whose value is referred to in text as "the layout" and must be a dict, containing attributes that control positioning and configuration of non-data-related parts of the figure such as:

* Dimensions and margins, which define the bounds of "paper coordinates" (see below)
* Figure-wide defaults: [templates](/python/templates/), [fonts](/python/figure-labels/), colors, hover-label and modebar defaults
* [Title](/python/figure-labels/) and [legend](/python/legend/) (positionable in container and/or paper coordinates)
* [Color axes and associated color bars](/python/colorscales/) (positionable in paper coordinates)
* Subplots of various types on which can be drawn multiple traces and which are positioned in paper coordinates:
  + `xaxis`, `yaxis`, `xaxis2`, `yaxis3` etc: X and Y cartesian axes, the intersections of which are cartesian subplots
  + `scene`, `scene2`, `scene3` etc: 3d scene subplots
  + `ternary`, `ternary2`, `ternary3`, `polar`, `polar2`, `polar3`, `geo`, `geo2`, `geo3`, `map`, `map2`, `map3`, `smith`, `smith2` etc: ternary, polar, geo, map or smith subplots
* Non-data marks which can be positioned in paper coordinates, or in data coordinates linked to 2d cartesian subplots:
  + `annotations`: [textual annotations with or without arrows](/python/text-and-annotations/)
  + `shapes`: [lines, rectangles, ellipses or open or closed paths](/python/shapes/)
  + `images`: [background or decorative images](/python/images/)
* Controls which can be positioned in paper coordinates and which can trigger Plotly.js functions when interacted with by a user:
  + `updatemenus`: [single buttons, toggles](/python/custom-buttons/) and [dropdown menus](/python/dropdowns/)
  + `sliders`: [slider controls](/python/sliders/)

### The Top-Level `frames` Attribute[¶](#The-Top-Level-frames-Attribute)

The third of the three top-level attributes of a figure is `frames`, whose value must be a list of dicts that define sequential frames in an [animated plot](/python/animations/). Each frame contains its own data attribute as well as other parameters. Animations are usually triggered and controlled via controls defined in layout.sliders and/or layout.updatemenus

### The `config` Object[¶](#The-config-Object)

At [render-time](/python/renderers/), it is also possible to control certain figure behaviors which are not considered part of the figure proper i.e. the behavior of the "modebar" and how the figure relates to mouse actions like scrolling etc. The object that contains these options is called the [`config`, and has its own documentation page](/python/configuration-options/). It is exposed in Python as the `config` keyword argument of the `.show()` method on `plotly.graph_objects.Figure` objects.

### Positioning With Paper, Container Coordinates, or Axis Domain Coordinates[¶](#Positioning-With-Paper,-Container-Coordinates,-or-Axis-Domain-Coordinates)

Various figure components configured within the layout of the figure support positioning attributes named `x` or `y`, whose values may be specified in "paper coordinates" (sometimes referred to as "plot fractions" or "normalized coordinates"). Examples include `layout.xaxis.domain` or `layout.legend.x` or `layout.annotation[].x`.

Positioning in paper coordinates is *not* done in absolute pixel terms, but rather in terms relative to a coordinate system defined with an origin `(0,0)` at `(layout.margin.l, layout.margin.b)` and a point `(1,1)` at `(layout.width-layout.margin.r, layout.height-layout.margin.t)` (note: `layout.margin` values are pixel values, as are `layout.width` and `layout.height`). Paper coordinate values less than 0 or greater than 1 are permitted, and refer to areas within the plot margins.

To position an object in "paper" coordinates, the corresponding axis reference
is set to `"paper"`. For instance a shape's `xref` attribute would be set to
`"paper"` so that the `x` value of the shape refers to its position in paper
coordinates.

Note that the contents of the `layout.margin` attribute are by default computed based on the position and dimensions of certain items like the title or legend, and may be made dependent on the position and dimensions of tick labels as well when setting the `layout.xaxis.automargin` attribute to `True`. This has the effect of automatically increasing the margin values and therefore shrinking the physical area defined betw