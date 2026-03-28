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
* [Grouping](grouping.html)
* [Operations](operators.html)
* [Pipeline](pipeline.html)
* [Query](query.html)
* Summary

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
* Summary
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/struct/summary.rst)

---

# Summary[](#module-pybel.struct.summary "Permalink to this headline")

Summary functions for BEL graphs.

pybel.struct.summary.iter\_annotation\_value\_pairs(*graph*)[[source]](../../_modules/pybel/struct/summary/edge_summary.html#iter_annotation_value_pairs)[](#pybel.struct.summary.iter_annotation_value_pairs "Permalink to this definition")
:   Iterate over the key/value pairs, with duplicates, for each annotation used in a BEL graph.

    Parameters
    :   **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`Tuple`](https://docs.python.org/3/library/typing.html#typing.Tuple "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Entity`](../constants.html#pybel.language.Entity "pybel.language.Entity")]]

pybel.struct.summary.iter\_annotation\_values(*graph*, *annotation*)[[source]](../../_modules/pybel/struct/summary/edge_summary.html#iter_annotation_values)[](#pybel.struct.summary.iter_annotation_values "Permalink to this definition")
:   Iterate over all of the values for an annotation used in the graph.

    Parameters
    :   * **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **annotation** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The annotation to grab

    Return type
    :   [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`Entity`](../constants.html#pybel.language.Entity "pybel.language.Entity")]

pybel.struct.summary.get\_annotation\_values\_by\_annotation(*graph*)[[source]](../../_modules/pybel/struct/summary/edge_summary.html#get_annotation_values_by_annotation)[](#pybel.struct.summary.get_annotation_values_by_annotation "Permalink to this definition")
:   Get the set of values for each annotation used in a BEL graph.

    Parameters
    :   **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`Entity`](../constants.html#pybel.language.Entity "pybel.language.Entity")]]

    Returns
    :   A dictionary of {annotation key: set of annotation values}

pybel.struct.summary.get\_annotation\_values(*graph*, *annotation*)[[source]](../../_modules/pybel/struct/summary/edge_summary.html#get_annotation_values)[](#pybel.struct.summary.get_annotation_values "Permalink to this definition")
:   Get all values for the given annotation.

    Parameters
    :   * **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **annotation** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The annotation to summarize

    Return type
    :   [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`Entity`](../constants.html#pybel.language.Entity "pybel.language.Entity")]

    Returns
    :   A set of all annotation values

pybel.struct.summary.count\_relations(*graph*)[[source]](../../_modules/pybel/struct/summary/edge_summary.html#count_relations)[](#pybel.struct.summary.count_relations "Permalink to this definition")
:   Return a histogram over all relationships in a graph.

    Parameters
    :   **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`Counter`](https://docs.python.org/3/library/collections.html#collections.Counter "(in Python v3.10)")

    Returns
    :   A Counter from {relation type: frequency}

pybel.struct.summary.get\_annotations(*graph*)[[source]](../../_modules/pybel/struct/summary/edge_summary.html#get_annotations)[](#pybel.struct.summary.get_annotations "Permalink to this definition")
:   Get the set of annotations used in the graph.

    Parameters
    :   **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

    Returns
    :   A set of annotation keys

pybel.struct.summary.count\_annotations(*graph*)[[source]](../../_modules/pybel/struct/summary/edge_summary.html#count_annotations)[](#pybel.struct.summary.count_annotations "Permalink to this definition")
:   Count how many times each annotation is used in the graph.

    Parameters
    :   **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`Counter`](https://docs.python.org/3/library/collections.html#collections.Counter "(in Python v3.10)")

    Returns
    :   A Counter from {annotation key: frequency}

pybel.struct.summary.get\_unused\_annotations(*graph*)[[source]](../../_modules/pybel/struct/summary/edge_summary.html#get_unused_annotations)[](#pybel.struct.summary.get_unused_annotations "Permalink to this definition")
:   Get the set of all annotations that are defined in a graph, but are never used.

    Parameters
    :   **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

    Returns
    :   A set of annotations

pybel.struct.summary.get\_unused\_list\_annotation\_values(*graph*)[[source]](../../_modules/pybel/struct/summary/edge_summary.html#get_unused_list_annotation_values)[](#pybel.struct.summary.get_unused_list_annotation_values "Permalink to this definition")
:   Get all of the unused values for list annotations.

    Parameters
    :   **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]

    Returns
    :   A dictionary of {str annotation: set of str values that aren’t used}

pybel.struct.summary.get\_metaedge\_to\_key(*graph*)[[source]](../../_modules/pybel/struct/summary/edge_summary.html#get_metaedge_to_key)[](#pybel.struct.summary.get_metaedge_to_key "Permalink to this definition")
:   Get all edge types.

    Return type
    :   [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`Tuple`](https://docs.python.org/3/library/typing.html#typing.Tuple "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`Tuple`](https://docs.python.org/3/library/typing.html#typing.Tuple "(in Python v3.10)")], [`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`Tuple`](https://docs.python.org/3/library/typing.html#typing.Tuple "(in Python v3.10)")]], [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`Tuple`](https://docs.python.org/3/library/typing.html#typing.Tuple "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]]

pybel.struct.summary.iter\_sample\_metaedges(*graph*)[[source]](../../_modules/pybel/struct/summary/edge_summary.html#iter_sample_metaedges)[](#pybel.struct.summary.iter_sample_metaedges "Permalink to this definition")
:   Iterate sampled metaedges.

pybel.struct.summary.get\_syntax\_errors(*graph*)[[source]](../../_modules/pybel/struct/summary/errors.html#get_syntax_errors)[](#pybel.struct.summary.get_syntax_errors "Permalink to this definition")
:   List the syntax errors encountered during compilation of a BEL script.

    Return type
    :   [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Tuple`](https://docs.python.org/3/library/typing.html#typing.Tuple "(in Python v3.10)")[[`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`BELParserWarning`](../logging.html#pybel.exceptions.BELParserWarning "pybel.exceptions.BELParserWarning"), [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")]]

pybel.struct.summary.count\_error\_types(*graph*)[[source]](../../_modules/pybel/struct/summary/errors.html#count_error_types)[](#pybel.struct.summary.count_error_types "Permalink to this definition")
:   Count the occurrence of each type of error in a graph.

    Return type
    :   [`Counter`](https://docs.python.org/3/library/typing.html#typing.Counter "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

    Returns
    :   A Counter of {error type: frequency}

pybel.struct.summary.count\_naked\_names(*graph*)[[source]](../../_modules/pybel/struct/summary/errors.html#count_naked_names)[](#pybel.struct.summary.count_naked_names "Permalink to this definition")
:   Count the frequency of each naked name (names without namespaces).

    Return type
    :   [`Counter`](https://docs.python.org/3/library/typing.html#typing.Counter "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

    Returns
    :   A Counter from {name: frequency}

pybel.struct.summary.get\_naked\_names(*graph*)[[source]](../../_modules/pybel/struct/summary/errors.html#get_naked_names)[](#pybel.struct.summary.get_naked_names "Permalink to this definition")
:   Get the set of naked names in the graph.

    Return type
    :   [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

pybel.struct.summary.calculate\_incorrect\_name\_dict(*graph*)[[source]](../../_modules/pybel/struct/summary/errors.html#calculate_incorrect_name_dict)[](#pybel.struct.summary.calculate_incorrect_name_dict "Permalink to this definition")
:   Get missing names grouped by namespace.

    Return type
    :   [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]

pybel.struct.summary.calculate\_error\_by\_annotation(*graph*, *annotation*)[[source]](../../_modules/pybel/struct/summary/errors.html#calculate_error_by_annotation)[](#pybel.struct.summary.calculate_error_by_annotation "Permalink to this definition")
:   Group error names by a given annotation.

    Return type
    :   [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]

pybel.struct.summary.get\_functions(*graph*)[[source]](../../_modules/pybel/struct/summary/node_summary.html#get_functions)[](#pybel.struct.summary.get_functions "Permalink to this definition")
:   Get the set of all functions used in this graph.

    Parameters
    :   **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

    Returns
    :   A set of functions

pybel.struct.summary.count\_functions(*graph*)[[source]](../../_modules/pybel/struct/summary/node_summary.html#count_functions)[](#pybel.struct.summary.count_functions "Permalink to this definition")
:   Count the frequency of each function present in a graph.

    Parameters
    :   **graph** ([`BELGraph`](datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`Counter`](https://docs.python.org/3/library/typing.html#typing.Counter "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

    Returns
    :   A Counter from {function: frequency}

pybel.struct.summary.get\_namespaces(*graph*)[[source]](../../_modules/pybel/struct/summary/node_summary.html#get_namespaces)[](#pybel.struct.summary.get_namespaces "Permalink to this definition")
:   Get the set of all namespaces used in this graph