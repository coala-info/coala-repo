Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

[Skip to content](#furo-main-content)

Toggle site navigation sidebar

[Snakebids 0.15.0 documentation](../index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[Snakebids 0.15.0 documentation](../index.html)

User Guide

* [Why use snakebids?](../general/why_snakebids.html)
* [Tutorial](../tutorial/tutorial.html)
* [Bids Function](../bids_function/overview.html)
* [Bids Apps](../bids_app/overview.html)[ ]
* [Running Snakebids](../running_snakebids/overview.html)
* [Migrations](../migration/index.html)[ ]

Reference

* API[x]
* [Internals](internals.html)
* [Plugins](plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/api/main.rst?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/api/main.rst "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# API[¶](#api "Link to this heading")

## Path Building[¶](#path-building "Link to this heading")

|  |  |
| --- | --- |
| [`bids`](paths.html#snakebids.bids "snakebids.bids") | Generate bids or bids-like paths |
| [`bids_factory`](paths.html#snakebids.bids_factory "snakebids.bids_factory") | Create new [`bids()`](paths.html#snakebids.bids "snakebids.bids") functions according to a spec |

## Dataset Creation[¶](#dataset-creation "Link to this heading")

|  |  |
| --- | --- |
| [`generate_inputs`](creation.html#snakebids.generate_inputs "snakebids.generate_inputs") | Dynamically generate snakemake inputs using pybids\_inputs. |

## Dataset Manipulation[¶](#dataset-manipulation "Link to this heading")

|  |  |
| --- | --- |
| [`filter_list`](manipulation.html#snakebids.filter_list "snakebids.filter_list") | Filter zip\_list, including only entries with provided entity values. |
| [`get_filtered_ziplist_index`](manipulation.html#snakebids.get_filtered_ziplist_index "snakebids.get_filtered_ziplist_index") | Return the indices of all entries matching the filter query. |

## Data Structures[¶](#data-structures "Link to this heading")

|  |  |
| --- | --- |
| [`BidsComponent`](structures.html#snakebids.BidsComponent "snakebids.BidsComponent") | Representation of a bids data component. |
| [`BidsPartialComponent`](structures.html#snakebids.BidsPartialComponent "snakebids.BidsPartialComponent") | Primitive representation of a bids data component. |
| [`BidsComponentRow`](structures.html#snakebids.BidsComponentRow "snakebids.BidsComponentRow") | A single row from a BidsComponent. |
| [`BidsDataset`](structures.html#snakebids.BidsDataset "snakebids.BidsDataset") | A bids dataset parsed by pybids, organized into BidsComponents. |
| [`BidsDatasetDict`](structures.html#snakebids.BidsDatasetDict "snakebids.BidsDatasetDict") | Dict equivalent of BidsInputs, for backwards-compatibility. |

## BIDS App Booststrapping[¶](#bids-app-booststrapping "Link to this heading")

|  |  |
| --- | --- |
| [`SnakeBidsApp`](app.html#snakebids.app.SnakeBidsApp "snakebids.app.SnakeBidsApp") | Snakebids app with config and arguments. |

[Next

Path Building](paths.html)
[Previous

0.11 to 0.12+](../migration/0.11_to_0.12.html)

Copyright © 2025, Ali R. Khan

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* API
  + [Path Building](#path-building)
  + [Dataset Creation](#dataset-creation)
  + [Dataset Manipulation](#dataset-manipulation)
  + [Data Structures](#data-structures)
  + [BIDS App Booststrapping](#bids-app-booststrapping)