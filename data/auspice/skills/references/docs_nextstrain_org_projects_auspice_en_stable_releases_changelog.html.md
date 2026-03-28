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

* [Overview (Server)](../server/overview.html)
* [Server API](../server/api.html)
* [Authentication](../server/authentication.html)

Releases

* [Releases](index.html)
  + Changelog
  + [Auspice Version 2.0](v2.html)

* [Stuck? Ask us on the discussion board. We're happy to help!](https://discussion.nextstrain.org/)

[Auspice](../index.html)

* [Home](https://docs.nextstrain.org)
* [Auspice](../index.html)
* [Releases](index.html)
* [View page source](../_sources/releases/changelog.md.txt)

---

# Changelog[](#changelog "Link to this heading")

## version 2.68.0 - 2026/01/20[](#version-2-68-0-2026-01-20 "Link to this heading")

### Major changes[](#major-changes "Link to this heading")

* The “Focus on selected” toggle now zoooms horizontally as well as vertically. This helps to explore clades which only existed for a small proportion of the entire tree’s temporal / divergence range. ([#1993](https://github.com/nextstrain/auspice/pull/1993))
* When multiple trees are displayed (”tangletrees”) the tree-buttons (zoom out, zoom to selected, zoom to root) are now present for each tree and only change their respective tree. ([#2026](https://github.com/nextstrain/auspice/pull/2026))
* We now have a completely new dataset selector, replacing the dropdowns in the sidebar. This is activated by clicking on the dataset name in the sidebar, and allows you to select a new dataset based on the available datasets. This fixes a slew of bugs and should make it much clearer to navigate between datasets. ([#2030](https://github.com/nextstrain/auspice/pull/2030))

### Minor changes[](#minor-changes "Link to this heading")

* Downloaded TSV will include associated URL regardless of value type ([#2024](https://github.com/nextstrain/auspice/pull/2024))
* Tip info modal displays link for traits that have a URL regardless of value type ([#2024](https://github.com/nextstrain/auspice/pull/2024))

## version 2.67.0 - 2025/11/03[](#version-2-67-0-2025-11-03 "Link to this heading")

* Mutations in a node-info modal (via tip click or shift+branch click) are now clickable. Clicking on a mutation will colour the tree by the genotypes at that position. Shift+clicking will append that position to the current genotype colouring (if possible), or remove it if it’s already part of it. Command clicking (with or without shift) will behave similarly but filter the tree via the specific mutated state instead of changing the colouring. ([#2018](https://github.com/nextstrain/auspice/pull/2018))
* Shift-clicking bars in the entropy panel will now add the position to the existing color-by (as long as the gene is the same), or remove it if it was already part of the color-by. ([#2019](https://github.com/nextstrain/auspice/pull/2019))
* Added support for Node.js version 24 and its corresponding NPM version (11). ([#2012](https://github.com/nextstrain/auspice/pull/2012))

## version 2.66.0 - 2025/09/05[](#version-2-66-0-2025-09-05 "Link to this heading")

* Fixed a bug that prevented drag-and-drop metadata files from being parsed that was introduced in version 2.64.0 ([#2007](https://github.com/nextstrain/auspice/pull/2007))
* Added SVG-download support for the measurements panel. ([#2005](https://github.com/nextstrain/auspice/pull/2005))

## version 2.65.0 - 2025/09/02[](#version-2-65-0-2025-09-02 "Link to this heading")

* “show all branch labels” toggle has been updated to only show labels for visible branches, i.e. branches of selected tips after applying filters ([#2004](https://github.com/nextstrain/auspice/pull/2004))

## version 2.64.0 - 2025/08/15[](#version-2-64-0-2025-08-15 "Link to this heading")

* Link-outs are explicitly disabled for v1 datasets because the nextstrain.org API does not support the v1 -> v2 conversion. ([#2002](https://github.com/nextstrain/auspice/pull/2002))
* Added a `treeZoom=selected` query to load trees at the same zoom level after the “zoom to selected” button has been pressed, where applicable. See [the view settings docs](https://docs.nextstrain.org/projects/auspice/en/latest/advanced-functionality/view-settings.html) for more details. ([#1321](https://github.com/nextstrain/auspice/pull/1321))
* Downloaded metadata and acknowledgments TSVs will now use extra columns to export associated URLs. ([#2003](https://github.com/nextstrain/auspice/pull/2003))

**internal changes**

* The JS bundles created when Auspice (client) is built have been changed in various ways ([#1992](https://github.com/nextstrain/auspice/pull/1992)):

  + Polyfills have been updated and we now only add a subset of polyfills to match our 95% browser target used for JS syntax.
  + Bundles are now available using Brotli compression (in addition to gzip) and the Auspice server is updated to support them.
  + Duplicated code has been reduced in the bundles, and the bundle layout has changed.
  + The map component is separated into a new bundle which should improve load times on datasets which don’t use it.
* Loading spinners have been improved in various ways. ([#1991](https://github.com/nextstrain/auspice/pull/1991))
* Logos available in the bundle are used rather than a fetch to an external domain. ([#1996](https://github.com/nextstrain/auspice/pull/1996))
* Added unit tests for `createStateFromQueryOrJSONs`. ([#1988](https://github.com/nextstrain/auspice/pull/1988))

## version 2.63.1 - 2025/06/04[](#version-2-63-1-2025-06-04 "Link to this heading")

* Fixed a bug where datasets without the (optional!) `display_defaults` would crash, which included newick files dragged onto auspice.us. ([#1986](https://github.com/nextstrain/auspice/pull/1986))

## version 2.63.0 - 2025/06/02[](#version-2-63-0-2025-06-02 "Link to this heading")

* **Streamtrees** are a new visualisation option for displaying phylogenetic trees. They require datasets with labels on internal nodes which we essentially use to partition the nodes of the tree and render each partition as a streamgraph. Such visualisations are useful for conveying relationships between parts of the tree as well as improving performance for very large trees. See the [added documentation](https://docs.nextstrain.org/projects/auspice/en/latest/advanced-functionality/streamtrees.html) for more details. ([#1902](https://github.com/nextstrain/auspice/issues/1902))
* Label URL queries (available when zoomed into a node which has an branch label) are now added in more cases and, when loading the page, we now remove the query if it is not valid. ([#1952](https://github.com/nextstrain/auspice/pull/1952))
* Datasets can define `display_defaults.label` to specify the starting zoom level of a tree, similarly to the `?label=...` URL query. ([#1952](https://github.com/nextstrain/auspice/pull/1952))
* The tree’s “Reset Layout” button has been renamed “Zoom to Root”. ([#1952](https://github.com/nextstrain/auspice/pull/1952))
* Removed the experimental markers from “Focus on selected” and “Explode Tree By” options. These seem to be working well. ([#1954](https://github.com/nextstrain/auspice/issues/1954))
* Toggling “Focus on selected” now updates the URL parameter `focus=selected`. URLs with this parameter can be shared to enable focus on initial page load. ([#1955](https://github.com/nextstrain/auspice/issues/1955))
* Added Chinese language support. ([#1959](https://github.com/nextstrain/auspice/pull/1959))
* Added flexibility to the way the “Built with …” sentence can be translated. ([#1964](https://github.com/nextstrain/auspice/pull/1964))
* Dropped support for Node.JS versions 16 & 18 and their corresponding NPM versions (7 & 8). ([#1975](https://github.com/nextstrain/auspice/pull/1975))

## version 2.62.0 - 2025/01/21[](#version-2-62-0-2025-01-21 "Link to this heading")

* Added a new color tree by measurements feature.
  Clicking on a group in the measurements panel will add a new coloring to the tree,
  where the colors represent an average of the measurement values for the matching
  test strain within the selected measurements group.
  For full details, please see [#1924](https://github.com/nextstrain/auspice/pull/1924).
* Dataset authors can display a warning banner at the top of the page by setting `.meta.warning` in the main dataset JSON.
  The warning can be plain text or markdown format.
  This can be incorporated into Nextstrain workflows using `augur export v2 --warning`, available as of Augur version 27.2.0.
  ([#1927](https://github.com/nextstrain/auspice/issues/1927))
* Bugfix: Clicking on the icons for FULL and GRID layout now changes the layout, just like clicking on the text ([#1911](https://github.com/nextstrain/auspice/issues/1911))
* The [1Password browser extension](https://support.1password.com/getting-started-browser/), since roughly late November 2024, has interfered with Auspice views, notably when rendering many visual elements which is often the case with a large number of samples and/or genome size. The 1Password developer team is continuing to investigate the issue. In the meantime, we have applied a workaround to mitigate the effects of the issue on Auspice. ([#1919](https://github.com/nextstrain/auspice/issues/1919))

*Internal changes.*

* Added a “Cite this repository” button on the GitHub repo.
  ([#1921](https://github.com/nextstrain/auspice/pull/1921))
* Kept dependencies up to date.
  ([#1443](https://github.com/nextstrain/auspice/pull/1443),
  [#1923](https://github.com/nextstrain/auspice/pull/1923))
* Improved TypeScript usage.
  ([#1910](https://github.com/nextstrain/auspice/pull/1910),
  [#1913](https://github.com/nextstrain/auspice/pull/1913),
  [#1914](https://github.com/nextstrain/auspice/pull/1914),
  [#1915](https://github.com/nextstrain/auspice/pull/1915))
* Improved GitHub Actions usage.
  ([#1916](https://github.com/nextstrain/auspice/pull/1916),
  [#1920](https://github.com/nextstrain/auspice/pull/1920),
  [#1929](https://github.com/nextstrain/auspice/pull/1929))

## version 2.61.2 - 2024/11/19[](#version-2-61-2-2024-11-19 "Link to this heading")

* Bugfix: Fix errors where the tree wouldn’t correctly update certain properties ([#1907](https://github.com/nextstrain/auspice/pull/1907))
* Bugfix: Fix incorrect parsing of root-node dates of 0-99 CE ([#1909](https://github.com/nextstrain/auspice/pull/1909))
* Bugfix: Fix an out-of-sync bug in the Entropy panel where the tooltip text would remain “Shannon entropy” and not update to “Num changes observed” (the value was correct). ([#1906](https://github.com/nextstrain/auspice/pull/1906))

## version 2.61.1 - 2024/11/14[](#version-2-61-1-2024-11-14 "Link to this heading")

* Bugfix: Restore shift-click behaviour for branches on the tree ([#1901](https://github.com/nextstrain/auspice/pull/1901))

## version 2.61.0 - 2024/11/14[](#version-2-61-0-2024-11-14 "Link to this heading")

* Error boundaries added for all panels (tree, map etc) so that in the case of uncaught errors we’ll now show an error message rather than crashing Auspice. Hopefully these are never observed in production! ([#1897](https://github.com/nextstrain/auspice/pull/1897))
* Bugfix: Auspice would crash in some situations when the entropy panel was scrolled back into view (bug introduced in v2.60.0). ([#1898](https://github.com/nextstrain/auspice/pull/1898))

### Internal / development changes[](#internal-development-changes "Link to this heading")

* Convert the tree component (and related tree-parsing functions) to TypeScript ([#1864](https://github.com/nextstrain/auspice/pull/1864))

## version 2.60.0 - 2024/11/07[](#version-2-60-0-2024-11-07 "Link to this heading")

> *Note: this release contains a few rather large bugs and we suggest you upgrade to 2.61.2 or later*

* Performance improvement: We no longer attempt to animate actions on trees with over 4000 tips which results in more responsive interactions. ([#1880](https://github.com/nextstrain/auspice/pull/1880))
* Performance improvement: We no longer recompute the entropy data (which can be expensive) when the entropy panel is toggled off or off-screen. ([#1879](https://github.com/nextstrain/auspice/pull/1879))
* Bugfix: narrative slide changes which removed a filter would not work as expected in some cases ([#1883](https://github.com/nextstrain/auspice/pull/1883))

### Internal / development changes[](#id1 "Link to this heading")

* Refactor how the measurement-sidecar JSON is loaded ([#1881](https://github.com/nextstrain/auspice/pull/1881))
* Move jest config to TypeScript ([#1885](https://github.com/nextstrain/auspice/pull/1885))
* Move jest-puppeteer with Playright ([#1884](https://github.com/nextstrain/auspice/pull/1884))
* Verbose logging during CI ([#1876](https://github.com/nextstrain/auspice/pull/1876))

## version 2.59.1 - 2024/10/23[](#version-2-59-1-2024-10-23 "Link to this heading")

* Moved the “Focus on Selected” toggle next to the “Show confidence intervals” toggle.
  ([#1875](https://github.com/nextstrain/auspice/pull/1875))

## version 2.59.0 - 2024/10/22[](#version-2-59-0-2024-10-22 "Link to this heading")

* Added an experimental “Focus on Selected” toggle in the sidebar.
  When focusing on selected nodes, nodes that do not match the filter will occupy less vertical space on the tree.
  Only applicable to rectangular and radial layouts.
  ([#1373](https://github.com/nextstrain/auspice/pull/1373))

## version 2.58.0 - 2024/09/12[](#version-2-58-0-2024-09-12 "Link to this heading")

* Fix bug where drag-and-drop metadata columns were no longer included as tip labels ([#1845](https://github.com/nextstrain/auspice/pull/1845))
* Fixed a bug where internal node names were sometimes omitted from the branch info modal (arrived at via shift-clicking on a branch).
  They are now always displayed irrespective of the selected tip label.
  ([#1849](https://github.com/nextstrain/auspice/pull/1849))
* Added URL params for measurements panel controls: m\_collection, m\_display, m\_groupBy, m\_overallMean, m\_threshold, and mf\_\*.
  See [docs](https://docs.nextstrain.org/projects/auspice/en/stable/advanced-functionality/view-settings.html#measurements-panel-url-query-options) for more details. ([#1848](https://github.com/nextstrain/auspice/pull/1848))

## version 2.57.0 - 2024/08/30[](#versi