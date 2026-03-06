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

Simple Traces

* [Scatter](/python/reference/scatter)
* [Scatter GL](/python/reference/scattergl)
* [Bar](/python/reference/bar)
* [Pie](/python/reference/pie)
* [Heatmap](/python/reference/heatmap)
* [Heatmap GL](/python/reference/heatmapgl)
* [Image](/python/reference/image)
* [Contour](/python/reference/contour)
* [Table](/python/reference/table)

Distribution Traces

* [Box](/python/reference/box)
* [Violin](/python/reference/violin)
* [Histogram](/python/reference/histogram)
* [Histogram 2D](/python/reference/histogram2d)
* [Histogram 2D Contour](/python/reference/histogram2dcontour)

Finance Traces

* [OHLC](/python/reference/ohlc)
* [Candlestick](/python/reference/candlestick)
* [Waterfall](/python/reference/waterfall)
* [Funnel](/python/reference/funnel)
* [Funnel Area](/python/reference/funnelarea)
* [Indicator](/python/reference/indicator)

3D Traces

* [Scatter 3D](/python/reference/scatter3d)
* [Surface](/python/reference/surface)
* [Mesh](/python/reference/mesh3d)
* [Cone](/python/reference/cone)
* [Streamtube](/python/reference/streamtube)
* [Volume](/python/reference/volume)
* [Isosurface](/python/reference/isosurface)

Map Traces

* [Scatter Geo](/python/reference/scattergeo)
* [Choropleth](/python/reference/choropleth)
* [Scatter Map](/python/reference/scattermap)
* [Scatter Mapbox](/python/reference/scattermapbox)
* [Choropleth Map](/python/reference/choroplethmap)
* [Choropleth Mapbox](/python/reference/choroplethmapbox)
* [Density Map](/python/reference/densitymap)
* [Density Mapbox](/python/reference/densitymapbox)

Specialized Traces

* [Scatter Polar](/python/reference/scatterpolar)
* [Scatter Polar GL](/python/reference/scatterpolargl)
* [Bar Polar](/python/reference/barpolar)
* [Scatter Ternary](/python/reference/scatterternary)
* [Scatter Smith](/python/reference/scattersmith)
* [Sunburst](/python/reference/sunburst)
* [Treemap](/python/reference/treemap)
* [Icicle](/python/reference/icicle)
* [Sankey](/python/reference/sankey)
* [SPLOM](/python/reference/splom)
* [Parallel Coordinates](/python/reference/parcoords)
* [Parallel Categories](/python/reference/parcats)
* [Carpet](/python/reference/carpet)
* [Scatter Carpet](/python/reference/scattercarpet)
* [Contour Carpet](/python/reference/contourcarpet)

---

Layout

* [Title](/python/reference/layout/)
* [Legend](/python/reference/layout/#layout-showlegend)
* [Margins](/python/reference/layout/#layout-margin)
* [Size](/python/reference/layout/#layout-autosize)
* [Fonts](/python/reference/layout/#layout-font)
* [Colors](/python/reference/layout/#layout-paper_bgcolor)

Axes and Subplots

* [X Axis](/python/reference/layout/xaxis/)
* [Y Axis](/python/reference/layout/yaxis/)
* [Ternary](/python/reference/layout/ternary/)
* [Smith](/python/reference/layout/smith/)
* [3D Scene](/python/reference/layout/scene/)
* [Geo](/python/reference/layout/geo/)
* [Mapbox](/python/reference/layout/mapbox/)
* [Polar](/python/reference/layout/polar/)
* [Color Axis](/python/reference/layout/coloraxis/)

Layers

* [Annotations](/python/reference/layout/annotations/)
* [Shapes](/python/reference/layout/shapes/)
* [Selections](/python/reference/layout/selections/)
* [Images](/python/reference/layout/images/)
* [Sliders](/python/reference/layout/sliders/)
* [Update Menus](/python/reference/layout/updatemenus/)

[![Sign up for the upcoming webinar: Take Your Power BI Models Beyond the Static Dashboard](https://images.prismic.io/plotly-marketing-website-2/aaHFvsFoBIGEg7rA_power-bi-webinar-square.jpg?auto=format,compress)](https://plotly.com/webinars/power-bi-models-beyond-the-static-dashboard/?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=power-bi-models-beyond-dashboard&utm_content=sidebar)

[Python](/python)
> [Figure Reference](/python/reference/index/)
> Reference Index

## Python Figure Reference

The pages linked in the sidebar together form the exhaustive reference for all of the attributes in the core [figure data structure](/python/figure-structure/)
that the `plotly` library operates on. They are automatically-generated from the
[machine-readable Plotly.js schema reference](https://raw.githubusercontent.com/plotly/plotly.js/master/dist/plot-schema.json).

### How to use these Reference pages

Figures are represented as trees with named nodes called "attributes".
The root node of the tree has three top-level attributes: `data`, `layout` and `frames`.
Attributes are referred to in text and in this reference by their full "path" i.e. the dot-delimited concatenation of their parents.
For example `"layout.width"` refers to the attribute whose key is `"width"` inside a dict which is
the value associated with a key `"layout"` at the root of the figure. If one of the parents is a list rather
than a dict, a set of brackets is inserted in the path when referring to the attribute in the abstract,
e.g. `"layout.annotations[].text"`. Finally, as explained below, the top-level "data"
attribute defines a list of typed objects called "traces" with the schema dependent upon the type,
and these attributes' paths are listed in this reference as
`"data[type=scatter].name"`. When [manipulating
a `plotly.graph_objects.Figure` object](/python/creating-and-updating-figures/), attributes can be set either directly
using Python object attributes e.g. `fig.layout.title.font.family="Open Sans"`
or using [update methods
and "magic underscores"](/python/creating-and-updating-figures/#magic-underscore-notation) e.g. `fig.update_layout(title_font_family="Open Sans")`

When building a figure, it is *not necessary to populate every attribute*
of every object. At render-time, the JavaScript layer will compute default values
for each required unspecified attribute, depending upon the ones that are specified,
as documented in this page. An example of this would be `layout.xaxis.range`,
which may be specified explicitly, but if not will be computed based on the range of `x` values for
every trace linked to that axis. The JavaScript layer will ignore unknown attributes
or malformed values, although the `plotly.graph_objects` module provides
Python-side validation for attribute values. Note also that if [the `layout.template`
key is present (as it is by default)](/python/templates/) then default values will be drawn first from the contents
of the template and only if missing from there will the JavaScript layer infer further defaults.
The built-in template can be disabled by setting `layout.template="none"`.

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