[ ]
[ ]

[Skip to content](#050)

[![logo](../architeuthis.webp)](.. "Documentation")

Documentation

Releases

Initializing search

[cdiener/architeuthis](https://github.com/cdiener/architeuthis "Go to repository")

* [Home](..)
* [Installation](../install/)
* [User Guide](../lineage/)
* [Releases](./)

[![logo](../architeuthis.webp)](.. "Documentation")
Documentation

[cdiener/architeuthis](https://github.com/cdiener/architeuthis "Go to repository")

* [Home](..)
* [Installation](../install/)
* [ ]

  User Guide

  User Guide
  + [Lineage annotation](../lineage/)
  + [Merging](../merge/)
  + [Mapping Analysis](../mapping/)
  + [Filtering](../filter/)
* [ ]

  Releases

  [Releases](./)

  Table of contents
  + [0.5.0](#050)
  + [0.4.0](#040)
  + [0.3.1](#031)
  + [0.3.0](#030)

Table of contents

* [0.5.0](#050)
* [0.4.0](#040)
* [0.3.1](#031)
* [0.3.0](#030)

# Releases

Those are the changes to `architeuthis` starting with version 0.3.0.

## 0.5.0

Now uses `reformat2` from taxonkit providing more flexibility to the reported taxonomy.

Similar to taxonkit, architeuthis reports a modified domain rank merging the NCBI taxonomy's
"domain", "acellular root", and "superkingdom" to provide support for multiple NCBI
Taxonomy versions and Viruses.

## 0.4.0

`architeuthis mapping filter` now allows the `--format` argument.

Switches the default highest rank in lineage annotaion to kingdom (`K__`) as superkingdom
has been removed from the newest NCBI taxonomy.

The annotation leaf is now detected from the back, making it resistant to missing
higher ranks.

`architeuthis mapping filter` logs will now indicate if a custom taxonomy directory is used.

## 0.3.1

Fixes the merging for Kraken2 files.

Add more checks during parsing.

## 0.3.0

Now supports Kraken2 output generated with the `--use-names` flag.

Adds documentation with mkdocs.

[Previous

Filtering](../filter/)

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)