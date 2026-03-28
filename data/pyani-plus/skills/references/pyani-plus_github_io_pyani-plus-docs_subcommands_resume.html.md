1. [pyANI-plus subcommands](../subcommands/subcommands.html)
2. [11  `resume`](../subcommands/resume.html)

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

* [11.1 Options](#options)
* [11.2 Debugging](#debugging)

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/subcommands/resume.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

1. [pyANI-plus subcommands](../subcommands/subcommands.html)
2. [11  `resume`](../subcommands/resume.html)

# 11  `resume`

The `resume` subcommand restarts any partially completed run stored in the database if it was interrupted or canceled, ensuring it continues from where it left off. Any missing pairwise comparisons will be computed, and the the old run will be marked as complete. This should have no effect on completed comparisons.

Important

The output directory must already exist. The scatter plots will be named `<method>_<property>_<run-id>_vs_*.<extension>` and any pre-existing files will be overwritten.

If the version of the underlying tool has changed, this will abort as the original run cannot be completed.

`pyani-plus resume` Usage

```
pyani-plus resume [OPTIONS]
```

## 11.1 Options

`--database`: Path to `pyANI-plus` SQLite3 database. (FILE) [REQUIRED]

`--run-id`: Which run from the database. [Defaults to latest.] (INTEGER)

`--executor`: How should the internal tools be run? [Default: local] (`local`|`slurm`)

`--cache`: Cache location if required for a method (must be visible to cluster workers). Default to .cache in the current directory. (DIRECTORY)

`--help`, `-h`: Display usage information for `pyani-plus reasume` and exit.

## 11.2 Debugging

`--temp`: Directory to use for intermediate files, which for debugging purposes will not be deleted. For clusters this must be on a shared drive. Default behaviour is to use a system specified temporary directory (specific to the compute-node when using a cluster) and remove this afterwards. (Directory)

`--wtemp`: Directory to use for temporary workflow coordination files, which for debugging purposes will not be deleted. For clusters this must be on shared drive. Default behaviour is to use a system specified temporary directory (for the local executor) or a temporary directory under the present direct (for clusters), and remove this afterwards. (Directory)

[10  `export-run`](../subcommands/export_run.html)

[12  `delete-run`](../subcommands/delete_run.html)

pyANI-plus documentation

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/subcommands/resume.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

This book was built with [Quarto](https://quarto.org/).