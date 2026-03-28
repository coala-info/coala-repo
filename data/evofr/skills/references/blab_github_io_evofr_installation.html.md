[evofr](index.html)

Contents

* Installation Guide
  + [Installing with pip](#installing-with-pip)
  + [Installing from Source](#installing-from-source)
  + [Installing from Source Using Poetry](#installing-from-source-using-poetry)
  + [Environment Setup](#environment-setup)
  + [Additional Installation Help](#additional-installation-help)
* [API Reference](api_reference.html)
* [Getting started with `evofr`](notebooks/example_mlr.html)

[evofr](index.html)

* Installation Guide
* [View page source](_sources/installation.rst.txt)

---

# Installation Guide[](#installation-guide "Link to this heading")

This page provides detailed instructions on how to install evofr, a Python package for evolutionary forecasting of genetic variants.

## Installing with pip[](#installing-with-pip "Link to this heading")

The easiest way to install the latest version of evofr is via pip. This method will automatically handle all dependencies, including JAX and Numpyro:

```
pip install evofr
```

## Installing from Source[](#installing-from-source "Link to this heading")

For those who prefer to install evofr from the source or want to contribute to the development, follow these steps:

```
git clone https://github.com/blab/evofr.git
cd evofr
pip install .
```

## Installing from Source Using Poetry[](#installing-from-source-using-poetry "Link to this heading")

Poetry is a tool for dependency management and packaging in Python. To use Poetry to install evofr from the source, follow these instructions:

```
git clone https://github.com/blab/evofr.git
cd evofr
poetry install
```

This command will create a virtual environment and install all dependencies defined in pyproject.toml. To activate the virtual environment created by Poetry, you can use:

```
poetry shell
```

Alternatively, to run commands within the virtual environment without activating it, use poetry run:

```
poetry run python -m mymodule
```

For more information on using Poetry, visit the [Poetry documentation](https://python-poetry.org/docs/).

## Environment Setup[](#environment-setup "Link to this heading")

It is often beneficial to set up a virtual environment for Python projects to manage dependencies separately from the system-wide installations:

```
python -m venv evofr-env
source evofr-env/bin/activate
pip install evofr
```

This method is especially recommended when working on development or managing multiple Python packages.

## Additional Installation Help[](#additional-installation-help "Link to this heading")

If you encounter any issues during the installation, particularly related to JAX, please consult the [JAX installation guide](https://jax.readthedocs.io/en/latest/installation.html) for detailed instructions and troubleshooting tips.

[Previous](index.html "Welcome to evofr’s documentation!")
[Next](api_reference.html "API Reference")

---

© Copyright 2025, Marlin Figgins.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).