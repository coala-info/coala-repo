[ ]
[ ]

[Skip to content](#krakenuniq)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

KrakenUniq

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
  + [ ]

    KrakenUniq

    [KrakenUniq](./)

    Table of contents
    - [Profile Format](#profile-format)
    - [Example](#example)
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

# KrakenUniq[¶](#krakenuniq "Permanent link")

> [KrakenUniq](https://github.com/fbreitwieser/krakenuniq) is a novel metagenomics classifier that combines the fast k-mer-based classification of Kraken with an efficient algorithm for assessing the coverage of unique k-mers found in each species in a dataset.

## Profile Format[¶](#profile-format "Permanent link")

Taxpasta expects a 9 column table. This file is generated with the KrakenUniq parameter `--output`. The accepted format is:

| Column Header | Description |
| --- | --- |
| % |  |
| reads[1](#fn:1) |  |
| taxReads |  |
| kmers |  |
| dup |  |
| cov |  |
| taxID |  |
| rank |  |
| taxName |  |

## Example[¶](#example "Permanent link")

```
# KrakenUniq v1.0.0 DATE:2022-11-03T07:44:13Z DB:customdb/ DB_SIZE:358660 WD:/tmp/tmprujvrgk2/krakenuniq
# CL:perl /mnt/archgen/users/james_fellows_yates/bin/miniconda3/envs/mamba/envs/krakenuniq/bin/krakenuniq --db customdb/ --threads 8 --output test1.krakenuniq.classified.txt --report-file test1.krakenuniq.report.txt test_1.fastq.gz
%   reads   taxReads    kmers   dup cov taxID   rank    taxName
100 100 0   7556    1.3 0.1268  1   no rank root
100 100 0   7556    1.3 0.1268  10239   superkingdom      Viruses
100 100 0   7556    1.3 0.1268  2559587 clade       Riboviria
100 100 0   7556    1.3 0.1268  2732396 kingdom       Orthornavirae
100 100 0   7556    1.3 0.1268  2732408 phylum          Pisuviricota
100 100 0   7556    1.3 0.1268  2732506 class             Pisoniviricetes
100 100 0   7556    1.3 0.1268  76804   order               Nidovirales
100 100 0   7556    1.3 0.1268  2499399 suborder                  Cornidovirineae
100 100 0   7556    1.3 0.1268  11118   family                  Coronaviridae
100 100 0   7556    1.3 0.1268  2501931 subfamily                     Orthocoronavirinae
100 100 0   7556    1.3 0.1268  694002  genus                       Betacoronavirus
100 100 0   7556    1.3 0.1268  2509511 subgenus                          Sarbecovirus
100 100 0   7556    1.3 0.1268  694009  species                         Severe acute respiratory syndrome-related coronavirus
100 100 100 7556    1.3 0.1268  2697049 no rank                           Severe acute respiratory syndrome coronavirus 2
```

---

1. Value used in standardised profile output [↩](#fnref:1 "Jump back to footnote 1 in the text")

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)