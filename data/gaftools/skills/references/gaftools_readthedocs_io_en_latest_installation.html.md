[gaftools](index.html)

* Installation
  + [Requirements](#requirements)
  + [Building from Source](#building-from-source)
  + [Installing from PyPI](#installing-from-pypi)
  + [Installing from Conda](#installing-from-conda)
* [User Guide](guide.html)
* [Developing](develop.html)
* [Changes](changes.html)

[gaftools](index.html)

* Installation
* [View page source](_sources/installation.rst.txt)

---

# Installation[](#installation "Link to this heading")

## Requirements[](#requirements "Link to this heading")

gaftools has the following requirement:

* python>=3.9
* pysam
* pywfa

The users do not need to explicitly install the requirements. The requirements are installed as part of the pip installation step.

The documentation is built using `sphinx` (only installed installed automatically in development mode installation of gaftools).

## Building from Source[](#building-from-source "Link to this heading")

Unreleased development versions of `gaftools` can be installed by building from source:

```
pip install git+https://github.com/marschall-lab/gaftools
```

We recommend installing inside a conda environment to allow easy removal:

```
conda create -n gaftools-env python=3.10
conda activate gaftools-env
pip install git+https://github.com/marschall-lab/gaftools
```

If you already have a clone locally, then run:

```
git clone https://github.com/marschall-lab/gaftools
conda create -n gaftools-env python=3.10
conda activate gaftools-env
cd gaftools
pip install .
```

To remove `gaftools`, the conda environment needs to be removed using:

```
conda env remove -n gaftools-env
```

`gaftools` can be used with python>=3.8

## Installing from PyPI[](#installing-from-pypi "Link to this heading")

`gaftools` is now available on PyPI and can be installed with:

```
pip install gaftools
```

We recommend installation inside a clean conda environment to allow easy removal and avoid dependency issues. For example, to install `gaftools` in a conda environment named `gaftools-env`, run the following commands:

```
conda create -n gaftools-env python=3.10
conda activate gaftools-env
pip install gaftools
```

## Installing from Conda[](#installing-from-conda "Link to this heading")

`gaftools` is now available on bioconda and can be installed with:

```
conda install bioconda::gaftools
```

We recommend installation inside a clean conda environment to allow easy removal and avoid dependency issues. For example, to install `gaftools` in a conda environment named `gaftools-env`, run the following commands:

```
conda create -n gaftools-env python=3.10
conda activate gaftools-env
conda install bioconda::gaftools
```

[Previous](index.html "gaftools")
[Next](guide.html "User Guide")

---

© Copyright 2022.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).