[![](../CWL-Logo-Header.png)](index.html)

* [Table of contents](#toc)

# Semantic Annotations for Linked Avro Data (SALAD) [§](#Semantic_Annotations_for_Linked_Avro_Data_(SALAD))

Author:

* Peter Amstutz peter.amstutz@curii.com, Curii Corporation

Contributors:

* The developers of Apache Avro
* The developers of JSON-LD
* Nebojša Tijanić nebojsa.tijanic@sbgenomics.com, Seven Bridges Genomics
* Michael R. Crusoe, ELIXIR-DE

# Abstract [§](#Abstract)

Salad is a schema language for describing structured linked data documents
in JSON or YAML documents. A Salad schema provides rules for
preprocessing, structural validation, and link checking for documents
described by a Salad schema. Salad builds on JSON-LD and the Apache Avro
data serialization system, and extends Avro with features for rich data
modeling such as inheritance, template specialization, object identifiers,
and object references. Salad was developed to provide a bridge between the
record oriented data modeling supported by Apache Avro and the Semantic
Web.

# Status of This Document [§](#Status_of_This_Document)

This document is the product of the [Common Workflow Language working
group](https://groups.google.com/forum/#!forum/common-workflow-language). The
latest version of this document is available in the "schema\_salad" repository at

<https://github.com/common-workflow-language/schema_salad>

The products of the CWL working group (including this document) are made available
under the terms of the Apache License, version 2.0.

# Table of contents

1. [Semantic Annotations for Linked Avro Data (SALAD)](#Semantic_Annotations_for_Linked_Avro_Data_(SALAD))
   - [Abstract](#Abstract)
     - [Status of This Document](#Status_of_This_Document)
       - [1. Introduction](#Introduction)
         1. [1.1 Introduction to v1.1](#Introduction_to_v1.1)
            - [1.2 Introduction to v1.2](#Introduction_to_v1.2)
              1. [1.2.1 Changelog for v1.2.1](#Changelog_for_v1.2.1)- [1.3 References to Other Specifications](#References_to_Other_Specifications)
                - [1.4 Scope](#Scope)
                  - [1.5 Terminology](#Terminology)- [2. Document model](#Document_model)
           1. [2.1 Data concepts](#Data_concepts)
              - [2.2 Syntax](#Syntax)
                - [2.3 Document context](#Document_context)
                  1. [2.3.1 Implied context](#Implied_context)
                     - [2.3.2 Explicit context](#Explicit_context)- [2.4 Document graph](#Document_graph)
                    - [2.5 Document metadata](#Document_metadata)
                      - [2.6 Document schema](#Document_schema)
                        - [2.7 Record field annotations](#Record_field_annotations)
                          - [2.8 Document traversal](#Document_traversal)
                            - [2.9 Short names](#Short_names)
                              - [2.10 Inheritance and specialization](#Inheritance_and_specialization)- [3. Document preprocessing](#Document_preprocessing)
             1. [3.1 Field name resolution](#Field_name_resolution)
                1. [3.1.1 Field name resolution example](#Field_name_resolution_example)- [3.2 Identifier resolution](#Identifier_resolution)
                  1. [3.2.1 Identifier resolution example](#Identifier_resolution_example)- [3.3 Link resolution](#Link_resolution)
                    1. [3.3.1 Link resolution example](#Link_resolution_example)- [3.4 Vocabulary resolution](#Vocabulary_resolution)
                      1. [3.4.1 Vocabulary resolution example](#Vocabulary_resolution_example)- [3.5 Import](#Import)
                        1. [3.5.1 Import example: replacing the `$import` node](#Import_example:_replacing_the_`$import`_node)
                           - [3.5.2 Import example: flattening the `$import`ed array](#Import_example:_flattening_the_`$import`ed_array)- [3.6 Include](#Include)
                          1. [3.6.1 Include example](#Include_example)- [3.7 Identifier maps](#Identifier_maps)
                            1. [3.7.1 Identifier map example](#Identifier_map_example)- [3.8 Domain Specific Language for types](#Domain_Specific_Language_for_types)
                              1. [3.8.1 Type DSL example](#Type_DSL_example)- [3.9 Domain Specific Language for secondary files](#Domain_Specific_Language_for_secondary_files)
                                1. [3.9.1 Type DSL example](#Type_DSL_example)- [4. SaladRecordSchema](#SaladRecordSchema)
               1. [4.1 SaladRecordField](#SaladRecordField)
                  1. [4.1.1 PrimitiveType](#PrimitiveType)
                     - [4.1.2 Any](#Any)
                       - [4.1.3 RecordSchema](#RecordSchema)
                         - [4.1.4 RecordField](#RecordField)
                           1. [4.1.4.1 EnumSchema](#EnumSchema)
                              - [4.1.4.2 ArraySchema](#ArraySchema)- [4.1.5 JsonldPredicate](#JsonldPredicate)- [4.2 SpecializeDef](#SpecializeDef)- [5. SaladEnumSchema](#SaladEnumSchema)
                 - [6. Documentation](#Documentation)

# 1. Introduction [§](#Introduction)

The JSON data model is an extremely popular way to represent structured
data. It is attractive because of its relative simplicity and is a
natural fit with the standard types of many programming languages.
However, this simplicity means that basic JSON lacks expressive features
useful for working with complex data structures and document formats, such
as schemas, object references, and namespaces.

JSON-LD is a W3C standard providing a way to describe how to interpret a
JSON document as Linked Data by means of a "context". JSON-LD provides a
powerful solution for representing object references and namespaces in JSON
based on standard web URIs, but is not itself a schema language. Without a
schema providing a well defined structure, it is difficult to process an
arbitrary JSON-LD document as idiomatic JSON because there are many ways to
express the same data that are logically equivalent but structurally
distinct.

Several schema languages exist for describing and validating JSON data,
such as the Apache Avro data serialization system, however none understand
linked data. As a result, to fully take advantage of JSON-LD to build the
next generation of linked data applications, one must maintain separate
JSON schema, JSON-LD context, RDF schema, and human documentation, despite
significant overlap of content and obvious need for these documents to stay
synchronized.

Schema Salad is designed to address this gap. It provides a schema
language and processing rules for describing structured JSON content
permitting URI resolution and strict document validation. The schema
language supports linked data through annotations that describe the linked
data interpretation of the content, enables generation of JSON-LD context
and RDF schema, and production of RDF triples by applying the JSON-LD
context. The schema language also provides for robust support of inline
documentation.

## 1.1 Introduction to v1.1 [§](#Introduction_to_v1.1)

This is the third version of the Schema Salad specification. It is
developed concurrently with v1.1 of the Common Workflow Language for use in
specifying the Common Workflow Language, however Schema Salad is intended to be
useful to a broader audience. Compared to the v1.0 schema salad
specification, the following changes have been made:

* Support for `default` values on record fields to specify default values
* Add subscoped fields (fields which introduce a new inner scope for identifiers)
* Add the *inVocab* flag (default true) to indicate if a type is added to the vocabulary of well known terms or must be prefixed
* Add *secondaryFilesDSL* micro DSL (domain specific language) to convert text strings to a secondaryFiles record type used in CWL
* The `$mixin` feature has been removed from the specification, as it
  is poorly documented, not included in conformance testing,
  and not widely supported.

## 1.2 Introduction to v1.2 [§](#Introduction_to_v1.2)

This is the fourth version of the Schema Salad specification. It was created to
ease the development of extensions to CWL v1.2. The only change is that
inherited records can narrow the types of fields if those fields are re-specified
with a matching jsonldPredicate.

### 1.2.1 Changelog for v1.2.1 [§](#Changelog_for_v1.2.1)

There are no new features nor behavior changes in Schema Salad v1.2.1
as compared to Schema-Salad v1.2. Schema Salad v1.2.1 only fixes typos and adds
clarifications.

* The `salad` directory's contents have been trimmed to the bare necessities.
  The `salad/README.rst` has been refreshed from the [upstream repository](https://github.com/common-workflow-language/schema_salad/).
* The [existing behaviour of `$import`](#Import) has been clarified.
  If the `$import` node is in an array and the import operation yields an
  array, it is flattened to the parent array. Otherwise the `$import`
  node is replaced in the document structure by the object or array yielded
  from the import operation. An [additional example](#import_example2)
  has been added to illustrate this better.
* A pair of missing brackets was added to the [Type DSL Example](#Type_DSL_example)'s
  example input.
* Missing newlines have been added to the [identifier map example](#Identifier_map_example)'s
  example source and example result.
* [Inherited fields in Salad types](#SaladRecordSchema) may be re-specified
  to narrow their type and/or to override the `doc` field.
* Clarify that fields with `jsonldPredicate: { _type: "@id" }` indicate that the
  field is a [link fields](#SaladRecordSchema) and that if the `jsonldPredicate`
  also has the field `identity` with the value `true`, then field is
  resolved with [identifier resolution](#Identifier_resolution).
  Otherwise the field is resolved with [link resolution](#Link_resolution).

## 1.3 References to Other Specifications [§](#References_to_Other_Specifications)

**Javascript Object Notation (JSON)**: <http://json.org>

**JSON Linked Data (JSON-LD)**: <http://json-ld.org>

**YAML**: <https://yaml.org/spec/1.2/spec.html>

**Avro**: <https://avro.apache.org/docs/current/spec.html>

**Uniform Resource Identifier (URI) Generic Syntax**: <https://tools.ietf.org/html/rfc3986>)

**Resource Description Framework (RDF)**: <http://www.w3.org/RDF/>

**UTF-8**: <https://www.ietf.org/rfc/rfc2279.txt>)

## 1.4 Scope [§](#Scope)

This document describes the syntax, data model, algorithms, and schema
language for working with Salad documents. It is not intended to document
a specific implementation of Salad, however it may serve as a reference for
the behavior of conforming implementations.

## 1.5 Terminology [§](#Terminology)

The terminology used to describe Salad documents is defined in the Concepts
section of the specification. The terms defined in the following list are
used in building those definitions and in describing the actions of a
Salad implementation:

**may**: Conforming Salad documents and Salad implementations are permitted but
not required to be interpreted as described.

**must**: Conforming Salad documents and Salad implementations are required
to be interpreted as described; otherwise they are in error.

**error**: A violation of the rules of this specification; results are
undefined. Conforming implementations may detect and report an error and may
recover from it.

**fatal error**: A violation of the rules of this specification; results
are undefined. Conforming implementations must not continue to process the
document and may report an error.

**at user option**: Conforming software may or must (depending on the modal verb in
the sentence) behave as described; if it does, it must provide users a means to
enable or disable the behavior described.

# 2. Document model [§](#Document_model)

## 2.1 Data concepts [§](#Data_concepts)

An **object** is a data structure equivalent to the "object" type in JSON,
consisting of a unordered set of name/value pairs (referred to here as
**fields**) and where the name is a string and the value is a string, number,
boolean, array, or object.

A **document** is a file containing a serialized object, or an array of
objects.

A **document type** is a class of files that share a common structure and
semantics.

A **document schema** is a formal description of the grammar of a document type.

A **base URI** is a context-dependent URI used to resolve relative references.

An **identifier** is a URI that designates a single document or single
object within a document.

A **vocabulary** is the set of symbolic field names and enumerated symbols defined
by a document schema, where each term maps to absolute URI.

## 2.2 Syntax [§](#Syntax)

Conforming Salad v1.1 documents are serialized and loaded using a
subset of YAML 1.2 syntax and UTF-8 text encoding. Salad documents
are written using the [JSON-compatible subset of YAML described in
section 10.2](https://yaml.org/spec/1.2/spec.html#id2803231). The
following features of YAML must not be used in conforming Salad
documents:

* Use of explicit node tags with leading `!` or `!!`
* Use of anchors with leading `&` and aliases with leading `*`
* %YAML directives
* %TAG directives

It is a fatal error if the document is not valid YAML.

A Salad document must consist only of either a single root object or an
array of objects.

## 2.3 Document context [§](#Document_context)

### 2.3.1 Implied context [§](#Implied_context)

The implicit context consists of the vocabulary defined by the schema and
the base URI. By default, the base URI must be the URI that was used to
load the document. It may be overridden by an explicit context.

### 2.3.2 Explicit context [§](#Explicit_context)

If a document consists of a root object, this object may contain the
fields `$base`, `$namespaces`, `$schemas`, and `$graph`:

* `$base`: Must be a string. Set the base URI for the document used to
  resolve relative references.
* `$namespaces`: Must be an object with strings as values. The keys of
  the object are namespace prefixes used in the document; the values of
  the object are the prefix expansions.
* `$schemas`: Must be an array of strings. This field may list URI
  references to documents in RDF-XML format which will be queried for RDF
  schema data. The subjects and predicates described by the RDF schema
  may provide additional semantic context for the document, and may be
  used for validation of prefixed extension fields found in the document.

Other directives beginning with `$` must be ignored.

## 2.4 Document graph [§](#Document_graph)

If a document consists of a single root object, this object may contain the
field `$graph`. This field must be an array of objects. If present, this
field holds the primary content of the document. A document that consists
of array of objects at the root is an implicit graph.

## 2.5 Document metadata [§](#Document_metadata)

If a document consists of a single root object, metadata about the
document, such as