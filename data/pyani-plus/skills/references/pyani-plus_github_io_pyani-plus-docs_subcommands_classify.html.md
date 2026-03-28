1. [pyANI-plus subcommands](../subcommands/subcommands.html)
2. [13  `classify`](../subcommands/classify.html)

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

* [13.1 Options](#options)
* [13.2 Method parameters](#method-parameters)

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/subcommands/classify.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

1. [pyANI-plus subcommands](../subcommands/subcommands.html)
2. [13  `classify`](../subcommands/classify.html)

# 13  `classify`

The `classify` subcommand classifies genomes into cliques (k-complete) graphs based on ANI results, generating plots and tabular summaries. This is helpful for circumscribing potentially meaningful groups of genomes that can not be described using traditional taxonomy. The output, including classify plots (`JPG`, `PDF`, `PNG`, `SVGZ`) and tabular data, is written to `outdir` directory.

`pyani-plus classify` Usage

```
pyani-plus classify [OPTIONS]
```

## 13.1 Options

`--database`: Path to `pyANI-plus` SQLite3 database. (FILE) [REQUIRED]

`--outdir`: Output directory. (DIRECTORY) [REQUIRED]

`--run-id`: Which run from the database. [Defaults to latest.] (INTEGER)

`--label`: How to label the genomes. [Default: stem.] (md5|filename|stem)

`--help`, `-h`: Display usage information for `pyani-plus reasume` and exit.

## 13.2 Method parameters

`--mode`: Classify mode intended to identify cliques within a set of genomes. [Default: identity] (identity|tANI)

`--score-edges`: How to resolve asymmetrical ANI identity/tANI results for edges in the graph (min, max or mean). [Default: min] (TEXT)

`--coverage-edges`: How to resolve asymmetrical ANI coverage results for edges in the graph (min, max or mean). [Default: min] (TEXT)

`--cov-min`: Minimum %coverage for an edge. [Default: 0.5] (\(0.0 \leq x \leq 1.0\) )

`--vertical-line`: Threshold for red vertical line at identity/tANI. The default is set to 0.95 if `--mode` is `identity` and -0.323 if `--mode` is `tANI`. (TEXT)

[12  `delete-run`](../subcommands/delete_run.html)

[Cluster](../cluster.html)

pyANI-plus documentation

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/subcommands/classify.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

This book was built with [Quarto](https://quarto.org/).