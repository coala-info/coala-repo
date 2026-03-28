[ ]
[ ]

[Skip to content](#resource-requirements)

[![logo](../../assets/logo.svg)](../.. "sr2silo")

sr2silo

Resource Requirements

Initializing search

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [Usage](../configuration/)
* [API Reference](../../api/loculus/)
* [Contributing](../../contributing/)

[![logo](../../assets/logo.svg)](../.. "sr2silo")
sr2silo

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [x]

  Usage

  Usage
  + [Configuration](../configuration/)
  + [Multi-Organism Support](../organisms/)
  + [Deployment](../deployment/)
  + [ ]

    Resource Requirements

    [Resource Requirements](./)

    Table of contents
    - [Memory Requirements](#memory-requirements)
    - [Storage Requirements](#storage-requirements)
    - [Cluster Environment Configuration](#cluster-environment-configuration)
* [ ]

  API Reference

  API Reference
  + [Loculus Integration](../../api/loculus/)
  + [Processing](../../api/process/)
  + [Data Schemas](../../api/schema/)
  + [V-Pipe Integration](../../api/vpipe/)
* [ ]

  Contributing

  Contributing
  + [Overview](../../contributing/)
  + [Branching Strategy](../../contributing/branching-strategy/)

# Resource Requirements

When running sr2silo, especially the `--import to loculus` command, you should be aware of the following resource requirements:

## Memory Requirements

* **Standard Resources**: The default Snakemake configuration uses 8 GB RAM and one CPU core
* **Actual Usage**:
* sr2silo processes in batches of 100k reads at a time, requiring approximately 3 GB of RAM
* An additional 3 GB of RAM is needed for running Diamond for amino acid translation and alignment

## Storage Requirements

* **Temporary Space**:
* sr2silo itself requires some temporary directory space
* Diamond may require up to 30 GB of temporary storage
* Ideally, this should be on high I/O storage

## Cluster Environment Configuration

When running on a personal computer, standard temporary directories are usually sufficient as long as you have free disk space. However, in a cluster environment:

1. Set the environment variable `TMPDIR` to a location with at least 50 GB of free space per run:

```
export TMPDIR=/path/to/temp/directory
```

1. Make sure this directory has good I/O performance for optimal processing speed

This configuration will help prevent issues with temporary file storage during the processing of large datasets.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)