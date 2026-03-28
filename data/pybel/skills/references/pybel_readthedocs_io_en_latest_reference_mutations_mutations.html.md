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

* Mutations
* [Collapse](collapse.html)
* [Deletion](deletion.html)
* [Expansion](expansion.html)
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
* Mutations
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/mutations/mutations.rst)

---

# Mutations[](#module-pybel.struct.mutation.utils "Permalink to this headline")

General-use induction functions.

pybel.struct.mutation.utils.remove\_isolated\_nodes(*graph*)[[source]](../../_modules/pybel/struct/mutation/utils.html#remove_isolated_nodes)[](#pybel.struct.mutation.utils.remove_isolated_nodes "Permalink to this definition")
:   Remove isolated nodes from the network, in place.

    Parameters
    :   **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph

pybel.struct.mutation.utils.remove\_isolated\_nodes\_op(*graph*)[[source]](../../_modules/pybel/struct/mutation/utils.html#remove_isolated_nodes_op)[](#pybel.struct.mutation.utils.remove_isolated_nodes_op "Permalink to this definition")
:   Build a new graph excluding the isolated nodes.

    Parameters
    :   **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph

    Return type
    :   [pybel.BELGraph](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")

pybel.struct.mutation.utils.expand\_by\_edge\_filter(*source*, *target*, *edge\_predicates*)[[source]](../../_modules/pybel/struct/mutation/utils.html#expand_by_edge_filter)[](#pybel.struct.mutation.utils.expand_by_edge_filter "Permalink to this definition")
:   Expand a target graph by edges in the source matching the given predicates.

    Parameters
    :   * **source** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **target** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **edge\_predicates** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")], [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]]]) – An edge predicate or list of edge predicates

    Returns
    :   A BEL sub-graph induced over the edges passing the given filters

    Return type
    :   [pybel.BELGraph](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")

[Previous](../struct/summary.html "Summary")
[Next](collapse.html "Collapse")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).