[ ]
[ ]

[Skip to content](#diamond)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

DIAMOND

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
  + [Bracken](../bracken/)
  + [Centrifuge](../centrifuge/)
  + [ ]

    DIAMOND

    [DIAMOND](./)

    Table of contents
    - [Profile Format](#profile-format)
    - [Example](#example)
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

# DIAMOND[¶](#diamond "Permanent link")

> [DIAMOND](https://github.com/bbuchfink/diamond) is a sequence aligner for protein and translated DNA searches, designed for high performance analysis of big sequence data.

## Profile Format[¶](#profile-format "Permanent link")

Taxpasta expects a tab-separated file with three columns. This is generated with the DIAMOND parameter `--outfmt 102`. Taxpasta will interpret the columns as:

| Column Header | Description |
| --- | --- |
| query\_id |  |
| taxonomy\_id |  |
| e\_value |  |

> Taxpasta internally generates the value used in the standardised profile output, by summarising number of reads per `taxonomy_id`

## Example[¶](#example "Permanent link")

```
shigella_dysenteriae_958/1  511145  2.46e-08
shigella_dysenteriae_1069/1 511145  2.37e-07
escherichia_coli_308/1  511145  1.55e-12
shigella_dysenteriae_1418/1 1310613 7.75e-10
escherichia_coli_962/1  1310613 7.02e-06
shigella_dysenteriae_520/1  1310613 5.46e-12
shigella_dysenteriae_242/1  1310613 2.91e-12
escherichia_coli_1146/1 1310613 2.61e-11
escherichia_coli_551/1  1310613 1.94e-14
shigella_dysenteriae_1094/1 1310613 1.74e-13
shigella_dysenteriae_999/1  0   0
```

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)