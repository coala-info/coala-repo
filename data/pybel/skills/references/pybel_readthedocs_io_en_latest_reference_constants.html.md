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

* Constants
* [Parsers](parser.html)
* [Internal Domain Specific Language](dsl.html)
* [Logging Messages](logging.html)

Project

* [References](../meta/references.html)
* [Current Issues](../meta/postmortem.html)
* [Technology](../meta/technology.html)

[PyBEL](../index.html)

* »
* Constants
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/constants.rst)

---

# Constants[](#module-pybel.constants "Permalink to this headline")

Constants for PyBEL.

This module maintains the strings used throughout the PyBEL codebase to promote consistency.

pybel.constants.get\_cache\_connection()[[source]](../_modules/pybel/constants.html#get_cache_connection)[](#pybel.constants.get_cache_connection "Permalink to this definition")
:   Get the preferred RFC-1738 database connection string.

    1. Check the environment variable `PYBEL_CONNECTION`
    2. Check the `PYBEL_CONNECTION` key in the config file `~/.config/pybel/config.json`. Optionally, this config
       file might be in a different place if the environment variable `PYBEL_CONFIG_DIRECTORY` has been set.
    3. Return a default connection string using a SQLite database in the `~/.pybel`. Optionally, this directory
       might be in a different place if the environment variable `PYBEL_RESOURCE_DIRECTORY` has been set.

    Return type
    :   [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")

pybel.constants.NAMESPACE\_DOMAIN\_TYPES *= {'BiologicalProcess', 'Chemical', 'Gene and Gene Products', 'Other'}*[](#pybel.constants.NAMESPACE_DOMAIN_TYPES "Permalink to this definition")
:   The valid namespace types
    .. seealso:: [https://wiki.openbel.org/display/BELNA/Custom+Namespaces](https://wiki.openbel.org/display/BELNA/Custom%2BNamespaces)

pybel.constants.CITATION\_DATE *= 'date'*[](#pybel.constants.CITATION_DATE "Permalink to this definition")
:   Represents the key for the citation date in a citation dictionary

pybel.constants.CITATION\_AUTHORS *= 'authors'*[](#pybel.constants.CITATION_AUTHORS "Permalink to this definition")
:   Represents the key for the citation authors in a citation dictionary

pybel.constants.CITATION\_JOURNAL *= 'journal'*[](#pybel.constants.CITATION_JOURNAL "Permalink to this definition")
:   Represents the key for the citation comment in a citation dictionary

pybel.constants.CITATION\_VOLUME *= 'volume'*[](#pybel.constants.CITATION_VOLUME "Permalink to this definition")
:   Represents the key for the optional PyBEL citation volume entry in a citation dictionary

pybel.constants.CITATION\_ISSUE *= 'issue'*[](#pybel.constants.CITATION_ISSUE "Permalink to this definition")
:   Represents the key for the optional PyBEL citation issue entry in a citation dictionary

pybel.constants.CITATION\_PAGES *= 'pages'*[](#pybel.constants.CITATION_PAGES "Permalink to this definition")
:   Represents the key for the optional PyBEL citation pages entry in a citation dictionary

pybel.constants.CITATION\_FIRST\_AUTHOR *= 'first'*[](#pybel.constants.CITATION_FIRST_AUTHOR "Permalink to this definition")
:   Represents the key for the optional PyBEL citation first author entry in a citation dictionary

pybel.constants.CITATION\_LAST\_AUTHOR *= 'last'*[](#pybel.constants.CITATION_LAST_AUTHOR "Permalink to this definition")
:   Represents the key for the optional PyBEL citation last author entry in a citation dictionary

pybel.constants.CITATION\_ARTICLE\_TYPE *= 'article\_type'*[](#pybel.constants.CITATION_ARTICLE_TYPE "Permalink to this definition")
:   Represents the type of article (Journal Article, Review, etc.)

pybel.constants.FUNCTION *= 'function'*[](#pybel.constants.FUNCTION "Permalink to this definition")
:   The node data key specifying the node’s function (e.g. [`GENE`](#pybel.constants.GENE "pybel.constants.GENE"), [`MIRNA`](#pybel.constants.MIRNA "pybel.constants.MIRNA"), [`BIOPROCESS`](#pybel.constants.BIOPROCESS "pybel.constants.BIOPROCESS"), etc.)

pybel.constants.CONCEPT *= 'concept'*[](#pybel.constants.CONCEPT "Permalink to this definition")
:   The key specifying a concept

pybel.constants.NAMESPACE *= 'namespace'*[](#pybel.constants.NAMESPACE "Permalink to this definition")
:   The key specifying an identifier dictionary’s namespace. Used for nodes, activities, and transformations.

pybel.constants.NAME *= 'name'*[](#pybel.constants.NAME "Permalink to this definition")
:   The key specifying an identifier dictionary’s name. Used for nodes, activities, and transformations.

pybel.constants.IDENTIFIER *= 'identifier'*[](#pybel.constants.IDENTIFIER "Permalink to this definition")
:   The key specifying an identifier dictionary

pybel.constants.LABEL *= 'label'*[](#pybel.constants.LABEL "Permalink to this definition")
:   The key specifying an optional label for the node

pybel.constants.DESCRIPTION *= 'description'*[](#pybel.constants.DESCRIPTION "Permalink to this definition")
:   The key specifying an optional description for the node

pybel.constants.XREFS *= 'xref'*[](#pybel.constants.XREFS "Permalink to this definition")
:   The key specifying xrefs

pybel.constants.MEMBERS *= 'members'*[](#pybel.constants.MEMBERS "Permalink to this definition")
:   They key representing the nodes that are a member of a composite or complex

pybel.constants.REACTANTS *= 'reactants'*[](#pybel.constants.REACTANTS "Permalink to this definition")
:   The key representing the nodes appearing in the reactant side of a biochemical reaction

pybel.constants.PRODUCTS *= 'products'*[](#pybel.constants.PRODUCTS "Permalink to this definition")
:   The key representing the nodes appearing in the product side of a biochemical reaction

pybel.constants.PARTNER\_3P *= 'partner\_3p'*[](#pybel.constants.PARTNER_3P "Permalink to this definition")
:   The key specifying the identifier dictionary of the fusion’s 3-Prime partner

pybel.constants.PARTNER\_5P *= 'partner\_5p'*[](#pybel.constants.PARTNER_5P "Permalink to this definition")
:   The key specifying the identifier dictionary of the fusion’s 5-Prime partner

pybel.constants.RANGE\_3P *= 'range\_3p'*[](#pybel.constants.RANGE_3P "Permalink to this definition")
:   The key specifying the range dictionary of the fusion’s 3-Prime partner

pybel.constants.RANGE\_5P *= 'range\_5p'*[](#pybel.constants.RANGE_5P "Permalink to this definition")
:   The key specifying the range dictionary of the fusion’s 5-Prime partner

pybel.constants.VARIANTS *= 'variants'*[](#pybel.constants.VARIANTS "Permalink to this definition")
:   The key specifying the node has a list of associated variants

pybel.constants.KIND *= 'kind'*[](#pybel.constants.KIND "Permalink to this definition")
:   The key representing what kind of variation is being represented

pybel.constants.HGVS *= 'hgvs'*[](#pybel.constants.HGVS "Permalink to this definition")
:   The value for [`KIND`](#pybel.constants.KIND "pybel.constants.KIND") for an HGVS variant

pybel.constants.PMOD *= 'pmod'*[](#pybel.constants.PMOD "Permalink to this definition")
:   The value for [`KIND`](#pybel.constants.KIND "pybel.constants.KIND") for a protein modification

pybel.constants.GMOD *= 'gmod'*[](#pybel.constants.GMOD "Permalink to this definition")
:   The value for [`KIND`](#pybel.constants.KIND "pybel.constants.KIND") for a gene modification

pybel.constants.FRAGMENT *= 'frag'*[](#pybel.constants.FRAGMENT "Permalink to this definition")
:   The value for [`KIND`](#pybel.constants.KIND "pybel.constants.KIND") for a fragment

pybel.constants.PYBEL\_VARIANT\_KINDS *= {'frag', 'gmod', 'hgvs', 'pmod'}*[](#pybel.constants.PYBEL_VARIANT_KINDS "Permalink to this definition")
:   The allowed values for [`KIND`](#pybel.constants.KIND "pybel.constants.KIND")

pybel.constants.PYBEL\_NODE\_DATA\_KEYS *= {'function', 'fusion', 'identifier', 'members', 'name', 'namespace', 'products', 'reactants', 'variants'}*[](#pybel.constants.PYBEL_NODE_DATA_KEYS "Permalink to this definition")
:   The group of all BEL-provided keys for node data dictionaries, used for hashing.

pybel.constants.DIRTY *= 'dirty'*[](#pybel.constants.DIRTY "Permalink to this definition")
:   Used as a namespace when none is given when lenient parsing mode is turned on. Not recommended!

pybel.constants.ABUNDANCE *= 'Abundance'*[](#pybel.constants.ABUNDANCE "Permalink to this definition")
:   Represents the BEL abundance, abundance()

pybel.constants.GENE *= 'Gene'*[](#pybel.constants.GENE "Permalink to this definition")
:   Represents the BEL abundance, geneAbundance()
    .. seealso:: <http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#Xabundancea>

pybel.constants.RNA *= 'RNA'*[](#pybel.constants.RNA "Permalink to this definition")
:   Represents the BEL abundance, rnaAbundance()

pybel.constants.MIRNA *= 'miRNA'*[](#pybel.constants.MIRNA "Permalink to this definition")
:   Represents the BEL abundance, microRNAAbundance()

pybel.constants.PROTEIN *= 'Protein'*[](#pybel.constants.PROTEIN "Permalink to this definition")
:   Represents the BEL abundance, proteinAbundance()

pybel.constants.BIOPROCESS *= 'BiologicalProcess'*[](#pybel.constants.BIOPROCESS "Permalink to this definition")
:   Represents the BEL function, biologicalProcess()

pybel.constants.PATHOLOGY *= 'Pathology'*[](#pybel.constants.PATHOLOGY "Permalink to this definition")
:   Represents the BEL function, pathology()

pybel.constants.POPULATION *= 'Population'*[](#pybel.constants.POPULATION "Permalink to this definition")
:   Represents the BEL function, populationAbundance()

pybel.constants.COMPOSITE *= 'Composite'*[](#pybel.constants.COMPOSITE "Permalink to this definition")
:   Represents the BEL abundance, compositeAbundance()

pybel.constants.COMPLEX *= 'Complex'*[](#pybel.constants.COMPLEX "Permalink to this definition")
:   Represents the BEL abundance, complexAbundance()

pybel.constants.REACTION *= 'Reaction'*[](#pybel.constants.REACTION "Permalink to this definition")
:   Represents the BEL transformation, reaction()

pybel.constants.PYBEL\_NODE\_FUNCTIONS *= {'Abundance', 'BiologicalProcess', 'Complex', 'Composite', 'Gene', 'Pathology', 'Population', 'Protein', 'RNA', 'Reaction', 'miRNA'}*[](#pybel.constants.PYBEL_NODE_FUNCTIONS "Permalink to this definition")
:   A set of all of the valid PyBEL node functions

pybel.constants.rev\_abundance\_labels *= {'Abundance': 'a', 'BiologicalProcess': 'bp', 'Complex': 'complex', 'Composite': 'composite', 'Gene': 'g', 'Pathology': 'path', 'Population': 'pop', 'Protein': 'p', 'RNA': 'r', 'miRNA': 'm'}*[](#pybel.constants.rev_abundance_labels "Permalink to this definition")
:   The mapping from PyBEL node functions to BEL strings

pybel.constants.RELATION *= 'relation'*[](#pybel.constants.RELATION "Permalink to this definition")
:   The key for an internal edge data dictionary for the relation string

pybel.constants.CITATION *= 'citation'*[](#pybel.constants.CITATION "Permalink to this definition")
:   The key for an internal edge data dictionary for the citation dictionary

pybel.constants.EVIDENCE *= 'evidence'*[](#pybel.constants.EVIDENCE "Permalink to this definition")
:   The key for an internal edge data dictionary for the evidence string

pybel.constants.ANNOTATIONS *= 'annotations'*[](#pybel.constants.ANNOTATIONS "Permalink to this definition")
:   The key for an internal edge data dictionary for the annotations dictionary

pybel.constants.SOURCE\_MODIFIER *= 'source\_modifier'*[](#pybel.constants.SOURCE_MODIFIER "Permalink to this definition")
:   The key for an internal edge data dictionary for the source modifier dictionary

pybel.constants.TARGET\_MODIFIER *= 'target\_modifier'*[](#pybel.constants.TARGET_MODIFIER "Permalink to this definition")
:   The key for an internal edge data dictionary for the target modifier dictionary

pybel.constants.LINE *= 'line'*[](#pybel.constants.LINE "Permalink to this definition")
:   The key or an internal edge data dictionary for the line number

pybel.constants.HASH *= 'hash'*[](#pybel.constants.HASH "Permalink to this definition")
:   The key representing the hash of the other

pybel.constants.PYBEL\_EDGE\_DATA\_KEYS *= {'annotations', 'citation', 'evidence', 'relation', 'source\_modifier', 'target\_modifier'}*[](#pybel.constants.PYBEL_EDGE_DATA_KEYS "Permalink to this definition")
:   The group of all BEL-provided keys for edge data dictionaries, used for hashing.

pybel.constants.PYBEL\_EDGE\_METADATA\_KEYS *= {'hash', 'line'}*[](#pybel.constants.PYBEL_EDGE_METADATA_KEYS "Permalink to this definition")
:   The group of all PyBEL-specific keys for edge data dictionaries, not used for hashing.

pybel.constants.PYBEL\_EDGE\_ALL\_KEYS *= {'annotations', 'citation', 'evidence', 'hash', 'line', 'relation', 'source\_modifier', 'target\_modifier'}*[](#pybel.constants.PYBEL_EDGE_ALL_KEYS "Permalink to this definition")
:   The group of all PyBEL annotated keys for edge data dictionaries

pybel.constants.HAS\_REACTANT *= 'hasReactant'*[](#pybel.constants.HAS_REACTANT "Permalink to this definition")
:   A BEL relationship

pybel.constants.HAS\_PRODUCT *= 'hasProduct'*[](#pybel.constants.HAS_PRODUCT "Permalink to this definition")
:   A BEL relationship

pybel.constants.HAS\_VARIANT *= 'hasVariant'*[](#pybel.constants.HAS_VARIANT "Permalink to this definition")
:   A BEL relationship

pybel.constants.TRANSCRIBED\_TO *= 'transcribedTo'*[](#pybel.constants.TRANSCRIBED_TO "Permalink to this definition")
:   A BEL relationship
    [`GENE`](#pybel.constants.GENE "pybel.constants.GENE") to [`RNA`](#pybel.constants.RNA "pybel.constants.RNA") is called transcription

pybel.constants.TRANSLATED\_TO *= 'translatedTo'*[](#pybel.constants.TRANSLATED_TO "Permalink to this definition")
:   A BEL relationship
    [`RNA`](#pybel.constants.RNA "pybel.constants.RNA") to [`PROTEIN`](#pybel.constants.PROTEIN "pybel.constants.PROTEIN") is called translation

pybel.constants.INCREASES *= 'increases