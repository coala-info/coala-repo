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
* [ ]

  [Commands](../../commands/)

  Commands
  + [standardise](../../commands/standardise/)
  + [merge](../../commands/merge/)
* [x]

  [Quick reference](../)

  Quick reference
  + [standardise](../standardise/)
  + [ ]
    [merge](./)
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

# merge[¶](#merge "Permanent link")

```
taxpasta merge --help
```

```
Usage: taxpasta merge [OPTIONS] [PROFILE1 PROFILE2 [...]]

  Standardise and merge two or more taxonomic profiles.

Arguments:
  [PROFILE1 PROFILE2 [...]]  Two or more files containing taxonomic profiles.
                             Required unless there is a sample sheet.
                             Filenames will be parsed as sample names.

Options:
  -p, --profiler [bracken|centrifuge|diamond|ganon|kaiju|kmcp|kraken2|krakenuniq|megan6|metaphlan|motus]
                                  The taxonomic profiler used. All provided
                                  profiles must come from the same tool!
                                  [required]
  -s, --samplesheet FILE          A table with a header and two columns: the
                                  first column named 'sample' which can be any
                                  string and the second column named 'profile'
                                  which must be a file path to an actual
                                  taxonomic abundance profile. If this option
                                  is provided, any arguments are ignored.
  --samplesheet-format [TSV|CSV|ODS|XLSX|arrow|parquet]
                                  The file format of the sample sheet.
                                  Depending on the choice, additional package
                                  dependencies may apply. Will be parsed from
                                  the sample sheet file name but can be set
                                  explicitly.
  -o, --output PATH               The desired output file. By default, the
                                  file extension will be used to determine the
                                  output format, but when setting the format
                                  explicitly using the --output-format option,
                                  automatic detection is disabled.  [required]
  --output-format [TSV|CSV|ODS|XLSX|arrow|parquet|BIOM]
                                  The desired output format. Depending on the
                                  choice, additional package dependencies may
                                  apply. By default it will be parsed from the
                                  output file name but it can be set
                                  explicitly and will then disable the
                                  automatic detection.
  --wide / --long                 Output merged abundance data in either wide
                                  or (tidy) long format. Ignored when the
                                  desired output format is BIOM.  [default:
                                  wide]
  --summarise-at, --summarize-at TEXT
                                  Summarise abundance profiles at higher
                                  taxonomic rank. The provided option must
                                  match a rank in the taxonomy exactly. This
                                  is akin to the clade assigned reads provided
                                  by, for example, kraken2, where the
                                  abundances of a whole taxonomic branch are
                                  assigned to a taxon at the desired rank.
                                  Please note that abundances above the
                                  selected rank are simply ignored. No attempt
                                  is made to redistribute those down to the
                                  desired rank. Some tools, like Bracken, were
                                  designed for this purpose but it doesn't
                                  seem like a problem we can generally solve
                                  here.
  --taxonomy PATH                 The path to a directory containing taxdump
                                  files. At least nodes.dmp and names.dmp are
                                  required. A merged.dmp file is optional.
  --add-name                      Add the taxon name to the output.
  --add-rank                      Add the taxon rank to the output.
  --add-lineage                   Add the taxon's entire lineage to the
                                  output. These are taxon names separated by
                                  semi-colons.
  --add-id-lineage                Add the taxon's entire lineage to the
                                  output. These are taxon identifiers
                                  separated by semi-colons.
  --add-rank-lineage              Add the taxon's entire rank lineage to the
                                  output. These are taxon ranks separated by
                                  semi-colons.
  -h, --help                      Show this message and exit.
```

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)