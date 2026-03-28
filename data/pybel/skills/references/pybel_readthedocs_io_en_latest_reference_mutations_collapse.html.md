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
* Collapse
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
* Collapse
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/mutations/collapse.rst)

---

# Collapse[](#module-pybel.struct.mutation.collapse "Permalink to this headline")

Functions for collapsing nodes.

pybel.struct.mutation.collapse.collapse\_pair(*graph*, *survivor*, *victim*)[[source]](../../_modules/pybel/struct/mutation/collapse/collapse.html#collapse_pair)[](#pybel.struct.mutation.collapse.collapse_pair "Permalink to this definition")
:   Rewire all edges from the synonymous node to the survivor node, then deletes the synonymous node.

    Does not keep edges between the two nodes.

    Parameters
    :   * **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **survivor** ([`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")) – The BEL node to collapse all edges on the synonym to
        * **victim** ([`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")) – The BEL node to collapse into the surviving node

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.collapse.collapse\_nodes(*graph*, *survivor\_mapping*)[[source]](../../_modules/pybel/struct/mutation/collapse/collapse.html#collapse_nodes)[](#pybel.struct.mutation.collapse.collapse_nodes "Permalink to this definition")
:   Collapse all nodes in values to the key nodes, in place.

    Parameters
    :   * **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **survivor\_mapping** ([`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]]) – A dictionary with survivors as their keys, and iterables of the corresponding victims as
          values.

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.collapse.collapse\_all\_variants(*graph*)[[source]](../../_modules/pybel/struct/mutation/collapse/collapse.html#collapse_all_variants)[](#pybel.struct.mutation.collapse.collapse_all_variants "Permalink to this definition")
:   Collapse all genes’, RNAs’, miRNAs’, and proteins’ variants to their parents.

    Parameters
    :   **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL Graph

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.collapse.surviors\_are\_inconsistent(*survivor\_mapping*)[[source]](../../_modules/pybel/struct/mutation/collapse/collapse.html#surviors_are_inconsistent)[](#pybel.struct.mutation.collapse.surviors_are_inconsistent "Permalink to this definition")
:   Check that there’s no transitive shit going on.

    Return type
    :   [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")]

pybel.struct.mutation.collapse.collapse\_to\_genes(*graph*)[[source]](../../_modules/pybel/struct/mutation/collapse/protein_rna_origins.html#collapse_to_genes)[](#pybel.struct.mutation.collapse.collapse_to_genes "Permalink to this definition")
:   Collapse all protein, RNA, and miRNA nodes to their corresponding gene nodes.

    Parameters
    :   **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph

[Previous](mutations.html "Mutations")
[Next](deletion.html "Deletion")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).