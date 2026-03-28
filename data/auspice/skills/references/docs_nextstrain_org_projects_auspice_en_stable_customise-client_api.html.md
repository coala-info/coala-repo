[![Logo](../_static/nextstrain-logo.svg)](https://docs.nextstrain.org)

[Auspice](../index.html)

Introduction

* [Install Auspice](../introduction/install.html)
* [How to Run Auspice](../introduction/how-to-run.html)

Functionality

* [Displaying multiple trees](../advanced-functionality/second-trees.html)
* [View Settings](../advanced-functionality/view-settings.html)
* [Adding extra metadata via CSV/TSV/XLSX](../advanced-functionality/drag-drop-csv-tsv.html)
* [Streamtrees](../advanced-functionality/streamtrees.html)
* [Miscellaneous](../advanced-functionality/misc.html)

Customising Auspice

* [Overview (Client)](overview.html)
* Client Customisation API
* [Requests Made from the Client](requests.html)

Auspice servers

* [Overview (Server)](../server/overview.html)
* [Server API](../server/api.html)
* [Authentication](../server/authentication.html)

Releases

* [Releases](../releases/index.html)
  + [Changelog](../releases/changelog.html)
  + [Auspice Version 2.0](../releases/v2.html)

* [Stuck? Ask us on the discussion board. We're happy to help!](https://discussion.nextstrain.org/)

[Auspice](../index.html)

* [Home](https://docs.nextstrain.org)
* [Auspice](../index.html)
* [View page source](../_sources/customise-client/api.rst.txt)

---

# Client Customisation API[](#client-customisation-api "Link to this heading")

Warning

The functionality detailed in this page needs more attention, both in terms of testing and code development. We expect there to be some bugs and possible API changes. If you rely on this functionality, we recommend you pin your installation of Auspice to a specific version. Please [get in touch with us](https://nextstrain.org/contact) if you are using these customisations so that we can work with you!

This page details the available options and format of the customisations available at (client) build time. They are contained in a JSON file supplied to Auspice via

```
auspice build --extend <JSON>
```

Note

The hot-reloading development functionality does not work for code which is included via this client customisation mechanism. Thus, while you can run `auspice develop --extend <JSON>` it will not update as you may expect!

## Available Customisations[](#client-api-available-customisations "Link to this heading")

The following are definable as top-level keys of the JSON file. A useful reference may be the [customisation JSON file](https://github.com/nextstrain/nextstrain.org/blob/master/auspice-client/customisations/config.json) used by nextstrain.org.

* `sidebarTheme` allows modifications to the aesthetics of the sidebar. See below.
* `navbarComponent` a (relative) path to a JS file exporting a React component to be rendered as the nav bar. See below.
* `splashComponent` a (relative) path to a JS file exporting a React component to be rendered as the splash page. See below.
* `browserTitle` The browser title for the page. Defaults to “auspice” if not defined.
* `finePrint` String of Markdown to add to the “fine print” at the bottom of pages.
* `plausibleDataDomain` plausible.io analytics (see below)
* `googleAnalyticsKey` You can specify a Google Analytics key to enable (some) analytics functionality. This is deprecated and will be removed from an upcoming release.
* `serverAddress` Specify the address / prefix which the auspice client uses for API requests.
* `mapTiles` Specify the address (and other information) for the tiles used to render the map.

Note

Please remember to make any modifications, including customisations described here, publicly available. See [the previous page](overview.html) for more details.

---

### Sidebar Theme[](#sidebar-theme "Link to this heading")

The appearence of the sidebar can be customised by specifing a theme in the config JSON used to build Auspice. This theme is then available (via [styled-components](https://www.styled-components.com/)) to the components rendered in the sidebar. It is also passed to the nav bar component (see below) as the `theme` prop.

For instance, here is the customisation used by nextstrain.org:

```
{
  "sidebarTheme": {
    "background": "#F2F2F2",
    "color": "#000",
    "sidebarBoxShadow": "rgba(0, 0, 0, 0.2)",
    "font-family": "Lato, Helvetica Neue, Helvetica, sans-serif",
    "selectedColor": "#5097BA",
    "unselectedColor": "#333",
    "alternateBackground": "#888"
  }
}
```

| Properties | CSS string of | Description |
| --- | --- | --- |
| selectedColor | color | Text color of selected text / button text |
| unselectedColor | color | Text color of unselected text / button text |
| color | color | Text color of all other text |
| unselectedBackground (deprecated) | color | Old key for `alternateBackground` |
| alternateBackground | color | Background color of some elements (unselected toggle, panel section borders) |
| font-family | font | Font used throughout the sidebar |
| background | color | Background color of the entire sidebar |

## Components[](#components "Link to this heading")

One way to extend Auspice is by replacing React components with your own custom components. These custom components will receive props defined here, which can be used to update the rendering of the component using the normal react lifecycle methods. Right now this is only available for the splash page and nav-bar components, whose interfaces are defined here.

Each component must be the default export of a javascript file which is specified in the (client) config JSON passed to Auspice at build time (`auspice build` or `auspice develop`).

### Nav-bar Component[](#nav-bar-component "Link to this heading")

**Build config:**

```
{
  "navbarComponent": "<relative path to javascript file>"
}
```

Where the javascript file contains a default export of a React component.

**React Props Available:**

| Prop | Type | Description |
| --- | --- | --- |
| `narrativeTitle` | String |  |
| `sidebar` | Bool | Is it to be displayed in the sidebar? |
| `width` | Number | Width of the sidebar, in pixels |
| `theme` | Object | See above. Use this to style components. |

### Splash component[](#splash-component "Link to this heading")

Define a custom splash page for Auspice. Please note that this is extremely expirimental and the interface is expected to change.

**Build config:**

```
{
  "splashComponent": "<relative path to javascript file>"
}
```

Where the javascript file contains a default export of a React component.

**React Props available:**

| Prop | Type | Description |
| --- | --- | --- |
| `isMobile` | Bool |  |
| `available` | Object | available datasets and narratives |
| `browserDimensions` | Object | Browser width & height |
| `dispatch` | function | access to redux’s dispatch mechanism |
| `errorMessage` | function | to do |
| `changePage` | function | to do |

---

### Specifying the API server address[](#specifying-the-api-server-address "Link to this heading")

By default, the client makes API requests ([as detailed here](requests.html)) to “/charon/getAvailable”, “/charon/getDataset” etc. This is using the default server address of “/charon”. This can be changed by specifying `serverAddress` in the customisation JSON.

Note

If you specify a `serverAddress` on a different origin (protocol + domain + port) than Auspice, the server will need to send CORS headers to permit the requests from Auspice.

---

### Custom Map tiles[](#custom-map-tiles "Link to this heading")

Auspice uses [Leaflet](https://leafletjs.com/) to render the map, which requires access to a tile set in order to render the geography. By default, auspice uses [Mapbox](https://www.mapbox.com/) for these tiles, and we make these available for local use of auspice. If you are distributing your own version of auspice (i.e. not running it locally) you must set an appropriate API address here so that the map can fetch suitable tiles.

```
{
  "mapTiles": {
    "api": "API address for Leaflet to fetch map tiles",
    "attribution": "HTML-formatted attribution string to be displayed in bottom-right-hand corner of map",
    "mapboxWordmark": "(optional) should the Mapbox logo be displayed in the bottom-left of the map? (boolean)"
  }
}
```

Please see [this discussion post](https://discussion.nextstrain.org/t/build-with-newest-nextstrain-ncov-has-api-requests-to-mapbox-403-forbidden/396/11?u=james) for a hands-on guide to setting custom map tile info. For some examples of other tile sets you may use, see the [OpenStreetMap wiki](https://wiki.openstreetmap.org/wiki/Tile_servers), and please remember to adhere to the licenses and terms of use for each tile server. The API address contains parameters as specified by the [Leaflet API](https://docs.mapbox.com/api/overview/).

---

### Tracking Analytics[](#tracking-analytics "Link to this heading")

Auspice has in-built support for [Plausible Analytics](https://plausible.io/docs). To enable this you will need to provide the `plausibleDataDomain` in your extensions. The analytics are not included when running Auspice in development mode.

Auspice has support for Google Analytics but this is deprecated and will be removed in a future release. Google Analytics run when the `googleAnalyticsKey` extension is set and only run in production mode.

[Previous](overview.html "Overview (Client)")
[Next](requests.html "Requests Made from the Client")

---

Hadfield *et al.,*
[Nextstrain: real-time tracking of pathogen evolution](https://doi.org/10.1093/bioinformatics/bty407)
*, Bioinformatics* (2018)

The core Nextstrain team is

[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/trevor-bedford.jpg)
Trevor Bedford](http://bedford.io/team/trevor-bedford/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/richard-neher.jpg)
Richard Neher](https://neherlab.org/richard-neher.html)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/ivan-aksamentov.jpg)
Ivan Aksamentov](https://neherlab.org/ivan-aksamentov.html)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/kim-andrews.jpg)
Kim Andrews](https://bedford.io/team/kim-andrews/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/jennifer-chang.jpg)
Jennifer Chang](https://bedford.io/team/jennifer-chang/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/james-hadfield.jpg)
James Hadfield](http://bedford.io/team/james-hadfield/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/emma-hodcroft.jpg)
Emma Hodcroft](http://emmahodcroft.com/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/john-huddleston.jpg)
John Huddleston](http://bedford.io/team/john-huddleston/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/jover-lee.jpg)
Jover Lee](http://bedford.io/team/jover-lee/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/victor-lin.png)
Victor Lin](https://bedford.io/team/victor-lin/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/cornelius-roemer.jpg)
Cornelius Roemer](https://neherlab.org/cornelius-roemer.html)

Please see the [team page](https://nextstrain.org/team) for more details.

All [source code for Nextstrain](https://github.com/nextstrain) is freely available under the terms of an [open-source license](https://opensource.org/osd), typically [AGPL-3.0](https://opensource.org/licenses/AGPL-3.0) or [MIT](https://opensource.org/licenses/MIT).
Refer to specific projects for details.
Screenshots may be used under a [CC-BY-4.0 license](https://creativecommons.org/licenses/by/4.0/) and attribution to nextstrain.org must be provided.

This work is made possible by the open sharing of genetic data by research groups from all over the world.
We gratefully acknowledge their contributions.
Special thanks to Kristian Andersen, Josh Batson, David Blazes, Jesse Bloom, Peter Bogner, Anderson Brito, Matt Cotten, Ana Crisan, Tulio de Oliveira, Gytis Dudas, Vivien Dugan, Karl Erlandson, Nuno Faria, Jennifer Gardy, Nate Grubaugh, Becky Kondor, Dylan George, Ian Goodfellow, Betz Halloran, Christian Happi, Jeff Joy, Paul Kellam, Philippe Lemey, Nick Loman, Duncan MacCannell, Erick Matsen, Sebastian Maurer-Stroh, Placide Mbala, Danny Park, Oliver Pybus, Andrew Rambaut, Colin Russell, Pardis Sabeti, Katherine Siddle, Kristof Theys, Dave Wentworth, Shirlee Wohl and Cecile Viboud for comments, suggestions and data sharing.

---

[![Logo of the Fred Hutch](../_static/logos/fred-hutch-logo-small.png)](http://www.fredhutch.org/)
[![Logo of the Swiss Institute of Bioinformatics](../_static/logos/sib-logo.png)](http://www.sib.swiss/)
[![Logo of the National Institutes of Health](../_static/logos/nih-logo.jpg)](https://www.nih.gov/)
[![Logo of Mapbox](../_static/logos/mapbox-logo-black.svg)](https://www.mapbox.com)
[![Logo of the University of Basel](../_static/logos/unibas-logo.svg)](https://unibas.ch/)
[![Logo of the Open Science Prize](../_static/logos/osp-logo-small.png)](https://www.nih.gov/news-events/news-releases/open-science-prize-announces-epidemic-tracking-tool-grand-prize-winner)
[![Logo of the Biozentrum](../_static/logos/bz_logo.png)](http://biozentrum.org/)

© Copyright 2020, James Hadfield, Trevor Bedford and Richard Neher

Built with [Sphinx](https://www.sphinx-doc.org/)
using [our customised version](https://github.com/nextstrain/sphinx-theme) of a
[base theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by
[Read the Docs](https://readthedocs.org).