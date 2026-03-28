[![Logo](../_static/nextstrain-logo.svg)](https://docs.nextstrain.org)

[Auspice](../index.html)

Introduction

* [Install Auspice](../introduction/install.html)
* [How to Run Auspice](../introduction/how-to-run.html)

Functionality

* [Displaying multiple trees](second-trees.html)
* [View Settings](view-settings.html)
* Adding extra metadata via CSV/TSV/XLSX
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
* [View page source](../_sources/advanced-functionality/drag-drop-csv-tsv.rst.txt)

---

# Adding extra metadata via CSV/TSV/XLSX[](#adding-extra-metadata-via-csv-tsv-xlsx "Link to this heading")

A common use case is to have additional metadata which you would like to add to the current dataset. If you created the dataset itself, then you may wish to keep certain data out of the dataset, as it may change frequently or be sensitive information which you don’t want to share publicly.

Additional metadata (CSV / TSV / XLSX file(s)) can be dragged onto an existing dataset in Auspice. These extra data are processed within the browser, so no information leaves the client, which can be useful for viewing private metadata.

The general format is compatible with other popular tools such as [MicroReact](https://microreact.org/). The first column defines the names of the strains / samples in the tree, while the first row (header row) defines the metadata names. You can add as many columns you want, each will result in a different colouring of the data being made available. The separator can be either a tab character or a comma & the file extension should be `.tsv` or `.csv`, respectively. Excel files with file extension `.xlsx` are also supported, but the metadata must be in the first sheet of the workbook. Older Excel files with the `.xls` extension are not supported.

## Example:[](#example "Link to this heading")

A [`small TSV file`](../_downloads/c5920f6e79966532916a881fb5cbc211/extra-data.tsv) with the following data:

|  |  |
| --- | --- |
| strain | secret |
| USVI/19/2016 | A |
| USVI/28/2016 | B |
| USVI/41/2016 | C |
| USVI/42/2016 | C |

can be dragged onto [nextstrain.org/zika](https://nextstrain.org/zika) to add a “secret” color-by:

![Auspice with extra data shown via TSV](../_images/extra-data.png)

Auspice with extra data shown via TSV[](#id1 "Link to this image")

A [`more complex TSV file`](../_downloads/c2ab0492afe4f741a9fab0cefc0953af/extra-data-2.tsv) can add more data to make use of additional features available:

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| strain | secret | secret\_\_colour | latitude | longitude |
| USVI/19/2016 | A | #f4e409 | 0 | -120 |
| USVI/28/2016 | B | #f49015 | 0 | -115 |
| USVI/41/2016 | C | #710000 | 0 | -100 |
| USVI/42/2016 | C | #710000 | 0 | -120 |

This defines colours for the metadata (e.g. `A` is yellow, `B` is orange) as well as associating strains with (made up) geographic coordinates. When dragged onto [nextstrain.org/zika](https://nextstrain.org/zika), it looks like:

![Auspice with extra data shown via TSV](../_images/extra-data-2.png)

Auspice with extra data shown via TSV[](#id2 "Link to this image")

## Adding extra colorings and filters[](#adding-extra-colorings-and-filters "Link to this heading")

Most metadata columns will be added as colourings; once the data has been added they should appear as new entries in the “Color By” dropdown (Left-hand sidebar of Auspice). This means you can also filter by these traits using the “Filter Data” box.

An extra colouring is automatically created to represent the set of samples which were in the CSV/TSV/XLSX file – this allows you to easily filter the dataset to just those samples which you had in your metadata file.

You can choose the colours you want to associate with values by adding in a separate column with the same name + `__colour` (see above example), or the suffix `__color` may also be used. Currently the values in this column must be hex values such as `#3498db` (blue). If the same value of metadata is associated with multiple, distinct, colours then the colours are blended together.

## Adding geographic locations[](#adding-geographic-locations "Link to this heading")

If the columns `latitude` and `longitude` exist (or `__latitude` and `__longitude`) then you can see these samples on the map. This means that there will be a new geographic resolution available in the sidebar dropdown, labelled the same as the metadata filename you dropped on, which will plot the location on the map for those samples in the metadata file for which you provided positions for.

Additional metadata of this format defines lat-longs *per-sample*, which is different to Nextstrain’s approach (where we associate a location to a metadata trait). To resolve this, we create a new (dummy) trait whose values represent the unique lat/longs provided. In the above example screenshot, note that auspice groups `USVI/19/2016` and `USVI/42/2016` together on the map as their lat/longs are identical; the other metadata columns (e.g. `secret`) are irrelevant in this case.

> P.S. If the dataset itself doesn’t contain any geographic data, then adding metadata will trigger the map to be displayed.

## Privacy[](#privacy "Link to this heading")

All data added via these additional metadata files remains in-browser, and doesn’t leave your computer. This makes it safe for sensitive data.

## Schema[](#schema "Link to this heading")

The following fields are ignored completely. (Some of these may be allowed in the future when we have increased the features available here.)

```
name
div
vaccine
labels
hidden
mutations
url
authors
accession
traits
children
date
num_date
year
month
day
```

Fields which end with certain strings are treated as follows:

* `__autocolour`: this suffix is dropped, but the column is otherwise parsed as normal
* `__colour`: see above section on adding colours
* `__shape`: this column is currently ignored

The following columns are interpreted as geographic locations (see section above) and therefore are not added as a colouring:

```
__latitude
__longitude
latitude
longitude
```

The name of the first column is not used, but the first column is always taken to be the sample (strain) name.

## Scale types[](#scale-types "Link to this heading")

The type of the data is currently always categorical. This means that while numeric data will work, it won’t be very usable if there are many values.

[Previous](view-settings.html "View Settings")
[Next](streamtrees.html "Streamtrees")

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