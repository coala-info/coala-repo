[PyBEL
![Logo](../../_static/PyBEL-square-100.png)](../../index.html)

latest

Getting Started

* [Overview](../../introduction/overview.html)
* [Installation](../../introduction/installation.html)

Data Structure

* [Data Model](datamodel.html)
* [Example Networks](examples.html)
* [Filters](filters.html)
* Grouping
* [Operations](operators.html)
* [Pipeline](pipeline.html)
* [Query](query.html)
* [Summary](summary.html)

Mutations

* [Mutations](../mutations/mutations.html)
* [Collapse](../mutations/collapse.html)
* [Deletion](../mutations/deletion.html)
* [Expansion](../mutations/expansion.html)
* [Induction](../mutations/induction.html)
* [Induction and Expansion](../mutations/induction_expansion.html)
* [Inference](../mutations/inference.html)
* [Metadata](../mutations/metadata.html)

Conversion

* [Input and Output](../io.html)

Database

* [Manager](../database/manager.html)
* [Models](../database/models.html)

Topic Guide

* [Cookbook](../../topics/cookbook.html)
* [Command Line Interface](../../topics/cli.html)

Reference

* [Constants](../constants.html)
* [Parsers](../parser.html)
* [Internal Domain Specific Language](../dsl.html)
* [Logging Messages](../logging.html)

Project

* [References](../../meta/references.html)
* [Current Issues](../../meta/postmortem.html)
* [Technology](../../meta/technology.html)

[PyBEL](../../index.html)

* »
* Grouping
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/struct/grouping.rst)

---

# Grouping[](#module-pybel.struct.grouping "Permalink to this headline")

Functions for grouping BEL graphs into sub-graphs.

pybel.struct.grouping.get\_subgraphs\_by\_annotation(*graph*, *annotation*, *sentinel=None*)[[source]](../../_modules/pybel/struct/grouping/annotations.html#get_subgraphs_by_annotation)[](#pybel.struct.grouping.get_subgraphs_by_annotation "Permalink to this definition")
:   Stratify the given graph into sub-graphs based on the values for edges’ annotations.

    Parameters
    :   * **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **annotation** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The annotation to group by
        * **sentinel** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The value to stick unannotated edges into. If none, does not keep undefined.

    Return type
    :   [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`Entity`](../constants.html#pybel.language.Entity "pybel.language.Entity"), [`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")]

pybel.struct.grouping.get\_subgraphs\_by\_citation(*graph*)[[source]](../../_modules/pybel/struct/grouping/provenance.html#get_subgraphs_by_citation)[](#pybel.struct.grouping.get_subgraphs_by_citation "Permalink to this definition")
:   Stratify the graph based on citations.

    Parameters
    :   **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`Tuple`](https://docs.python.org/3/library/typing.html#typing.Tuple "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")]

    Returns
    :   A mapping of each citation db/id to the BEL graph from it.

[Previous](filters.html "Filters")
[Next](operators.html "Operations")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).