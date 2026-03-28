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

* [Overview (Client)](../customise-client/overview.html)
* [Client Customisation API](../customise-client/api.html)
* [Requests Made from the Client](../customise-client/requests.html)

Auspice servers

* Overview (Server)
* [Server API](api.html)
* [Authentication](authentication.html)

Releases

* [Releases](../releases/index.html)
  + [Changelog](../releases/changelog.html)
  + [Auspice Version 2.0](../releases/v2.html)

* [Stuck? Ask us on the discussion board. We're happy to help!](https://discussion.nextstrain.org/)

[Auspice](../index.html)

* [Home](https://docs.nextstrain.org)
* [Auspice](../index.html)
* [View page source](../_sources/server/overview.rst.txt)

---

# Overview (Server)[](#overview-server "Link to this heading")

The Auspice client (i.e. what you see in the web browser) requires a server behind it to
- (a) serve the client HTML, CSS & JavaScript to the browser and
- (b) handle certain [GET](https://en.wikipedia.org/wiki/HTTP) requests from the client, for instance “give me the zika dataset to display”.

We provide a basic server to run Auspice locally – any time you run `auspice view` or `auspice develop` you’re running a server!
In these cases, the server is running on your computer, sending datasets and narratives, which are stored on your machine, to the Auspice client.
Alternatively, you can build your own server – it just needs to satisfy the above two requirements.

## GET Requests[](#get-requests "Link to this heading")

Currently the client is able to make three requests:

| address | description |
| --- | --- |
| `/charon/getAvailable` | return a list of available datasets and narratives |
| `/charon/getDataset` | return the requested dataset |
| `/charon/getNarrative` | return the requested narrative |

For instance, when you’re running `auspice view` if you go to [localhost:4000/charon/getAvailable](http://localhost:4000/charon/getAvailable) you’ll see a list of the available datasets and narratives known to the server.
Similarly, nextstrain.org is a server which has handlers for these three API endpoints, so if you visit [nextstrain.org/charon/getAvailable](https://nextstrain.org/charon/getAvailable) you’ll see Nextstrain’s available datasets.

See [the server API](api.html) for details about each of these requests.

Note

Note that “/charon” can be changed to any address you wish by customising the client at build time.
See the client-cusomisation API <../customise-client/api.html> for more details.

## The “Default” Auspice Server[](#the-default-auspice-server "Link to this heading")

The server provided with Auspice is intended to be run on your local setup.
It thus scans the directories you provide when you run it in order to find datasets and narratives to serve.
It has “handlers” for each of the above 3 requests – i.e. bits of code that tell it how to handle each request.

## Customising the Default Auspice Server[](#customising-the-default-auspice-server "Link to this heading")

You can customise the default Auspice server by supplying your own handlers for each of the three GET requests.
See [the API documentation](api.html#server-api-supplying-custom-handlers) for how to define these and provide them to auspice view.

## AGPL Source Code Requirement[](#agpl-source-code-requirement "Link to this heading")

Auspice is distributed under [AGPL 3.0](https://www.gnu.org/licenses/agpl-3.0.en.html).
Any modifications made to the auspice source code, including the auspice server, must be made publicly available.

## Writing Your Own Custom Server[](#writing-your-own-custom-server "Link to this heading")

The provided Auspice server also lets you define your own handlers, allowing plenty of flexibility in how requests are handled.
But if you \_really\_ want to implement your own server, then you only need to implement two things:
- serve the index.html file (and linked javascript bundles) which are created by `auspice build` \_and\_
- handle the three GET requests detailed above

Note

If you’re interested, this is what we do with [nextstrain.org](https://nextstrain.org), where only some of the pages use Auspice ([code](https://github.com/nextstrain/nextstrain.org)).

## Deploying via Heroku[](#deploying-via-heroku "Link to this heading")

It should be simple to deploy a custom version of auspice to any server, but we have experience using [Heroku](https://heroku.com/) apps for this.
Deploying to Heroku is straightforward, but there are a few points to note:

1. You must set the config var `HOST=0.0.0.0` for the app.
2. You will need to either create a `Procfile` or a `npm run start` script which calls `auspice view` (or `npx auspice view` depending on how you implement auspice).
3. Make sure the datasets to be served are either (a) included in your git repo or (b) downloaded by the heroku build pipeline. [We use option (b)](https://github.com/nextstrain/auspice/blob/master/package.json) by specifying a npm script called `heroku-postbuild`.

[Previous](../customise-client/requests.html "Requests Made from the Client")
[Next](api.html "Server API")

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