[ ]
[ ]

[Skip to content](#how-to-add-taxa-names-to-output)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

How-to Add Taxa Names to Output

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
  + [ ]

    How-to Add Taxa Names to Output

    [How-to Add Taxa Names to Output](./)

    Table of contents
    - [Clean Up](#clean-up)
  + [How-to Customise Sample Names](../how-to-customise-sample-names/)
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

# How-to Add Taxa Names to Output[¶](#how-to-add-taxa-names-to-output "Permanent link")

Info

We follow on from the main [tutorial](../../tutorials/getting-started/) including
all files just before the clean up step.

If you wish to have actual human-readable taxon names in your standardised
output, you need to supply 'taxonomy' files. These files are typically called
`nodes.dmp` and `names.dmp`. Most profilers use the NCBI
taxonomy files.

Assuming that your current working directory is the `taxpasta-tutorial`
directory, we can download the taxonomy files with the following.

```
curl -O ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz.md5
curl -O ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz
md5sum --check taxdump.tar.gz.md5
mkdir taxdump
tar -C taxdump -xzf taxdump.tar.gz
```

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0100    49  100    49    0     0     33      0  0:00:01  0:00:01 --:--:--    33
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0 58.5M    0     0    0     0      0      0 --:--:--  0:00:01 --:--:--     0  8 58.5M    8 4877k    0     0  2289k      0  0:00:26  0:00:02  0:00:24 2289k 49 58.5M   49 29.0M    0     0  9437k      0  0:00:06  0:00:03  0:00:03 9438k 90 58.5M   90 53.1M    0     0  12.9M      0  0:00:04  0:00:04 --:--:-- 12.9M100 58.5M  100 58.5M    0     0  13.2M      0  0:00:04  0:00:04 --:--:-- 13.9M
taxdump.tar.gz: OK
```

Once downloaded and extracted, you can supply the directory with the taxdump
files to your respective `taxpasta` commands with the `--taxonomy` flag, and
specify which type of taxonomy information to display, e.g., just the name, the
rank, and/or taxonomic lineage.

```
taxpasta merge -p motus -o dbMOTUs_motus_with_names.tsv --taxonomy taxdump --add-name 2612_pe-ERR5766176-db_mOTU.out 2612_se-ERR5766180-db_mOTU.out
```

```
[WARNING] The merged profiles contained different taxa. Additional zeroes were introduced for missing taxa.
[INFO] Write result to 'dbMOTUs_motus_with_names.tsv'.
```

The merged taxpasta output now looks like:

```
head dbMOTUs_motus_with_names.tsv
```

```
taxonomy_id name    2612_pe-ERR5766176-db_mOTU  2612_se-ERR5766180-db_mOTU
40518   Ruminococcus bromii 20  2
216816  Bifidobacterium longum  1   0
1680    Bifidobacterium adolescentis    6   1
1262820 Clostridium sp. CAG:567 1   0
74426   Collinsella aerofaciens 2   1
1907654 Collinsella bouchesdurhonensis  1   0
1852370 Prevotellamassilia timonensis   3   1
39491   [Eubacterium] rectale   3   0
33039   [Ruminococcus] torques  2   0
```

## Clean Up[¶](#clean-up "Permanent link")

Don't forget to [remove the tutorial
directory](../../tutorials/getting-started/#clean-up) if you don't want to keep it for
later use.

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)