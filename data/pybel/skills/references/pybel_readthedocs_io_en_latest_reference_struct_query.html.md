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
* Query
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
* Query
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/struct/query.rst)

---

# Query[](#module-pybel.struct.query "Permalink to this headline")

Query builder for PyBEL.

*exception* pybel.struct.query.QueryMissingNetworksError[[source]](../../_modules/pybel/struct/query/exc.html#QueryMissingNetworksError)[](#pybel.struct.query.QueryMissingNetworksError "Permalink to this definition")
:   Raised if a query is created from json but doesn’t have a listing of network identifiers.

*exception* pybel.struct.query.NodeDegreeIterError[[source]](../../_modules/pybel/struct/query/exc.html#NodeDegreeIterError)[](#pybel.struct.query.NodeDegreeIterError "Permalink to this definition")
:   Raised when failing to iterate over node degrees.

*class* pybel.struct.query.Query(*network\_ids=None*, *seeding=None*, *pipeline=None*)[[source]](../../_modules/pybel/struct/query/query.html#Query)[](#pybel.struct.query.Query "Permalink to this definition")
:   Represents a query over a network store.

    Build a query.

    Parameters
    :   **network\_ids** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)"), [`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)"), [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")]]) – Database network identifiers identifiers

    append\_network(*network\_id*)[[source]](../../_modules/pybel/struct/query/query.html#Query.append_network)[](#pybel.struct.query.Query.append_network "Permalink to this definition")
    :   Add a network to this query.

        Parameters
        :   **network\_id** ([`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")) – The database identifier of the network

        Return type
        :   [`Query`](#pybel.struct.query.Query "pybel.struct.query.query.Query")

        Returns
        :   self for fluid API

    append\_seeding\_induction(*nodes*)[[source]](../../_modules/pybel/struct/query/query.html#Query.append_seeding_induction)[](#pybel.struct.query.Query.append_seeding_induction "Permalink to this definition")
    :   Add a seed induction method.

        Return type
        :   [`Seeding`](#pybel.struct.query.Seeding "pybel.struct.query.seeding.Seeding")

        Returns
        :   seeding container for fluid API

    append\_seeding\_neighbors(*nodes*)[[source]](../../_modules/pybel/struct/query/query.html#Query.append_seeding_neighbors)[](#pybel.struct.query.Query.append_seeding_neighbors "Permalink to this definition")
    :   Add a seed by neighbors.

        Return type
        :   [`Seeding`](#pybel.struct.query.Seeding "pybel.struct.query.seeding.Seeding")

        Returns
        :   seeding container for fluid API

    append\_seeding\_annotation(*annotation*, *values*)[[source]](../../_modules/pybel/struct/query/query.html#Query.append_seeding_annotation)[](#pybel.struct.query.Query.append_seeding_annotation "Permalink to this definition")
    :   Add a seed induction method for single annotation’s values.

        Parameters
        :   * **annotation** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The annotation to filter by
            * **values** ([`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The values of the annotation to keep

        Return type
        :   [`Seeding`](#pybel.struct.query.Seeding "pybel.struct.query.seeding.Seeding")

    append\_seeding\_sample(*\*\*kwargs*)[[source]](../../_modules/pybel/struct/query/query.html#Query.append_seeding_sample)[](#pybel.struct.query.Query.append_seeding_sample "Permalink to this definition")
    :   Add seed induction methods.

        Kwargs can have `number_edges` or `number_seed_nodes`.

        Return type
        :   [`Seeding`](#pybel.struct.query.Seeding "pybel.struct.query.seeding.Seeding")

    append\_pipeline(*name*, *\*args*, *\*\*kwargs*)[[source]](../../_modules/pybel/struct/query/query.html#Query.append_pipeline)[](#pybel.struct.query.Query.append_pipeline "Permalink to this definition")
    :   Add an entry to the pipeline. Defers to `pybel_tools.pipeline.Pipeline.append()`.

        Parameters
        :   **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)") *or* *types.FunctionType*) – The name of the function

        Return type
        :   [`Pipeline`](pipeline.html#pybel.Pipeline "pybel.struct.pipeline.pipeline.Pipeline")

        Returns
        :   This pipeline for fluid query building

    run(*manager*)[[source]](../../_modules/pybel/struct/query/query.html#Query.run)[](#pybel.struct.query.Query.run "Permalink to this definition")
    :   Run this query and returns the resulting BEL graph.

        Parameters
        :   **manager** – A cache manager

        Return type
        :   Optional[[pybel.BELGraph](datamodel.html#pybel.BELGraph "pybel.BELGraph")]

    to\_json()[[source]](../../_modules/pybel/struct/query/query.html#Query.to_json)[](#pybel.struct.query.Query.to_json "Permalink to this definition")
    :   Return this query as a JSON object.

        Return type
        :   [`Dict`](https://docs.python.org/3/library/typing.html#typing.Dict "(in Python v3.10)")

    dump(*file*, *\*\*kwargs*)[[source]](../../_modules/pybel/struct/query/query.html#Query.dump)[](#pybel.struct.query.Query.dump "Permalink to this definition")
    :   Dump this query to a file as JSON.

        Return type
        :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

    dumps(*\*\*kwargs*)[[source]](../../_modules/pybel/struct/query/query.html#Query.dumps)[](#pybel.struct.query.Query.dumps "Permalink to this definition")
    :   Dump this query to a string as JSON.

        Return type
        :   [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")

    *static* from\_json(*data*)[[source]](../../_modules/pybel/struct/query/query.html#Query.from_json)[](#pybel.struct.query.Query.from_json "Permalink to this definition")
    :   Load a query from a JSON dictionary.

        Parameters
        :   **data** ([`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")) – A JSON dictionary

        Raises
        :   QueryMissingNetworksError

        Return type
        :   [`Query`](#pybel.struct.query.Query "pybel.struct.query.query.Query")

    *static* load(*file*)[[source]](../../_modules/pybel/struct/query/query.html#Query.load)[](#pybel.struct.query.Query.load "Permalink to this definition")
    :   Load a query from a JSON file.

        Raises
        :   QueryMissingNetworksError

        Return type
        :   [`Query`](#pybel.struct.query.Query "pybel.struct.query.query.Query")

    *static* loads(*s*)[[source]](../../_modules/pybel/struct/query/query.html#Query.loads)[](#pybel.struct.query.Query.loads "Permalink to this definition")
    :   Load a query from a JSON string.

        Parameters
        :   **s** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – A stringified JSON query

        Raises
        :   QueryMissingNetworksError

        Return type
        :   [`Query`](#pybel.struct.query.Query "pybel.struct.query.query.Query")

*class* pybel.struct.query.Seeding(*initlist=None*)[[source]](../../_modules/pybel/struct/query/seeding.html#Seeding)[](#pybel.struct.query.Seeding "Permalink to this definition")
:   Represents a container of seeding methods to apply to a network.

    append\_induction(*nodes*)[[source]](../../_modules/pybel/struct/query/seeding.html#Seeding.append_induction)[](#pybel.struct.query.Seeding.append_induction "Permalink to this definition")
    :   Add a seed induction method.

        Parameters
        :   **nodes** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")], [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Dict`](https://docs.python.org/3/library/typing.html#typing.Dict "(in Python v3.10)")]]) – A node or list of nodes

        Return type
        :   [`Seeding`](#pybel.struct.query.Seeding "pybel.struct.query.seeding.Seeding")

        Returns
        :   self for fluid API

    append\_neighbors(*nodes*)[[source]](../../_modules/pybel/struct/query/seeding.html#Seeding.append_neighbors)[](#pybel.struct.query.Seeding.append_neighbors "Permalink to this definition")
    :   Add a seed by neighbors.

        Parameters
        :   **nodes** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity"), [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`BaseEntity`](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.node_classes.BaseEntity")], [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Dict`](https://docs.python.org/3/library/typing.html#typing.Dict "(in Python v3.10)")]]) – A node or list of nodes

        Return type
        :   [`Seeding`](#pybel.struct.query.Seeding "pybel.struct.query.seeding.Seeding")

        Returns
        :   self for fluid API

    append\_annotation(*annotation*, *values*)[[source]](../../_modules/pybel/struct/query/seeding.html#Seeding.append_annotation)[](#pybel.struct.query.Seeding.append_annotation "Permalink to this definition")
    :   Add a seed induction method for single annotation’s values.

        Parameters
        :   * **annotation** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The annotation to filter by
            * **values** ([`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The values of the annotation to keep

        Return type
        :   [`Seeding`](#pybel.struct.query.Seeding "pybel.struct.query.seeding.Seeding")

        Returns
        :   self for fluid API

    append\_sample(*\*\*kwargs*)[[source]](../../_modules/pybel/struct/query/seeding.html#Seeding.append_sample)[](#pybel.struct.query.Seeding.append_sample "Permalink to this definition")
    :   Add seed induction methods.

        Kwargs can have `number_edges` or `number_seed_nodes`.

        Return type
        :   [`Seeding`](#pybel.struct.query.Seeding "pybel.struct.query.seeding.Seeding")

        Returns
        :   self for fluid API

    run(*graph*)[[source]](../../_modules/pybel/struct/query/seeding.html#Seeding.run)[](#pybel.struct.query.Seeding.run "Permalink to this definition")
    :   Seed the graph or return none if not possible.

        Return type
        :   Optional[[pybel.BELGraph](datamodel.html#pybel.BELGraph "pybel.BELGraph")]

    to\_json()[[source]](../../_modules/pybel/struct/query/seeding.html#Seeding.to_json)[](#pybel.struct.query.Seeding.to_json "Permalink to this definition")
    :   Serialize this seeding container to a JSON object.

        Return type
        :   [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Dict`](https://docs.python.org/3/library/typing.html#typing.Dict "(in Python v3.10)")]

    dump(*file*, *sort\_keys=True*, *\*\*kwargs*)[[source]](../../_modules/pybel/struct/query/seeding.html#Seeding.dump)[](#pybel.struct.query.Seeding.dump "Permalink to this definition")
    :   Dump this seeding container to a file as JSON.

        Return type
        :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

    dumps(*sort\_keys=True*, *\*\*kwargs*)[[source]](../../_modules/pybel/struct/query/seeding.html#Seeding.dumps)[](#pybel.struct.query.Seeding.dumps "Permalink to this definition")
    :   Dump this query to a string as JSON.

        Return type
        :   [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")

    *static* from\_json(*data*)[[source]](../../_modules/pybel/struct/query/seeding.html#Seeding.from_json)[](#pybel.struct.query.Seeding.from_json "Permalink to this definition")
    :   Build a seeding container from a JSON list.

        Return type
        :   [`Seeding`](#pybel.struct.query.Seeding "pybel.struct.query.seeding.Seeding")

    *static* load(*file*)[[source]](../../_modules/pybel/struct/query/seeding.html#Seeding.load)[](#pybel.struct.query.Seeding.load "Permalink to this definition")
    :   Load a seeding container from a JSON file.

        Return type
        :   [`Seeding`](#pybel.struct.query.Seeding "pybel.struct.query.seeding.Seeding")

    *static* loads(*s*)[[source]](../../_modules/pybel/struct/query/seeding.html#Seeding.loads)[](#pybel.struct.query.Seeding.loads "Permalink to this definition")
    :   Load a seeding container from a JSON string.

        Return type
        :   [`Seeding`](#pybel.struct.query.Seeding "pybel.struct.query.seeding.Seeding")

pybel.struct.query.get\_subgraph(*graph*, *seed\_me