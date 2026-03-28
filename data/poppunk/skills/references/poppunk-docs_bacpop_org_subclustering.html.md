Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[PopPUNK 2.7.0 documentation](index.html)

[![Logo](_static/poppunk_v2.png)

PopPUNK 2.7.0 documentation](index.html)

Contents:

* [PopPUNK documentation](index.html)
* [Installation](installation.html)
* [Overview](overview.html)
* [Sketching (`--create-db`)](sketching.html)
* [Data quality control (`--qc-db`)](qc.html)
* [Fitting new models (`--fit-model`)](model_fitting.html)
* [Distributing PopPUNK models](model_distribution.html)
* [Query assignment (`poppunk_assign`)](query_assignment.html)
* [Creating visualisations](visualisation.html)
* [Minimum spanning trees](mst.html)
* Subclustering with PopPIPE
* [Using GPUs](gpu.html)
* [Troubleshooting](troubleshooting.html)
* [Scripts](scripts.html)
* [Iterative PopPUNK](poppunk_iterate.html)
* [Citing PopPUNK](citing.html)
* [Reference documentation](api.html)
* [Roadmap](roadmap.html)
* [Miscellaneous](miscellaneous.html)

Back to top

[View this page](_sources/subclustering.rst.txt "View this page")

# Subclustering with PopPIPE[¶](#subclustering-with-poppipe "Link to this heading")

## Overview[¶](#overview "Link to this heading")

You can run [PopPIPE](https://github.com/johnlees/PopPIPE) on your PopPUNK output,
which will run subclustering and visualisation within your strains. The pipeline
consists of the following steps:

* Split files into their strains.
* Calculate core and accessory distances within each strain.
* Use the core distances to make a neighbour-joining tree.
* (lineage\_clust mode) Generate clusters from core distances with lineage clustering in PopPUNK.
* Use [ska](https://github.com/simonrharris/SKA) to generate within-strain alignments.
* Use [IQ-TREE](http://www.iqtree.org/) to generate an ML phylogeny for each strain using this alignment,
  and the NJ tree as a starting point.
* Use [fastbaps](https://github.com/gtonkinhill/fastbaps) to generate subclusters which are partitions of the phylogeny.
* Create an overall visualisation with both core and accessory distances, as in PopPUNK.
  The final tree consists of refining the NJ tree by grafting the maximum likelihood trees for subclusters to their matching nodes.

An example DAG for the steps (excluding `ska index`, for which there is one per sample):

![Example DAG for a PopPIPE run](_images/poppipe_dag.png)

## Installation[¶](#installation "Link to this heading")

PopPIPE is a [snakemake](https://snakemake.readthedocs.io/en/stable/) pipeline, which depends
upon snakemake and pandas:

```
conda install snakemake pandas
```

Other dependencies will be automatically installed by conda the first time
you run the pipeline. You can also install them yourself and omit the -use-conda
directive to snakemake:

```
conda env create -n poppipe --file=environment.yml
```

Then clone the repository:

```
git clone git@github.com:johnlees/PopPIPE.git
```

## Usage[¶](#usage "Link to this heading")

1. Modify `config.yml` as appropriate.
2. Run `snakemake --cores <n_cores> --use-conda`.

On a cluster or the cloud, you can use snakemake’s built-in `--cluster` argument:

```
snakemake --cluster qsub -j 16 --use-conda
```

See the [snakemake docs](https://snakemake.readthedocs.io/en/stable/executing/cluster-cloud.html%29)
for more information on your cluster/cloud provider.

### Alternative runs[¶](#alternative-runs "Link to this heading")

For quick and dirty clustering and phylogenies using core distances from
[pp-sketchlib](https://github.com/johnlees/pp-sketchlib) alone, run:

```
snakemake --cores <n_cores> --use-conda lineage_clust
```

To create a visualisation on [microreact](https://microreact.org/):

> snakemake –use-conda make\_microreact

## Config file[¶](#config-file "Link to this heading")

### PopPIPE configuration[¶](#poppipe-configuration "Link to this heading")

* `script_location`: The `scripts/` directory, if not running from the root of this repository
* `poppunk_db`: The PopPUNK HDF5 database file, without the `.h5` suffix.
* `poppunk_clusters`: The PopPUNK cluster CSV file, usually `poppunk_db/poppunk_db_clusters.csv`.
* `poppunk_rfile`: The `--rfile` used with PopPUNK, which lists sample names and files, one per line, tab separated.
* `min_cluster_size`: The minimum size of a cluster to run the analysis on (recommended at least 6).

### IQ-TREE configuration[¶](#iq-tree-configuration "Link to this heading")

* `enabled`: Set to `false` to turn off ML tree generation, and use the NJ tree throughout.
* `mode`: Set to `full` to run with the specified model, set to `fast` to run using `--fast` (like fasttree).
* `model`: A string for the `-m` parameter describing the model. Adding `+ASC` is recommended.

### fastbaps configuration[¶](#fastbaps-configuration "Link to this heading")

* `levels`: Number of levels of recursive subclustering.
* `script`: Location of the `run_fastbaps` script. Find by running `system.file("run_fastbaps", package = "fastbaps")` in R.

## Updating a run[¶](#updating-a-run "Link to this heading")

Running `snakemake` from the same directory will keep outputs where possible,
so new additions will automatically be included.

**TODO**: How to do this when adding new isolates with `poppunk_assign`

[Next

Using GPUs](gpu.html)
[Previous

Minimum spanning trees](mst.html)

Copyright © 2018-2025, John Lees and Nicholas Croucher

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Subclustering with PopPIPE
  + [Overview](#overview)
  + [Installation](#installation)
  + [Usage](#usage)
    - [Alternative runs](#alternative-runs)
  + [Config file](#config-file)
    - [PopPIPE configuration](#poppipe-configuration)
    - [IQ-TREE configuration](#iq-tree-configuration)
    - [fastbaps configuration](#fastbaps-configuration)
  + [Updating a run](#updating-a-run)