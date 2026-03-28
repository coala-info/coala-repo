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
* [Induction and Expansion](induction_expansion.html)
* Inference
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
* Inference
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/mutations/inference.rst)

---

# Inference[](#module-pybel.struct.mutation.inference "Permalink to this headline")

Mutations for inferring new edges in the graph.

pybel.struct.mutation.inference.enrich\_rnas\_with\_genes(*graph*)[[source]](../../_modules/pybel/struct/mutation/inference/protein_rna_origins.html#enrich_rnas_with_genes)[](#pybel.struct.mutation.inference.enrich_rnas_with_genes "Permalink to this definition")
:   Add the corresponding gene node for each RNA/miRNA node and connect them with a transcription edge.

    Parameters
    :   **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.inference.enrich\_proteins\_with\_rnas(*graph*)[[source]](../../_modules/pybel/struct/mutation/inference/protein_rna_origins.html#enrich_proteins_with_rnas)[](#pybel.struct.mutation.inference.enrich_proteins_with_rnas "Permalink to this definition")
:   Add the corresponding RNA node for each protein node and connect them with a translation edge.

    Parameters
    :   **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.inference.enrich\_protein\_and\_rna\_origins(*graph*)[[source]](../../_modules/pybel/struct/mutation/inference/protein_rna_origins.html#enrich_protein_and_rna_origins)[](#pybel.struct.mutation.inference.enrich_protein_and_rna_origins "Permalink to this definition")
:   Add the corresponding RNA for each protein then the corresponding gene for each RNA/miRNA.

    Parameters
    :   **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.inference.infer\_child\_relations(*graph*, *node*)[[source]](../../_modules/pybel/struct/mutation/inference/transfer.html#infer_child_relations)[](#pybel.struct.mutation.inference.infer_child_relations "Permalink to this definition")
:   Propagate causal relations to children.

    Return type
    :   [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

[Previous](induction_expansion.html "Induction and Expansion")
[Next](metadata.html "Metadata")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).