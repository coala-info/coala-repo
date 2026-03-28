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

* [Input and Output](io.html)

Database

* [Manager](database/manager.html)
* [Models](database/models.html)

Topic Guide

* [Cookbook](../topics/cookbook.html)
* [Command Line Interface](../topics/cli.html)

Reference

* [Constants](constants.html)
* [Parsers](parser.html)
* Internal Domain Specific Language
  + [Primitives](#primitives)
  + [Named Entities](#named-entities)
  + [Central Dogma](#central-dogma)
    - [Variants](#variants)
  + [Fusions](#fusions)
    - [Fusion Ranges](#fusion-ranges)
    - [List Abundances](#list-abundances)
  + [Utilities](#utilities)
* [Logging Messages](logging.html)

Project

* [References](../meta/references.html)
* [Current Issues](../meta/postmortem.html)
* [Technology](../meta/technology.html)

[PyBEL](../index.html)

* »
* Internal Domain Specific Language
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/dsl.rst)

---

# Internal Domain Specific Language[](#module-pybel.dsl "Permalink to this headline")

PyBEL implements an internal domain-specific language (DSL).

This enables you to write BEL using Python scripts. Even better,
you can programatically generate BEL using Python. See the
Bio2BEL [paper](https://doi.org/10.1101/631812) and [repository](https://github.com/bio2bel/bio2bel)
for many examples.

Internally, the BEL parser converts BEL script into the BEL DSL
then adds it to a BEL graph object. When you iterate through
the [`pybel.BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.BELGraph"), the nodes are instances of subclasses
of [`pybel.dsl.BaseEntity`](#pybel.dsl.BaseEntity "pybel.dsl.BaseEntity").

## Primitives[](#primitives "Permalink to this headline")

*class* pybel.dsl.Entity(*\**, *namespace*, *name=None*, *identifier=None*)[[source]](../_modules/pybel/language.html#Entity)[](#pybel.dsl.Entity "Permalink to this definition")
:   Represents a named entity with a namespace and name/identifier.

    Create a dictionary representing a reference to an entity.

    Parameters
    :   * **namespace** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The namespace to which the entity belongs
        * **name** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The name of the entity
        * **identifier** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The identifier of the entity in the namespace

*class* pybel.dsl.BaseEntity[[source]](../_modules/pybel/dsl/node_classes.html#BaseEntity)[](#pybel.dsl.BaseEntity "Permalink to this definition")
:   This is the superclass for all BEL terms.

    A BEL term has three properties:

    1. It has a type. Subclasses of this function should set the class variable
       `function`.
    2. It can be converted to BEL. Note, this is an abstract class, so all sub-classes
       must implement this functionality in `as_bel()`.
    3. It can be hashed, based on the BEL conversion

*class* pybel.dsl.BaseAbundance(*namespace*, *name=None*, *identifier=None*, *xrefs=None*)[[source]](../_modules/pybel/dsl/node_classes.html#BaseAbundance)[](#pybel.dsl.BaseAbundance "Permalink to this definition")
:   The superclass for all named BEL terms.

    A named BEL term has:

    1. A type (taken care of by being a subclass of [`BaseEntity`](#pybel.dsl.BaseEntity "pybel.dsl.BaseEntity"))
    2. A named [`Entity`](#pybel.dsl.Entity "pybel.dsl.Entity"). Though this doesn’t directly inherit from
       [`Entity`](#pybel.dsl.Entity "pybel.dsl.Entity"), it creates one internally using the namespace,
       identifier, and name. Ideally, both the identifier and name are given.
       If one is missing, it can be looked up with `pybel.grounding.ground()`
    3. An optional list of xrefs, corresponding to the whole entity,
       not just the namespace/name. For example, the BEL term
       `p(HGNC:APP, frag(672_713)` could xref CHEBI:64647.

    Build an abundance from a function, namespace, and a name and/or identifier.

    Parameters
    :   * **namespace** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The name of the namespace
        * **name** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The name of this abundance
        * **identifier** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The database identifier for this abundance
        * **xrefs** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Entity`](constants.html#pybel.language.Entity "pybel.language.Entity")]]) – Alternate identifiers for the entity

*class* pybel.dsl.ListAbundance(*members*)[[source]](../_modules/pybel/dsl/node_classes.html#ListAbundance)[](#pybel.dsl.ListAbundance "Permalink to this definition")
:   The superclass for all BEL terms defined by lists, as opposed to by names like in [`BaseAbundance`](#pybel.dsl.BaseAbundance "pybel.dsl.BaseAbundance").

    Build a list abundance node.

    Parameters
    :   **members** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`BaseAbundance`](#pybel.dsl.BaseAbundance "pybel.dsl.node_classes.BaseAbundance"), [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`BaseAbundance`](#pybel.dsl.BaseAbundance "pybel.dsl.node_classes.BaseAbundance")]]) – A list of PyBEL node data dictionaries

## Named Entities[](#named-entities "Permalink to this headline")

*class* pybel.dsl.Abundance(*namespace*, *name=None*, *identifier=None*, *xrefs=None*)[[source]](../_modules/pybel/dsl/node_classes.html#Abundance)[](#pybel.dsl.Abundance "Permalink to this definition")
:   Builds an abundance node.

    ```
    >>> from pybel.dsl import Abundance
    >>> Abundance(namespace='CHEBI', name='water')
    ```

    Build an abundance from a function, namespace, and a name and/or identifier.

    Parameters
    :   * **namespace** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The name of the namespace
        * **name** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The name of this abundance
        * **identifier** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The database identifier for this abundance
        * **xrefs** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Entity`](constants.html#pybel.language.Entity "pybel.language.Entity")]]) – Alternate identifiers for the entity

*class* pybel.dsl.BiologicalProcess(*namespace*, *name=None*, *identifier=None*, *xrefs=None*)[[source]](../_modules/pybel/dsl/node_classes.html#BiologicalProcess)[](#pybel.dsl.BiologicalProcess "Permalink to this definition")
:   Builds a biological process node.

    ```
    >>> from pybel.dsl import BiologicalProcess
    >>> BiologicalProcess(namespace='GO', name='apoptosis')
    ```

    Build an abundance from a function, namespace, and a name and/or identifier.

    Parameters
    :   * **namespace** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The name of the namespace
        * **name** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The name of this abundance
        * **identifier** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The database identifier for this abundance
        * **xrefs** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Entity`](constants.html#pybel.language.Entity "pybel.language.Entity")]]) – Alternate identifiers for the entity

*class* pybel.dsl.Pathology(*namespace*, *name=None*, *identifier=None*, *xrefs=None*)[[source]](../_modules/pybel/dsl/node_classes.html#Pathology)[](#pybel.dsl.Pathology "Permalink to this definition")
:   Build a pathology node.

    ```
    >>> from pybel.dsl import Pathology
    >>> Pathology(namespace='DO', name='Alzheimer Disease')
    ```

    Build an abundance from a function, namespace, and a name and/or identifier.

    Parameters
    :   * **namespace** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The name of the namespace
        * **name** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The name of this abundance
        * **identifier** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The database identifier for this abundance
        * **xrefs** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Entity`](constants.html#pybel.language.Entity "pybel.language.Entity")]]) – Alternate identifiers for the entity

*class* pybel.dsl.Population(*namespace*, *name=None*, *identifier=None*, *xrefs=None*)[[source]](../_modules/pybel/dsl/node_classes.html#Population)[](#pybel.dsl.Population "Permalink to this definition")
:   Builds a population node.

    ```
    >>> from pybel.dsl import Population
    >>> Population(namespace='uberon', name='blood')
    ```

    Build an abundance from a function, namespace, and a name and/or identifier.

    Parameters
    :   * **namespace** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The name of the namespace
        * **name** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The name of this abundance
        * **identifier** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The database identifier for this abundance
        * **xrefs** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Entity`](constants.html#pybel.language.Entity "pybel.language.Entity")]]) – Alternate identifiers for the entity

## Central Dogma[](#central-dogma "Permalink to this headline")

*class* pybel.dsl.CentralDogma(*namespace*, *name=None*, *identifier=None*, *xrefs=None*, *variants=None*)[[source]](../_modules/pybel/dsl/node_classes.html#CentralDogma)[](#pybel.dsl.CentralDogma "Permalink to this definition")
:   The base class for “central dogma” abundances (i.e., genes, miRNAs, RNAs, and proteins).

    Build a node for a gene, RNA, miRNA, or protein.

    Parameters
    :   * **namespace** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The name of the database used to identify this entity
        * **name** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The database’s preferred name or label for this entity
        * **identifier** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – The database’s identifier for this entity
        * **xrefs** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Entity`](constants.html#pybel.language.Entity "pybel.language.Entity")]]) – Alternative database cross references
        * **variants** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)"), [`Variant`](#pybel.dsl.Variant "pybel.dsl.node_classes.Variant"), [`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`Variant`](#pybel.dsl.Variant "pybel.dsl.node_classes.Variant")]]) – An optional variant or list of variants

*class* pybel.dsl.Gene(*namespace*, *name=None*, *identifier=None*, *xrefs=None*, *variants=None*)[[source]](../_modules/pybel/dsl/node_classes.html#Gene)[](#pybel.dsl.Gene "Permalink to this definition")
:   Builds a gene node.

    Build a node for a gene, RNA, miRNA, or protein.

    Parameters
    :   * **namespace** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The name of the database used to identify this entity
        * **name** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3