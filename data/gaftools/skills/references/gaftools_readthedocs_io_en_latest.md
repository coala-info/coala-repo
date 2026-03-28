gaftools

* [Installation](installation.html)
* [User Guide](guide.html)
* [Developing](develop.html)
* [Changes](changes.html)

gaftools

* gaftools
* [View page source](_sources/index.rst.txt)

---

[![https://img.shields.io/pypi/v/gaftools.svg?branch=main](https://img.shields.io/pypi/v/gaftools.svg?branch=main)](https://pypi.python.org/pypi/gaftools)
![https://github.com/marschall-lab/gaftools/workflows/CI/badge.svg](https://github.com/marschall-lab/gaftools/workflows/CI/badge.svg)

# gaftools[](#gaftools "Link to this heading")

gaftools is a fast and comprehensive toolkit designed for processing pangenome alignments. It provides various functionalities such as
indexing, sorting, realignment, viewing and statistical analysis of rGFA-based GAF files.

[Link to GitHub](https://github.com/marschall-lab/gaftools/tree/main)

[Documentation](https://gaftools.readthedocs.io/) is available on Read The Docs. Documentation can be locally built under `docs` folder
using `sphinx`. `sphinx` is automatically installed when installing gaftools in dev mode.

[Preprint](https://www.biorxiv.org/content/10.1101/2024.12.10.627813v1) is available on bioRxiv.

## Features[](#features "Link to this heading")

* Viewing GAF files based on user-defined regions or node IDs.
* Conversion of GAF format from unstable segment coordinates to stable coordinates and vice-versa.
* New tags for GFA files for ordering of bubbles and sorting GAF files.
* Post-processing GAF alignments using Wavefront Alignment and generating basic alignment statistics.
* Easy-to-install. Available in PyPI and bioconda.
* Open Source (MIT License)

## Citation[](#citation "Link to this heading")

Pani, S., Dabbaghie, F., Marschall, T. & Söylev, A. gaftools: a toolkit for analyzing and manipulating pangenome alignments. (2024) doi:10.1101/2024.12.10.627813.

## Table of Contents[](#table-of-contents "Link to this heading")

* [Installation](installation.html)
  + [Requirements](installation.html#requirements)
  + [Building from Source](installation.html#building-from-source)
  + [Installing from PyPI](installation.html#installing-from-pypi)
  + [Installing from Conda](installation.html#installing-from-conda)
* [User Guide](guide.html)
  + [Requirement Summary by Subcommands](guide.html#requirement-summary-by-subcommands)
  + [gaftools find\_path](guide.html#gaftools-find-path)
  + [gaftools gfa2rgfa](guide.html#gaftools-gfa2rgfa)
  + [gaftools index](guide.html#gaftools-index)
  + [gaftools order\_gfa](guide.html#gaftools-order-gfa)
  + [gaftools phase](guide.html#gaftools-phase)
  + [gaftools realign](guide.html#gaftools-realign)
  + [gaftools sort](guide.html#gaftools-sort)
  + [gaftools stat](guide.html#gaftools-stat)
  + [gaftools view](guide.html#gaftools-view)
* [Developing](develop.html)
  + [Developer’s Installation](develop.html#developer-s-installation)
  + [Adding a new subcommand](develop.html#adding-a-new-subcommand)
  + [Executing Test Cases](develop.html#executing-test-cases)
  + [Using Pre-Commit](develop.html#using-pre-commit)
  + [Writing Documentation](develop.html#writing-documentation)
  + [Adding C++ and Cython scripts](develop.html#adding-c-and-cython-scripts)
  + [Making a Release](develop.html#making-a-release)
* [Changes](changes.html)
  + [v1.3.2 (25/03/2026)](changes.html#v1-3-2-25-03-2026)
  + [v1.3.1 (27/01/2026)](changes.html#v1-3-1-27-01-2026)
  + [v1.3.0 (06/11/2025)](changes.html#v1-3-0-06-11-2025)
  + [v1.2.1 (08/09/2025)](changes.html#v1-2-1-08-09-2025)
  + [v1.2.0 (03/07/2025)](changes.html#v1-2-0-03-07-2025)
  + [v1.1.3 (30/05/2025)](changes.html#v1-1-3-30-05-2025)
  + [v1.1.2 (30/05/2025)](changes.html#v1-1-2-30-05-2025)
  + [v1.1.1 (23/01/2025)](changes.html#v1-1-1-23-01-2025)
  + [v1.1.0 (09/10/2024)](changes.html#v1-1-0-09-10-2024)
  + [v1.0.0 (24/06/2024)](changes.html#v1-0-0-24-06-2024)

[Next](installation.html "Installation")

---

© Copyright 2022.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).