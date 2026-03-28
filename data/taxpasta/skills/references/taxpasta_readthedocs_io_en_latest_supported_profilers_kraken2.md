[ ]
[ ]

[Skip to content](#kraken2)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

Kraken2

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
  + [DIAMOND](../diamond/)
  + [ganon](../ganon/)
  + [Kaiju](../kaiju/)
  + [KMCP](../kmcp/)
  + [ ]

    Kraken2

    [Kraken2](./)

    Table of contents
    - [Profile Format](#profile-format)
    - [Example](#example)
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

# Kraken2[¶](#kraken2 "Permanent link")

> [Kraken2](https://ccb.jhu.edu/software/kraken2/) is a taxonomic classification system using exact k-mer matches to achieve high accuracy and fast classification speeds. This classifier matches each k-mer within a query sequence to the lowest common ancestor (LCA) of all genomes containing the given k-mer.

## Profile Format[¶](#profile-format "Permanent link")

A tab-separated kraken-report output file with either six or eight columns as described [in the documentation](https://github.com/DerrickWood/kraken2/blob/master/docs/MANUAL.markdown#sample-report-output-format). This is generated with the Kraken2 parameter `--report`. Taxpasta interprets the columns as follows:

| Column Header | Description |
| --- | --- |
| percent |  |
| clade\_assigned\_reads |  |
| direct\_assigned\_reads[1](#fn:1) |  |
| num\_minimizers | optional |
| distinct\_minimizers | optional |
| taxonomy\_lvl |  |
| taxonomy\_id |  |
| name |  |

## Example[¶](#example "Permanent link")

```
 99.98  787758  787758  U   0   unclassified
  0.02  119 0   R   1   root
  0.02  119 0   R1  131567    cellular organisms
  0.02  119 0   D   2759        Eukaryota
  0.02  119 0   D1  33154         Opisthokonta
  0.01  96  0   K   4751            Fungi
  0.01  96  0   K1  451864            Dikarya
```

---

1. Value used in standardised profile output [↩](#fnref:1 "Jump back to footnote 1 in the text")

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)