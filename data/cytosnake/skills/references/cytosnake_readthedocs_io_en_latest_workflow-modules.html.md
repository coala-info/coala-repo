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
* [CytoSnake Workflows](workflows.html)[ ]
* Workflow Modules[x]
* [CytoSnake API](modules.html)[ ]
* [Testing Framework](testing.html)[ ]

  Toggle navigation of Testing Framework

  + [Functional Tests](func-tests.html)
  + [Unittest documentation](unit-tests.html)
  + [Workflow tests](workflow-tests.html)
* [Benchmarking Workflows](benchmarking.html)[ ]

  Toggle navigation of Benchmarking Workflows

Back to top

[Edit this page](https://github.com/WayScience/CytoSnake/edit/master/docs/workflow-modules.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Workflow Modules[#](#workflow-modules "Permalink to this heading")

## Aggregate[#](#aggregate "Permalink to this heading")

Aggregates single-cell profiles into aggregated profiles based on the given strata.

For example, users can configure `Metadata_Well` as their strata in order to
aggregate single-cell data into the Well level.

Utilize’s pycytominer’s aggregate module:
<https://github.com/cytomining/pycytominer/blob/c90438fd7c11ad8b1689c21db16dab1a5280de6c/pycytominer/aggregate.py>

**Parameters** (params)

inputs:

* **profile**: single-cell morphology dataset.
* **barcode** (optional): file containing unique barcodes that maps to a specific plate
* **metadata**: metadata file associated with single-cell morphology dataset.

outputs:

* **profile** : aggregated datsaset
* **cell-counts** : csv file containg cell counts per well

## Annotate[#](#annotate "Permalink to this heading")

Generates an annotated profile with given metadata and is stored
in the `results/` directory.

Utilizes pycytominer’s annotate module:
<https://github.com/cytomining/pycytominer/blob/master/pycytominer/annotate.py>

**parameters**

inputs:

* **profiles**: single-cell morphology or aggregate profiles.
* **barcode**: file containing unique barcodes that maps to a specific plate.
* **metadata**: metadata file associated with single-cell morphology dataset.

output:

* **profiles**: annotated profiles.

## Common[#](#common "Permalink to this heading")

common.smk is a workflow module that sets up the expected input and output paths
for the main analytical workflow.

## Cytotable Convert[#](#cytotable-convert "Permalink to this heading")

Converts single-cell morphology dataset to parquet format.

Utilizes CytoTable’s convert workflow module:
<https://github.com/cytomining/CytoTable/blob/main/cytotable/convert.py>

**paramters**

inputs:

* **profiles**: single-cell morphology profiles.
* **barcode**: file containing unique barcodes that maps to a specific plate.
* **metadata**: metadata file associated with single-cell morphology dataset.

outputs:

* **profiles**: converted single-cell morphology dataset.

## Feature Select[#](#feature-select "Permalink to this heading")

Performs feature selection based on the given profiles.

PyCytominer contains different operations to conduct its feature selection: variance\_threshold, correlation\_threshold, drop\_na\_columns, drop\_outliers, and noise\_removal.

Utilizes pycytominer’s feature select module:
<https://github.com/cytomining/pycytominer/blob/master/pycytominer/feature_select.py>

**paramters**

inputs:

* **profiles**: single-cell morphology datasets.
* **barcode**: file containing unique barcodes that maps to a specific plate.
* **metadata**: metadata file associated with single-cell morphology dataset.

outputs:

* **profiles**: selected features profiles.
  “””

## Generate consensus[#](#generate-consensus "Permalink to this heading")

Creates consensus profiles that reflects unique signatures associated with external factors.

Utilize’s pycytominer’s consensus module:
<https://github.com/cytomining/pycytominer/blob/master/pycytominer/consensus.py>

**parameters**

inputs:

* **profiles**: selected features profiles.
* **barcode**: file containing unique barcodes that maps to a specific plate.
* **metadata**: metadata file associated with single-cell morphology dataset.

output:

* **profiles**: consensus profiles.

## Normalize[#](#normalize "Permalink to this heading")

Normalizing single-cell or aggregate features. Current default normalization
method is `standardize`. Other methods include: `robustize`, `mad_robustize`, and `spherize`.

Utlizes pycytominer’s normalization module:
<https://github.com/cytomining/pycytominer/blob/c90438fd7c11ad8b1689c21db16dab1a5280de6c/pycytominer/normalize.py>

* **profiles**: single-cell morphology or annotated profiles.
* **barcode**: file containing unique barcodes that maps to a specific plate.
* **metadata**: metadata file associated with single-cell morphology dataset.

output

* **profiles**: normalized profiles.

[Next

CytoSnake API](modules.html)
[Previous

CytoSnake Workflows](workflows.html)

Copyright © 2022, Way Lab

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Workflow Modules
  + [Aggregate](#aggregate)
  + [Annotate](#annotate)
  + [Common](#common)
  + [Cytotable Convert](#cytotable-convert)
  + [Feature Select](#feature-select)
  + [Generate consensus](#generate-consensus)
  + [Normalize](#normalize)