[ ]
[ ]

[Skip to content](#how-to-customise-sample-names)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

How-to Customise Sample Names

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
* [x]

  How-tos

  How-tos
  + [How-to Add Taxa Names to Output](../how-to-add-names/)
  + [ ]

    How-to Customise Sample Names

    [How-to Customise Sample Names](./)

    Table of contents
    - [Clean Up](#clean-up)
  + [How-to Merge Across Profilers](../how-to-merge-across-profilers/)
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

* [Clean Up](#clean-up)

# How-to Customise Sample Names[¶](#how-to-customise-sample-names "Permanent link")

Info

We follow on from the main [tutorial](../../tutorials/getting-started/) including
all files just before the clean up step.

With `taxpasta` you can also customise the sample names that are displayed in
the column header of your merged table, by creating a sample sheet that has the
sample name you want and paths to the files.

We can generate such a TSV sample sheet with a bit of `bash` trickery or your
favourite spreadsheet program.

Assuming that your current working directory is the `taxpasta-tutorial`
directory.

```
## Get the full paths for each file
ls -1 *mOTU.out > motus_paths.txt

## Construct a sample name based on the filename
sed 's#-db_mOTU.out##g;s#^.*/##g' motus_paths.txt > motus_names.txt

## Create the samplesheet, adding a header, and then adding the samplenames and paths
printf 'sample\tprofile\n' > motus_samplesheet.tsv
paste motus_names.txt motus_paths.txt >> motus_samplesheet.tsv
```

Then instead of giving to `merge` the paths to each of the profiles, we can
provide the sample sheet itself.

```
taxpasta merge -p motus -o dbMOTUs_motus_cleannames.tsv -s motus_samplesheet.tsv
```

```
[INFO] Read sample sheet from 'motus_samplesheet.tsv'.
[WARNING] The merged profiles contained different taxa. Additional zeroes were introduced for missing taxa.
[INFO] Write result to 'dbMOTUs_motus_cleannames.tsv'.
```

You can now see that the column headers look a bit better.

```
head dbMOTUs_motus_cleannames.tsv
```

```
taxonomy_id 2612_pe-ERR5766176  2612_se-ERR5766180
40518   20  2
216816  1   0
1680    6   1
1262820 1   0
74426   2   1
1907654 1   0
1852370 3   1
39491   3   0
33039   2   0
```

## Clean Up[¶](#clean-up "Permanent link")

Don't forget to [remove the tutorial
directory](../../tutorials/getting-started/#clean-up) if you don't want to keep it for
later use.

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)