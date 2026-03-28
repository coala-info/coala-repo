[ ]
[ ]

[Skip to content](#merge)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

merge

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
* [x]

  [Commands](../)

  Commands
  + [standardise](../standardise/)
  + [ ]

    merge

    [merge](./)

    Table of contents
    - [What](#what)
    - [When](#when)
    - [How](#how)
    - [Why](#why)
* [ ]

  [Quick reference](../../quick_reference/)

  Quick reference
  + [standardise](../../quick_reference/standardise/)
  + [merge](../../quick_reference/merge/)
* [ ]

  [Supported profilers](../../supported_profilers/)

  Supported profilers
  + [Terminology](../../supported_profilers/terminology/)
  + [Bracken](../../supported_profilers/bracken/)
  + [Centrifuge](../../supported_profilers/centrifuge/)
  + [DIAMOND](../../supported_profilers/diamond/)
  + [ganon](../../supported_profilers/ganon/)
  + [Kaiju](../../supported_profilers/kaiju/)
  + [KMCP](../../supported_profilers/kmcp/)
  + [Kraken2](../../supported_profilers/kraken2/)
  + [KrakenUniq](../../supported_profilers/krakenuniq/)
  + [MEGAN6/MALT](../../supported_profilers/megan6/)
  + [MetaPhlAn](../../supported_profilers/metaphlan/)
  + [mOTUs](../../supported_profilers/motus/)
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

* [What](#what)
* [When](#when)
* [How](#how)
* [Why](#why)

# merge[¶](#merge "Permanent link")

## What[¶](#what "Permanent link")

The purpose of the `merge` command is to standardise and immediately combine
multiple taxonomic profiles from the same tool but different samples. This produces a
standard 'taxon table' in either wide or long format.

## When[¶](#when "Permanent link")

You should use `taxpasta merge` when you want to standardise multiple profiles
in one go and have all profiles combined into a single table. You will
use this command if you want to load the table directly into a spreadsheet
program or programming language without needing to manually combine profiles.

See [`standardise`](../standardise/) if you wish to only standardise without merging.

Warning

You should only use this command if you are interested in raw 'counts'! The
standardised output will remove profiler specific information, such as
names, percentages, and lineage information.

## How[¶](#how "Permanent link")

To use this command, you will need multiple profiles of a single tool, the name
of the tool, and specify an output file name:

```
taxpasta merge --profiler kraken2 --output taxon_table.tsv sample1.kreport.txt sample2.kreport.txt sample3.kreport.txt
```

where `sample1.kreport.txt`, `sample2.kreport.txt`, `sample3.kreport.txt` are
report files from Kraken2.

This will produce a file called `sample_standardised.tsv` that contains the
taxpasta 'standard' multi-column structure described [below](#why).

## Why[¶](#why "Permanent link")

Take, for example, the following Kraken2 output file.

```
 99.98  787758  787758  U   0   unclassified
  0.02  119 0   R   1   root
  0.02  119 0   R1  131567    cellular organisms
  0.02  119 0   D   2759        Eukaryota
  0.02  119 0   D1  33154         Opisthokonta
  0.01  96  0   K   4751            Fungi
  0.01  96  0   K1  451864            Dikarya
```

This output format is specific to Kraken2 and is unlikely to be comparable with
other tools, as they will record this information in different formats.
Furthermore, the indentation system to show taxonomic rank depth is not
particularly 'machine-readable'; making it difficult to load it into spreadsheet
tools or tabular formats preferred by languages such as
[R](https://www.r-project.org/).

A more common format in metagenomics is to have a first column with the taxon
name and each subsequent column representing a different sample. Each cell
represents a count of the number of sequence hits against that row's taxon within
that column's sample.

We have chosen to reduce all taxa to their respective identifiers. We chose zero as the
identifier for unclassified reads. Since there are many downstream processing and
analytics methods
that assume integer read counts, we only support such a count or pseudo count column.

An example of this format could be:

| taxonomy\_id | sample1 | sample2 | sample3 |
| --- | --- | --- | --- |
| 0 | 787758 | 2233938 | 98872 |
| 1 | 119 | 12929 | 872 |
| 131567 | 119 | 5345 | 800 |
| 2759 | 119 | 123 | 200 |
| 33154 | 119 | 123 | 29 |
| 4751 | 96 | 30 | 29 |
| 451864 | 96 | 30 | 29 |

Where you have a header indicating each column, the first (`taxonomy_id`) indicating
which taxon has the counts in the second column (`sample1`), then third column
(`sample2`), fourth column (`sample3`), and so on.

As you can see here, this is a much more compact way of looking at multiple
samples, with the caveat that you may not have additional information, such as the
accuracy of each assignment.

Danger

Taxpasta will assume that all taxonomic profiles to be processed are based
on the same underlying taxonomy. That means, taxpasta will happily join taxa
by their identifier even if they stem from different taxonomies.

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)