Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

Toggle site navigation sidebar

[CytoSnake 0.0.1 documentation](index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[![Logo](_static/just-icon.svg)

CytoSnake 0.0.1 documentation](index.html)

* [CytoSnake Tutorial](tutorial.html)[ ]
* CytoSnake Workflows[x]
* [Workflow Modules](workflow-modules.html)[ ]
* [CytoSnake API](modules.html)[ ]
* [Testing Framework](testing.html)[ ]

  Toggle navigation of Testing Framework

  + [Functional Tests](func-tests.html)
  + [Unittest documentation](unit-tests.html)
  + [Workflow tests](workflow-tests.html)
* [Benchmarking Workflows](benchmarking.html)[ ]

  Toggle navigation of Benchmarking Workflows

Back to top

[Edit this page](https://github.com/WayScience/CytoSnake/edit/master/docs/workflows.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# CytoSnake Workflows[#](#cytosnake-workflows "Permalink to this heading")

Below are the available workflow modules in `CytoSnake`

## cp\_process[#](#cp-process "Permalink to this heading")

Generates consensus profiles.

Consensus profiles contain unique signatures that are associated with a specific state of the cell (e.g., control, DMSO, chemical/genetic perturbations, etc.).

The development of this workflow was heavily influenced by this study:
<https://github.com/broadinstitute/cell-health>

**included modules**:

* common
* aggregate
* annotate
* normalize
* feature\_select
* generate\_consensus

**parameters**

input:

* **profile**: single-cell morphology datasets
* **metadata**: metadata directory associated with plate data.
* **barcode** (optional): file containing plate data to plate map pairings. Default is `None`.

**outputs**:

* **profiles**: aggregated, annotated, normalized, selected features, and consensus profiles.
* **cell counts**: Cell counts per well

## cp\_process\_singlecells[#](#cp-process-singlecells "Permalink to this heading")

Converts SQLite plate data into parquet and returns selected features from
single-cell morphology profiles.

The development of this workflow was heavily influenced by:
<https://github.com/WayScience/Benchmarking_NF1_data/tree/main/3_extracting_features>

**included modules**

* common
* cytotable\_convert
* annotate
* normalize
* feature\_select

**parameters**

inputs:

* **profiles**: single-cell morphology datasets in SQLite format.
* **metadata**: metadata file associated with single-cell morphology dataset.

outputs:

* **profiles**: annotated, normalized, and feature selected profiles.

[Next

Workflow Modules](workflow-modules.html)
[Previous

CytoSnake Tutorial](tutorial.html)

Copyright © 2022, Way Lab

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* CytoSnake Workflows
  + [cp\_process](#cp-process)
  + [cp\_process\_singlecells](#cp-process-singlecells)