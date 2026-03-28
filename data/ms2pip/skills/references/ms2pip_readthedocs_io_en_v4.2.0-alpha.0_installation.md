[ms2pip](../)

About

* [Home](../)
* Installation
  + [Pip package](#pip-package)
  + [Conda package](#conda-package)
  + [Docker container](#docker-container)
  + [For development](#for-development)
* [Usage](../usage/)
* [Prediction models](../prediction-models/)

Command line interface

* [Command line interface](../cli/cli/)

Python API reference

* [ms2pip](../api/ms2pip/)
* [ms2pip.constants](../api/ms2pip.constants/)
* [ms2pip.correlation](../api/ms2pip.correlation/)
* [ms2pip.exceptions](../api/ms2pip.exceptions/)
* [ms2pip.result](../api/ms2pip.result/)
* [ms2pip.search\_space](../api/ms2pip.search-space/)
* [ms2pip.spectrum](../api/ms2pip.spectrum/)
* [ms2pip.spectrum\_input](../api/ms2pip.spectrum-input/)
* [ms2pip.spectrum\_output](../api/ms2pip.spectrum-output/)

[ms2pip](../)

* Installation
* [View page source](../_sources/installation.rst.txt)

---

# Installation[](#installation "Link to this heading")

## Pip package[](#pip-package "Link to this heading")

[![https://flat.badgen.net/badge/install%20with/pip/green](https://flat.badgen.net/badge/install%20with/pip/green)](https://pypi.org/project/ms2pip/)

With Python 3.9 or higher, run:

```
pip install ms2pip
```

Compiled wheels are available for various Python versions on 64bit Linux,
Windows, and macOS. This should install MS²PIP in a few seconds. For other
platforms, MS²PIP can be built from source, although it can take a while
to compile the large prediction models.

We recommend using a [venv](https://docs.python.org/3/library/venv.html) or
[conda](https://docs.conda.io/en/latest/) virtual environment.

## Conda package[](#conda-package "Link to this heading")

[![https://flat.badgen.net/badge/install%20with/bioconda/green](https://flat.badgen.net/badge/install%20with/bioconda/green)](https://bioconda.github.io/recipes/ms2pip/README.html)

Install with activated bioconda and conda-forge channels:

```
conda install -c defaults -c bioconda -c conda-forge ms2pip
```

Bioconda packages are only available for Linux and macOS.

## Docker container[](#docker-container "Link to this heading")

[![https://flat.badgen.net/badge/pull/biocontainer/blue?icon=docker](https://flat.badgen.net/badge/pull/biocontainer/blue?icon=docker)](https://quay.io/repository/biocontainers/ms2pip)

First check the latest version tag on [biocontainers/ms2pip/tags](https://quay.io/repository/biocontainers/ms2pip?tab=tags). Then pull and run the container with:

```
docker container run -v <working-directory>:/data -w /data quay.io/biocontainers/ms2pip:<tag> ms2pip <ms2pip-arguments>
```

where <working-directory> is the absolute path to the directory with your MS²PIP input files, <tag> is the container version tag, and <ms2pip-arguments> are the ms2pip command line options (see [Command line interface](../cli/cli/#command-line-interface)).

## For development[](#for-development "Link to this heading")

Clone this repository and use pip to install an editable version:

```
pip install --editable .
```

Optionally, add the `[dev,docs]` extras to install the development and
documentation dependencies:

```
pip install --editable .[dev,docs]
```

[Previous](../ "About")
[Next](../usage/ "Usage")

---

© Copyright .

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).