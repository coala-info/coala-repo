1. [Installation](./installation.html)

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

* [Installation from source](#installation-from-source)
* [Installation with Miniconda/Anaconda/Bioconda](#installation-with-minicondaanacondabioconda)
* [Installation via `pip`/PyPI](#installation-via-pippypi)
* [Check the installation](#check-the-installation)

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/installation.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

# Installation

This section describes different ways to install `pyANI-plus` on the most common operating systems such as Unix/Linux and macOS.

Currently, we support three ways to install `pyANI-plus` on your system:

1. Installation from source (i.e. download/clone from GitHub)
2. Installation with Miniconda/Anaconda/Bioconda
3. Installation via `pip`/PyPI

## Installation from source

To install `pyANI-plus` from source, you can either download it from the [Releases page](https://github.com/pyani-plus/pyani-plus/releases/) or clone the repository using `git`.

To get the latest version with `git`, run the following command in a terminal:

```
git clone https://github.com/pyani-plus/pyani-plus
```

Alternatively you can visit the [Release](https://github.com/pyani-plus/pyani-plus/releases) page and click on one of the avaliable versions to get the source code in compressed form.

Once the download is complete (and uncompressed, if required), navigate to the repository:

```
cd pyani-plus
```

Then install `pyANI-plus` by running the appropriate script for your operating system:

```
make install_linux # For Linux
make install_macos # For macOS
```

## Installation with Miniconda/Anaconda/Bioconda

With a working Miniconda/Anacodna installation that has Bioconda available, install using the command

```
conda install pyani-plus
```

## Installation via `pip`/PyPI

`Pyani-plus` can be installed using the command

```
pip install pyani-plus
```

## Check the installation

To check if the installation was sucessful, run the following command:

```
pyani-plus --help
```

If the installation was completed correctly, this should display a list of available commands and options, similar to this:

```
% pyani-plus -h

 Usage: pyani-plus [OPTIONS] COMMAND [ARGS]...

╭─ Options ──────────────────────────────────────────────────────────────────────────────╮
│ --version             -v        Show tool version (on stdout) and quit.                │
│ --install-completion            Install completion for the current shell.              │
│ --show-completion               Show completion for the current shell, to copy it or   │
│                                 customize the installation.                            │
│ --help                -h        Show this message and exit.                            │
╰────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────╮
│ resume               Resume any (partial) run already logged in the database.          │
│ list-runs            List the runs defined in a given pyANI-plus SQLite3 database.     │
│ delete-run           Delete any single run from the given pyANI-plus SQLite3 database. │
│ export-run           Export any single run from the given pyANI-plus SQLite3 database. │
│ plot-run             Plot heatmaps and distributions for any single run.               │
│ plot-run-comp        Plot comparisons between multiple runs.                           │
│ classify             Classify genomes into clusters based on ANI results.              │
╰────────────────────────────────────────────────────────────────────────────────────────╯
╭─ ANI methods ──────────────────────────────────────────────────────────────────────────╮
│ anim                 Execute ANIm calculations, logged to a pyANI-plus SQLite3         │
│                      database.                                                         │
│ dnadiff              Execute mumer-based dnadiff calculations, logged to a pyANI-plus  │
│                      SQLite3 database.                                                 │
│ anib                 Execute ANIb calculations, logged to a pyANI-plus SQLite3         │
│                      database.                                                         │
│ fastani              Execute fastANI calculations, logged to a pyANI-plus SQLite3      │
│                      database.                                                         │
│ sourmash             Execute sourmash-plugin-branchwater ANI calculations, logged to a │
│                      pyANI-plus SQLite3 database.                                      │
│ external-alignment   Compute pairwise ANI from given multiple-sequence-alignment (MSA) │
│                      file.                                                             │
╰────────────────────────────────────────────────────────────────────────────────────────╯
```

[Requirements](./requirements.html)

[pyANI-plus walkthrough](./walkthrough.html)

pyANI-plus documentation

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/installation.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

This book was built with [Quarto](https://quarto.org/).