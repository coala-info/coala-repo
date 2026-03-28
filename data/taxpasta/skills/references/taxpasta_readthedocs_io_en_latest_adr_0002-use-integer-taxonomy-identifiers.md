[ ]
[ ]

[Skip to content](#2-use-integer-taxonomy-identifiers)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

2. Use Integer Taxonomy Identifiers

Initializing search

[taxprofiler/taxpasta](https://github.com/taxprofiler/taxpasta "Go to repository")

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")
TAXPASTA

[taxprofiler/taxpasta](https://github.com/taxprofiler/taxpasta "Go to repository")

* [Home](../..)
* [ ]

  Tutorials

  Tutorials
  + [Getting Started](../../tutorials/getting-started/)
  + [Deep Dive](../../tutorials/deepdive/)
* [ ]

  How-tos

  How-tos
  + [How-to Add Taxa Names to Output](../../how-tos/how-to-add-names/)
  + [How-to Customise Sample Names](../../how-tos/how-to-customise-sample-names/)
  + [How-to Merge Across Profilers](../../how-tos/how-to-merge-across-profilers/)
* [ ]

  [Commands](../../commands/)

  Commands
  + [standardise](../../commands/standardise/)
  + [merge](../../commands/merge/)
* [ ]

  [Quick reference](../../quick_reference/)

  Quick reference
  + [standardise](../../quick_reference/standardise/)
  + [merge](../../quick_reference/merge/)
* [ ]

  [Supported profilers](../../supported_profilers/)

  Supported profilers
  + [Terminology](../../supported_profilers/terminology/)
  + [Bracken](../../supported_profilers/bracken/)
  + [Centrifuge](../../supported_profilers/centrifuge/)
  + [DIAMOND](../../supported_profilers/diamond/)
  + [ganon](../../supported_profilers/ganon/)
  + [Kaiju](../../supported_profilers/kaiju/)
  + [KMCP](../../supported_profilers/kmcp/)
  + [Kraken2](../../supported_profilers/kraken2/)
  + [KrakenUniq](../../supported_profilers/krakenuniq/)
  + [MEGAN6/MALT](../../supported_profilers/megan6/)
  + [MetaPhlAn](../../supported_profilers/metaphlan/)
  + [mOTUs](../../supported_profilers/motus/)
* [FAQ](../../faq/)
* [x]

  Design Decisions

  Design Decisions
  + [1. Record architecture decisions](../0001-record-architecture-decisions/)
  + [ ]

    2. Use Integer Taxonomy Identifiers

    [2. Use Integer Taxonomy Identifiers](./)

    Table of contents
    - [Status](#status)
    - [Context](#context)
    - [Decision](#decision)
    - [Consequences](#consequences)
* [ ]

  API Reference

  API Reference
  + [Application](../../api/application/)
  + [Domain](../../api/domain/)
  + [Infrastructure](../../api/infrastructure/)
* [ ]

  [Contributing](../../contributing/)

  Contributing
  + [Supporting New Taxonomic Profilers](../../contributing/supporting_new_profiler/)

Table of contents

* [Status](#status)
* [Context](#context)
* [Decision](#decision)
* [Consequences](#consequences)

# 2. Use Integer Taxonomy Identifiers[¶](#2-use-integer-taxonomy-identifiers "Permanent link")

Date: 2022-12-23

## Status[¶](#status "Permanent link")

Accepted

## Context[¶](#context "Permanent link")

Various taxonomic profilers either use supplied or built-in taxonomies. Most
commonly those are either from [NCBI](https://www.ncbi.nlm.nih.gov/taxonomy) or [GTDB](https://gtdb.ecogenomic.org/). In any case, most profilers that we encountered so far use integers to refer to nodes within their taxonomy. This is also the convention for the [TaxonKit's taxdump](https://bioinf.shenwei.me/taxonkit/usage/#create-taxdump) format.

## Decision[¶](#decision "Permanent link")

We will use integer taxonomy identifiers for our internal standard profile. We
will use the number zero to denote unclassified reads.

## Consequences[¶](#consequences "Permanent link")

All taxonomic profiles need to have their identifiers transformed to integers.
There is some variety in how tools denote unclassified reads. Often they are
given 0 or -1 as the identifier but some tools also provide no value at all. All
of those must be converted to zero. Since pandas cannot handle missing values
for integers, we load identifier columns as string first and then convert them
later.

Another consequence is that if we ever want to attach names or lineages to our
output files, the corresponding taxonomy will have to be loaded separately.

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)