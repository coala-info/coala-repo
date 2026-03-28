[ ]
[ ]

[Skip to content](#terminology)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

Terminology

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
  + [ ]

    Terminology

    [Terminology](./)

    Table of contents
    - [Criteria](#criteria)

      * [Type of Abundance/Profiler](#type-of-abundanceprofiler)
      * [Differences in Abundance](#differences-in-abundance)
      * [Classification Method](#classification-method)
    - [Categorisation](#categorisation)
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

* [Criteria](#criteria)

  + [Type of Abundance/Profiler](#type-of-abundanceprofiler)
  + [Differences in Abundance](#differences-in-abundance)
  + [Classification Method](#classification-method)
* [Categorisation](#categorisation)

# Terminology[¶](#terminology "Permanent link")

Info

Even though we have very specific concepts in mind when talking about the
different tools and their results, we don't (yet) apply this terminology
consistently everywhere. We will do so as time permits. In the meantime,
please study the concepts presented herein carefully and form your own
judgement how they apply elsewhere in the documentation.

Our thinking about terminology is strongly influenced by the categorisation proposed by Sun *et al.* (2021)[1](#fn:1).
To summarise: Broadly, we call all of these tools *metagenomic profilers*. They can be
more finely grouped by considering their type of reference database and thus the kind of relative abundance profile
produced. Furthermore, the underlying method for sequencing read classification impacts
the [computational complexity](https://en.wikipedia.org/wiki/Computational_complexity) (time and database size/memory)
dramatically.

## Criteria[¶](#criteria "Permanent link")

### Type of Abundance/Profiler[¶](#type-of-abundanceprofiler "Permanent link")

Our main criteria for categorizing a metagenomic profiler are summarised in the list below,
as well as shown in the schema.

* Reference database:
  + **DNA-to-DNA**, aka a metagenome library
  + **DNA-to-AA**, aka a genomic library of protein coding sequences (amino-acid)
  + **DNA-to-marker**, aka marker gene, aka gene families selection
* Result:
  + relative **sequence abundance**
  + relative **protein sequence abundance**
  + relative **taxonomic abundance**

```
graph TB

    P(Metagenomic Profiler)
    D(DNA-to-DNA)
    A(DNA-to-AA)
    M(DNA-to-marker)
    S(Sequence Abundance)
    SAA(Protein Sequence Abundance)
    T(Taxonomic Abundance)
    TP(Taxonomic Profiler)
    SP(Sequence Profiler aka Classifier)

    P --> D
    P --> A
    P --> M
    D --> S
    A --> SAA
    M --> T
    S --> SP
    SAA --> SP
    T --> TP
```

### Differences in Abundance[¶](#differences-in-abundance "Permanent link")

A key takeaway from Sun *et al.* (2021)[1](#fn:1) is also that the different kinds of relative
abundances cannot easily be interconverted by, for example, normalizing sequence abundance by genome size.
Reasons for this include, in particular for metagenome-assembled genomes (MAGs), inaccurate
genome size, unknown polyploidy. Sun *et al.* (2021)[1](#fn:1) observed that broadly sequence abundance
tends to overestimate large genomes and underestimates smaller genomes. Any attempts to
perform normalization by, for example, genome size, are just as likely to introduce
systematic errors than improve the results. Furthermore, α-diversity measures
appear to be statistically significantly affected by the type of relative abundance - higher for taxonomic abundance.
The type also affects β-diversity although the effect is harder to quantify.

### Classification Method[¶](#classification-method "Permanent link")

Additionally, we may be interested in the method used to classify sequencing reads.

* Method:
  + index
  + alignment

## Categorisation[¶](#categorisation "Permanent link")

| Tool | Reference Database | Result | Method |
| --- | --- | --- | --- |
| Bracken | See Kraken2 | See Kraken2 | Bayesian re-estimation of sequence abundance |
| Centrifuge | DNA-to-DNA | Sequence abundance (optionally normalized by genome size) | FM index |
| DIAMOND | DNA-to-AA | Protein sequence abundance |  |
| Kaiju | DNA-to-AA | Protein sequence abundance |  |
| Kraken2 | DNA-to-DNA (DNA-to-AA) | (Protein) sequence abundance | k-mer index |
| KrakenUniq | DNA-to-DNA | Sequence abundance | see Kraken |
| MEGAN6/MALT | DNA-to-DNA | Sequence abundance | alignment |
| MetaPhlAn | DNA-to-marker | Taxonomic abundance | alignment (bowtie2) |
| mOTUs | DNA-to-marker | Taxonomic abundance | alignment (bowtie2) |

---

1. Sun, Z., Huang, S., Zhang, M., Zhu, Q., Haiminen, N., Carrieri, A. P., Vázquez-Baeza, Y., Parida, L., Kim, H.-C., Knight, R., & Liu, Y.-Y. (2021). Challenges in benchmarking metagenomic profilers. *Nature Methods*. <https://doi.org/10.1038/s41592-021-01141-3> [↩](#fnref:1 "Jump back to footnote 1 in the text")[↩](#fnref2:1 "Jump back to footnote 1 in the text")[↩](#fnref3:1 "Jump back to footnote 1 in the text")

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)