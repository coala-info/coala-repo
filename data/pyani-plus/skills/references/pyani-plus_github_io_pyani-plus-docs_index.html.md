1. [About pyANI-plus](./index.html)

[pyANI-plus](./)

* [About pyANI-plus](./index.html)
* [Requirements](./requirements.html)
* [Installation](./installation.html)
* [pyANI-plus walkthrough](./walkthrough.html)
* [pyANI-plus subcommands](./subcommands/subcommands.html)

  + [1  `anib`](./subcommands/anib.html)
  + [2  `anim`](./subcommands/anim.html)
  + [3  `dnadiff`](./subcommands/dnadiff.html)
  + [4  `external-alignment`](./subcommands/external_alignment.html)
  + [5  `fastani`](./subcommands/fastani.html)
  + [6  `sourmash`](./subcommands/sourmash.html)
  + [7  `plot-run`](./subcommands/plot_run.html)
  + [8  `plot-run-comp`](./subcommands/plot_run_comp.html)
  + [9  `list-runs`](./subcommands/list_runs.html)
  + [10  `export-run`](./subcommands/export_run.html)
  + [11  `resume`](./subcommands/resume.html)
  + [12  `delete-run`](./subcommands/delete_run.html)
  + [13  `classify`](./subcommands/classify.html)
* [Cluster](./cluster.html)
* [Contributing to `pyANI-plus`](./contributing.html)
* [Testing](./testing.html)
* [Licensing](./licensing.html)

  + [14  pyANI-plus](./pyani_licence.html)
  + [15  pyANI-plus documentation](./doc_licence.html)

## Table of contents

* [About pyANI-plus](#sec-about)

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/index.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

# pyANI-plus

Author

Angelika Kiepas, Peter Cock, and Leighton Pritchard

Published

March 15, 2025

# About pyANI-plus

![](sipbs_compbio_800.png "pyANI-plus")

`pyANI-plus` is a Python package and software package that calculates average nucleotide identity (ANI), provides other related measures for whole genome comparisons, stores results persistently in a local SQLite3 database, and renders relevant graphical and tabular summary output. It is designed to be used with draft or complete prokaryote genomes, and implements the following methods:

* `ANIb` (average nucleotide identity using [`BLAST+`](https://blast.ncbi.nlm.nih.gov/Blast.cgi))
* `ANIm` (average nucleotide identity using [`MUMmer`](https://mummer.sourceforge.net/manual/))
* `dnadiff` (average nucleotide identity using [`dnadiff`](https://mummer.sourceforge.net/manual/))
* `fastANI` (average nucleotide identity using [`fastANI`](https://github.com/ParBLiSS/FastANI))
* `sourmash` (average nucleotide identity using [`sourmash`](https://sourmash.readthedocs.io/en/latest/index.html))
* `external-alignment` (pairwise average nucleotide identity from an externally-generated multiple sequence alignment)

In addition to calculating ANI for a given set of genomes, `pyANI-plus` also includes the following features:

* Plotting heatmaps and distributions for individual runs.
* Comparing and visualising multiple runs.
* Exporting any single run from the `pyANI-plus` SQLite3 database in tabular format.
* Classifying genomes into clusters based on ANI results.
* Resuming partial runs already logged in the database.
* Deleting any single run from the pyANI-plus SQLite3 database.
* Running on a High Performance Compute (HPC) cluster.

[Requirements](./requirements.html)

pyANI-plus documentation

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/index.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

This book was built with [Quarto](https://quarto.org/).