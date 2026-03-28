[PyBEL
![Logo](../_static/PyBEL-square-100.png)](../index.html)

latest

Getting Started

* [Overview](../introduction/overview.html)
* [Installation](../introduction/installation.html)

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

* Cookbook
  + [Configuration](#configuration)
    - [Prepare a Cytoscape Network](#prepare-a-cytoscape-network)
* [Command Line Interface](cli.html)

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
* Cookbook
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/topics/cookbook.rst)

---

# Cookbook[](#cookbook "Permalink to this headline")

An extensive set of examples can be found on the [PyBEL Notebooks](https://github.com/pybel/pybel-notebooks)
repository on GitHub. These notebooks contain basic usage and also make numerous references to the analytical
package [PyBEL Tools](https://github.com/pybel/pybel-tools)

## Configuration[](#configuration "Permalink to this headline")

The default connection string can be set as an environment variable in your `~/.bashrc`. If you’re using MySQL or
MariaDB, it could look like this:

```
$ export PYBEL_CONNECTION="mysql+pymysql://user:password@server_name/database_name?charset=utf8"
```

### Prepare a Cytoscape Network[](#prepare-a-cytoscape-network "Permalink to this headline")

Load, compile, and export to Cytoscape format:

```
$ pybel convert --path ~/Desktop/example.bel --graphml ~/Desktop/example.graphml
```

In Cytoscape, open with `Import > Network > From File`.

[Previous](../reference/database/models.html "Models")
[Next](cli.html "Command Line Interface")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).