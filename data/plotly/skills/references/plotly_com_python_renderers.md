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
> Displaying Figures

[Suggest an edit to this page](https://github.com/plotly/plotly.py/edit/doc-prod/doc/python/renderers.md)

# Displaying Figures in Python

Displaying Figures using Plotly's Python graphing library

Plotly Studio: Transform any dataset into an interactive data application in minutes with AI. [Try Plotly Studio now.](https://plotly.com/studio?utm_source=graphing_libraries&utm_medium=documentation&utm_campaign=studio_cloud_community&utm_content=sidebar)

# Displaying Figures[¶](#Displaying-Figures)

Plotly's Python graphing library, `plotly.py`, gives you a wide range of options for how and where to display your figures.

In general, there are six different approaches you can take in order to display `plotly` figures:

* Using the `renderers` framework in the context of a script or notebook (the main topic of this page)
* Using [Plotly Studio](https://plotly.com/studio?utm_medium=graphing_libraries&utm_content=python_renderers) to generate charts using natural language
* Using [Dash](https://dash.plot.ly) in a web app context
* Using a [`FigureWidget` rather than a `Figure`](https://plotly.com/python/figurewidget/) in an [`ipywidgets` context](https://ipywidgets.readthedocs.io/en/stable/)
* By [exporting to an HTML file](https://plotly.com/python/interactive-html-export/) and loading that file in a browser immediately or later
* By [rendering the figure to a static image file using Kaleido](https://plotly.com/python/static-image-export/) such as PNG, JPEG, SVG, PDF or EPS and loading the resulting file in any viewer

Each of the first four approaches is discussed below.

### Displaying Figures Using The `renderers` Framework[¶](#Displaying-Figures-Using-The-renderers-Framework)

The renderers framework is a flexible approach for displaying `plotly.py` figures in a variety of contexts. To display a figure using the renderers framework, you call the `.show()` method on a graph object figure, or pass the figure to the `plotly.io.show` function. With either approach, `plotly.py` will display the figure using the current default renderer(s).

In [1]:

```
import plotly.graph_objects as go
fig = go.Figure(
    data=[go.Bar(y=[2, 1, 3])],
    layout_title_text="A Figure Displayed with fig.show()"
)
fig.show()
```

In most situations, you can omit the call to `.show()` and allow the figure to display itself.

In [2]:

```
import plotly.graph_objects as go
fig = go.Figure(
    data=[go.Bar(y=[2, 1, 3])],
    layout_title_text="A Figure Displaying Itself"
)
fig
```

> To be precise, figures will display themselves using the current default renderer when the two following conditions are true. First, the last expression in a cell must evaluate to a figure. Second, `plotly.py` must be running from within an `IPython` kernel.

**In many contexts, an appropriate renderer will be chosen automatically and you will not need to perform any additional configuration.** These contexts include the classic [Jupyter Notebook](https://jupyter.org/), [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/), [Visual Studio Code notebooks](https://code.visualstudio.com/docs/python/jupyter-support), [Google Colab](https://colab.research.google.com/notebooks/intro.ipynb), [Kaggle](https://www.kaggle.com/kernels) notebooks, [Azure](https://notebooks.azure.com/) notebooks, and the [Python interactive shell](https://www.python.org/shell/).

Additional contexts are supported by choosing a compatible renderer including [QtConsole](https://qtconsole.readthedocs.io/en/stable/), [Spyder](https://www.spyder-ide.org/), and more.

Next, we will show how to configure the default renderer. After that, we will describe all of the built-in renderers and discuss why you might choose to use each one.

> Note: The `renderers` framework is a generalization of the `plotly.offline.iplot` and `plotly.offline.plot` functions that were the recommended way to display figures prior to `plotly.py` version 4. These functions have been reimplemented using the `renderers` framework and are still supported for backward compatibility, but they will not be discussed here.

#### Setting The Default Renderer[¶](#Setting-The-Default-Renderer)

The current and available renderers are configured using the `plotly.io.renderers` configuration object. Display this object to see the current default renderer and the list of all available renderers.

In [3]:

```
import plotly.io as pio
pio.renderers
```

Out[3]:

```
Renderers configuration
-----------------------
    Default renderer: 'notebook_connected'
    Available renderers:
        ['plotly_mimetype', 'jupyterlab', 'nteract', 'vscode',
         'notebook', 'notebook_connected', 'kaggle', 'azure', 'colab',
         'cocalc', 'databricks', 'json', 'png', 'jpeg', 'jpg', 'svg',
         'pdf', 'browser', 'firefox', 'chrome', 'chromium', 'iframe',
         'iframe_connected', 'sphinx_gallery', 'sphinx_gallery_png']
```

The default renderer that you see when you display `pio.renderers` might be different than what is shown here. This is because `plotly.py` attempts to autodetect an appropriate renderer at startup. You can change the default renderer by assigning the name of an available renderer to the `pio.renderers.default` property. For example, to switch to the `'browser'` renderer, which opens figures in a tab of the default web browser, you would run the following.

In [4]:

```
import plotly.io as pio
pio.renderers.default = "browser"
```

> Note: Default renderers persist for the duration of a single session. For example, if you set a default renderer in an `IPython` kernel, that default won't persist across kernel restarts.

It is also possible to set the default renderer using a system environment variable. At startup, `plotly.py` checks for the existence of an environment variable named `PLOTLY_RENDERER`. If this environment variable is set to the name of an available renderer, this renderer is set as the default.

#### Overriding The Default Renderer[¶](#Overriding-The-Default-Renderer)

You can override the default renderer temporarily by passing the name of an available renderer as the `renderer` keyword argument to a figure's `show()` method. For example, to use the `svg` renderer (described later) without changing the default renderer, set `renderer="svg"`:

In [5]:

```
import plotly.graph_objects as go
fig = go.Figure(
    data=[go.Bar(y=[2, 1, 3])],
    layout_title_text="A Figure Displayed with the 'svg' Renderer"
)
fig.show(renderer="svg")
```

−0.500.511.522.500.511.522.53A Figure Displayed with the 'svg' Renderer

#### Built-in Renderers[¶](#Built-in-Renderers)

In this section, we will describe the built-in renderers so that you can choose the one(s) that best suit your needs.

##### Interactive Renderers[¶](#Interactive-Renderers)

Interactive renderers display figures using the plotly.js JavaScript library and are fully interactive, supporting pan, zoom, hover tooltips, etc.

###### `notebook`[¶](#notebook)

This renderer is intended for use in the classic [Jupyter Notebook](https://jupyter.org/install.html) (not JupyterLab). The full plotly.js JavaScript library bundle is added to the notebook the first time a figure is rendered, so this renderer will work without an internet connection.

This renderer is a good choice for notebooks that will be exported to HTML files (Either using [nbconvert](https://nbconvert.readthedocs.io/en/latest/) or the "Download as HTML" menu action) because the exported HTML files will work without an internet connection.

> Note: Adding the plotly.js bundle to the notebook adds a few megabytes to the notebook size. If you can count on always having an internet connection, you may want to consider using the `notebook_connected` renderer if notebook size is a constraint.

###### `notebook_connected`[¶](#notebook_connected)

This renderer is the same as `notebook` renderer, except the plotly.js JavaScript library bundle is loaded from an online CDN location. This saves a few megabytes in notebook size, but an internet connection is required in order to display figures that are rendered this way.

This renderer is a good choice for notebooks that will be shared with [nbviewer](https://nbviewer.jupyter.org/) since users must have an active internet connection to access nbviewer in the first place.

###### `kaggle` and `azure`[¶](#kaggle-and-azure)

These are aliases for `notebook_connected` because this renderer is a good choice for use with [Kaggle Notebooks](https://www.kaggle.com/docs/notebooks) and [Azure Notebooks](https://notebooks.azure.com/).

###### `colab`[¶](#colab)

This is a custom renderer for use with [Google Colab](https://colab.research.google.com).

###### `browser`[¶](#browser)

This renderer will open a figure in a browser tab using the default web browser. This renderer can only be used when the Python kernel is running locally on the same machine as the web browser, so it is not compatible with Jupyter Hub or online notebook services.

> Implementation Note 1: In this context, the "default browser" is the browser that is chosen by the Python [`webbrowser`](https://docs.python.org/3.7/library/webbrowser.html) module.
>
> Implementation Note 2: The `browser` renderer works by setting up a single use local webserver on a local port. Since the webserver is shut down as soon as the figure is served to the browser, the figure will not be restored if the browser is refreshed.

###### `firefox`, `chrome`, and `chromium`[¶](#firefox,-chrome,-and-chromium)

These renderers are the same as the `browser` renderer, but they force the use of a particular browser.

###### `iframe` and `iframe_connected`[¶](#iframe-and-iframe_connected)

These renderers write figures out as standalone HTML files and then display [`iframe`](https://www.w3schools.com/html/html_iframe.asp) elements that reference these HTML files. The `iframe` renderer will include the plotly.js JavaScript bundle in each HTML file that is written, while the `iframe_connected` renderer includes only a reference to an online CDN location from which to load plotly.js. Consequently, the `iframe_connected` renderer outputs files that are smaller than the `iframe` renderer, but it requires an internet connection while the `iframe` renderer can operate offline.

This renderer may be useful when working with notebooks that contain lots of large figures. When using the `notebook` or `notebook_connected` renderer, all of the data for all of the figures in a notebook are stored inline in the notebook itself. If this would result in a prohibitively large notebook size, an `iframe` or `iframe_connected` renderer could be used instead. With the `iframe` renderers, the figure data are stored in the individual HTML files rather than in the notebook itself, resulting in a smaller notebook size.

> Implementation Note: The HTML files written by the `iframe` renderers are stored in a subdirectory named `iframe_figures`. The HTML files are given names based on the execution number of the notebook cell that produced the figure. This means that each time a notebook kernel is restarted, any prior HTML files will be overwritten. This also means that you should not store multiple notebooks using an `iframe` renderer in the same directory, because this could result in figures from one notebook overwriting figures from another notebook.

###### `plotly_mimetype`[¶](#plotly_mimetype)

The `plotly_mimetype` renderer creates a specification of the figure (called a MIME-type bundle), and requests that the current user interface displays it. User interfaces that support this renderer include [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/), [nteract](https://nteract.io/), and the Visual Studio Code [notebook interface](https://code.visualstudio.com/docs/python/jupyter-support).

###### `jupyterlab`, `nteract`, and `vscode`[¶](#jupyterlab,-nteract,-and-vscode)

These are aliases for `plotly_mimetype` since this renderer is a good choice when working in JupyterLab, nteract, and the Visual Studio Code notebook interface. Note that in VSCode Notebooks, the version of Plotly.js that is used to render is provided by the [vscode-python extension](https://code.visualstudio.com/docs/languages/python) and often trails the latest version by several weeks, so the latest features of `plotly` may not be available in VSCode right away. The situation is similar for Nteract.

##### Static Image Renderers[¶](#Static-Image-Renderers)

A set of renderers is provided for displaying figures as static images. See the [Static Image Export](https://plotly.com/python/static-image-export/) page for more information on getting set up.

###### `png`, `jpeg`, and `svg`[¶](#png,-jpeg,-and-svg)

These renderers display figures as static `.png`, `.jpeg`, and `.svg` files, respectively. These renderers are useful for us