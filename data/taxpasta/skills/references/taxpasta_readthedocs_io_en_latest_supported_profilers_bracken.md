[ ]
[ ]

[Skip to content](#bracken)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

Bracken

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
* [x]

  [Supported profilers](../)

  Supported profilers
  + [Terminology](../terminology/)
  + [ ]

    Bracken

    [Bracken](./)

    Table of contents
    - [Profile Format](#profile-format)
    - [Example](#example)
  + [Centrifuge](../centrifuge/)
  + [DIAMOND](../diamond/)
  + [ganon](../ganon/)
  + [Kaiju](../kaiju/)
  + [KMCP](../kmcp/)
  + [Kraken2](../kraken2/)
  + [KrakenUniq](../krakenuniq/)
  + [MEGAN6/MALT](../megan6/)
  + [MetaPhlAn](../metaphlan/)
  + [mOTUs](../motus/)
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

* [Profile Format](#profile-format)
* [Example](#example)

# Bracken[¶](#bracken "Permanent link")

> [Bracken](https://ccb.jhu.edu/software/bracken/) (Bayesian Reestimation of Abundance with KrakEN) is a highly accurate statistical method that computes the abundance of species in DNA sequences from a metagenomics sample. Bracken uses the taxonomy labels assigned by Kraken, a highly accurate metagenomics classification algorithm, to estimate the number of reads originating from each species present in a sample.

## Profile Format[¶](#profile-format "Permanent link")

The following input format is accepted by `taxpasta`. This file is generated with the Bracken parameter `-o`. A tab-separated file with the following column headers:

| Column Header | Description |
| --- | --- |
| name |  |
| taxonomy\_id |  |
| taxonomy\_lvl |  |
| kraken\_assigned\_reads |  |
| added\_reads |  |
| new\_est\_reads[1](#fn:1) |  |
| fraction\_total\_reads |  |

## Example[¶](#example "Permanent link")

```
name    taxonomy_id taxonomy_lvl    kraken_assigned_reads   added_reads new_est_reads   fraction_total_reads
Homo sapiens    9606    S   156 0   156 0.90173
Saccharomyces cerevisiae    4932    S   17  0   17  0.09827
```

---

1. Value used in standardised profile output [↩](#fnref:1 "Jump back to footnote 1 in the text")

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)