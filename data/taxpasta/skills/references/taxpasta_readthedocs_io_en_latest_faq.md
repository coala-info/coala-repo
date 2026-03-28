[ ]
[ ]

[Skip to content](#frequently-asked-questions)

[![logo](../assets/images/taxpasta-logo-white-pastaonly.svg)](.. "TAXPASTA")

TAXPASTA

FAQ

Initializing search

[taxprofiler/taxpasta](https://github.com/taxprofiler/taxpasta "Go to repository")

[![logo](../assets/images/taxpasta-logo-white-pastaonly.svg)](.. "TAXPASTA")
TAXPASTA

[taxprofiler/taxpasta](https://github.com/taxprofiler/taxpasta "Go to repository")

* [Home](..)
* [ ]

  Tutorials

  Tutorials
  + [Getting Started](../tutorials/getting-started/)
  + [Deep Dive](../tutorials/deepdive/)
* [ ]

  How-tos

  How-tos
  + [How-to Add Taxa Names to Output](../how-tos/how-to-add-names/)
  + [How-to Customise Sample Names](../how-tos/how-to-customise-sample-names/)
  + [How-to Merge Across Profilers](../how-tos/how-to-merge-across-profilers/)
* [ ]

  [Commands](../commands/)

  Commands
  + [standardise](../commands/standardise/)
  + [merge](../commands/merge/)
* [ ]

  [Quick reference](../quick_reference/)

  Quick reference
  + [standardise](../quick_reference/standardise/)
  + [merge](../quick_reference/merge/)
* [ ]

  [Supported profilers](../supported_profilers/)

  Supported profilers
  + [Terminology](../supported_profilers/terminology/)
  + [Bracken](../supported_profilers/bracken/)
  + [Centrifuge](../supported_profilers/centrifuge/)
  + [DIAMOND](../supported_profilers/diamond/)
  + [ganon](../supported_profilers/ganon/)
  + [Kaiju](../supported_profilers/kaiju/)
  + [KMCP](../supported_profilers/kmcp/)
  + [Kraken2](../supported_profilers/kraken2/)
  + [KrakenUniq](../supported_profilers/krakenuniq/)
  + [MEGAN6/MALT](../supported_profilers/megan6/)
  + [MetaPhlAn](../supported_profilers/metaphlan/)
  + [mOTUs](../supported_profilers/motus/)
* [ ]

  FAQ

  [FAQ](./)

  Table of contents
  + [Why can't I output BIOM format when standardising a single profile?](#why-cant-i-output-biom-format-when-standardising-a-single-profile)
* [ ]

  Design Decisions

  Design Decisions
  + [1. Record architecture decisions](../adr/0001-record-architecture-decisions/)
  + [2. Use Integer Taxonomy Identifiers](../adr/0002-use-integer-taxonomy-identifiers/)
* [ ]

  API Reference

  API Reference
  + [Application](../api/application/)
  + [Domain](../api/domain/)
  + [Infrastructure](../api/infrastructure/)
* [ ]

  [Contributing](../contributing/)

  Contributing
  + [Supporting New Taxonomic Profilers](../contributing/supporting_new_profiler/)

Table of contents

* [Why can't I output BIOM format when standardising a single profile?](#why-cant-i-output-biom-format-when-standardising-a-single-profile)

# Frequently Asked Questions[¶](#frequently-asked-questions "Permanent link")

Do you have questions? We may have your answer already. If not, please also take a look at the existing [discussion topics](https://github.com/taxprofiler/taxpasta/discussions).

## Why can't I output BIOM format when standardising a single profile?[¶](#why-cant-i-output-biom-format-when-standardising-a-single-profile "Permanent link")

The [BIOM format](https://biom-format.org/) is currently not a supported output format for the [`taxpasta standardise` command](../quick_reference/standardise/). Attempting to do so will result in an error.
The reason for that is that the BIOM format, in the authors' own words, was "designed to be a general-use format for representing biological sample by observation contingency tables". That means, the format was developed to adequately describe *groups* of samples.
If you have multiple samples, please use [`taxpasta merge`](../quick_reference/merge/) to combine them into a single BIOM file.

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)