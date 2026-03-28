1. [pyANI-plus subcommands](../subcommands/subcommands.html)
2. [3  `dnadiff`](../subcommands/dnadiff.html)

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

* [3.1 Arguments](#arguments)
* [3.2 Options](#options)
* [3.3 Debugging](#debugging)

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/subcommands/dnadiff.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

1. [pyANI-plus subcommands](../subcommands/subcommands.html)
2. [3  `dnadiff`](../subcommands/dnadiff.html)

# 3  `dnadiff`

The `dnadiff` subcommand processes genome files from the `indir` directory to perform dnadiff analysis, and logs comparison and run data in a local SQLite3 database.

`pyani-plus dnadiff` Usage

```
pyani-plus dnadiff [OPTIONS] FASTA
```

## 3.1 Arguments

**fasta**: Directory of FASTA files (extensions `.fas`, `.fasta`, `.fna`). (PATH) [REQUIRED]

## 3.2 Options

`--database`: Path to `pyANI-plus` SQLite3 database. (FILE) [REQUIRED]

`--create-db`: Create database if does not exist.

`--name`: Run name. [Default: “N genomes using METHOD”] (TEXT)

`--executor`: How should the internal tools be run? [Default: local] (`local`|`slurm`)

`--help`, `-h`: Display usgae information for `pyani-plus anib`.

## 3.3 Debugging

`--temp`: Directory to use for intermediate files, which for debugging purposes will not be deleted. For clusters this must be on a shared drive. Default behaviour is to use a system specified temporary directory (specific to the compute-node when using a cluster) and remove this afterwards. (Directory)

`--wtemp`: Directory to use for temporary workflow coordination files, which for debugging purposes will not be deleted. For clusters this must be on shared drive. Default behaviour is to use a system specified temporary directory (for the local executor) or a temporary directory under the present direct (for clusters), and remove this afterwards. (Directory)

[2  `anim`](../subcommands/anim.html)

[4  `external-alignment`](../subcommands/external_alignment.html)

pyANI-plus documentation

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/subcommands/dnadiff.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

This book was built with [Quarto](https://quarto.org/).