[amdirt](index.html)

Contents:

* Install
  + [1. With pip](#with-pip)
  + [2. With conda](#with-conda)
  + [The latest development version, directly from GitHub](#the-latest-development-version-directly-from-github)
  + [The latest development version, with local changes](#the-latest-development-version-with-local-changes)
* [Cite](#cite)
* [More information](#more-information)
* [Tutorials](tutorials/index.html)
* [How Tos](how_to/index.html)
* [Quick Reference](reference.html)
* [Python API](API.html)

[amdirt](index.html)

* Install
* [View page source](_sources/README.md.txt)

---

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4003825.svg)](https://doi.org/10.5281/zenodo.4003825) [![PyPI version](https://badge.fury.io/py/amdirt.svg)](https://pypi.org/project/amdirt) [![Documentation Status](https://readthedocs.org/projects/amdirt/badge/?version=dev)](https://amdirt.readthedocs.io/en/dev/?badge=dev) [![amdirt-CI](https://github.com/SPAAM-community/amdirt/actions/workflows/ci_test.yml/badge.svg)](https://github.com/SPAAM-community/amdirt/actions/workflows/ci_test.yml)

![amdirt Logo](https://raw.githubusercontent.com/SPAAM-community/amdirt/master/assets/logo_rectangular_transparent.png)

**amdirt**: [**A**ncient**M**etagenome**Dir**](https://github.com/SPAAM-community/ancientmetagenomedir) **T**oolkit

amdirt is a toolkit for interacting with the AncientMetagenomeDir metadata repository of ancient metagenomic samples and ancient microbial genomes.

This tool provides ways to explore and download sequencing data for ancient microbial and environmental (meta)genomes, automatically prepare input samplesheets for a range of bioinformatic processing pipelines, and to validate AncientMetagenomeDir submissions.

For documentation on using the tool, please see [How Tos](https://amdirt.readthedocs.io/en/latest/how_to/index.html), [Tutorials](https://amdirt.readthedocs.io/en/latest/tutorials/index.html) and/or [Quick Reference](https://amdirt.readthedocs.io/en/latest/reference.html).

# Install[](#install "Link to this heading")

amdirt has been tested on different Unix systems (macOS and Ubuntu) using Intel and AMD chips. If you suspect that amdirt isn’t working properly because you use a different hardware/OS, please open an [issue on GitHub](https://github.com/SPAAM-community/amdirt/issues).

## 1. With [pip](https://pip.pypa.io/en/stable/getting-started/)[](#with-pip "Link to this heading")

```
pip install amdirt
```

## 2. With conda[](#with-conda "Link to this heading")

Installing amdirt in a dedicated [conda](https://docs.conda.io/projects/miniconda/en/latest/index.html) environment

```
conda create -n amdirt -c bioconda amdirt #install amdirt in a dedicated conda environment
conda activate amdirt # activate the conda environment
# use amdirt
conda deactivate amdirt # deactivate the conda environment
```

## The latest development version, directly from GitHub[](#the-latest-development-version-directly-from-github "Link to this heading")

```
pip install --upgrade --force-reinstall git+https://github.com/SPAAM-community/amdirt.git@dev
```

## The latest development version, with local changes[](#the-latest-development-version-with-local-changes "Link to this heading")

* Fork amdirt on GitHub
* Clone your fork `git clone [your-amdirt-fork]`
* Checkout the `dev` branch `git switch dev`
* Create the conda environment `conda env create -f environment.yml`
* Activate the environment `conda activate amdirt`
* Install amdirt in development mode `pip install -e .`

  + In some cases you may need to force update streamlit with `pip install --upgrade steamlit`

To locally render documentation:

* `conda activate amdirt`
* Install additional requirements `cd docs && pip install -r requirements.txt`
* Build the HTML `make html`
* Open the `build/html/README.html` file in your browser

# Cite[](#cite "Link to this heading")

amdirt has been published in F1000 with the following *DOI*: [10.12688/f1000research.134798.2](https://doi.org/10.12688/f1000research.134798.2).

You can cite amdirt like so:

```
Borry M, Forsythe A, Andrades Valtueña A et al. Facilitating accessible, rapid, and appropriate processing of ancient metagenomic data with amdirt. F1000Research 2024, 12:926
```

A bibtex file is also available here: <amdirt.bib>

# More information[](#more-information "Link to this heading")

For more information, please see the amdirt Documentation

* Stable: [amdirt.readthedocs.io/en/latest/](https://amdirt.readthedocs.io/en/latest/)
* Development version: [amdirt.readthedocs.io/en/dev/](https://amdirt.readthedocs.io/en/dev/)

[Previous](index.html "Welcome to amdirt’s documentation!")
[Next](tutorials/index.html "Tutorials")

---

© Copyright 2022, Maxime Borry.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).