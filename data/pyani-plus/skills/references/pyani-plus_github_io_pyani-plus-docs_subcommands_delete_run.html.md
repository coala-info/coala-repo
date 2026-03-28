1. [pyANI-plus subcommands](../subcommands/subcommands.html)
2. [12  `delete-run`](../subcommands/delete_run.html)

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

* [12.1 Options](#options)

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/subcommands/delete_run.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

1. [pyANI-plus subcommands](../subcommands/subcommands.html)
2. [12  `delete-run`](../subcommands/delete_run.html)

# 12  `delete-run`

The `delete-run` subcommand deletes any single run stored in the database. This will prompt the user for confirmation if the run has comparisons, or if the run status is “Running”, but that can be overridden.

Important

Currently this will *not* delete any linked comparisons, even if they are not currently linked to another run. They will be reused should you start a new run using an overlapping set of input FASTA files.

`pyani-plus delete-run` Usage

```
pyani-plus resume [OPTIONS]
```

## 12.1 Options

`--database`: Path to `pyANI-plus` SQLite3 database. (FILE) [REQUIRED]

`--run-id`: Which run from the database. [Defaults to latest.] (INTEGER)

`--force`, `-f`: Delete without confirmation.

`--help`, `-h`: Display usage information for `pyani-plus reasume` and exit.

[11  `resume`](../subcommands/resume.html)

[13  `classify`](../subcommands/classify.html)

pyANI-plus documentation

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/subcommands/delete_run.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

This book was built with [Quarto](https://quarto.org/).