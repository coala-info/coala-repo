[PyBEL
![Logo](../_static/PyBEL-square-100.png)](../index.html)

latest

Getting Started

* [Overview](../introduction/overview.html)
* [Installation](../introduction/installation.html)

Data Structure

* [Data Model](struct/datamodel.html)
* [Example Networks](struct/examples.html)
* [Filters](struct/filters.html)
* [Grouping](struct/grouping.html)
* [Operations](struct/operators.html)
* [Pipeline](struct/pipeline.html)
* [Query](struct/query.html)
* [Summary](struct/summary.html)

Mutations

* [Mutations](mutations/mutations.html)
* [Collapse](mutations/collapse.html)
* [Deletion](mutations/deletion.html)
* [Expansion](mutations/expansion.html)
* [Induction](mutations/induction.html)
* [Induction and Expansion](mutations/induction_expansion.html)
* [Inference](mutations/inference.html)
* [Metadata](mutations/metadata.html)

Conversion

* Input and Output
  + [Import](#import)
    - [Parsing Modes](#parsing-modes)
      * [Allow Naked Names](#allow-naked-names)
      * [Allow Nested](#allow-nested)
      * [Citation Clearing](#citation-clearing)
    - [Reference](#reference)
    - [Hetionet](#module-pybel.io.hetionet)
  + [Transport](#transport)
    - [Bytes](#module-pybel.io.gpickle)
    - [Node-Link JSON](#module-pybel.io.nodelink)
    - [Streamable BEL (JSONL)](#module-pybel.io.sbel)
    - [Cyberinfrastructure Exchange](#module-pybel.io.cx)
    - [JSON Graph Interchange Format](#module-pybel.io.jgif)
    - [GraphDati](#module-pybel.io.graphdati)
    - [INDRA](#module-pybel.io.indra)
  + [Visualization](#visualization)
    - [Jupyter](#module-pybel.io.jupyter)
  + [Analytical Services](#analytical-services)
    - [PyNPA](#module-pybel.io.pynpa)
    - [HiPathia](#module-pybel.io.hipathia)
      * [Input](#input)
    - [SPIA](#module-pybel.io.spia)
    - [PyKEEN](#module-pybel.io.pykeen)
    - [Machine Learning](#module-pybel.io.triples)
  + [Web Services](#web-services)
    - [BEL Commons](#module-pybel.io.bel_commons_client)
    - [Amazon Simple Storage Service (S3)](#module-pybel.io.aws)
    - [BioDati](#module-pybel.io.biodati_client)
    - [Fraunhofer OrientDB](#module-pybel.io.fraunhofer_orientdb)
    - [EMMAA](#module-pybel.io.emmaa)
  + [Databases](#databases)
    - [SQL Databases](#module-pybel.manager.database_io)
    - [Neo4j](#module-pybel.io.neo4j)
  + [Lossy Export](#lossy-export)
    - [Umbrella Node-Link JSON](#module-pybel.io.umbrella_nodelink)
    - [GraphML](#module-pybel.io.graphml)
    - [Miscellaneous](#module-pybel.io.extras)

Database

* [Manager](database/manager.html)
* [Models](database/models.html)

Topic Guide

* [Cookbook](../topics/cookbook.html)
* [Command Line Interface](../topics/cli.html)

Reference

* [Constants](constants.html)
* [Parsers](parser.html)
* [Internal Domain Specific Language](dsl.html)
* [Logging Messages](logging.html)

Project

* [References](../meta/references.html)
* [Current Issues](../meta/postmortem.html)
* [Technology](../meta/technology.html)

[PyBEL](../index.html)

* »
* Input and Output
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/io.rst)

---

# Input and Output[](#module-pybel.io "Permalink to this headline")

Input and output functions for BEL graphs.

PyBEL provides multiple lossless interchange options for BEL. Lossy output formats are also included for convenient
export to other programs. Notably, a *de facto* interchange using Resource Description Framework (RDF) to match the
ability of other existing software is excluded due the immaturity of the BEL to RDF mapping.

pybel.load(*path*, *\*\*kwargs*)[[source]](../_modules/pybel/io/api.html#load)[](#pybel.load "Permalink to this definition")
:   Read a BEL graph.

    Parameters
    :   * **path** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The path to a BEL graph in any of the formats
          with extensions described below
        * **kwargs** – The keyword arguments are passed to the importer
          function

    Return type
    :   [`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

    Returns
    :   A BEL graph.

    This is the universal loader, which means any file
    path can be given and PyBEL will look up the appropriate
    load function. Allowed extensions are:

    * bel
    * bel.nodelink.json
    * bel.cx.json
    * bel.jgif.json

    The previous extensions also support gzipping.
    Other allowed extensions that don’t support gzip are:

    * bel.pickle / bel.gpickle / bel.pkl
    * indra.json

pybel.dump(*graph*, *path*, *\*\*kwargs*)[[source]](../_modules/pybel/io/api.html#dump)[](#pybel.dump "Permalink to this definition")
:   Write a BEL graph.

    Parameters
    :   * **graph** ([`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **path** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The path to which the BEL graph is written.
        * **kwargs** – The keyword arguments are passed to the exporter
          function

    This is the universal loader, which means any file
    path can be given and PyBEL will look up the appropriate
    writer function. Allowed extensions are:

    * bel
    * bel.nodelink.json
    * bel.unodelink.json
    * bel.cx.json
    * bel.jgif.json
    * bel.graphdati.json

    The previous extensions also support gzipping.
    Other allowed extensions that don’t support gzip are:

    * bel.pickle / bel.gpickle / bel.pkl
    * indra.json
    * tsv
    * gsea

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

## Import[](#import "Permalink to this headline")

### Parsing Modes[](#parsing-modes "Permalink to this headline")

The PyBEL parser has several modes that can be enabled and disabled. They are described below.

#### Allow Naked Names[](#allow-naked-names "Permalink to this headline")

By default, this is set to `False`. The parser does not allow identifiers that are not qualified with
namespaces (*naked names*), like in `p(YFG)`. A proper namespace, like `p(HGNC:YFG)` must be used. By
setting this to `True`, the parser becomes permissive to naked names. In general, this is bad practice and this
feature will be removed in the future.

#### Allow Nested[](#allow-nested "Permalink to this headline")

By default, this is set to `False`. The parser does not allow nested statements is disabled. See overview.
By setting this to `True` the parser will accept nested statements one level deep.

#### Citation Clearing[](#citation-clearing "Permalink to this headline")

By default, this is set to `True`. While the BEL specification clearly states how the language should be used as
a state machine, many BEL documents do not conform to the strict `SET`/`UNSET` rules. To guard against
annotations accidentally carried from one set of statements to the next, the parser has two modes. By default, in
citation clearing mode, when a `SET CITATION` command is reached, it will clear all other annotations (except
the `STATEMENT_GROUP`, which has higher priority). This behavior can be disabled by setting this to `False`
to re-enable strict parsing.

### Reference[](#reference "Permalink to this headline")

pybel.from\_bel\_script(*path: [Union](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [TextIO](https://docs.python.org/3/library/typing.html#typing.TextIO "(in Python v3.10)")]*, *\*\*kwargs*) → [pybel.struct.graph.BELGraph](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")[[source]](../_modules/pybel/io/lines.html#from_bel_script)[](#pybel.from_bel_script "Permalink to this definition")
:   Load a BEL graph from a file resource. This function is a thin wrapper around `from_lines()`.

    Parameters
    :   **path** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`TextIO`](https://docs.python.org/3/library/typing.html#typing.TextIO "(in Python v3.10)")]) – A path or file-like

    The remaining keyword arguments are passed to [`pybel.io.line_utils.parse_lines()`](parser.html#pybel.io.line_utils.parse_lines "pybel.io.line_utils.parse_lines"),
    which populates a [`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.BELGraph").

    Return type
    :   [`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

pybel.from\_bel\_script\_url(*url*, *\*\*kwargs*)[[source]](../_modules/pybel/io/lines.html#from_bel_script_url)[](#pybel.from_bel_script_url "Permalink to this definition")
:   Load a BEL graph from a URL resource.

    Parameters
    :   **url** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – A valid URL pointing to a BEL document

    The remaining keyword arguments are passed to [`pybel.io.line_utils.parse_lines()`](parser.html#pybel.io.line_utils.parse_lines "pybel.io.line_utils.parse_lines").

    Return type
    :   [`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

pybel.to\_bel\_script(*graph*, *path: [Union](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [TextIO](https://docs.python.org/3/library/typing.html#typing.TextIO "(in Python v3.10)")]*, *use\_identifiers: [bool](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)") = True*) → [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")[[source]](../_modules/pybel/canonicalize.html#to_bel_script)[](#pybel.to_bel_script "Permalink to this definition")
:   Write the BELGraph as a canonical BEL script.

    Parameters
    :   * **graph** ([*BELGraph*](struct/datamodel.html#pybel.BELGraph "pybel.BELGraph")) – the BEL Graph to output as a BEL Script
        * **path** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`TextIO`](https://docs.python.org/3/library/typing.html#typing.TextIO "(in Python v3.10)")]) – A path or file-like.
        * **use\_identifiers** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Enables extended [BEP-0008](http://bep.bel.bio/published/BEP-0008.html) syntax

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

### Hetionet[](#module-pybel.io.hetionet "Permalink to this headline")

Importer for Hetionet JSON.

pybel.from\_hetionet\_json(*hetionet\_dict*, *use\_tqdm=True*)[[source]](../_modules/pybel/io/hetionet/hetionet.html#from_hetionet_json)[](#pybel.from_hetionet_json "Permalink to this definition")
:   Convert a Hetionet dictionary to a BEL graph.

    Return type
    :   [`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

pybel.from\_hetionet\_file(*file*)[[source]](../_modules/pybel/io/hetionet/hetionet.html#from_hetionet_file)[](#pybel.from_hetionet_file "Permalink to this definition")
:   Get Hetionet from a JSON file.

    Return type
    :   [`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

pybel.from\_hetionet\_gz(*path*)[[source]](../_modules/pybel/io/hetionet/hetionet.html#from_hetionet_gz)[](#pybel.from_hetionet_gz "Permalink to this definition")
:   Get Hetionet from its JSON GZ file.

    Return type
    :   [`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

pybel.get\_hetionet()[[source]](../_modules/pybel/io/hetionet/hetionet.html#get_hetionet)[](#pybel.get_hetionet "Permalink to this definition")
:   Get Hetionet from GitHub, cache, and convert to BEL.

    Return type
    :   [`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

## Transport[](#transport "Permalink to this headline")

All transport pairs are reflective and data-preserving.

### Bytes[](#module-pybel.io.gpickle "Permalink to this headline")

Conversion functions for BEL graphs with bytes and Python pickles.

pybel.from\_bytes(*bytes\_graph*, *check\_version=True*)[[source]](../_modules/pybel/io/gpickle.html#from_bytes)[](#pybel.from_bytes "Permalink to this definition")
:   Read a graph from bytes (the result of pickling the graph).

    Parameters
    :   * **bytes\_graph** ([`bytes`](https://docs.python.org/3/library/stdtypes.html#bytes "(in Python v3.10)")) – File or filename to write
        * **check\_version** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Checks if the graph was produced by this version of PyBEL

    Return type
    :   [`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

pybel.to\_bytes(*graph*, *protocol=5*)[[source]](../_modules/pybel/io/gpickle.html#to_bytes)[](#pybel.to_bytes "Permalink to this definition")
:   Convert a graph to bytes with pickle.

    Note that the pickle module has some incompatibilities between Python 2 and 3. To export a universally importable
    pickle, choose 0, 1, or 2.

    Parameters
    :   * **graph** ([`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **protocol** ([`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")) – Pickling protocol to use. Defaults to `HIGHEST_PROTOCOL`.

    See also

    <https://docs.python.org/3.6/library/pickle.html#data-stream-format>

    Return type
    :   [`bytes`](https://docs.python.org/3/library/stdtypes.html#bytes "(in Python v3.10)")

pybel.from\_bytes\_gz(*bytes\_graph*)[[source]](../_modules/pybel/io/gpickle.html#from_bytes_gz)[](#pybel.from_bytes_gz "Permalink to this definition")
:   Read a graph from gzipped bytes (the result of pickling the graph).

    Parameters
    :   **bytes\_graph** ([`bytes`](https://docs.python.org/3/library/stdtypes.html#bytes "(in Python v3.10)")) – File or filename to write

    Return type
    :   [`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

pybel.to\_bytes\_gz(*graph*, *protocol=5*)[[source]](../_modules/pybel/io/gpickle.html#to_bytes_gz)[](#pybel.to_bytes_gz "Permalink to this definition")
:   Convert a graph to gzipped bytes with pickle.

    Parameters
    :   * **graph** ([`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")) – A BEL graph
        * **protocol** ([`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")) – Pickling protocol to use. Defaults to `HIGHEST_PROTOCOL`.

    Return type
    :   [`bytes`](https://docs.python.org/3/library/stdtypes.html#bytes "(in Python v3.10)")

pybel.from\_pickle(*path: [Union](https://docs.python.org/3/library/typing.html#typing.Union "(in Pytho