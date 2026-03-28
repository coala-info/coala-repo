[ ]
[ ]

[Skip to content](#ganon)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

ganon

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
  + [ ]

    ganon

    [ganon](./)

    Table of contents
    - [Profile Format](#profile-format)
    - [Example](#example)
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

# ganon[¶](#ganon "Permanent link")

> [ganon](https://pirovc.github.io/ganon/) is designed to index large sets of genomic reference sequences and to classify reads against them efficiently. The tool uses Interleaved Bloom Filters as indices based on k-mers/minimizers. It was mainly developed, but not limited, to the metagenomics classification problem: quickly assign sequence fragments to their closest reference among thousands of references. After classification, taxonomic abundance is estimated and reported.

## Profile Format[¶](#profile-format "Permanent link")

Taxpasta expects a tab-separated file with nine columns. This is generated with the `ganon report` command. Taxpasta will interpret the columns as:

| Column Header | Description |
| --- | --- |
| rank |  |
| target |  |
| lineage |  |
| name |  |
| nr\_unique[1](#fn:1) |  |
| nr\_shared |  |
| nr\_children |  |
| nr\_cumulative |  |
| pc\_cumulative |  |

## Example[¶](#example "Permanent link")

```
unclassified    -   -   unclassified    0   0   0   174530  27.61288
root    1   1   root    0   0   457530  457530  72.38712
superkingdom    2   1|2 Bacteria    0   0   447016  447016  69.95031
superkingdom    2157    1|2157  Archaea 0   0   10514   10514   2.43680
phylum  1224    1|2|1224    Pseudomonadota  0   0   189513  189513  22.08574
```

---

1. Value used in standardised profile output, representing unambiguous reads that match that reference (i.e., multi-match reads, nor with child reads). See [ganon docs](https://pirovc.github.io/ganon/outputfiles/) for further description. [↩](#fnref:1 "Jump back to footnote 1 in the text")

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)