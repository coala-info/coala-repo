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

* [Manager](manager.html)
* Models

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
* Models
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/database/models.rst)

---

# Models[](#module-pybel.manager.models "Permalink to this headline")

This module contains the SQLAlchemy database models that support the definition cache and graph cache.

*class* pybel.manager.models.Base(*\*\*kwargs*)[](#pybel.manager.models.Base "Permalink to this definition")
:   The base class of the class hierarchy.

    When called, it accepts no arguments and returns a new featureless
    instance that has no instance attributes and cannot be given any.

    A simple constructor that allows initialization from kwargs.

    Sets attributes on the constructed instance using the names and
    values in `kwargs`.

    Only keys that are present as
    attributes of the instance’s class are allowed. These could be,
    for example, any mapped columns or relationships.

*class* pybel.manager.models.Namespace(*\*\*kwargs*)[[source]](../../_modules/pybel/manager/models.html#Namespace)[](#pybel.manager.models.Namespace "Permalink to this definition")
:   Represents a BEL Namespace.

    A simple constructor that allows initialization from kwargs.

    Sets attributes on the constructed instance using the names and
    values in `kwargs`.

    Only keys that are present as
    attributes of the instance’s class are allowed. These could be,
    for example, any mapped columns or relationships.

    uploaded[](#pybel.manager.models.Namespace.uploaded "Permalink to this definition")
    :   The date of upload

    keyword[](#pybel.manager.models.Namespace.keyword "Permalink to this definition")
    :   Keyword that is used in a BEL file to identify a specific namespace

    pattern[](#pybel.manager.models.Namespace.pattern "Permalink to this definition")
    :   Contains regex pattern for value identification.

    miriam\_id[](#pybel.manager.models.Namespace.miriam_id "Permalink to this definition")
    :   MIRIAM resource identifier matching the regular expression `^MIR:001\d{5}$`

    version[](#pybel.manager.models.Namespace.version "Permalink to this definition")
    :   Version of the namespace

    url[](#pybel.manager.models.Namespace.url "Permalink to this definition")
    :   BELNS Resource location as URL

    name[](#pybel.manager.models.Namespace.name "Permalink to this definition")
    :   Name of the given namespace

    domain[](#pybel.manager.models.Namespace.domain "Permalink to this definition")
    :   Domain for which this namespace is valid

    species[](#pybel.manager.models.Namespace.species "Permalink to this definition")
    :   Taxonomy identifiers for which this namespace is valid

    description[](#pybel.manager.models.Namespace.description "Permalink to this definition")
    :   Optional short description of the namespace

    created[](#pybel.manager.models.Namespace.created "Permalink to this definition")
    :   DateTime of the creation of the namespace definition file

    query\_url[](#pybel.manager.models.Namespace.query_url "Permalink to this definition")
    :   URL that can be used to query the namespace (externally from PyBEL)

    author[](#pybel.manager.models.Namespace.author "Permalink to this definition")
    :   The author of the namespace

    license[](#pybel.manager.models.Namespace.license "Permalink to this definition")
    :   License information

    contact[](#pybel.manager.models.Namespace.contact "Permalink to this definition")
    :   Contact information

    get\_term\_to\_encodings()[[source]](../../_modules/pybel/manager/models.html#Namespace.get_term_to_encodings)[](#pybel.manager.models.Namespace.get_term_to_encodings "Permalink to this definition")
    :   Return the term (db, id, name) to encodings from this namespace.

        Return type
        :   [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`Tuple`](https://docs.python.org/3/library/typing.html#typing.Tuple "(in Python v3.10)")[[`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

    to\_json(*include\_id=False*)[[source]](../../_modules/pybel/manager/models.html#Namespace.to_json)[](#pybel.manager.models.Namespace.to_json "Permalink to this definition")
    :   Return the most useful entries as a dictionary.

        Parameters
        :   **include\_id** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – If true, includes the model identifier

        Return type
        :   [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

*class* pybel.manager.models.NamespaceEntry(*\*\*kwargs*)[[source]](../../_modules/pybel/manager/models.html#NamespaceEntry)[](#pybel.manager.models.NamespaceEntry "Permalink to this definition")
:   Represents a name within a BEL namespace.

    A simple constructor that allows initialization from kwargs.

    Sets attributes on the constructed instance using the names and
    values in `kwargs`.

    Only keys that are present as
    attributes of the instance’s class are allowed. These could be,
    for example, any mapped columns or relationships.

    name[](#pybel.manager.models.NamespaceEntry.name "Permalink to this definition")
    :   Name that is defined in the corresponding namespace definition file

    identifier[](#pybel.manager.models.NamespaceEntry.identifier "Permalink to this definition")
    :   The database accession number

    encoding[](#pybel.manager.models.NamespaceEntry.encoding "Permalink to this definition")
    :   The biological entity types for which this name is valid

    to\_json(*include\_id=False*)[[source]](../../_modules/pybel/manager/models.html#NamespaceEntry.to_json)[](#pybel.manager.models.NamespaceEntry.to_json "Permalink to this definition")
    :   Describe the namespaceEntry as dictionary of Namespace-Keyword and Name.

        Parameters
        :   **include\_id** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – If true, includes the model identifier

        Return type
        :   [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

    *classmethod* name\_contains(*name\_query*)[[source]](../../_modules/pybel/manager/models.html#NamespaceEntry.name_contains)[](#pybel.manager.models.NamespaceEntry.name_contains "Permalink to this definition")
    :   Make a filter if the name contains a certain substring.

*class* pybel.manager.models.Network(*\*\*kwargs*)[[source]](../../_modules/pybel/manager/models.html#Network)[](#pybel.manager.models.Network "Permalink to this definition")
:   Represents a collection of edges, specified by a BEL Script.

    A simple constructor that allows initialization from kwargs.

    Sets attributes on the constructed instance using the names and
    values in `kwargs`.

    Only keys that are present as
    attributes of the instance’s class are allowed. These could be,
    for example, any mapped columns or relationships.

    name[](#pybel.manager.models.Network.name "Permalink to this definition")
    :   Name of the given Network (from the BEL file)

    version[](#pybel.manager.models.Network.version "Permalink to this definition")
    :   Release version of the given Network (from the BEL file)

    authors[](#pybel.manager.models.Network.authors "Permalink to this definition")
    :   Authors of the underlying BEL file

    contact[](#pybel.manager.models.Network.contact "Permalink to this definition")
    :   Contact email from the underlying BEL file

    description[](#pybel.manager.models.Network.description "Permalink to this definition")
    :   Descriptive text from the underlying BEL file

    copyright[](#pybel.manager.models.Network.copyright "Permalink to this definition")
    :   Copyright information

    disclaimer[](#pybel.manager.models.Network.disclaimer "Permalink to this definition")
    :   Disclaimer information

    licenses[](#pybel.manager.models.Network.licenses "Permalink to this definition")
    :   License information

    blob[](#pybel.manager.models.Network.blob "Permalink to this definition")
    :   A pickled version of this network

    to\_json(*include\_id=False*)[[source]](../../_modules/pybel/manager/models.html#Network.to_json)[](#pybel.manager.models.Network.to_json "Permalink to this definition")
    :   Return this network as JSON.

        Parameters
        :   **include\_id** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – If true, includes the model identifier

        Return type
        :   [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Any`](https://docs.python.org/3/library/typing.html#typing.Any "(in Python v3.10)")]

    *classmethod* name\_contains(*name\_query*)[[source]](../../_modules/pybel/manager/models.html#Network.name_contains)[](#pybel.manager.models.Network.name_contains "Permalink to this definition")
    :   Build a filter for networks whose names contain the query.

    *classmethod* description\_contains(*description\_query*)[[source]](../../_modules/pybel/manager/models.html#Network.description_contains)[](#pybel.manager.models.Network.description_contains "Permalink to this definition")
    :   Build a filter for networks whose descriptions contain the query.

    *classmethod* id\_in(*network\_ids*)[[source]](../../_modules/pybel/manager/models.html#Network.id_in)[](#pybel.manager.models.Network.id_in "Permalink to this definition")
    :   Build a filter for networks whose identifiers appear in the given sequence.

    as\_bel()[[source]](../../_modules/pybel/manager/models.html#Network.as_bel)[](#pybel.manager.models.Network.as_bel "Permalink to this definition")
    :   Get this network and loads it into a `BELGraph`.

        Return type
        :   [`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")

    store\_bel(*graph*)[[source]](../../_modules/pybel/manager/models.html#Network.store_bel)[](#pybel.manager.models.Network.store_bel "Permalink to this definition")
    :   Insert a BEL graph.

*class* pybel.manager.models.Node(*\*\*kwargs*)[[source]](../../_modules/pybel/manager/models.html#Node)[](#pybel.manager.models.Node "Permalink to this definition")
:   Represents a BEL Term.

    A simple constructor that allows initialization from kwargs.

    Sets attributes on the constructed instance using the names and
    values in `kwargs`.

    Only keys that are present as
    attributes of the instance’s class are allowed. These could be,
    for example, any mapped columns or relationships.

    type[](#pybel.manager.models.Node.type "Permalink to this definition")
    :   The type of the represented biological entity e.g. Protein or Gene

    bel[](#pybel.manager.models.Node.bel "Permalink to this definition")
    :   Canonical BEL term that represents the given node

    data[](#pybel.manager.models.Node.data "Permalink to this definition")
    :   PyBEL BaseEntity as JSON

    *classmethod* bel\_contains(*bel\_query*)[[source]](../../_modules/pybel/manager/models.html#Node.bel_contains)[](#pybel.manager.models.Node.bel_contains "Permalink to this definition")
    :   Build a filter for nodes whose BEL contain the query.

    as\_bel()[[source]](../../_modules/pybel/manager/models.html#Node.as_bel)[](#pybel.manager.models.Node.as_bel "Permalink to this definition")
    :   Serialize this node as a PyBEL DSL object.

        Return type
        :   [pybel.dsl.BaseEntity](../dsl.html#pybel.dsl.BaseEntity "pybel.dsl.BaseEntity")

    to\_json()[[source]](../../_modules/pybel/manager/models.html#Node.to_json)[](#pybel.manager.models.Node.to_json "Permalink to this definition")
    :   Serialize this node as a JSON object using as\_bel().

*class* pybel.manager.models.Author(*\*\*kwargs*)[[source]](../../_modules/pybel/manager/models.html#Author)[](#pybel.manager.models.Author "Permalink to this definition")
:   Contains all author names.

    A simple constructor that allows initialization from kwargs.

    Sets attributes on the constructed instance using the names and
    values in `kwargs`.

    Only keys that are present as
    attributes of the instance’s class are allowed. These could be,
    for example, any mapped columns or relationships.

    *classmethod* name\_contains(*name\_query*)[[source]](../../_modules/pybel/manager/models.html#Author.name_contains)[](#pybel.manager.models.Author.name_contains "Permalink to this definition")
    :   Build a filter for authors whose names contain the given query.

    *classmethod* has\_name\_in(*names*)[[source]](../../_modules/pybel/manager/models.html#Author.has_name_in)[](#pybel.manager.models.Author.has_name_in "Permalink to this definition")
    :   Build a filter if the 