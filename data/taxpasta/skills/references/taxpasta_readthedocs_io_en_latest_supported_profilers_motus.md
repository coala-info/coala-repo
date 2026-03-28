[ ]
[ ]

[Skip to content](#motus)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

mOTUs

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
  + [Kraken2](../kraken2/)
  + [KrakenUniq](../krakenuniq/)
  + [MEGAN6/MALT](../megan6/)
  + [MetaPhlAn](../metaphlan/)
  + [ ]

    mOTUs

    [mOTUs](./)

    Table of contents
    - [Profile Format](#profile-format)
    - [Example](#example)
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

# mOTUs[¶](#motus "Permanent link")

> The [mOTU](https://github.com/motu-tool/mOTUs/wiki) profiler is a computational tool that estimates relative taxonomic abundance of known and currently unknown microbial community members using metagenomic shotgun sequencing data.

## Profile Format[¶](#profile-format "Permanent link")

Taxpasta expects a three-column, tab-separated file. This file is generated with the mOTUs parameter `-o` . It interprets the columns as:

| Column Header | Description |
| --- | --- |
| consensus\_taxonomy |  |
| ncbi\_tax\_id |  |
| read\_count[1](#fn:1) |  |

## Example[¶](#example "Permanent link")

```
# git tag version 3.0.3 |  motus version 3.0.3 | map_tax 3.0.3 | gene database: nr3.0.3 | calc_mgc 3.0.3 -y insert.scaled_counts -l 75 | calc_motu 3.0.3 -k mOTU -C no_CAMI -g 3 -c -p | taxonomy: ref_mOTU_3.0.3 meta_mOTU_3.0.3
# call: python /usr/local/bin/../share/motus-3.0.1//motus profile -p -c -f ERX5474932_ERR5766176_1.fastq.gz -r ERX5474932_ERR5766176_2.fastq.gz -db db_mOTU -t 2 -n 2612_pe-ERR5766176-db_mOTU -o 2612_pe-ERR5766176-db_mOTU.out
#consensus_taxonomy NCBI_tax_id 2612_pe-ERR5766176-db_mOTU
Leptospira alexanderi [ref_mOTU_v3_00001]   100053  0
Leptospira weilii [ref_mOTU_v3_00002]   28184   0
Chryseobacterium sp. [ref_mOTU_v3_00004]    NA  0
```

---

1. Value used in standardised profile output [↩](#fnref:1 "Jump back to footnote 1 in the text")

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)