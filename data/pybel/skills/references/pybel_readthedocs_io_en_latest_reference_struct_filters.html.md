[PyBEL
![Logo](../../_static/PyBEL-square-100.png)](../../index.html)

latest

Getting Started

* [Overview](../../introduction/overview.html)
* [Installation](../../introduction/installation.html)

Data Structure

* [Data Model](datamodel.html)
* [Example Networks](examples.html)
* Filters
* [Grouping](grouping.html)
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
* Filters
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/struct/filters.rst)

---

# Filters[](#module-pybel.struct.filters "Permalink to this headline")

This module contains functions for filtering node and edge iterables.

It relies heavily on the concepts of [functional programming](https://en.wikipedia.org/wiki/Functional_programming)
and the concept of [predicates](https://en.wikipedia.org/wiki/Predicate_%28mathematical_logic%29).

pybel.struct.filters.invert\_edge\_predicate(*edge\_predicate*)[[source]](../../_modules/pybel/struct/filters/edge_filters.html#invert_edge_predicate)[](#pybel.struct.filters.invert_edge_predicate "Permalink to this definition")
:   Build an edge predicate that is the inverse of the given edge predicate.

    Return type
    :   [`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]

pybel.struct.filters.and\_edge\_predicates(*edge\_predicates*)[[source]](../../_modules/pybel/struct/filters/edge_filters.html#and_edge_predicates)[](#pybel.struct.filters.and_edge_predicates "Permalink to this definition")
:   Concatenate multiple edge predicates to a new predicate that requires all predicates to be met.

    Return type
    :   [`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]

pybel.struct.filters.filter\_edges(*graph*, *edge\_predicates*)[[source]](../../_modules/pybel/struct/filters/edge_filters.html#filter_edges)[](#pybel.struct.filters.filter_edges "Permalink to this definition")
:   Apply a set of filters to the edges iterator of a BEL graph.

    Return type
    :   [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`Tuple`](https://docs.python.org/3/library/typing.html#typing.Tuple "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]

    Returns
    :   An iterable of edges that pass all predicates

pybel.struct.filters.count\_passed\_edge\_filter(*graph*, *edge\_predicates*)[[source]](../../_modules/pybel/struct/filters/edge_filters.html#count_passed_edge_filter)[](#pybel.struct.filters.count_passed_edge_filter "Permalink to this definition")
:   Return the number of edges passing a given set of predicates.

    Return type
    :   [`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")

pybel.struct.filters.build\_pmid\_exclusion\_filter(*pmids*)[[source]](../../_modules/pybel/struct/filters/edge_predicate_builders.html#build_pmid_exclusion_filter)[](#pybel.struct.filters.build_pmid_exclusion_filter "Permalink to this definition")
:   Fail for edges with citations whose references are one of the given PubMed identifiers.

    Parameters
    :   **pmids** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]) – A PubMed identifier or list of PubMed identifiers to filter against

    Return type
    :   [`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]

pybel.struct.filters.build\_annotation\_dict\_all\_filter(*annotations*)[[source]](../../_modules/pybel/struct/filters/edge_predicate_builders.html#build_annotation_dict_all_filter)[](#pybel.struct.filters.build_annotation_dict_all_filter "Permalink to this definition")
:   Build an edge predicate for edges whose annotations are super-dictionaries of the given dictionary.

    If no annotations are given, will always evaluate to true.

    Parameters
    :   **annotations** ([`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]) – The annotation query dict to match

    Return type
    :   [`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]

pybel.struct.filters.build\_annotation\_dict\_any\_filter(*annotations*)[[source]](../../_modules/pybel/struct/filters/edge_predicate_builders.html#build_annotation_dict_any_filter)[](#pybel.struct.filters.build_annotation_dict_any_filter "Permalink to this definition")
:   Build an edge predicate that passes for edges whose data dictionaries match the given dictionary.

    If the given dictionary is empty, will always evaluate to true.

    Parameters
    :   **annotations** ([`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]) – The annotation query dict to match

    Return type
    :   [`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]

pybel.struct.filters.build\_upstream\_edge\_predicate(*nodes*)[[source]](../../_modules/pybel/struct/filters/edge_predicate_builders.html#build_upstream_edge_predicate)[](#pybel.struct.filters.build_upstream_edge_predicate "Permalink to this definition")
:   Build an edge predicate that pass for relations for which one of the given nodes is the object.

    Return type
    :   [`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]

pybel.struct.filters.build\_downstream\_edge\_predicate(*nodes*)[[source]](../../_modules/pybel/struct/filters/edge_predicate_builders.html#build_downstream_edge_predicate)[](#pybel.struct.filters.build_downstream_edge_predicate "Permalink to this definition")
:   Build an edge predicate that passes for edges for which one of the given nodes is the subject.

    Return type
    :   [`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]

pybel.struct.filters.build\_relation\_predicate(*relations*)[[source]](../../_modules/pybel/struct/filters/edge_predicate_builders.html#build_relation_predicate)[](#pybel.struct.filters.build_relation_predicate "Permalink to this definition")
:   Build an edge predicate that passes for edges with the given relation.

    Return type
    :   [`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]

pybel.struct.filters.build\_pmid\_inclusion\_filter(*pmids*)[[source]](../../_modules/pybel/struct/filters/edge_predicate_builders.html#build_pmid_inclusion_filter)[](#pybel.struct.filters.build_pmid_inclusion_filter "Permalink to this definition")
:   Build an edge predicate that passes for edges with citations from the given PubMed identifier(s).

    Parameters
    :   **pmids** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]) – A PubMed identifier or list of PubMed identifiers to filter for

    Return type
    :   [`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]

pybel.struct.filters.build\_author\_inclusion\_filter(*authors*)[[source]](../../_modules/pybel/struct/filters/edge_predicate_builders.html#build_author_inclusion_filter)[](#pybel.struct.filters.build_author_inclusion_filter "Permalink to this definition")
:   Build an edge predicate that passes for edges with citations written by the given author(s).

    Return type
    :   [`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]

pybel.struct.filters.edge\_predicate(*func*)[[source]](../../_modules/pybel/struct/filters/edge_predicates.html#edge_predicate)[](#pybel.struct.filters.edge_predicate "Permalink to this definition")
:   Decorate an edge predicate function that only takes a dictionary as its singular argument.

    Apply this as a decorator to a function that takes a single argument, a PyBEL node data dictionary, to make
    sure that it can also accept a pair of arguments, a BELGraph and a PyBEL node tuple as well.

    Return type
    :   [`Callable`](https://docs.python.org/3/library/typing.html#typing.Callable "(in Python v3.10)")[[[`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")]

pybel.struct.filters.true\_edge\_predicate(*graph*, *u*, *v*, *k*)[[source]](../../_modules/pybel/struct/filte