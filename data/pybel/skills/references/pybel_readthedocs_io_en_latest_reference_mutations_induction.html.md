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
* Induction
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
* Induction
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/mutations/induction.rst)

---

# Induction[](#module-pybel.struct.mutation.induction "Permalink to this headline")

Mutations that induce a sub-graph.

pybel.struct.mutation.induction.get\_subgraph\_by\_annotation\_value(*graph*, *annotation*, *values*)[[source]](../../_modules/pybel/struct/mutation/induction/annotations.html#get_subgraph_by_annotation_value)[](#pybel.struct.mutation.induction.get_subgraph_by_annotation_value "Permalink to this definition")
:   Induce a sub-graph over all edges whose annotations match the given key and value.

    Parameters
    :   * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **annotation** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The annotation to group by
        * **values** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]) – The value(s) for the annotation

    Return type
    :   [`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

    Returns
    :   A subgraph of the original BEL graph

pybel.struct.mutation.induction.get\_subgraph\_by\_annotations(*graph*, *annotations*, *or\_=None*)[[source]](../../_modules/pybel/struct/mutation/induction/annotations.html#get_subgraph_by_annotations)[](#pybel.struct.mutation.induction.get_subgraph_by_annotations "Permalink to this definition")
:   Induce a sub-graph given an annotations filter.

    Parameters
    :   * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **annotations** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]], [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Entity`](../constants.html#pybel.language.Entity "pybel.language.Entity")]]]) – Annotation filters (match all with `pybel.utils.subdict_matches()`)
        * **or** – if True any annotation should be present, if False all annotations should be present in the
          edge. Defaults to True.

    Return type
    :   [`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

    Returns
    :   A subgraph of the original BEL graph

pybel.struct.mutation.induction.get\_subgraph\_by\_pubmed(*graph*, *pubmed\_identifiers*)[[source]](../../_modules/pybel/struct/mutation/induction/citation.html#get_subgraph_by_pubmed)[](#pybel.struct.mutation.induction.get_subgraph_by_pubmed "Permalink to this definition")
:   Induce a sub-graph over the edges retrieved from the given PubMed identifier(s).

    Parameters
    :   * **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **pubmed\_identifiers** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)") *or* [*list*](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.10)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")*]*) – A PubMed identifier or list of PubMed identifiers

    Return type
    :   [pybel.BELGraph](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")

pybel.struct.mutation.induction.get\_subgraph\_by\_authors(*graph*, *authors*)[[source]](../../_modules/pybel/struct/mutation/induction/citation.html#get_subgraph_by_authors)[](#pybel.struct.mutation.induction.get_subgraph_by_authors "Permalink to this definition")
:   Induce a sub-graph over the edges retrieved publications by the given author(s).

    Parameters
    :   * **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **authors** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)") *or* [*list*](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.10)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")*]*) – An author or list of authors

    Return type
    :   [pybel.BELGraph](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")

pybel.struct.mutation.induction.get\_subgraph\_by\_neighborhood(*graph*, *nodes*)[[source]](../../_modules/pybel/struct/mutation/induction/neighborhood.html#get_subgraph_by_neighborhood)[](#pybel.struct.mutation.induction.get_subgraph_by_neighborhood "Permalink to this definition")
:   Get a BEL graph around the neighborhoods of the given nodes.

    Returns none if no nodes are in the graph.

    Parameters
    :   * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **nodes** ([`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]) – An iterable of BEL nodes

    Return type
    :   [`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")]

    Returns
    :   A BEL graph induced around the neighborhoods of the given nodes

pybel.struct.mutation.induction.get\_nodes\_in\_all\_shortest\_paths(*graph*, *nodes*, *weight=None*, *remove\_pathologies=False*)[[source]](../../_modules/pybel/struct/mutation/induction/paths.html#get_nodes_in_all_shortest_paths)[](#pybel.struct.mutation.induction.get_nodes_in_all_shortest_paths "Permalink to this definition")
:   Get a set of nodes in all shortest paths between the given nodes.

    Thinly wraps `networkx.all_shortest_paths()`.

    Parameters
    :   * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **nodes** ([`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]) – The list of nodes to use to use to find all shortest paths
        * **weight** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – Edge data key corresponding to the edge weight. If none, uses unweighted search.
        * **remove\_pathologies** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Should pathology nodes be removed first?

    Return type
    :   [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]

    Returns
    :   A set of nodes appearing in the shortest paths between nodes in the BEL graph

    Note

    This can be trivially parallelized using `networkx.single_source_shortest_path()`

pybel.struct.mutation.induction.get\_subgraph\_by\_all\_shortest\_paths(*graph*, *nodes*, *weight=None*, *remove\_pathologies=False*)[[source]](../../_modules/pybel/struct/mutation/induction/paths.html#get_subgraph_by_all_shortest_paths)[](#pybel.struct.mutation.induction.get_subgraph_by_all_shortest_paths "Permalink to this definition")
:   Induce a subgraph over the nodes in the pairwise shortest paths between all of the nodes in the given list.

    Parameters
    :   * **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **nodes** ([`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]) – A set of nodes over which to calculate shortest paths
        * **weight** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – Edge data key corresponding to the edge weight. If None, performs unweighted search
        * **remove\_pathologies** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Should the pathology nodes be deleted before getting shortest paths?

    Returns
    :   A BEL graph induced over the nodes appearing in the shortest paths between the given nodes

    Return type
    :   Optional[[pybel.BELGraph](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")]

pybel.struct.mutation.induction.get\_random\_path(*graph*)[[source]](../../_modules/pybel/struct/mutation/induction/paths.html#get_random_path)[](#pybel.struct.mutation.induction.get_random_path "Permalink to this definition")
:   Get a random path from the graph as a list of nodes.

    Parameters
    :   **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]

pybel.struct.mutation.induction.get\_graph\_with\_random\_edges(*graph*, *n\_edges*)[[source]](../../_modules/pybel/struct/mutation/induction/random_subgraph.html#get_graph_with_random_edges)[](#pybel.struct.mutation.induction.get_graph_with_random_edges "Permalink to this definition")
:   Build a new graph from a seeding of edges.

    Parameters
    :   * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **n\_edges** ([`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")) – Number of edges to randomly select from the given graph

    Return type
    :   [`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

pybel.struct.mutation.induction.get\_random\_node(*graph*, *node\_blacklist*, *invert\_degrees=None*)[[source]](../../_modules/pybel/struct/mutation/induction/random_subgraph.html#get_random_node)[](#pybel.struct.mutation.induction.get_random_node "Permalink to this definition")
:   Choose a node from the graph with probabilities based on their degrees.

    Parameters
    :   * **node\_blacklist** ([`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]) – Nodes to filter out
        * **invert\_degrees** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]) – Should the degrees be inverted? Defaults to true.

    Return type
    :   [`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]

pybel.struct.mutation.induction.get\_random\_subgraph(*graph*, *number\_edges=None*, *number\_seed\_edges=None*, *seed=None*, *invert\_degrees=None*)[[source]](../../_modules/pybel/struct/mutation/induction/random_subgraph.html#get_random_subgraph)[](#pybel.struct.mutation.induction.get_random_subgraph "Permalink to this definition")
:   Generate a random subgraph based on weighted random walks from random seed edges.

    Parameters
    :   * **number\_edges** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")]) – Maximum number of edges. Defaults to
          `pybel_tools.constants.SAMPLE_RANDOM_EDGE_COUNT` (250).
        * **number\_seed\_edges** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")]) – Number of nodes to start with (which likely results in different components
          in large graphs). Defaults to `SAMPLE_RANDOM_EDGE_SEED_COUNT` (5).
        * **seed** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")]) – A seed for the random state
        * **invert\_degrees** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]) – Should the degrees be inverted? Defaults to true.

    Return type
    :   [`BELGraph`](../stru