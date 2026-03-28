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
* [Inference](inference.html)
* Metadata

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
* Metadata
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/mutations/metadata.rst)

---

# Metadata[](#module-pybel.struct.mutation.metadata "Permalink to this headline")

Functions to modify the metadata of graphs, their edges, and their nodes.

pybel.struct.mutation.metadata.strip\_annotations(*graph*)[[source]](../../_modules/pybel/struct/mutation/metadata.html#strip_annotations)[](#pybel.struct.mutation.metadata.strip_annotations "Permalink to this definition")
:   Strip all the annotations from a BEL graph.

    Parameters
    :   **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.metadata.add\_annotation\_value(*graph*, *annotation*, *value*, *strict=True*)[[source]](../../_modules/pybel/struct/mutation/metadata.html#add_annotation_value)[](#pybel.struct.mutation.metadata.add_annotation_value "Permalink to this definition")
:   Add the given annotation/value pair to all qualified edges.

    Parameters
    :   * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **annotation** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) –
        * **value** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) –
        * **strict** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Should the function ensure the annotation has already been defined?

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.metadata.remove\_annotation\_value(*graph*, *annotation*, *value*)[[source]](../../_modules/pybel/struct/mutation/metadata.html#remove_annotation_value)[](#pybel.struct.mutation.metadata.remove_annotation_value "Permalink to this definition")
:   Remove the given annotation/value pair to all qualified edges.

    Parameters
    :   * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **annotation** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) –
        * **value** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) –

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.mutation.metadata.remove\_extra\_citation\_metadata(*graph*)[[source]](../../_modules/pybel/struct/mutation/metadata.html#remove_extra_citation_metadata)[](#pybel.struct.mutation.metadata.remove_extra_citation_metadata "Permalink to this definition")
:   Remove superfluous metadata associated with a citation (that isn’t the db/id).

    Best practice is to add this information programmatically.

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.manager.enrich\_pubmed\_citations(*graph*, *\**, *manager=None*, *group\_size=None*, *offline=False*)[[source]](../../_modules/pybel/manager/citation_utils.html#enrich_pubmed_citations)[](#pybel.manager.enrich_pubmed_citations "Permalink to this definition")
:   Overwrite all PubMed citations with values from NCBI’s eUtils lookup service.

    Parameters
    :   * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **manager** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`Manager`](../database/manager.html#pybel.manager.Manager "pybel.manager.cache_manager.Manager")]) – A PyBEL database manager
        * **group\_size** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")]) – The number of PubMed identifiers to query at a time. Defaults to 200 identifiers.
        * **offline** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – An override for when you don’t want to hit the eUtils

    Return type
    :   [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

    Returns
    :   A set of PMIDs for which the eUtils service crashed

pybel.manager.enrich\_pmc\_citations(*graph*, *\**, *manager=None*, *group\_size=None*, *offline=False*)[[source]](../../_modules/pybel/manager/citation_utils.html#enrich_pmc_citations)[](#pybel.manager.enrich_pmc_citations "Permalink to this definition")
:   Overwrite all PubMed citations with values from NCBI’s eUtils lookup service.

    Parameters
    :   * **graph** ([`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **manager** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`Manager`](../database/manager.html#pybel.manager.Manager "pybel.manager.cache_manager.Manager")]) – A PyBEL database manager
        * **group\_size** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")]) – The number of PubMed identifiers to query at a time. Defaults to 200 identifiers.
        * **offline** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – An override for when you don’t want to hit the eUtils

    Return type
    :   [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

    Returns
    :   A set of PMIDs for which the eUtils service crashed

[Previous](inference.html "Inference")
[Next](../io.html "Input and Output")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).