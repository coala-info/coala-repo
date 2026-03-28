1. [pyANI-plus subcommands](../subcommands/subcommands.html)
2. [10  `export-run`](../subcommands/export_run.html)

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

* [10.1 Options](#options)

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/subcommands/export_run.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

1. [pyANI-plus subcommands](../subcommands/subcommands.html)
2. [10  `export-run`](../subcommands/export_run.html)

# 10  `export-run`

The `export-run` subcommand exports ANI results in a tabular format for a specified `--run_id`, using data stored in a local SQLite3 database.

Important

The output directory must already exist. Any pre-existing files will be overwitten. Incomplete runs will return an error. There will be no output for empty run. For partial runs the long form table will be exported, but not the matrices.

The matrix output files will be named `<method>_<property>.tsv` while the long form is named `<method>_run_<run-id>.tsv` and will include the query and subject genomes and all the comparison properties as columns.

`pyani-plus export-run` Usage

```
pyani-plus export-run [OPTIONS]
```

## 10.1 Options

`--database`: Path to `pyANI-plus` SQLite3 database. (FILE) [REQUIRED]

`--outdir`: Output directory. (DIRECTORY) [REQUIRED]

`--run-id`: Which run from the database. [Defaults to latest.] (INTEGER)

`--label`: How to label the genomes. [Default: stem.] (md5|filename|stem)

`--help`, `-h`: Display usage information for `pyani-plus reasume` and exit.

[9  `list-runs`](../subcommands/list_runs.html)

[11  `resume`](../subcommands/resume.html)

pyANI-plus documentation

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/subcommands/export_run.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

This book was built with [Quarto](https://quarto.org/).