[ ]
[ ]

[Skip to content](#how-to-merge-across-profilers)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

How-to Merge Across Profilers

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
* [x]

  How-tos

  How-tos
  + [How-to Add Taxa Names to Output](../how-to-add-names/)
  + [How-to Customise Sample Names](../how-to-customise-sample-names/)
  + [ ]

    How-to Merge Across Profilers

    [How-to Merge Across Profilers](./)

    Table of contents
    - [Dependencies](#dependencies)
    - [Merging Across Profilers](#merging-across-profilers)
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
* [ ]

  Design Decisions

  Design Decisions
  + [1. Record architecture decisions](../../adr/0001-record-architecture-decisions/)
  + [2. Use Integer Taxonomy Identifiers](../../adr/0002-use-integer-taxonomy-identifiers/)
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

* [Dependencies](#dependencies)
* [Merging Across Profilers](#merging-across-profilers)

# How-to Merge Across Profilers[¶](#how-to-merge-across-profilers "Permanent link")

As stated in the main description of the tools and tutorials, `taxpasta` does
not (directly) support merging *across* different profilers, as each tool may
have its own reference database, taxonomy, and/or abundance metric. This can
risk making naïve assumptions and false-positive interpretations, thus
`taxpasta` is designed to help *prepare* data for cross-profiler analysis
without doing so itself. We highly recommend doing this mindfully in an
exploratory fashion.

Here we will show you how you can load such standardised profiles into R and
Python in a way that allows you to distinguish between the two tools as
necessary.

## Dependencies[¶](#dependencies "Permanent link")

## Merging Across Profilers[¶](#merging-across-profilers "Permanent link")

Assuming you had two files in the same directory, `motus_dbMOTUs.tsv` and
`kraken2_db2.tsv` - both of which are the output from a previous `taxpasta merge` command - you can load them as follows.

From here, you can ensure that when you are making comparisons between tools you
are taking the tool and database into account via the `filename` column. Of
course, you may add further columns like `profiler` instead.

---

1. R code adapted from Claus Wilke's [blog
   post](https://clauswilke.com/blog/2016/06/13/reading-and-combining-many-tidy-data-files-in-r/). [↩](#fnref:1 "Jump back to footnote 1 in the text")

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)