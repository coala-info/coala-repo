[ ]
[ ]

[Skip to content](#centrifuge)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

Centrifuge

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
  + [ ]

    Centrifuge

    [Centrifuge](./)

    Table of contents
    - [Profile Format](#profile-format)
    - [Example](#example)
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

# Centrifuge[¶](#centrifuge "Permanent link")

> [Centrifuge](https://ccb.jhu.edu/software/centrifuge/) is a very rapid and memory-efficient system for the classification of DNA sequences from microbial samples, with better sensitivity than and comparable accuracy to other leading systems. The system uses a novel indexing scheme based on the Burrows-Wheeler transform (BWT) and the Ferragina-Manzini (FM) index, optimized specifically for the metagenomic classification problem. Centrifuge requires a relatively small index (e.g., 4.3 GB for ~4,100 bacterial genomes) yet provides very fast classification speed, allowing it to process a typical DNA sequencing run within an hour.

## Profile Format[¶](#profile-format "Permanent link")

A Kraken-style `txt` output file produced by the [`centrifuge-kreport`](https://ccb.jhu.edu/software/centrifuge/manual.shtml#kraken-style-report) auxiliary tool (a part of the Centrifuge package) is accepted by `taxpasta`.

| Column Header | Description |
| --- | --- |
| percent |  |
| clade\_assigned\_reads |  |
| direct\_assigned\_reads[1](#fn:1) |  |
| taxonomy\_level |  |
| taxonomy\_id |  |
| name |  |

## Example[¶](#example "Permanent link")

```
  0.00  0   0   U   0   unclassified
100.00  99  0   -   1   root
 98.99  98  0   D   10239     Viruses
 33.33  33  0   F   687329      Anelloviridae
 23.23  23  1   G   687331        Alphatorquevirus
  1.01  1   1   S   687340          Torque teno virus 1
  1.01  1   1   S   687342          Torque teno virus 3
```

---

1. Value used in standardised profile output [↩](#fnref:1 "Jump back to footnote 1 in the text")

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)