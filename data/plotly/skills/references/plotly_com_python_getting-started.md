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
> Getting Started with Plotly

[Suggest an edit to this page](https://github.com/plotly/plotly.py/edit/doc-prod/doc/python/getting-started.md)

# Getting Started with Plotly in Python

Getting Started with Plotly for Python.

Plotly Studio: Transform any dataset into an interactive data application in minutes with AI. [Try Plotly Studio now.](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=sidebar)

### Overview[¶](#Overview)

The [`plotly` Python library](/python/) is an interactive, [open-source](/python/is-plotly-free) plotting library that supports over 40 unique chart types covering a wide range of statistical, financial, geographic, scientific, and 3-dimensional use-cases.

Built on top of the Plotly JavaScript library ([plotly.js](https://plotly.com/javascript/)), `plotly` enables Python users to create beautiful interactive web-based visualizations that can be displayed in Jupyter notebooks, saved to standalone HTML files, or served as part of pure Python-built web applications using Dash. The `plotly` Python library is sometimes referred to as "plotly.py" to differentiate it from the JavaScript library.

Thanks to deep integration with our [Kaleido](https://github.com/plotly/Kaleido) image export utility, `plotly` also provides great support for non-web contexts including desktop editors (e.g. QtConsole, Spyder, PyCharm) and static document publishing (e.g. exporting notebooks to PDF with high-quality vector images).

This Getting Started guide explains how to install `plotly` and related optional pages. Once you've installed, you can use our documentation in three main ways:

1. You jump right in to **examples** of how to make [basic charts](/python/basic-charts/), [statistical charts](/python/statistical-charts/), [scientific charts](/python/scientific-charts/), [financial charts](/python/financial-charts/), [maps](/python/maps/), and [3-dimensional charts](/python/3d-charts/).
2. If you prefer to learn about the **fundamentals** of the library first, you can read about [the structure of figures](/python/figure-structure/), [how to create and update figures](/python/creating-and-updating-figures/), [how to display figures](/python/renderers/), [how to theme figures with templates](/python/templates/), [how to export figures to various formats](/python/static-image-export/) and about [Plotly Express, the high-level API](/python/plotly-express/) for doing all of the above.
3. You can check out our exhaustive **reference** guides: the [Python API reference](/python-api-reference) or the [Figure Reference](/python/reference)

For information on using Python to build web applications containing plotly figures, see the [*Dash User Guide*](https://dash.plotly.com/).

We also encourage you to join the [Plotly Community Forum](http://community.plotly.com/) if you want help with anything related to `plotly`.

### Installation[¶](#Installation)

`plotly` may be installed using `pip`:

```
$ pip install plotly
```

or `conda`:

```
$ conda install -c conda-forge plotly
```

If you want to use Plotly Express, install its required dependencies with:

```
pip install plotly[express]
```

You'll also need to install a [supported dataframe library](/python/px-arguments#supported-dataFrame-types).

### Plotly charts in Dash[¶](#Plotly-charts-in-Dash)

[Dash](https://plotly.com/dash/) is the best way to build analytical apps in Python using Plotly figures. To run the app below, run `pip install dash`, click "Download" to get the code and run `python app.py`.

Get started with [the official Dash docs](https://dash.plotly.com/installation) and **learn how to effortlessly [style](https://plotly.com/dash/design-kit/) & publish apps like this with [Dash Enterprise](https://plotly.com/dash/) or [Plotly Cloud](https://plotly.com/cloud/).**

Out[1]:

**Sign up for Dash Club** → Free cheat sheets plus updates from Chris Parmer and Adam Schroeder delivered to your inbox every two months. Includes tips and tricks, community apps, and deep dives into the Dash architecture.
[Join now](https://go.plotly.com/dash-club?utm_source=Dash+Club+2022&utm_medium=graphing_libraries&utm_content=inline).

#### JupyterLab Support[¶](#JupyterLab-Support)

To use `plotly` in [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/), install the `jupyterlab` and `anywidget` packages in the same environment as you installed `plotly`, using `pip`:

```
$ pip install jupyterlab anywidget
```

or `conda`:

```
$ conda install jupyterlab anywidget
```

Launch JupyterLab with:

```
$ jupyter lab
```

and display plotly figures inline:

In [2]:

```
import plotly.express as px
fig = px.bar(x=["a", "b", "c"], y=[1, 3, 2])
fig.show()
```

or using `FigureWidget` objects.

In [3]:

```
import plotly.express as px
fig = px.bar(x=["a", "b", "c"], y=[1, 3, 2])

import plotly.graph_objects as go
fig_widget = go.FigureWidget(fig)
fig_widget
```

Out[3]:

See [*Displaying Figures in Python*](/python/renderers/) for more information on the renderers framework, and see [*Plotly FigureWidget Overview*](/python/figurewidget/) for more information on using `FigureWidget`.

See the [Troubleshooting guide](/python/troubleshooting/) if you run into any problems with JupyterLab, particularly if you are using multiple Python environments inside Jupyter.

#### Jupyter Notebook Support[¶](#Jupyter-Notebook-Support)

For use in the classic [Jupyter Notebook](https://jupyter.org/), install the `notebook` and `ipywidgets`
packages using `pip`:

```
pip install "notebook>=7.0" "anywidget>=0.9.13"
```

or `conda`:

```
conda install "notebook>=7.0" "anywidget>=0.9.13"
```

These packages contain everything you need to run a Jupyter notebook...

```
$ jupyter notebook
```

and display plotly figures inline using the notebook renderer...

In [4]:

```
import plotly.express as px
fig = px.bar(x=["a", "b", "c"], y=[1, 3, 2])
fig.show()
```

or using `FigureWidget` objects.

In [5]:

```
import plotly.express as px
fig = px.bar(x=["a", "b", "c"], y=[1, 3, 2])

import plotly.graph_objects as go
fig_widget = go.FigureWidget(fig)
fig_widget
```

Out[5]:

See [*Displaying Figures in Python*](/python/renderers/) for more information on the renderers framework, and see [*Plotly FigureWidget Overview*](/python/figurewidget/) for more information on using `FigureWidget`.

### Static Image Export[¶](#Static-Image-Export)

plotly.py supports [static image export](https://plotly.com/python/static-image-export/),
using the [`kaleido`](https://github.com/plotly/Kaleido) package. (Support for the legacy [`orca`](https://github.com/plotly/orca) image export utility is deprecated and will be removed after September 2025.)

#### Kaleido[¶](#Kaleido)

The [`kaleido`](https://github.com/plotly/Kaleido) package has no dependencies and can be installed
using pip...

```
$ pip install --upgrade kaleido
```

or conda.

```
$ conda install -c plotly python-kaleido
```

#### Extended Geo Support[¶](#Extended-Geo-Support)

Some plotly.py features rely on fairly large geographic shape files. The county
choropleth figure factory is one such example. These shape files are distributed as a
separate `plotly-geo` package. This package can be installed using pip...

```
$ pip install plotly-geo==1.0.0
```

or conda.

```
$ conda install -c plotly plotly-geo=1.0.0
```

See [*USA County Choropleth Maps in Python*](/python/county-choropleth/) for more information on the county choropleth figure factory.

### Where to next?[¶](#Where-to-next?)

Once you've installed, you can use our documentation in three main ways:

1. You jump right in to **examples** of how to make [basic charts](/python/basic-charts/), [statistical charts](/python/statistical-charts/), [scientific charts](/python/scientific-charts/), [financial charts](/python/financial-charts/), [maps](/python/maps/), and [3-dimensional charts](/python/3d-charts/).
2. If you prefer to learn about the **fundamentals** of the library first, you can read about [the structure of figures](/python/figure-structure/), [how to create and update figures](/python/creating-and-updating-figures/), [how to display figures](/python/renderers/), [how to theme figures with templates](/python/templates/), [how to export figures to various formats](/python/static-image-export/) and about [Plotly Express, the high-level API](/python/plotly-express/) for doing all of the above.
3. You can check out our exhaustive **reference** guides: the [Python API reference](/python-api-reference) or the [Figure Reference](/python/reference)

For information on using Python to build web applications containing plotly figures, see the [*Dash User Guide*](https://dash.plotly.com/).

We also encourage you to join the [Plotly Community Forum](http://community.plotly.com/) if you want help with anything related to `plotly`.

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