[ ]
[ ]

[Skip to content](#usage)

[![logo](../architeuthis.webp)](.. "Documentation")

Documentation

Merging

Initializing search

[cdiener/architeuthis](https://github.com/cdiener/architeuthis "Go to repository")

* [Home](..)
* [Installation](../install/)
* [User Guide](../lineage/)
* [Releases](../release_notes/)

[![logo](../architeuthis.webp)](.. "Documentation")
Documentation

[cdiener/architeuthis](https://github.com/cdiener/architeuthis "Go to repository")

* [Home](..)
* [Installation](../install/)
* [x]

  User Guide

  User Guide
  + [Lineage annotation](../lineage/)
  + [ ]

    Merging

    [Merging](./)

    Table of contents
    - [Usage](#usage)
  + [Mapping Analysis](../mapping/)
  + [Filtering](../filter/)
* [Releases](../release_notes/)

Table of contents

* [Usage](#usage)

# Merging

The `merge` subcommand combines Kraken/Bracken output across several samples. It currently
supports

1. Kraken output files (`*.k2`)
2. Bracken output files (`*.b2`)
3. Mapping analyses (`*.csv`)

Info

`architeuthis` will automatically recognize and validate the file type
and tell you if your file is not supported.

## Usage

For instance to combine several Bracken output files:

```
architeuthis merge -o bracken_merged.csv *.b2
```

This will combine all `*.b2` files into a single merged CSV with an additional
`sample_id` column generated from the basename of the files.

For Kraken output the resulting file will still be in the native Kraken output
format without an additional column as this format operates on individual reads
which already have a unique sample-specific ID.

[Previous

Lineage annotation](../lineage/)
[Next

Mapping Analysis](../mapping/)

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)