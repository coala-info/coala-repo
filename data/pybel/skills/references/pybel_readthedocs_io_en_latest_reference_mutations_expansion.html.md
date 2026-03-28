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
* Expansion
* [Induction](induction.html)
* [Induction and Expansion](induction_expansion.html)
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
* Expansion
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/mutations/expansion.rst)

---

# Expansion[](#module-pybel.struct.mutation.expansion "Permalink to this headline")

Mutations that expand the graph.

pybel.struct.mutation.expansion.expand\_node\_predecessors(*universe*, *graph*, *node*)[[source]](../../_modules/pybel/struct/mutation/expansion/neighborhood.html#expand_node_predecessors)[](#pybel.struct.mutation.expansion.expand_node_predecessors "Permalink to this definition")
:   Expand around the predecessors of the given node in the result graph.

    Parameters
    :   * **universe** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – The graph containing the stuff to add
        * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – The graph to add stuff to
        * **node** ([`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")) – A BEL node

pybel.struct.mutation.expansion.expand\_node\_successors(*universe*, *graph*, *node*)[[source]](../../_modules/pybel/struct/mutation/expansion/neighborhood.html#expand_node_successors)[](#pybel.struct.mutation.expansion.expand_node_successors "Permalink to this definition")
:   Expand around the successors of the given node in the result graph.

    Parameters
    :   * **universe** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – The graph containing the stuff to add
        * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – The graph to add stuff to
        * **node** ([`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")) – A BEL node

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.expansion.expand\_node\_neighborhood(*universe*, *graph*, *node*)[[source]](../../_modules/pybel/struct/mutation/expansion/neighborhood.html#expand_node_neighborhood)[](#pybel.struct.mutation.expansion.expand_node_neighborhood "Permalink to this definition")
:   Expand around the neighborhoods of the given node in the result graph.

    Note: expands complexes’ members

    Parameters
    :   * **universe** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – The graph containing the stuff to add
        * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – The graph to add stuff to
        * **node** ([`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")) – A BEL node

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.expansion.expand\_nodes\_neighborhoods(*universe*, *graph*, *nodes*)[[source]](../../_modules/pybel/struct/mutation/expansion/neighborhood.html#expand_nodes_neighborhoods)[](#pybel.struct.mutation.expansion.expand_nodes_neighborhoods "Permalink to this definition")
:   Expand around the neighborhoods of the given node in the result graph.

    Parameters
    :   * **universe** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – The graph containing the stuff to add
        * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – The graph to add stuff to
        * **nodes** ([`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]) – Nodes from the query graph

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.expansion.expand\_all\_node\_neighborhoods(*universe*, *graph*, *filter\_pathologies=False*)[[source]](../../_modules/pybel/struct/mutation/expansion/neighborhood.html#expand_all_node_neighborhoods)[](#pybel.struct.mutation.expansion.expand_all_node_neighborhoods "Permalink to this definition")
:   Expand the neighborhoods of all nodes in the given graph.

    Parameters
    :   * **universe** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – The graph containing the stuff to add
        * **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – The graph to add stuff to
        * **filter\_pathologies** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Should expansion take place around pathologies?

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.expansion.expand\_internal(*universe*, *graph*)[[source]](../../_modules/pybel/struct/mutation/expansion/neighborhood.html#expand_internal)[](#pybel.struct.mutation.expansion.expand_internal "Permalink to this definition")
:   Expand on edges between entities in the sub-graph that pass the given filters, in place.

    Parameters
    :   * **universe** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – The full graph
        * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A sub-graph to find the upstream information

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.expansion.expand\_upstream\_causal(*universe*, *graph*)[[source]](../../_modules/pybel/struct/mutation/expansion/upstream.html#expand_upstream_causal)[](#pybel.struct.mutation.expansion.expand_upstream_causal "Permalink to this definition")
:   Add the upstream causal relations to the given sub-graph.

    Parameters
    :   * **universe** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph representing the universe of all knowledge
        * **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – The target BEL graph to enrich with upstream causal controllers of contained nodes

pybel.struct.mutation.expansion.expand\_downstream\_causal(*universe*, *graph*)[[source]](../../_modules/pybel/struct/mutation/expansion/upstream.html#expand_downstream_causal)[](#pybel.struct.mutation.expansion.expand_downstream_causal "Permalink to this definition")
:   Add the downstream causal relations to the given sub-graph.

    Parameters
    :   * **universe** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph representing the universe of all knowledge
        * **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – The target BEL graph to enrich with upstream causal controllers of contained nodes

[Previous](deletion.html "Deletion")
[Next](induction.html "Induction")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).