[![Logo](../_static/nextstrain-logo.svg)](https://docs.nextstrain.org)

[Auspice](../index.html)

Introduction

* [Install Auspice](../introduction/install.html)
* [How to Run Auspice](../introduction/how-to-run.html)

Functionality

* [Displaying multiple trees](second-trees.html)
* [View Settings](view-settings.html)
* [Adding extra metadata via CSV/TSV/XLSX](drag-drop-csv-tsv.html)
* Streamtrees
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
* [View page source](../_sources/advanced-functionality/streamtrees.rst.txt)

---

# Streamtrees[](#streamtrees "Link to this heading")

* [Overview](#overview)
* [Dataset requirements](#dataset-requirements)
* [User interactions](#user-interactions)
* [Terminology](#terminology)
* [Implementation details](#implementation-details)

  + [Summary of main steps](#summary-of-main-steps)
  + [KDE calculations](#kde-calculations)

## [Overview](#id1)[](#overview "Link to this heading")

[Streamtrees](#term-streamtree) are a novel visualisation approach to describe phylogenetic trees by rendering clades (mono- or para-phyletic) as a streamgraph.
They help with two distinct problems with phylogenetic trees:

1. Large trees (i.e. those with more than a few thousand tips) are both hard to interpret and computationally expensive, as the number of pixels available for each tip becomes miniscule. There have been a number of innovative approaches to address this such as [Taxonium’s](https://taxonium.org) progressive zoom where the number of nodes rendered changes according to the zoom level. Streamtrees replace a clade of nnn tips (∼2n\sim 2n∼2n nodes) with a streamtree with one [ribbon](#term-ribbon) ([stream](#term-stream)) per color-by category, which is both computationally easier to display and easier to interpret as nnn becomes large.
2. Seeing the big themes in trees is often hindered because all branches are given the same visual importance. For instance, seeing geographic jumps in a tree (where geographic ancestry has been inferred) may be difficult for many. Streamtrees may be created to partition the tree based on such jumps and the resulting visual separation of streams is often easier to interpret.

While streamtrees are currently implemented using a standard Auspice phylogenetic tree structure, it is conceivable to instead use a list of samples partitioned by metadata (e.g. Nextclade-assigned lineages) and thus avoid the cost of inferring a tree.

![summary](../_images/streamtrees_summary.png) *Figure 1. Streamtrees summarising all available (17k) Dengue virus genomes, with streamtrees conveying the genotype relationships and individual streams representing sample geography. The dataset remains performant and interactive despite large dataset sizes and we can switch to a more typical tree rendering as needed.*

## [Dataset requirements](#id2)[](#dataset-requirements "Link to this heading")

Streamtrees are created by using (internal) branch labels to partition the data, with all nodes below each label being displayed as streamtrees, one per label. A dataset can be displayed with “normal” nodes as well as streamtrees if the label does not appear on the root node. Multiple labels can be defined for a tree and a drop-down allows us to change the label in use.

You may use the [display default](view-settings.html#dataset-configurable-defaults) `stream_label` or [URL query](view-settings.html#url-query-options) `streamLabel` to start with streamtrees displayed using a specific label. Similarly you may set the (optional) JSON value `.meta.stream_labels: string[]` to limit the branch labels that are considered for streamtrees.

Note: It is possible to create datasets which have labels for which there are no associated tips (as all descendent tips get assigned to other labels). Rendering of streamtrees is not perfect with such datasets as we don’t render the internal-only streamtree and thus there’s a visual break between connected streamtrees.

## [User interactions](#id3)[](#user-interactions "Link to this heading")

Most of the typical interactions available in Auspice are also available in streamtrees such as zooming, hovering, filtering etc.

A toggle and dropdown in the sidebar may be used to change how streamtrees are defined, and changes to the selected color-by will update the way an individual streamtree is decomposed into individual streams.

At the moment streamtrees are only available in rectangular tree views.

## [Terminology](#id4)[](#terminology "Link to this heading")

streamtree[](#term-streamtree "Link to this term")
:   A [streamgraph](https://en.wikipedia.org/wiki/Streamgraph) (a type of stacked area graph which is symmetrical around the horizontal axis) which represents a monophyletic or paraphyletic set of nodes in the tree. The branch leading to the streamtree represents the (internal) node the defining branch label was on, but the streamtree itself only represents terminal nodes (tips). A dataset will typically be displayed as multiple streamtrees, although using a singular streamtree is also possible.

ribbon[](#term-ribbon "Link to this term")
:   A streamtree is partitioned into “categories” (via color-by metadata) and each category is drawn as a ribbon. For certain color-bys the entire streamtree may be a single ribbon. In *Figure 1* each ribbon represents tips from a specific geographic region.

stream[](#term-stream "Link to this term")
:   May refer to a streamtree or a ribbon (context dependent).

pivots[](#term-pivots "Link to this term")
:   A grid of times or divergences (depending on the tree metric in use) which are used to evaluate the kernels associated with each tip. A consistent grid is used across streamtrees, although each streamtree typically only uses a subset of them.

## [Implementation details](#id5)[](#implementation-details "Link to this heading")

### [Summary of main steps](#id6)[](#summary-of-main-steps "Link to this heading")

1. `labelStreamMembership` - traverses the tree, clearing any previous stream information and setting stream information on the root nodes of new streams.
   New streams are identified based on branch labels, so this function is called when streams are first toggled on (which may be when the dataset loads) as well as when the UI changes the stream branch label.

   This creates the mapping of stream name (via the branch label attached to the stream-start node) to an object describing various properties of the stream; see the type `StreamSummary` for more. Furthermore every node in the tree has the boolean property `node.inStream` set.
2. `processStreams` - computes a number of details about each stream, and may be called in a partial fashion in order to skip recomputations as needed. Each stream-start node will have the properties of the type `StreamStartNode` added to it via this function.

   * [Pivots](#term-pivots) for the entire dataset are calculated and a subset of pivots is assigned to each stream.
   * The rendering order for each set of connected streams is computed such that we avoid crossings of branches and streams; see the `calcRenderingOrder` function for more details.
   * Tips in each stream are partitioned via the current color scale
   * Each partition of tips is turned into a ribbon (in weight-space) by evaluating a kernel for each tip across the pivots in the stream and summing the weights. See “KDE calculations” below for more.

   This step is called on:

   * page load
   * change in branch-label
   * toggle stream tree
   * tree visibility updates
   * tree distance metric change
3. Rendering - the streamtree ribbons (in weight-space) are first transformed into display-order space and then to pixel space for rendering.

   > Note
   >
   > This code is all within `PhyloTree`. Not all of these steps need to be called on each update, and not all are explicitly about streams.
   >
   > * `setDisplayOrder`, `setRippleDisplayOrders` - sets `displayOrder` and `displayOrderRange` for the origin node of the stream. The former is the midpoint of the stream, the latter is the range the stream occupies. Also computes `rippleDisplayOrders` (on the stream start node) by converting the already set `streamDimensions` (sum of KDE weights) to an array of ripples in display-order space. The transform of weight-space to display-order space not only shifts the values (so that ultimately streams appear in different places on screen) but also scales them such that they don’t dominate the display-orders set for normally-rendered tips; see `weightToDisplayOrderScaleFactor` for more.
   > * `setDistance` - not required for streams
   > * `setLayout` - not required for streams
   > * `mapToScreen`, `mapStreamsToScreen` - Computes `streamRipples` which are in pixel-space, based on `rippleDisplayOrders` and `streamPivots`. The structure of `streamRipples` is a 3d matrix: `streamRipples[categoryIdx][pivotIdx] = {x, y0, y1}`
   > * `drawStreams` - d3 code to render `streamRipples`, stream labels, and connectors (the branches joining streams to streams)
   >
   > Note
   >
   > Many properties are still set on (or related to) nodes within a stream which don’t need to be set, such as those set by `setDistance` and `setLayout`, branch thicknesses etc. We should be able to improve performance by ignoring these updates while stream-trees are in view.

### [KDE calculations](#id7)[](#kde-calculations "Link to this heading")

Streams are a Kernel Density Estimate (KDE) with a Gaussian kernel to smooth out the contribution of each sampled sequence. Each kernel represents a sample with the kernel centered on the sampling date or divergence value and with a constant standard deviation

We calculate a underlying array of pivots spanning all tips (i.e. covering all streams) and extended slightly either side (so, e.g., the earliest sampled tip is not centered at the leftmost pivot). The standard deviation, σ\sigmaσ, of each kernel is a proportion of this pivot span and is thus the same across all kernels and streams. For each stream we use a subset of this list of pivots such that the pivots span the time range (tmin−3σ,tmax+3σ)(t\_{min} - 3\sigma, t\_{max} + 3\sigma)(tmin​−3σ,tmax​+3σ), where tmin,tmaxt\_{min}, t\_{max}tmin​,tmax​ are the minimum and maximum tips in the stream according to divergence values or sampling dates, as appropriate. If tmin−3σ<tstream startt\_{min} - 3\sigma < t\_{stream\ start}tmin​−3σ<tstream start​ then we set the minimum pivot to tstream startt\_{stream\ start}tstream start​ so that streams don’t extend leftwards of the branch connecting to the stream.

These Gaussians are summed together to form the KDE f^(x)=∑i=1nw×N(μ, σ2)\hat{f}(x) = \sum\_{i=1}^{n} w \times \mathcal{N}(\mu,\,\sigma^{2})f^​(x)=∑i=1n​w×N(μ,σ2) where μ\muμ is the tip sampling date/divergence, σ\sigmaσ is a constant across all streams, and www is a per-stream weight defined below. The PDF of the Gaussian is evaluated at each of the stream’s pivots.

The weighting parameter www scales each Gaussian proportional to the number of tips in the stream (mmm) via a negative exponential w=exp⁡(−(m−4)4)+1w=\exp(\frac{-(m-4)}{4})+1w=exp(4−(m−4)​)+1. This improves the interpretability of streams by increasing the rendering size of small streams (especially streams with a single tip), but we lose the ability to directly compare streams against one another.

[Previous](drag-drop-csv-tsv.html "Adding extra metadata via CSV/TSV/XLSX")
[Next](misc.html "Miscellaneous")

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
Special thanks to Kristian Andersen, Josh Batson, David Blazes, Jesse Bloom, Peter Bogner, Anderson Brito, Matt Cotten, Ana Cri