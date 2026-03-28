[ ]
[ ]

[Skip to content](#mlstdb)

mlstdb

Home

Initializing search

[MDU-PHL/mlstdb](https://github.com/MDU-PHL/mlstdb "Go to repository")

* [Home](.)
* [Installation](installation/)
* [Getting Started](getting-started/)
* [Usage](usage/overview/)
* [Disclaimer](disclaimer/)
* [Changelog](changelog/)

mlstdb

[MDU-PHL/mlstdb](https://github.com/MDU-PHL/mlstdb "Go to repository")

* [ ]

  Home

  [Home](.)

  Table of contents
  + [Why mlstdb?](#why-mlstdb)
  + [Quick Start](#quick-start)
  + [Commands at a Glance](#commands-at-a-glance)
  + [Next Steps](#next-steps)
* [Installation](installation/)
* [Getting Started](getting-started/)
* [ ]

  Usage

  Usage
  + [Overview](usage/overview/)
  + [Connect](usage/connect/)
  + [Update](usage/update/)
  + [Purge](usage/purge/)
  + [Fetch (Advanced)](usage/fetch/)
* [Disclaimer](disclaimer/)
* [Changelog](changelog/)

Table of contents

* [Why mlstdb?](#why-mlstdb)
* [Quick Start](#quick-start)
* [Commands at a Glance](#commands-at-a-glance)
* [Next Steps](#next-steps)

# mlstdb

[![Tests](https://github.com/MDU-PHL/mlstdb/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/MDU-PHL/mlstdb/actions/workflows/test.yml)
[![PyPI](https://img.shields.io/pypi/v/mlstdb.svg)](https://pypi.org/project/mlstdb)
[![Bioconda](https://anaconda.org/bioconda/mlstdb/badges/version.svg)](https://anaconda.org/bioconda/mlstdb)

**Keep your [`mlst`](https://github.com/tseemann/mlst) databases up to date with.. just two commands**

`mlstdb` handles the OAuth authentication required to access [PubMLST](https://pubmlst.org/) and [BIGSdb Pasteur](https://bigsdb.pasteur.fr/) APIs, downloads the latest MLST schemes, and builds a ready-to-use BLAST database for the `mlst` tool.

---

## Why `mlstdb`?

The `mlst` tool comes with a bundled database, but MLST schemes are continuously updated on PubMLST and Pasteur. Keeping your local database current requires authentication setup (OAuth2) and downloading files. `mlstdb` handles all of that with additional features.

**What it does:**

* Handles OAuth registration and token management for PubMLST and Pasteur
* Downloads allele sequences and ST profiles for curated MLST schemes
* Builds the BLAST database that `mlst` needs
* Supports parallel downloads, resume on failure, and custom scheme lists
* Lets you surgically remove contaminated STs or alleles

---

## Quick Start

```
# 1. Install
conda create -n mlst -c bioconda mlst && conda activate mlst
pip install mlstdb

# 2. Connect to databases (one-time setup)
mlstdb connect --db pubmlst
mlstdb connect --db pasteur

# 3. Download schemes and build BLAST database
mlstdb update

# 4. Use with mlst
mlst --blastdb blast/mlst.fa --datadir pubmlst your_assembly.fasta
```

See the [Getting Started](getting-started/) guide for a detailed walkthrough.

---

## Commands at a Glance

| Command | Purpose |
| --- | --- |
| `mlstdb connect` | Register OAuth credentials with PubMLST or Pasteur |
| `mlstdb update` | Download schemes and build the BLAST database |
| `mlstdb purge` | Remove contaminated STs, alleles, or entire schemes |
| `mlstdb fetch` | *(Advanced)* Explore and filter all available schemes |

Most users only need `connect` and `update`. See the [Usage Overview](usage/overview/) for details.

---

## Next Steps

* [Installation](installation/) — All installation methods
* [Getting Started](getting-started/) — End-to-end tutorial
* [Usage Overview](usage/overview/) — How the commands work together
* [Purge](usage/purge/) — Remove contaminated entries from your local database

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)