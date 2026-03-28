[PyBEL
![Logo](../../_static/PyBEL-square-100.png)](../../index.html)

latest

Getting Started

* [Overview](../../introduction/overview.html)
* [Installation](../../introduction/installation.html)

Data Structure

* Data Model
  + [Constants](#constants)
    - [Function Nomenclature](#function-nomenclature)
  + [Graph](#graph)
    - [Dispatches](#dispatches)
  + [Nodes](#nodes)
    - [Variants](#variants)
    - [Gene Substitutions](#module-pybel.parser.modifiers.gene_substitution)
    - [Gene Modifications](#module-pybel.parser.modifiers.gene_modification)
    - [Protein Substitutions](#module-pybel.parser.modifiers.protein_substitution)
    - [Protein Modifications](#module-pybel.parser.modifiers.protein_modification)
    - [Protein Truncations](#module-pybel.parser.modifiers.truncation)
    - [Protein Fragments](#module-pybel.parser.modifiers.fragment)
    - [Fusions](#module-pybel.parser.modifiers.fusion)
  + [Unqualified Edges](#unqualified-edges)
    - [Variant and Modifications’ Parent Relations](#variant-and-modifications-parent-relations)
    - [List Abundances](#list-abundances)
    - [Reactions](#reactions)
  + [Edges](#edges)
    - [Design Choices](#design-choices)
    - [Example Edge Data Structure](#example-edge-data-structure)
    - [Activities](#activities)
    - [Locations](#module-pybel.parser.modifiers.location)
    - [Translocations](#translocations)
    - [Degradations](#degradations)
* [Example Networks](examples.html)
* [Filters](filters.html)
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
* Data Model
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/struct/datamodel.rst)

---

# Data Model[](#module-pybel.struct "Permalink to this headline")

The [`pybel.struct`](#module-pybel.struct "pybel.struct") module houses functions for handling the main data structure in PyBEL.

Because BEL expresses how biological entities interact within many
different contexts, with descriptive annotations, PyBEL represents data as a directed multi-graph by sub-classing the
[`networkx.MultiDiGraph`](https://networkx.org/documentation/latest/reference/classes/multidigraph.html#networkx.MultiDiGraph "(in NetworkX v2.7rc1.dev0)"). Each node is an instance of a subclass of the [`pybel.dsl.BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.BaseEntity") and each
edge has a stable key and associated data dictionary for storing relevant contextual information.

The graph contains metadata for the PyBEL version, the BEL script metadata, the namespace definitions, the
annotation definitions, and the warnings produced in analysis. Like any `networkx` graph, all attributes of
a given object can be accessed through the `graph` property, like in: `my_graph.graph['my key']`.
Convenient property definitions are given for these attributes that are outlined in the documentation for
[`pybel.BELGraph`](#pybel.BELGraph "pybel.BELGraph").

This allows for much easier programmatic access to answer more complicated questions, which can be written with python
code. Because the data structure is the same in Neo4J, the data can be directly exported with [`pybel.to_neo4j()`](../io.html#pybel.to_neo4j "pybel.to_neo4j").
Neo4J supports the Cypher querying language so that the same queries can be written in an elegant and simple way.

## Constants[](#constants "Permalink to this headline")

These documents refer to many aspects of the data model using constants, which can be found in the top-level module
[`pybel.constants`](../constants.html#module-pybel.constants "pybel.constants").

Terms describing abundances, annotations, and other internal data are designated in [`pybel.constants`](../constants.html#module-pybel.constants "pybel.constants")
with full-caps, such as [`pybel.constants.FUNCTION`](../constants.html#pybel.constants.FUNCTION "pybel.constants.FUNCTION") and [`pybel.constants.PROTEIN`](../constants.html#pybel.constants.PROTEIN "pybel.constants.PROTEIN").

For normal usage, we suggest referring to values in dictionaries by these constants, in case the hard-coded
strings behind these constants change.

### Function Nomenclature[](#function-nomenclature "Permalink to this headline")

The following table shows PyBEL’s internal mapping from BEL functions to its own constants. This can be accessed
programatically via `pybel.parser.language.abundance_labels`.

| BEL Function | PyBEL Constant | PyBEL DSL |
| --- | --- | --- |
| `a()`, `abundance()` | [`pybel.constants.ABUNDANCE`](../constants.html#pybel.constants.ABUNDANCE "pybel.constants.ABUNDANCE") | [`pybel.dsl.Abundance`](../dsl.html#pybel.dsl.Abundance "pybel.dsl.Abundance") |
| `g()`, `geneAbundance()` | [`pybel.constants.GENE`](../constants.html#pybel.constants.GENE "pybel.constants.GENE") | [`pybel.dsl.Gene`](../dsl.html#pybel.dsl.Gene "pybel.dsl.Gene") |
| `r()`, `rnaAbunance()` | [`pybel.constants.RNA`](../constants.html#pybel.constants.RNA "pybel.constants.RNA") | [`pybel.dsl.Rna`](../dsl.html#pybel.dsl.Rna "pybel.dsl.Rna") |
| `m()`, `microRNAAbundance()` | [`pybel.constants.MIRNA`](../constants.html#pybel.constants.MIRNA "pybel.constants.MIRNA") | [`pybel.dsl.MicroRna`](../dsl.html#pybel.dsl.MicroRna "pybel.dsl.MicroRna") |
| `p()`, `proteinAbundance()` | [`pybel.constants.PROTEIN`](../constants.html#pybel.constants.PROTEIN "pybel.constants.PROTEIN") | [`pybel.dsl.Protein`](../dsl.html#pybel.dsl.Protein "pybel.dsl.Protein") |
| `bp()`, `biologicalProcess()` | [`pybel.constants.BIOPROCESS`](../constants.html#pybel.constants.BIOPROCESS "pybel.constants.BIOPROCESS") | [`pybel.dsl.BiologicalProcess`](../dsl.html#pybel.dsl.BiologicalProcess "pybel.dsl.BiologicalProcess") |
| `path()`, `pathology()` | [`pybel.constants.PATHOLOGY`](../constants.html#pybel.constants.PATHOLOGY "pybel.constants.PATHOLOGY") | [`pybel.dsl.Pathology`](../dsl.html#pybel.dsl.Pathology "pybel.dsl.Pathology") |
| `complex()`, `complexAbundance()` | [`pybel.constants.COMPLEX`](../constants.html#pybel.constants.COMPLEX "pybel.constants.COMPLEX") | [`pybel.dsl.ComplexAbundance`](../dsl.html#pybel.dsl.ComplexAbundance "pybel.dsl.ComplexAbundance") |
| `composite()`, `compositeAbundance()` | [`pybel.constants.COMPOSITE`](../constants.html#pybel.constants.COMPOSITE "pybel.constants.COMPOSITE") | [`pybel.dsl.CompositeAbundance`](../dsl.html#pybel.dsl.CompositeAbundance "pybel.dsl.CompositeAbundance") |
| `rxn()`, `reaction()` | [`pybel.constants.REACTION`](../constants.html#pybel.constants.REACTION "pybel.constants.REACTION") | [`pybel.dsl.Reaction`](../dsl.html#pybel.dsl.Reaction "pybel.dsl.Reaction") |

## Graph[](#graph "Permalink to this headline")

*class* pybel.BELGraph(*name=None*, *version=None*, *description=None*, *authors=None*, *contact=None*, *license=None*, *copyright=None*, *disclaimer=None*, *path=None*)[[source]](../../_modules/pybel/struct/graph.html#BELGraph)[](#pybel.BELGraph "Permalink to this definition")
:   An extension to [`networkx.MultiDiGraph`](https://networkx.org/documentation/latest/reference/classes/multidigraph.html#networkx.MultiDiGraph "(in NetworkX v2.7rc1.dev0)") to represent BEL.

    Initialize a BEL graph with its associated metadata.

    Parameters
    :   * **name** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The graph’s name
        * **version** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The graph’s version. Recommended to use [semantic versioning](http://semver.org/) or
          `YYYYMMDD` format.
        * **description** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – A description of the graph
        * **authors** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The authors of this graph
        * **contact** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The contact email for this graph
        * **license** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The license for this graph
        * **copyright** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The copyright for this graph
        * **disclaimer** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The disclaimer for this graph

    \_\_add\_\_(*other*)[[source]](../../_modules/pybel/struct/graph.html#BELGraph.__add__)[](#pybel.BELGraph.__add__ "Permalink to this definition")
    :   Copy this graph and join it with another graph with it using [`pybel.struct.left_full_join()`](operators.html#pybel.struct.left_full_join "pybel.struct.left_full_join").

        Parameters
        :   **other** ([`BELGraph`](#pybel.BELGraph "pybel.struct.graph.BELGraph")) – Another BEL graph

        Example usage:

        ```
        >>> from pybel.examples import ras_tloc_graph, braf_graph
        >>> k = ras_tloc_graph + braf_graph
        ```

        Return type
        :   [`BELGraph`](#pybel.BELGraph "pybel.struct.graph.BELGraph")

    \_\_iadd\_\_(*other*)[[source]](../../_modules/pybel/struct/graph.html#BELGraph.__iadd__)[](#pybel.BELGraph.__iadd__ "Permalink to this definition")
    :   Join another graph into this one, in-place, using [`pybel.struct.left_full_join()`](operators.html#pybel.struct.left_full_join "pybel.struct.left_full_join").

        Parameters
        :   **other** ([`BELGraph`](#pybel.BELGraph "pybel.struct.graph.BELGraph")) – Another BEL graph

        Example usage:

        ```
        >>> from pybel.examples import ras_tloc_graph, braf_graph
        >>> ras_tloc_graph += braf_graph
        ```

        Return type
        :   [`BELGraph`](#pybel.BELGraph "pybel.struct.graph.BELGraph")

    \_\_and\_\_(*other*)[[source]](../../_modules/pybel/struct/graph.html#BELGraph.__and__)[](#pybel.BELGraph.__and__ "Permalink to this definition")
    :   Create a deep copy of this graph and left outer joins another graph.

        Uses [`pybel.struct.left_outer_join()`](operators.html#pybel.struct.left_outer_join "pybel.struct.left_outer_join").

        Parameters
        :   **other** ([`BELGraph`](#pybel.BELGraph "pybel.struct.graph.BELGraph")) – Another BEL graph

        Example usage:

        ```
        >>> from pybel.examples import ras_tloc_graph, braf_graph
        >>> k = ras_tloc_graph & braf_graph
        ```

        Return type
        :   [`BELGraph`](#pybel.BELGraph "pybel.struct.graph.BELGraph")

    \_\_iand\_\_(*other*)[[source]](../../_modules/pybel/struct/graph.html#BELGraph.__iand__)[](#pybel.BELGraph.__iand__ "Permalink to this definition")
    :   Join another graph into this one, in-place, using [`pybel.struct.left_outer_join()`](operators.html#pybel.struct.left_outer_join "pybel.struct.left_outer_join").

        Parameters
        :   **other** ([`BELGraph`](#pybel.BELGraph "pybel.struct.graph.BELGraph")) – Another BEL graph

        Example usage:

        ```
        >>> from pybel.examples import ras_tloc_graph, braf_graph
        >>> ras_tloc_graph &= braf_graph
        ```

        Return type
        :   [`BELGraph`](#pybel.BELGraph "pybel.struct.graph.BELGraph")

    transitivities*: Set[Tuple[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]*[](#pybel.BELGraph.transitivities "Permalink to this definition")
    :   A set of pairs of hashes of edges over which there is transitivity.
        For example, for the nested statement (P(X) -> P(Y)) -> P(Z) will have
        a pair for (hash(P(X) -> P(Y)), hash(P(Y) -> P(Z)))

    parent[](#pybel.BELGraph.parent "Permalink to this definition")
    :   A reference to the parent graph

    child()[[source]](../../_modules/pybel/struct/graph.html#BELGraph.child)[](#pybel.BELGraph.child "Permalink to this definition")
    :   Create an empty graph with a “parent” reference back to this one.

        Return type
        :   [`BELGraph`](#pybel.BELGraph "pybel.struct.graph.BELGraph")

    *property* count*: [pybel.struct.graph.CountDispatch](#pybel.struct.graph.CountDispatch "pybel.struct.graph.CountDispatch")*[](#pybel.BELGraph.count "Permalink to this definition")
    :   A dispatch to count functions.

        Can be used like this:

        ```
        >>> from pybel.examples import sialic_acid_graph
        >>> sialic_acid_graph.count.functions()
        Counter({'Protein': 7, 'Complex': 1, 'Abundance': 1})
        ```

        Return type
        :   [`CountDispatch`](#pybel.struct.graph.CountDispatch "pybel.struct.graph.CountDispatch")

    *property* summarize*: [pybel.struct.graph.SummarizeDispatch](#pybel.struct.graph.SummarizeDispatch "pybel.struct.graph.SummarizeDispatch")*[](#pybel.BELGraph.summarize "Permalink to this definition")
    :   A dispatch to summarize the graph.

        Return type
        :   [`SummarizeDispatch`](#pybel.struct.graph.SummarizeDispatch "pybel.struct.graph.SummarizeDispatch")

    *property* expand*: [pybel.struct.graph.ExpandDispatch](#pybel.struct.graph.ExpandDispatch "pybel.struct.graph.ExpandDispatch")*[](#pybel.BELGraph.expand "Permalink to this defi