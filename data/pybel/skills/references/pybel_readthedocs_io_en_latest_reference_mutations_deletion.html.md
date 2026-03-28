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
* Deletion
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
* Deletion
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/mutations/deletion.rst)

---

# Deletion[](#module-pybel.struct.mutation.deletion "Permalink to this headline")

Modules supporting deletion and degradation of graphs.

pybel.struct.mutation.deletion.remove\_filtered\_edges(*graph*, *edge\_predicates=None*)[[source]](../../_modules/pybel/struct/mutation/deletion/deletion.html#remove_filtered_edges)[](#pybel.struct.mutation.deletion.remove_filtered_edges "Permalink to this definition")
:   Remove edges passing the given edge predicates.

    Parameters
    :   * **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **edge\_predicates** (*None* *or* *(**(*[*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")*,* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple "(in Python v3.10)")*,* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple "(in Python v3.10)")*,* [*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")*)* *-> bool**) or* *iter**[**(*[*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")*,* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple "(in Python v3.10)")*,* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple "(in Python v3.10)")*,* [*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")*)* *-> bool**]**]*) – A predicate or list of predicates

    Returns

pybel.struct.mutation.deletion.remove\_filtered\_nodes(*graph*, *node\_predicates=None*)[[source]](../../_modules/pybel/struct/mutation/deletion/deletion.html#remove_filtered_nodes)[](#pybel.struct.mutation.deletion.remove_filtered_nodes "Permalink to this definition")
:   Remove nodes passing the given node predicates.

    Parameters
    :   **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph

pybel.struct.mutation.deletion.remove\_associations(*graph*)[[source]](../../_modules/pybel/struct/mutation/deletion/deletion.html#remove_associations)[](#pybel.struct.mutation.deletion.remove_associations "Permalink to this definition")
:   Remove all associative relationships from the graph.

    Parameters
    :   **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph

pybel.struct.mutation.deletion.remove\_pathologies(*graph*)[[source]](../../_modules/pybel/struct/mutation/deletion/deletion.html#remove_pathologies)[](#pybel.struct.mutation.deletion.remove_pathologies "Permalink to this definition")
:   Remove pathology nodes from the graph.

    Parameters
    :   **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph

pybel.struct.mutation.deletion.remove\_biological\_processes(*graph*)[[source]](../../_modules/pybel/struct/mutation/deletion/deletion.html#remove_biological_processes)[](#pybel.struct.mutation.deletion.remove_biological_processes "Permalink to this definition")
:   Remove biological process nodes from the graph.

    Parameters
    :   **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph

pybel.struct.mutation.deletion.remove\_isolated\_list\_abundances(*graph*)[[source]](../../_modules/pybel/struct/mutation/deletion/deletion.html#remove_isolated_list_abundances)[](#pybel.struct.mutation.deletion.remove_isolated_list_abundances "Permalink to this definition")
:   Remove isolated list abundances from the graph.

    Parameters
    :   **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph

pybel.struct.mutation.deletion.remove\_non\_causal\_edges(*graph*)[[source]](../../_modules/pybel/struct/mutation/deletion/deletion.html#remove_non_causal_edges)[](#pybel.struct.mutation.deletion.remove_non_causal_edges "Permalink to this definition")
:   Remove non-causal edges from the graph.

pybel.struct.mutation.deletion.prune\_protein\_rna\_origins(*graph*)[[source]](../../_modules/pybel/struct/mutation/deletion/protein_rna_origins.html#prune_protein_rna_origins)[](#pybel.struct.mutation.deletion.prune_protein_rna_origins "Permalink to this definition")
:   Delete genes that are only connected to one node, their correspond RNA, by a translation edge.

    Parameters
    :   **graph** ([*pybel.BELGraph*](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph

[Previous](collapse.html "Collapse")
[Next](expansion.html "Expansion")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).