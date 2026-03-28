1. [pyANI-plus subcommands](../subcommands/subcommands.html)
2. [7  `plot-run`](../subcommands/plot_run.html)

[pyANI-plus](../)

* [About pyANI-plus](../index.html)
* [Requirements](../requirements.html)
* [Installation](../installation.html)
* [pyANI-plus walkthrough](../walkthrough.html)
* [pyANI-plus subcommands](../subcommands/subcommands.html)

  + [1  `anib`](../subcommands/anib.html)
  + [2  `anim`](../subcommands/anim.html)
  + [3  `dnadiff`](../subcommands/dnadiff.html)
  + [4  `external-alignment`](../subcommands/external_alignment.html)
  + [5  `fastani`](../subcommands/fastani.html)
  + [6  `sourmash`](../subcommands/sourmash.html)
  + [7  `plot-run`](../subcommands/plot_run.html)
  + [8  `plot-run-comp`](../subcommands/plot_run_comp.html)
  + [9  `list-runs`](../subcommands/list_runs.html)
  + [10  `export-run`](../subcommands/export_run.html)
  + [11  `resume`](../subcommands/resume.html)
  + [12  `delete-run`](../subcommands/delete_run.html)
  + [13  `classify`](../subcommands/classify.html)
* [Cluster](../cluster.html)
* [Contributing to `pyANI-plus`](../contributing.html)
* [Testing](../testing.html)
* [Licensing](../licensing.html)

  + [14  pyANI-plus](../pyani_licence.html)
  + [15  pyANI-plus documentation](../doc_licence.html)

## Table of contents

* [7.1 Options](#options)

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/subcommands/plot_run.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

1. [pyANI-plus subcommands](../subcommands/subcommands.html)
2. [7  `plot-run`](../subcommands/plot_run.html)

# 7  `plot-run`

The `plot-run` subcommand generates heatmaps, distribution plots, and tabular output from an ANI analysis for a specified `--run_id`, using data stored in a local SQLite3 database. All plots, including formats such as `JPG`, `PDF`, `PNG` and `SVGZ`, as well as the tabular data, will be saved in the `outdir` directory.

Important

The output directory must already exist. The heatmap files will be named `<method>_<property>.<extension>` and any pre-existing files will be overwritten.

`pyani-plus plot-run` Usage

```
pyani-plus plot-run [OPTIONS]
```

## 7.1 Options

`--database`: Path to `pyANI-plus` SQLite3 database. (FILE) [REQUIRED]

`--outdir`: Output directory. (DIRECTORY) [REQUIRED]

`--run-id`: Which run from the database. [Defaults to latest.] (INTEGER)

`--label`: How to label the genomes. [Default: stem.] (md5|filename|stem)

`--help`, `-h`: Display usage information for `pyani-plus plot-run` and exit.

[6  `sourmash`](../subcommands/sourmash.html)

[8  `plot-run-comp`](../subcommands/plot_run_comp.html)

pyANI-plus documentation

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/subcommands/plot_run.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

This book was built with [Quarto](https://quarto.org/).