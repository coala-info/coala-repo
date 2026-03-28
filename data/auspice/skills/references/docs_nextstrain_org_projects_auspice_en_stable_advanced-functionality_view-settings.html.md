[![Logo](../_static/nextstrain-logo.svg)](https://docs.nextstrain.org)

[Auspice](../index.html)

Introduction

* [Install Auspice](../introduction/install.html)
* [How to Run Auspice](../introduction/how-to-run.html)

Functionality

* [Displaying multiple trees](second-trees.html)
* View Settings
* [Adding extra metadata via CSV/TSV/XLSX](drag-drop-csv-tsv.html)
* [Streamtrees](streamtrees.html)
* [Miscellaneous](misc.html)

Customising Auspice

* [Overview (Client)](../customise-client/overview.html)
* [Client Customisation API](../customise-client/api.html)
* [Requests Made from the Client](../customise-client/requests.html)

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
* [View page source](../_sources/advanced-functionality/view-settings.rst.txt)

---

# View Settings[](#view-settings "Link to this heading")

View settings refer to things such as how we display the tree (radial? root-to-tip?), what panels we display (map? tree? both?), what colouring we are using etcetera. There are three ways these can be controlled:

1. The defaults are configured by the dataset creators (and stored as “display defaults” in the dataset JSON). This allows
2. Interacting with the visualisation (e.g. changing the color-by) modifies the view, and the URL is changed accordingly. For instance, change [nextstrain.org/zika](https://nextstrain.org/zika) to have a color-by of author, and you’ll see the URL silently update to [?c=author](https://nextstrain.org/zika?c=author). If you reload the page or share this URL, then the color-by is set via this URL.
3. Narratives, in which the narrative author chooses different “views” for each page, are created by associating each page with a URL (see (2)) which defines a specific view into the data.

## Auspice (hardcoded) defaults[](#auspice-hardcoded-defaults "Link to this heading")

Auspice has some hardcoded defaults, largely for historical reasons. Each of these can be overridden by the JSON `display_defaults`, and then the view can be further modified by the URL query (see below).

* Default phylogeny layout is rectangular.
* Default phylogeny distance measure is time, if available.
* Default geographic resolution is “country”, if available.
* Default colouring is “country”, if available.
* Default branch labelling is “clade”, if available.
* Default tip labelling is the sample / strain name (`node.name`)

## Dataset (JSON) configurable defaults[](#dataset-configurable-defaults "Link to this heading")

These are exported as the (optional) property of the dataset JSON `meta.display_defaults` (see JSON schema [here](https://github.com/nextstrain/augur/blob/master/augur/data/schema-export-v2.json)). The defaults (as set here) will be what are displayed when the page is loaded with no URL queries, but be aware that URL queries (see below) can modify how the view looks. For instance, if you set `display_defaults.color_by` to `country`, but load the page with `?c=region` then the view will be coloured by region.

| Property | Description | Example |
| --- | --- | --- |
| `color_by` | Colouring | “country” |
| `geo_resolution` | Geographic resolution | “country” |
| `distance_measure` | Phylogeny x-axis measure | “div” or “num\_date” |
| `map_triplicate` | Should the map repeat, so that you can pan further in each direction? | Boolean |
| `layout` | Tree layout | “rect”, “radial”, “unrooted”, “clock” or “scatter” |
| `tip_label` | What attribute (in ‘node\_attrs’) to use as tip (node) labels | “country” |
| `branch_label` | Which set of branch labels are to be displayed | “aa”, “lineage” |
| `sidebar` | Should the sidebar start open or closed? | “open” or “closed” |
| `panels` | List of panels which (if available) are to be displayed | [“tree”, “map”] |
| `transmission_lines` | Should transmission lines (if available) be rendered on the map? | Boolean |
| `stream_label` | Show streamtrees using this branch label (“none” starts toggled off) | “none”, “clade”, “lineage” etc |
| `language` | Language to display Auspice in | “ja” |
| `label` | Labelled branch that tree starts zoomed to | “Sublineage:J” or “clade:2a.3a” |
| `treeZoom` | Controls how a tree is initially zoomed (see note below) | “treeZoom=selected” |

* The treeZoom=selected query is only applicable in certain circumstances and acts as if we had applied all other view settings and then clicked the “zoom to selected” button. The behaviour of the “zoom to selected” button can differ depending on the current zoom level of the tree, and the URL query will only be set if the same zoom level is obtaibavle if you click the button from a fully zoomed out state; see [this GitHub thread for more details](<https://github.com/nextstrain/auspice/pull/1321#issuecomment-2914923800>). Finally, if a label query is in the URL then that will be used instead as it has higher specificity.

Certain other properties on the JSON’s `meta` dictionary also affect the view settings.
See the [JSON schema](https://github.com/nextstrain/augur/blob/master/augur/data/schema-export-v2.json) for more details.

* `meta.panels` (required) lists the possible panels that auspice may display for the dataset, whereas `meta.display_defaults.panels` (optional) controls which are toggled on by default.
* `meta.stream_labels` (optional) defines the branch labels which can be used to define streamtrees. Use an empty array to disable the use of streamtrees. If this is not set then we will use all defined branch labels on the tree.

**See this in action:**

For instance, go to [nextstrain.org/flu/seasonal/h3n2/ha/2y](https://nextstrain.org/flu/seasonal/h3n2/ha/2y) and you’ll see how the colouring is “Clade” – this has been set via the `display_defaults` in the JSON.

## URL query options[](#url-query-options "Link to this heading")

URL queries are the part of the URL coming after the `?` character, and typically consist of `key=value` – for instance [nextstrain.org/zika?c=author](https://nextstrain.org/zika?c=author) has a query with a key `c` and value `author`. Multiple queries are separated by the `&` character. All URL queries modify the view away from the default settings – if you change back to a default then that URL query will disappear.

| Key | Description | Example(s) |
| --- | --- | --- |
| `c` | Colouring to use | `c=author`, `c=region` |
| `r` | Geographic resolution | `r=region` |
| `m` | Phylogeny x-axis measure | `m=div` |
| `l` | Phylogeny layout | `l=clock` |
| `scatterX` | Scatterplot X variable | `scatterX=num_date` |
| `scatterY` | Scatterplot Y variable | `scatterY=num_date` |
| `branches` | Hide branches | `branches=hide` |
| `regression` | Show/Hide regression line | `regression=hide`, `regression=show` |
| `transmissions` | Hide transmission lines | `transmissions=hide` |
| `lang` | Language | `lang=ja` (Japanese) |
| `dmin` | Temporal range (minimum) | `dmin=2008-05-13` |
| `dmax` | Temporal range (maximum) | `dmax=2010-05-13` |
| `f_<name>` | Data filter. Multiple values per key are `,` separated. | `f_region=Oceania` |
| `gt` | Genotype filtering |  |
| `d` | List of panels to display, `,` separated | `d=tree,map` |
| `p` | Panel layout (buggy!) | `p=full`, `p=grid` |
| `gmin` | Entropy panel zoom (minimum) bound | `gmin=1000` |
| `gmax` | Entropy panel zoom (maximum) bound | `gmax=2000` |
| `animate` | Animation settings |  |
| `n` | Narrative page number | `n=1` goes to the first page |
| `s` | Selected strain | `s=1_0199_PF` |
| `tl` | Tip label to display | `tl=country` |
| `branchLabel` | Branch labels to display | `branchLabel=aa` |
| `showBranchLabels` | Force all branch labels to be displayed | `showBranchLabels=all` |
| `streamLabel` | Show stream trees defined by this label key | `streamLabel=clade` |
| `label` | Labeled branch that tree is zoomed to | `label=clade:B3`, `label=lineage:relapse` |
| `clade` | *DEPRECATED* Labeled clade that tree is zoomed to | `clade=B3` should now become `label=clade:B3` |
| `sidebar` | Force the sidebar into a certain state | `sidebar=closed` or `sidebar=open` |
| `legend` | Force the legend into a certain state | `legend=closed` or `legend=open` |
| `onlyPanels` | Do not display the footer / header. Useful for iframes. | `onlyPanels` |
| `ci` | Display confidence intervals on the tree. | `ci` |

**See this in action:**

For instance, go to [nextstrain.org/flu/seasonal/h3n2/ha/2y?c=num\_date&d=tree,map&m=div&r=region](https://nextstrain.org/flu/seasonal/h3n2/ha/2y?c=num_date&d=tree,map&m=div&p=grid&r=region) and you’ll see how we’ve changed the coloring to a temporal scale (`c=num_date`), we’re only showing the tree & map panels (`d=tree,map`), the tree x-axis is divergence (`m=div`) and the map resolution is region (`r=region`).

### Measurements panel URL query options[](#measurements-panel-url-query-options "Link to this heading")

The following query options are specifically for the measurements panel.

| Key | Description | Example(s) |
| --- | --- | --- |
| `m_collection` | Specify which collection to display | `m_collection=h3n2_ha_cell_hi` |
| `m_display` | Toggle measurements display between mean and raw | `m_display=mean` or `m_display=raw` |
| `m_groupBy` | Specify group by field to use | `m_groupBy=reference_strain` |
| `m_overallMean` | Show or hide the overall mean display | `m_overallMean=show` or `m_overallMean=hide` |
| `m_threshold` | Show or hide the threshold(s) | `m_threshold=show` or `m_threshold=hide` |
| `mf_<field_name>` | Filters for the measurements data. Multiple values for  the same field are specified by multiple query params | `mf_reference_strain=A/Alabama/5/2010`  `mf_clade_reference=145S.2&mf_clade_reference=158N/189K` |

[Previous](second-trees.html "Displaying multiple trees")
[Next](drag-drop-csv-tsv.html "Adding extra metadata via CSV/TSV/XLSX")

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