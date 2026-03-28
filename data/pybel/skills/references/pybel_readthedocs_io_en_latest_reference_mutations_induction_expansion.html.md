[PyBEL
![Logo](../../_static/PyBEL-square-100.png)](../../index.html)

latest

Getting Started

* [Overview](../../introduction/overview.html)
* [Installation](../../introduction/installation.html)

Data Structure

* [Data Model](../struct/datamodel.html)
* [Example Networks](../struct/examples.html)
* [Filters](../struct/filters.html)
* [Grouping](../struct/grouping.html)
* [Operations](../struct/operators.html)
* [Pipeline](../struct/pipeline.html)
* [Query](../struct/query.html)
* [Summary](../struct/summary.html)

Mutations

* [Mutations](mutations.html)
* [Collapse](collapse.html)
* [Deletion](deletion.html)
* [Expansion](expansion.html)
* [Induction](induction.html)
* Induction and Expansion
* [Inference](inference.html)
* [Metadata](metadata.html)

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
* Induction and Expansion
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/mutations/induction_expansion.rst)

---

# Induction and Expansion[](#module-pybel.struct.mutation.induction_expansion "Permalink to this headline")

Functions for building graphs that use both expansion and induction procedures.

pybel.struct.mutation.induction\_expansion.get\_multi\_causal\_upstream(*graph*, *nbunch*)[[source]](../../_modules/pybel/struct/mutation/induction_expansion.html#get_multi_causal_upstream)[](#pybel.struct.mutation.induction_expansion.get_multi_causal_upstream "Permalink to this definition")
:   Get the union of all the 2-level deep causal upstream subgraphs from the nbunch.

    Parameters
    :   * **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **nbunch** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]]) – A BEL node or list of BEL nodes

    Returns
    :   A subgraph of the original BEL graph

    Return type
    :   [pybel.BELGraph](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")

pybel.struct.mutation.induction\_expansion.get\_multi\_causal\_downstream(*graph*, *nbunch*)[[source]](../../_modules/pybel/struct/mutation/induction_expansion.html#get_multi_causal_downstream)[](#pybel.struct.mutation.induction_expansion.get_multi_causal_downstream "Permalink to this definition")
:   Get the union of all of the 2-level deep causal downstream subgraphs from the nbunch.

    Parameters
    :   * **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **nbunch** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]]) – A BEL node or list of BEL nodes

    Returns
    :   A subgraph of the original BEL graph

    Return type
    :   [pybel.BELGraph](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")

pybel.struct.mutation.induction\_expansion.get\_subgraph\_by\_second\_neighbors(*graph*, *nodes*, *filter\_pathologies=False*)[[source]](../../_modules/pybel/struct/mutation/induction_expansion.html#get_subgraph_by_second_neighbors)[](#pybel.struct.mutation.induction_expansion.get_subgraph_by_second_neighbors "Permalink to this definition")
:   Get a graph around the neighborhoods of the given nodes and expand to the neighborhood of those nodes.

    Returns none if none of the nodes are in the graph.

    Parameters
    :   * **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **nodes** ([`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]) – An iterable of BEL nodes
        * **filter\_pathologies** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Should expansion take place around pathologies?

    Returns
    :   A BEL graph induced around the neighborhoods of the given nodes

    Return type
    :   Optional[[pybel.BELGraph](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")]

[Previous](induction.html "Induction")
[Next](inference.html "Inference")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).