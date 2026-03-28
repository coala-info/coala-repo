[![Logo](_static/nextstrain-logo.svg)](https://docs.nextstrain.org)

Auspice

Introduction

* [Install Auspice](introduction/install.html)
* [How to Run Auspice](introduction/how-to-run.html)

Functionality

* [Displaying multiple trees](advanced-functionality/second-trees.html)
* [View Settings](advanced-functionality/view-settings.html)
* [Adding extra metadata via CSV/TSV/XLSX](advanced-functionality/drag-drop-csv-tsv.html)
* [Streamtrees](advanced-functionality/streamtrees.html)
* [Miscellaneous](advanced-functionality/misc.html)

Customising Auspice

* [Overview (Client)](customise-client/overview.html)
* [Client Customisation API](customise-client/api.html)
* [Requests Made from the Client](customise-client/requests.html)

Auspice servers

* [Overview (Server)](server/overview.html)
* [Server API](server/api.html)
* [Authentication](server/authentication.html)

Releases

* [Releases](releases/index.html)
  + [Changelog](releases/changelog.html)
  + [Auspice Version 2.0](releases/v2.html)

* [Stuck? Ask us on the discussion board. We're happy to help!](https://discussion.nextstrain.org/)

Auspice

* [Home](https://docs.nextstrain.org)
* Auspice
* [View page source](_sources/index.rst.txt)

---

# Auspice: An Open-source Interactive Tool for Visualising Phylogenomic Data[](#auspice-an-open-source-interactive-tool-for-visualising-phylogenomic-data "Link to this heading")

## *Auspice is software to display beautiful, interactive visualisations of phylogenomic data.*[](#auspice-is-software-to-display-beautiful-interactive-visualisations-of-phylogenomic-data "Link to this heading")

![_images/splash.png](_images/splash.png)

*Auspice being used to show the spread of influenza H7N9 virus across Asia.*

Communicating scientific results while also allowing interrogation of the underlying data is an integral part of the scientific process.
Current scientific publishing practices hinder both the rapid dissemination of epidemiologically relevant results and the ability to easily interact with the data used to draw inferences.
These shortcomings motivated the [Nextstrain](https://nextstrain.org) project, for which Auspice was initially devloped.

Auspice can be run on your computer or integrated into websites.
It allows easy customisation of aesthetics and functionality, and powers the visualisations on [nextstrain.org](https://nextstrain.org).

For a more formal introduction to auspice & the wider nextstrain project, please see [Hadfield et al., Nextstrain: real-time tracking of pathogen evolution, Bioinformatics (2018)](https://academic.oup.com/bioinformatics/article/34/23/4121/5001388).

![_images/v2-pie-charts.gif](_images/v2-pie-charts.gif)

*Exploring Enterovirus d68 by changing between three different colorings: clades, age-ranges & mutations at a certain genome position.*

### License and Copyright[](#license-and-copyright "Link to this heading")

Copyright © 2014-2020 Trevor Bedford and Richard Neher.

Source code to Nextstrain is made available under the terms of the [GNU Affero General Public License](https://github.com/nextstrain/auspice/blob/-/LICENSE.txt) (AGPL). Nextstrain is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

[Next](introduction/install.html "Install Auspice")

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

[![Logo of the Fred Hutch](_static/logos/fred-hutch-logo-small.png)](http://www.fredhutch.org/)
[![Logo of the Swiss Institute of Bioinformatics](_static/logos/sib-logo.png)](http://www.sib.swiss/)
[![Logo of the National Institutes of Health](_static/logos/nih-logo.jpg)](https://www.nih.gov/)
[![Logo of Mapbox](_static/logos/mapbox-logo-black.svg)](https://www.mapbox.com)
[![Logo of the University of Basel](_static/logos/unibas-logo.svg)](https://unibas.ch/)
[![Logo of the Open Science Prize](_static/logos/osp-logo-small.png)](https://www.nih.gov/news-events/news-releases/open-science-prize-announces-epidemic-tracking-tool-grand-prize-winner)
[![Logo of the Biozentrum](_static/logos/bz_logo.png)](http://biozentrum.org/)

© Copyright 2020, James Hadfield, Trevor Bedford and Richard Neher

Built with [Sphinx](https://www.sphinx-doc.org/)
using [our customised version](https://github.com/nextstrain/sphinx-theme) of a
[base theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by
[Read the Docs](https://readthedocs.org).