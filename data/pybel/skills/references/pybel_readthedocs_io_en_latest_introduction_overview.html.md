[PyBEL
![Logo](../_static/PyBEL-square-100.png)](../index.html)

latest

Getting Started

* Overview
  + [Background on Systems Biology Modeling](#background-on-systems-biology-modeling)
    - [Biological Expression Language (BEL)](#biological-expression-language-bel)
    - [BEL Community Links](#bel-community-links)
  + [Design Considerations](#design-considerations)
    - [Missing Namespaces and Improper Names](#missing-namespaces-and-improper-names)
    - [Outdated Namespaces](#outdated-namespaces)
    - [Generating New Namespaces](#generating-new-namespaces)
    - [Synonym Issues](#synonym-issues)
  + [Implementation](#implementation)
  + [Extensions to BEL](#extensions-to-bel)
    - [Syntax for Epigenetics](#syntax-for-epigenetics)
    - [Definition of Namespaces as Regular Expressions](#definition-of-namespaces-as-regular-expressions)
    - [Definition of Resources using OWL](#definition-of-resources-using-owl)
  + [Things to Consider](#things-to-consider)
    - [Do All Statements Need Supporting Text?](#do-all-statements-need-supporting-text)
    - [Multiple Annotations](#multiple-annotations)
    - [Namespace and Annotation Name Choices](#namespace-and-annotation-name-choices)
    - [Why Not Nested Statements?](#why-not-nested-statements)
      * [Direct](#direct)
      * [Indirect](#indirect)
      * [Increasing Nested Relationships](#increasing-nested-relationships)
      * [Decreasing Nested Relationships](#decreasing-nested-relationships)
      * [Recommendations for Use in PyBEL](#recommendations-for-use-in-pybel)
    - [Why Not RDF?](#why-not-rdf)
* [Installation](installation.html)

Data Structure

* [Data Model](../reference/struct/datamodel.html)
* [Example Networks](../reference/struct/examples.html)
* [Filters](../reference/struct/filters.html)
* [Grouping](../reference/struct/grouping.html)
* [Operations](../reference/struct/operators.html)
* [Pipeline](../reference/struct/pipeline.html)
* [Query](../reference/struct/query.html)
* [Summary](../reference/struct/summary.html)

Mutations

* [Mutations](../reference/mutations/mutations.html)
* [Collapse](../reference/mutations/collapse.html)
* [Deletion](../reference/mutations/deletion.html)
* [Expansion](../reference/mutations/expansion.html)
* [Induction](../reference/mutations/induction.html)
* [Induction and Expansion](../reference/mutations/induction_expansion.html)
* [Inference](../reference/mutations/inference.html)
* [Metadata](../reference/mutations/metadata.html)

Conversion

* [Input and Output](../reference/io.html)

Database

* [Manager](../reference/database/manager.html)
* [Models](../reference/database/models.html)

Topic Guide

* [Cookbook](../topics/cookbook.html)
* [Command Line Interface](../topics/cli.html)

Reference

* [Constants](../reference/constants.html)
* [Parsers](../reference/parser.html)
* [Internal Domain Specific Language](../reference/dsl.html)
* [Logging Messages](../reference/logging.html)

Project

* [References](../meta/references.html)
* [Current Issues](../meta/postmortem.html)
* [Technology](../meta/technology.html)

[PyBEL](../index.html)

* »
* Overview
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/introduction/overview.rst)

---

# Overview[](#overview "Permalink to this headline")

## Background on Systems Biology Modeling[](#background-on-systems-biology-modeling "Permalink to this headline")

### Biological Expression Language (BEL)[](#biological-expression-language-bel "Permalink to this headline")

Biological Expression Language (BEL) is a domain specific language that enables the expression of complex molecular
relationships and their context in a machine-readable form. Its simple grammar and expressive power have led to its
successful use to describe complex disease networks with several thousands of relationships. For a detailed
explanation, see the BEL [1.0](https://github.com/OpenBEL/language/raw/master/docs/version_1.0/bel_specification_version_1.0.pdf) and
[2.0](https://github.com/OpenBEL/language/raw/master/docs/version_2.0/bel_specification_version_2.0.pdf),
and [2.0+](https://biological-expression-language.github.io) specifications.

### BEL Community Links[](#bel-community-links "Permalink to this headline")

* BEL [Community Portal](https://biological-expression-language.github.io/)
* BEL [Google Group](https://groups.google.com/forum/#!forum/openbel-discuss)

## Design Considerations[](#design-considerations "Permalink to this headline")

### Missing Namespaces and Improper Names[](#missing-namespaces-and-improper-names "Permalink to this headline")

The use of openly shared controlled vocabularies (namespaces) within BEL facilitates the exchange and consistency of
information. Finding the correct `namespace:name` pair is often a difficult part of the curation process.

### Outdated Namespaces[](#outdated-namespaces "Permalink to this headline")

BEL provides a variety of [namespaces](https://biological-expression-language.github.io/identifiers/)
covering each of the BEL function types. Selventa used to provide BEL namespace files generated by the deprecated
project at `https://github.com/OpenBEL/resource-generator` and hosted at the abandoned website
`http://www.belframework.org/`. Newer versions of these namespaces can be found at
<https://github.com/pharmacome/conso/tree/master/external>.

### Generating New Namespaces[](#generating-new-namespaces "Permalink to this headline")

In some cases, it is appropriate to design a new namespace, using the
[custom namespace specification](http://openbel-framework.readthedocs.io/en/latest/tutorials/building_custom_namespaces.html)
provided by the OpenBEL Framework. Packages for generating namespace, annotation, and knowledge resources have
been grouped in the [Bio2BEL](https://github.com/bio2bel) organization on GitHub.

### Synonym Issues[](#synonym-issues "Permalink to this headline")

Due to the huge number of terms across many namespaces, it’s difficult for curators to know the domain-specific
synonyms that obscure the controlled/preferred term. However, the issue of synonym resolution and semantic searching
has already been generally solved by the use of ontologies. Besides just a controlled vocabulary, they also a
hierarchical model of knowledge, synonyms with cross-references to databases and other ontologies, and other
information semantic reasoning. Ontologies in the biomedical domain can be found at [OBO](obofoundry.org) and
[EMBL-EBI OLS](http://www.ebi.ac.uk/ols/index).

Additionally, as a tool for curators, the EMBL Ontology Lookup Service (OLS) allows for semantic searching. Simple
queries for the terms ‘mitochondrial dysfunction’ and ‘amyloid beta-peptides’ immediately returned results from
relevant ontologies, and ended a long debate over how to represent these objects within BEL. EMBL-EBI also provides a
programmatic API to the OLS service, for searching terms (<http://www.ebi.ac.uk/ols/api/search?q=folic%20acid>) and
suggesting resolutions (<http://www.ebi.ac.uk/ols/api/suggest?q=folic+acid>)

## Implementation[](#implementation "Permalink to this headline")

PyBEL is implemented using the PyParsing module. It provides flexibility and incredible speed in parsing compared
to regular expression implementation. It also allows for the addition of parsing action hooks, which allow
the graph to be checked semantically at compile-time.

It uses SQLite to provide a consistent and lightweight caching system for external data, such as
namespaces, annotations, ontologies, and SQLAlchemy to provide a cross-platform interface. The same data management
system is used to store graphs for high-performance querying.

## Extensions to BEL[](#extensions-to-bel "Permalink to this headline")

The PyBEL compiler is fully compliant with both BEL v1.0 and v2.0 and automatically upgrades legacy statements.
Additionally, PyBEL includes several additions to the BEL specification to enable expression of important concepts
in molecular biology that were previously missing and to facilitate integrating new data types. A short example is the
inclusion of protein oxidation in the default BEL namespace for protein modifications. Other, more elaborate additions
are outlined below.

### Syntax for Epigenetics[](#syntax-for-epigenetics "Permalink to this headline")

PyBEL introduces the gene modification function, gmod(), as a syntax for encoding epigenetic modifications. Its usage
mirrors the pmod() function for proteins and includes arguments for methylation.

For example, the methylation of NDUFB6 was found to be negatively correlated with its expression in a study of insulin
resistance and Type II diabetes. This can now be expressed in BEL such as in the following statement:

`g(HGNC:NDUFB6, gmod(Me)) negativeCorrelation r(HGNC:NDUFB6)`

References:

* <https://www.ncbi.nlm.nih.gov/pubmed/17948130>
* <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4655260/>

Note

This syntax is currently under consideration as [BEP-0006](https://github.com/belbio/bep/blob/bep-0006/docs/drafts/BEP-0006.md).

### Definition of Namespaces as Regular Expressions[](#definition-of-namespaces-as-regular-expressions "Permalink to this headline")

BEL imposes the constraint that each identifier must be qualified with an enumerated namespace to enable semantic
interoperability and data integration. However, enumerating a namespace with potentially billions of names, such as
dbSNP, poses a computational issue. PyBEL introduces syntax for defining namespaces with a consistent pattern using a
regular expression to overcome this issue. For these namespaces, semantic validation can be perform in post-processing
against the underlying database. The dbSNP namespace can be defined with a syntax familiar to BEL annotation
definitions with regular expressions as follows:

`DEFINE NAMESPACE dbSNP AS PATTERN "rs[0-9]+"`

Note

This syntax was proposed with [BEP-0005](https://github.com/belbio/bep/blob/master/docs/published/BEP-0005.md)
and has been officially accepted as part of the BEL 2.1 specification.

### Definition of Resources using OWL[](#definition-of-resources-using-owl "Permalink to this headline")

Previous versions of PyBEL until 0.11.2 had an alternative namespace definition. Now it is recommended to either
generate namespace files with reproducible build scripts following the Bio2BEL framework, or to directly add them to
the database with the Bio2BEL `bio2bel.manager.namespace_manager.NamespaceManagerMixin` extension.

## Things to Consider[](#things-to-consider "Permalink to this headline")

### Do All Statements Need Supporting Text?[](#do-all-statements-need-supporting-text "Permalink to this headline")

Yes! All statements must be minimally qualified with a citation and evidence (now called SupportingText in BEL 2.0) to
maintain provenance. Statements without evidence can’t be traced to their source or evaluated independently from the
curator, so they are excluded.

### Multiple Annotations[](#multiple-annotations "Permalink to this headline")

All single annotations are considered as single element sets. When multiple annotations are present, all are unioned
and attached to a given edge.

```
SET Citation = {"PubMed","Example Article","12345"}
SET ExampleAnnotation1 = {"Example Value 11", "Example Value 12"}
SET ExampleAnnotation2 = {"Example Value 21", "Example Value 22"}
p(HGNC:YFG1) -> p(HGNC:YFG2)
```

### Namespace and Annotation Name Choices[](#namespace-and-annotation-name-choices "Permalink to this headline")

`*.belns` and `*.belanno` configuration files include an entry called “Keyword” in their respective
[Namespace] and [AnnotationDefinition] sections. To maintain understandability between BEL documents, PyBEL
warns when the names given in `*.bel` documents do not match their respective resources. For now, capitalization
is not considered, but in the future, PyBEL will also warn when capitalization is not properly stylized, like forgetting
the lowercase ‘h’ in “ChEMBL”.

### Why Not Nested Statements?[](#why-not-nested-statements "Permalink to this headline")

BEL has different relationships for modeling direct and indirect causal relations.

#### Direct[](#direct "Permalink to this headline")

* `A => B` means that A directly increases B through a physical process.
* `A =| B` means that A directly decreases B through a physical process.

#### Indirect[](#indirect "Permalink to this headline")

The relationship between two entities can be coded in BEL, even if the process is not well understood.

* `A -> B` means that A indirectly increases B. There are hidden elements in X that mediate this interaction
  through a pathway direct interactions `A (=> or =|) X_1 (=> or =|) ... X_n (=> or =|) B`, or through a set of
  multiple pathways that constitute a network.
* `A -| B` means that A indirectly decreases B. Like for `A -> B`, this process involves hidden
  components with varying activities.

#### Increasing Nested Relationships[](#increasing-nested-relationships "Permalink to this headline")

BEL also allows object of a relationship to be another statement.

* `A => (B => C)` means that A increases the process by which B increases C. The example in the BEL Spec
  `p(HGNC:GATA1) => (act(p(HGNC:ZBTB16)) => r(HGNC:MPL))` represents GATA1 directly increasing the process by
  which ZBTB16 directly increases MPL. Before, directly increasing was used to specify physical contact, so it’s
  reasonable to conclude that `p(HGNC:GATA1) => act(p(HGNC:ZBTB16))`. The specification cites examples when B
  is an activity that only is affected in the context of A and C. This complicated enough that it is both
  impractical to standardize during curation, and impractical to represent in a network.
* `A -> (B => C)` can be interpreted by assuming that A indirectly increases B, and because of monotonicity,
  conclude that `A -> C` as well.
* `A => (B -> C)` is more difficult to interpret, because it does not describe which part of process
  `B -> C` is affected by A or how. Is it that `A => B`, and `B => C`, so we conclude
  `A -> C`, or does it mean something else? Perhaps A impacts a different portion of the hidden process in
  `B -> C`. These statements are ambiguous enough that they should be written as just `A => B`, and
  `B -> C`. If there is no literature evidence for the statement `A -> C`, then it is not the job of the
  curator to make this inference. Identifying statements of this might be the goal of a bioinformatics analysis of the
  BEL network after compilation.
* `A -> (B -> C)` introduces even more ambiguity, and it should not be used.
* `A => (B =| C)` states A increases the process by which B decreases C. One interpretation of this
  statement might be that `A => B` and `B =| C`. An analysis could infer `A -| C`. Statements in the
  form of `A -> (B =| C)` can also be resolved this way, but with added ambiguity.

#### Decreasing Nested Relationships[](#decreasing-nested-relationships "Permalink to this headline")
