[ ]
[ ]

[Skip to content](#installation)

mlstdb

Installation

Initializing search

[MDU-PHL/mlstdb](https://github.com/MDU-PHL/mlstdb "Go to repository")

* [Home](..)
* [Installation](./)
* [Getting Started](../getting-started/)
* [Usage](../usage/overview/)
* [Disclaimer](../disclaimer/)
* [Changelog](../changelog/)

mlstdb

[MDU-PHL/mlstdb](https://github.com/MDU-PHL/mlstdb "Go to repository")

* [Home](..)
* [ ]

  Installation

  [Installation](./)

  Table of contents
  + [Prerequisites](#prerequisites)
  + [Recommended Method](#recommended-method)
  + [Alternative Methods](#alternative-methods)
  + [Verify Installation](#verify-installation)
  + [Next Steps](#next-steps)
* [Getting Started](../getting-started/)
* [ ]

  Usage

  Usage
  + [Overview](../usage/overview/)
  + [Connect](../usage/connect/)
  + [Update](../usage/update/)
  + [Purge](../usage/purge/)
  + [Fetch (Advanced)](../usage/fetch/)
* [Disclaimer](../disclaimer/)
* [Changelog](../changelog/)

Table of contents

* [Prerequisites](#prerequisites)
* [Recommended Method](#recommended-method)
* [Alternative Methods](#alternative-methods)
* [Verify Installation](#verify-installation)
* [Next Steps](#next-steps)

# Installation

## Prerequisites

`mlstdb` is designed to work alongside the [`mlst`](https://github.com/tseemann/mlst) tool. You'll need:

* **Python** >= 3.8
* **mlst** — install via [bioconda](https://bioconda.github.io/)
* **BLAST+** — comes with `mlst`, or install separately via bioconda/apt

## Recommended Method

Create a conda environment with `mlst`, then install `mlstdb` via pip:

```
conda create -n mlst -c bioconda mlst
conda activate mlst
pip install mlstdb
```

This is the most reliable method and avoids dependency conflicts.

## Alternative Methods

## Verify Installation

```
mlstdb --version
mlstdb --help
```

You should see the version number and the available commands (`connect`, `update`, `fetch`).

## Next Steps

Head to the [Getting Started](../getting-started/) guide to connect to the databases and download your first MLST schemes.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)