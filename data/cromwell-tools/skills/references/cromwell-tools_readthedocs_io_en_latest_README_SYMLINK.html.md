[Cromwell Tools](index.html)

latest

Overview

* Cromwell-tools
  + [Overview](#overview)
  + [Installation](#installation)
  + [Usage](#usage)
    - [Python API](#python-api)
    - [Commandline Interface](#commandline-interface)
  + [Testing](#testing)
    - [Run Tests with Docker](#run-tests-with-docker)
    - [Run Tests with local Python environment](#run-tests-with-local-python-environment)
  + [Development](#development)
    - [Code Style](#code-style)
    - [Dependencies](#dependencies)
    - [Documentation](#documentation)
    - [Publish on PyPI](#publish-on-pypi)
  + [Contribute](#contribute)

Tutorials

* [Cromwell-tools Python API Quickstart](Tutorials/Quickstart/api_quickstart.html)
* [Cromwell-tools Command Line Interface Quickstart](Tutorials/Quickstart/cli_quickstart.html)

API Documentation

* [API Documentation](API/index.html)

[Cromwell Tools](index.html)

* [Docs](index.html) »
* Cromwell-tools
* [Edit on GitHub](https://github.com/broadinstitute/cromwell-tools/blob/master/docs/README_SYMLINK.rst)

---

# Cromwell-tools[¶](#cromwell-tools "Permalink to this headline")

[![Container Build Status](https://quay.io/repository/broadinstitute/cromwell-tools/status)](https://quay.io/repository/broadinstitute/cromwell-tools)
[![Unit Test Status](https://github.com/broadinstitute/cromwell-tools/workflows/Tests%20on%20Pull%20Requests%20and%20Master/badge.svg)](https://github.com/broadinstitute/cromwell-tools/actions?query=workflow%3A%22Tests+on+Pull+Requests+and+Master%22+branch%3Amaster)
[![Documentation Status](https://img.shields.io/readthedocs/cromwell-tools/latest.svg?label=ReadtheDocs%3A%20Latest&logo=Read%20the%20Docs&style=flat-square)](http://cromwell-tools.readthedocs.io/en/latest/?badge=latest)
[![Latest Release](https://img.shields.io/github/release/broadinstitute/cromwell-tools.svg?label=Latest%20Release&style=flat-square&colorB=green)](https://github.com/broadinstitute/cromwell-tools/releases)
[![License](https://img.shields.io/github/license/broadinstitute/cromwell-tools.svg?style=flat-square)](https://img.shields.io/github/license/broadinstitute/cromwell-tools.svg?style=flat-square)
[![Language](https://img.shields.io/badge/python-3.5|3.6|3.7-green.svg?style=flat-square&logo=python&colorB=blue)](https://img.shields.io/badge/python-3.5%7C3.6%7C3.7-green.svg?style=flat-square&logo=python&colorB=blue)
[![Code Style](https://img.shields.io/badge/Code%20Style-black-000000.svg?style=flat-square)](https://github.com/ambv/black)
[![Code Coverage](https://codecov.io/gh/broadinstitute/cromwell-tools/branch/master/graph/badge.svg)](https://codecov.io/gh/broadinstitute/cromwell-tools)

## Overview[¶](#overview "Permalink to this headline")

This repo contains a cromwell\_tools Python package, accessory scripts and IPython notebooks.

The cromwell\_tools Python package is designed to be a Python API and Command Line Tool for interacting with the [Cromwell](https://github.com/broadinstitute/cromwell). with the following features:
:   * Python3 compatible. (Starting from release v2.0.0, cromwell-tools will no longer support Python 2.7)
    * Consistency in authentication to work with Cromwell.
    * Consistency between API and CLI interfaces.
    * Sufficient test cases.
    * Documentation on [Read The Docs](https://cromwell-tools.readthedocs.io/en/latest/).

The accessory scripts and IPython notebooks are useful to:
:   * Monitor the resource usages of workflows running in Cromwell.
    * Visualize the workflows benchmarking metrics.

## Installation[¶](#installation "Permalink to this headline")

1. (optional and highly recommended) Create a Python 3 [virtual environment](https://virtualenv.pypa.io/en/latest/userguide/#usage)
locally and activate it: e.g. `virtualenv -p python3 myenv && source myenv/bin/activate`

2. Install (or upgrade) Cromwell-tools from [PyPI](https://pypi.org/):

```
pip install -U cromwell-tools
```

3. You can verify the installation by:

```
cromwell-tools --version
```

## Usage[¶](#usage "Permalink to this headline")

### Python API[¶](#python-api "Permalink to this headline")

In Python, you can import the package with:

```
import cromwell_tools.api as cwt
cwt.submit(*args)
```

assuming args is a list of arguments needed.

For more details, please check the tutorial on [Read the Docs](https://cromwell-tools.readthedocs.io/en/latest/Tutorials/Quickstart/api_quickstart.html).

### Commandline Interface[¶](#commandline-interface "Permalink to this headline")

This package also installs a command line interface that mirrors the API and is used as follows:

A set of sub-commands to submit, query, abort, release on-hold workflows, wait for workflow completion and determining
status of jobs are exposed by this CLI.

For more details, please check the tutorial on [Read the Docs](https://cromwell-tools.readthedocs.io/en/latest/Tutorials/Quickstart/cli_quickstart.html).

## Testing[¶](#testing "Permalink to this headline")

To run tests:

### Run Tests with Docker[¶](#run-tests-with-docker "Permalink to this headline")

Running the tests within docker image is the recommended way, to do this, you need to have docker-daemon installed
in your environment. From the root of the cromwell-tools repo:

### Run Tests with local Python environment[¶](#run-tests-with-local-python-environment "Permalink to this headline")

* If you have to run the tests with your local Python environment, we highly recommend to create and activate a
  [virtualenv](https://virtualenv.pypa.io/en/stable/) with requirements before you run the tests:

* Finally, from the root of the cromwell-tools repo, run the tests with:

Note

Which version of Python is used to run the tests here depends on the virtualenv parameter. You can use
`virtualenv -p` to choose which Python version you want to create the virtual environment.

## Development[¶](#development "Permalink to this headline")

### Code Style[¶](#code-style "Permalink to this headline")

The cromwell-tools code base is complying with the PEP-8 and using [Black](https://github.com/ambv/black) to
format our code, in order to avoid “nitpicky” comments during the code review process so we spend more time discussing about the logic,
not code styles.

In order to enable the auto-formatting in the development process, you have to spend a few seconds setting
up the `pre-commit` the first time you clone the repo:

1. Install `pre-commit` by running: `pip install pre-commit` (or simply run `pip install -r requirements.txt`).
2. Run pre-commit install to install the git hook.

Once you successfully install the `pre-commit` hook to this repo, the Black linter/formatter will be automatically triggered and run on this repo. Please make sure you followed the above steps, otherwise your commits might fail at the linting test!

If you really want to manually trigger the linters and formatters on your code, make sure `Black` and `flake8` are installed in your Python environment and run `flake8 DIR1 DIR2` and `black DIR1 DIR2 --skip-string-normalization` respectively.

### Dependencies[¶](#dependencies "Permalink to this headline")

When upgrading the dependencies of cromwell-tools, please make sure `requirements.txt`, `requirements-test.txt` and `setup.py` are consistent!

### Documentation[¶](#documentation "Permalink to this headline")

To edit the docmentation and rebuild it locally, make sure you have [Sphinx](http://www.sphinx-doc.org/en/master/) installed. You might
also want to install the dependencies for building the docs: `pip install requirements-docs.txt`.
Finally from within the root directory, run:

and then you could preview the built documentation by opening `docs/_build/index.html` in your web browser.

### Publish on PyPI[¶](#publish-on-pypi "Permalink to this headline")

To publish a new version of Cromwell-tools on PyPI:

1. Make sure you have an empty `dist` folder locally.
2. Make sure you have `twine` installed: `pip install twine`.
3. Build the package: `python setup.py sdist bdist_wheel`
4. Upload and publish on PyPI: `twine upload dist/* --verbose`, note you will need the username and password of the development account to finish this step.

## Contribute[¶](#contribute "Permalink to this headline")

Coming soon… For now, feel free to submit issues and open a PR, we will try our best to address them.

[Next](Tutorials/Quickstart/api_quickstart.html "Cromwell-tools Python API Quickstart")
 [Previous](index.html "Cromwell-tools documentation")

---

© Copyright 2018, Mint Team
Revision `fb1753dd`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).