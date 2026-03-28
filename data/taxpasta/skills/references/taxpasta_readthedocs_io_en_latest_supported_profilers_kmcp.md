[ ]
[ ]

[Skip to content](#kmcp)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

KMCP

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
  + [ ]

    KMCP

    [KMCP](./)

    Table of contents
    - [Profile Format](#profile-format)
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

# KMCP[¶](#kmcp "Permanent link")

> [KMCP](https://github.com/shenwei356/kmcp) uses genome coverage information by splitting the reference genomes into chunks and stores k-mers in a modified and optimized Compact Bit-Sliced Signature (COBS) index for fast alignment-free sequence searching. KMCP combines k-mer similarity and genome coverage information to reduce the false positive rate of k-mer-based taxonomic classification and profiling methods.

## Profile Format[¶](#profile-format "Permanent link")

Taxpasta expects a tab-separated file with seventeen columns. This is generated with the `kmcp profile` command. Taxpasta will interpret the columns as:

| Column Header | Description |
| --- | --- |
| ref |  |
| percentage |  |
| coverage | optional |
| score |  |
| chunksFrac |  |
| chunksRelDepth |  |
| chunksRelDepthStd | optional |
| reads |  |
| ureads |  |
| hicureads |  |
| refsize |  |
| refname | optional |
| taxid |  |
| rank | optional |
| taxname | optional |
| taxpath | optional |
| taxpathsn | optional |

Please refer to the [KMCP documentation](https://bioinf.shenwei.me/kmcp/usage/#profile) for further description.

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)