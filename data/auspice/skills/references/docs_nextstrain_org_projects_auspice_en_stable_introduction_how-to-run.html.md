[![Logo](../_static/nextstrain-logo.svg)](https://docs.nextstrain.org)

[Auspice](../index.html)

Introduction

* [Install Auspice](install.html)
* How to Run Auspice

Functionality

* [Displaying multiple trees](../advanced-functionality/second-trees.html)
* [View Settings](../advanced-functionality/view-settings.html)
* [Adding extra metadata via CSV/TSV/XLSX](../advanced-functionality/drag-drop-csv-tsv.html)
* [Streamtrees](../advanced-functionality/streamtrees.html)
* [Miscellaneous](../advanced-functionality/misc.html)

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
* [View page source](../_sources/introduction/how-to-run.rst.txt)

---

# How to Run Auspice[](#how-to-run-auspice "Link to this heading")

Auspice is run as a command line program – `auspice` – with various subcommands. You can run each command with `--help` attached to see help from the command line.

* `auspice view --help` (this is the main command for interacting with Auspice)
* `auspice build --help`
* `auspice develop --help`
* `auspice convert --help`

## How to Get an Example Dataset Up and Running[](#how-to-get-an-example-dataset-up-and-running "Link to this heading")

In order to get up and running you’ll need to have some datasets to visualise. For the purposes of getting Auspice up and running you can download the current Zika dataset via:

```
mkdir datasets
curl http://data.nextstrain.org/zika.json --compressed -o datasets/zika.json
```

And then run `auspice` via:

```
auspice view --datasetDir datasets
```

This will allow you to run Auspice locally (i.e. from your computer) and view the dataset which is behind [nextstrain.org/zika](https://nextstrain.org/zika). [See below](#introduction-obtaining-a-set-of-input-files) for how to download all of the data available on [nextstrain.org](https://nextstrain.org).

To analyse your own data, please see the tutorials on the [nextstrain docs](https://nextstrain.org/docs/).

## `auspice view`[](#auspice-view "Link to this heading")

This is the main command we’ll run Auspice with, as it makes Auspice available in a web browser for you. There are two common arguments used:

| argument name | data supplied | description |
| --- | --- | --- |
| datasetDir | PATH | Directory where datasets (JSONs) are sourced. This is ignored if you define custom handlers. |
| narrativeDir | PATH | Directory where narratives (Markdown files) are sourced. This is ignored if you define custom handlers. |

For more complicated setups, where you define your own server handlers, see [supplying custom handlers to the Auspice server](../server/api.html#server-api-supplying-custom-handlers).

## `auspice build`[](#auspice-build "Link to this heading")

Build the client source code bundle. This is needed in three cases:

1. You have installed Auspice from source, or updated the source code.
2. You are editing the source code and need to rebuild the client
3. You wish to build a customised version of the Auspice client. See [Customising Auspice](../customise-client/overview.html) for more info.

## `auspice develop`[](#auspice-develop "Link to this heading")

Launch Auspice in development mode. This runs a local server and uses hot-reloading to allow automatic updating as you edit the code.

This is only useful if you are editing the client source code!

## `auspice convert`[](#auspice-convert "Link to this heading")

This is a utility command to convert between dataset formats. Currently, it only converts “Auspice v1” JSONs into “Auspice v2” JSONs, using the same code that is [programatically importable](../server/api.html#server-api-convertfromv1).

Right now, `auspice view` will automatically convert “v1” JSONs into “v2” JSONs, so there’s no need to do this yourself.

## Input File Formats[](#input-file-formats "Link to this heading")

Auspice is agnostic about the data it visualises – they don’t have to be viral genomes, or real-time, or generated in Augur. (They do, however have to be in a specific file format.)

Auspice takes two different file types:

* Datasets (the tree, map, etc.), which are defined as one or more JSON files.
* Narratives, which are specified as a Markdown file.

See the [Server API](../server/api.html) for more details about the file formats an Auspice server (e.g. `auspice view`) sends to the client.

### Dataset JSONs[](#dataset-jsons "Link to this heading")

Currently we mainly use [Augur](https://github.com/nextstrain/augur) to create these datasets. See [the Nextstrain documentation](https://nextstrain.org/docs/bioinformatics/introduction-to-augur) for more details on this process.

Datasets JSONs include:

* Auspice v2 JSON (required) - [schema here](https://github.com/nextstrain/augur/blob/master/augur/data/schema-export-v2.json). It includes the following information:
  :   + `tree`: The tree structure encoded as a deeply nested JSON object.
        :   - Traits (such as country, divergence, collection date, attributions, etc.) are stored on each node.
            - The presence of a `children` property indicates that it’s an internal node and contains the child objects.
      + `metadata`: Additional data to control and inform the visualization.
* Frequency JSON (optional) - [example here](http://data.nextstrain.org/flu_seasonal_h3n2_ha_2y_tip-frequencies.json)
  :   + Generates the frequencies panel, e.g. on [nextstrain.org/flu](https://nextstrain.org/flu).

Note

We are working on ways to make datasets in Newick / Nexus formats available. You can see an early prototype of this at [auspice-us.herokuapp.com](https://auspice-us.herokuapp.com/) where you can drop on Newick (and CSV) files. Using BEAST trees is possible, but you have to use Augur to convert them first.

Note

If you happen to maintain builds that rely on Auspice v1, don’t worry - Auspice v2 is backward compatible and accepts the v1 format as well. The v1 schema is also available below. See [the v2 release notes](../releases/v2.html) for details and motivation for the v2 format.

#### Auspice v1 JSONs (for backwards compatibility use only)[](#auspice-v1-jsons-for-backwards-compatibility-use-only "Link to this heading")

Auspice works with the v1 format for backwards compatibility. *The zika dataset we download above is in this format.*

This format includes:

* Tree JSON (required) - [schema here](https://github.com/nextstrain/augur/blob/master/augur/data/schema-export-v1-tree.json)
  :   + The same tree information as in the v2 JSON above in a separate file whose name *must* end with `_tree.json`.
* Metadata JSON (required) - [schema here](https://github.com/nextstrain/augur/blob/master/augur/data/schema-export-v1-meta.json)
  :   + The same metadata information as in the v2 JSON above in a separate file whose name *must* end with `_meta.json` and have the same prefix as the tree JSON above.
* Frequency JSON (optional) - [example here](http://data.nextstrain.org/flu_seasonal_h3n2_ha_2y_tip-frequencies.json)
  :   + Generates the frequencies panel, e.g. on [nextstrain.org/flu](https://nextstrain.org/flu).

### Narratives[](#narratives "Link to this heading")

For narratives, please see [Writing a Narrative](https://docs.nextstrain.org/en/latest/tutorials/narratives-how-to-write.html) for a description of the file format.

## Obtaining a Set of Input Files[](#introduction-obtaining-a-set-of-input-files "Link to this heading")

If you’d like to download the dataset JSONs which are behind the core-datasets shown on [nextstrain.org](https://nextstrain.org), then you can run [this script](https://github.com/nextstrain/auspice/blob/master/scripts/get-data.sh) which will create a `./data` directory for you.

The nextstrain-maintained narratives are stored in the [nextstrain/narratives github repo](https://github.com/nextstrain/narratives). You can obtain these by cloning that repo.

You can then run `auspice view --datasetDir data --narrativeDir <path-to-narratives>` to visualise all of the [nextstrain.org](https://nextstrain.org) datasets locally.

[Previous](install.html "Install Auspice")
[Next](../advanced-functionality/second-trees.html "Displaying multiple trees")

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