[PyBEL
![Logo](../_static/PyBEL-square-100.png)](../index.html)

latest

Getting Started

* [Overview](overview.html)
* Installation
  + [Extras](#extras)
    - [neo4j](#neo4j)
    - [indra](#indra)
    - [jupyter](#jupyter)
  + [Caveats](#caveats)
  + [Upgrading](#upgrading)

Data Structure

* [Data Model](../reference/struct/datamodel.html)
* [Example Networks](../reference/struct/examples.html)
* [Filters](../reference/struct/filters.html)
* [Grouping](../reference/struct/grouping.html)
* [Operations](../reference/struct/operators.html)
* [Pipeline](../reference/struct/pipeline.html)
* [Query](../reference/struct/query.html)
* [Summary](../reference/struct/summary.html)

Mutations

* [Mutations](../reference/mutations/mutations.html)
* [Collapse](../reference/mutations/collapse.html)
* [Deletion](../reference/mutations/deletion.html)
* [Expansion](../reference/mutations/expansion.html)
* [Induction](../reference/mutations/induction.html)
* [Induction and Expansion](../reference/mutations/induction_expansion.html)
* [Inference](../reference/mutations/inference.html)
* [Metadata](../reference/mutations/metadata.html)

Conversion

* [Input and Output](../reference/io.html)

Database

* [Manager](../reference/database/manager.html)
* [Models](../reference/database/models.html)

Topic Guide

* [Cookbook](../topics/cookbook.html)
* [Command Line Interface](../topics/cli.html)

Reference

* [Constants](../reference/constants.html)
* [Parsers](../reference/parser.html)
* [Internal Domain Specific Language](../reference/dsl.html)
* [Logging Messages](../reference/logging.html)

Project

* [References](../meta/references.html)
* [Current Issues](../meta/postmortem.html)
* [Technology](../meta/technology.html)

[PyBEL](../index.html)

* »
* Installation
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/introduction/installation.rst)

---

# Installation[](#installation "Permalink to this headline")

The latest stable code can be installed from [PyPI](https://pypi.python.org/pypi/pybel) with:

```
$ python3 -m pip install pybel
```

The most recent code can be installed from the source on [GitHub](https://github.com/pybel/pybel) with:

```
$ python3 -m pip install git+https://github.com/pybel/pybel.git
```

For developers, the repository can be cloned from [GitHub](https://github.com/pybel/pybel) and installed in editable
mode with:

```
$ git clone https://github.com/pybel/pybel.git
$ cd pybel
$ python3 -m pip install -e .
```

## Extras[](#extras "Permalink to this headline")

The `setup.py` makes use of the `extras_require` argument of `setuptools.setup()` in order to make some heavy
packages that support special features of PyBEL optional to install, in order to make the installation more lean by
default. A single extra can be installed from PyPI like `python3 -m pip install pybel[neo4j]` or multiple can
be installed using a list like `python3 -m pip install pybel[neo4j,indra]`. Likewise, for developer
installation, extras can be installed in editable mode with `python3 -m pip install -e .[neo4j]` or multiple can
be installed using a list like `python3 -m pip install -e .[neo4j,indra]`. The available extras are:

### neo4j[](#neo4j "Permalink to this headline")

This extension installs the `py2neo` package to support upload and download to Neo4j databases.

See also

* [`pybel.to_neo4j()`](../reference/io.html#pybel.to_neo4j "pybel.to_neo4j")

### indra[](#indra "Permalink to this headline")

This extra installs support for `indra`, the integrated network dynamical reasoner and assembler. Because it also
represents biology in BEL-like statements, many statements from PyBEL can be converted to INDRA, and visa-versa. This
package also enables the import of BioPAX, SBML, and SBGN into BEL.

See also

* [`pybel.from_biopax()`](../reference/io.html#pybel.from_biopax "pybel.from_biopax")
* [`pybel.from_indra_statements()`](../reference/io.html#pybel.from_indra_statements "pybel.from_indra_statements")
* `pybel.from_indra_pickle()`
* `pybel.to_indra()`

### jupyter[](#jupyter "Permalink to this headline")

This extra installs support for visualizing BEL graphs in Jupyter notebooks.

See also

* `pybel.io.jupyter.to_html()`
* `pybel.io.jupyter.to_jupyter()`

## Caveats[](#caveats "Permalink to this headline")

* PyBEL extends the `networkx` for its core data structure. Many of the graphical aspects of `networkx`
  depend on `matplotlib`, which is an optional dependency.
* If `HTMLlib5` is installed, the test that’s supposed to fail on a web page being missing actually tries to
  parse it as RDFa, and doesn’t fail. Disregard this.

## Upgrading[](#upgrading "Permalink to this headline")

During the current development cycle, programmatic access to the definition and graph caches might become unstable. If
you have any problems working with the database, try removing it with one of the following commands:

1. Running `pybel manage drop` (unix)
2. Running `python3 -m pybel manage drop` (windows)
3. Removing the folder `~/.pybel`

PyBEL will build a new database and populate it on the next run.

[Previous](overview.html "Overview")
[Next](../reference/struct/datamodel.html "Data Model")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).