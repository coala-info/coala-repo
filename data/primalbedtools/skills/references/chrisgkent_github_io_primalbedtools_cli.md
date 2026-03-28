[ ]
[ ]

[Skip to content](#primalbedtools-cli)

primalbedtools

Command Line Interface

[GitHub](https://github.com/ChrisgKent/primalbedtools "Go to repository")

primalbedtools

[GitHub](https://github.com/ChrisgKent/primalbedtools "Go to repository")

* [Quick Start](..)
* [How To Guides](../how-to-guides/)
* [ ]

  Command Line Interface

  [Command Line Interface](./)

  Table of contents
  + [Installation](#installation)
  + [Basic Usage](#basic-usage)
  + [Commands](#commands)

    - [remap](#remap)
    - [sort](#sort)
    - [update](#update)
    - [amplicon](#amplicon)
    - [merge](#merge)
    - [fasta](#fasta)
    - [validate\_bedfile](#validate_bedfile)
    - [validate](#validate)
    - [downgrade](#downgrade)
* [API](../api/)

Table of contents

* [Installation](#installation)
* [Basic Usage](#basic-usage)
* [Commands](#commands)

  + [remap](#remap)
  + [sort](#sort)
  + [update](#update)
  + [amplicon](#amplicon)
  + [merge](#merge)
  + [fasta](#fasta)
  + [validate\_bedfile](#validate_bedfile)
  + [validate](#validate)
  + [downgrade](#downgrade)

# PrimalBedTools CLI

PrimalBedTools provides a command-line interface for working with primer BED files. It offers utilities for manipulating, validating, and analyzing primer designs.

## Installation

Install primalbedtools using pip:

```
pip install primalbedtools
```

or conda:

```
conda install bioconda::primalbedtools
```

## Basic Usage

```
primalbedtools <command> [options]
```

## Commands

### remap

Remap BED file coordinates from one reference to another using a multiple sequence alignment.

```
primalbedtools remap --bed <bed_file> --msa <msa_file> --from_id <source_id> --to_id <target_id>
```

**Arguments:**

* `--bed`: Input BED file (required)
* `--msa`: Multiple sequence alignment file (required)
* `--from_id`: Source sequence ID to remap from (required)
* `--to_id`: Target sequence ID to remap to (required)

**Example:**

```
primalbedtools remap --bed primers.bed --msa alignment.fasta --from_id MN908947.3 --to_id BA.2
```

### sort

Sort BED file by chromosome, amplicon number, and primer direction.

```
primalbedtools sort <bed_file>
```

**Arguments:**

* `bed`: Input BED file

**Example:**

```
primalbedtools sort primers.bed > primers.sorted.bed
```

### update

Update primer names to v2 format (`prefix_number_DIRECTION_index`).

```
primalbedtools update <bed_file>
```

**Arguments:**

* `bed`: Input BED file

**Example:**

```
primalbedtools update primers.v1.bed > primers.v2.bed
```

### amplicon

Generate amplicon information from primer pairs.

```
primalbedtools amplicon <bed_file> [--primertrim]
```

**Arguments:**

* `bed`: Input BED file
* `-t, --primertrim`: Generate primer-trimmed amplicon information

**Example:**

```
primalbedtools amplicon primers.bed > amplicons.txt
primalbedtools amplicon primers.bed --primertrim > trimmed_amplicons.txt
```

### merge

Merge primers with the same properties (chromosome, amplicon number, direction).

```
primalbedtools merge <bed_file>
```

**Arguments:**

* `bed`: Input BED file

**Example:**

```
primalbedtools merge primers.bed > primers.merged.bed
```

### fasta

Convert BED file to FASTA format.

```
primalbedtools fasta <bed_file>
```

**Arguments:**

* `bed`: Input BED file

**Example:**

```
primalbedtools fasta primers.bed > primers.fasta
```

### validate\_bedfile

Validate a BED file for internal consistency (correct primer pairings, etc.).

```
primalbedtools validate_bedfile <bed_file>
```

**Arguments:**

* `bed`: Input BED file

**Example:**

```
primalbedtools validate_bedfile primers.bed
```

### validate

Validate a BED file against a reference genome.

```
primalbedtools validate <bed_file> <fasta_file>
```

**Arguments:**

* `bed`: Input BED file
* `fasta`: Reference FASTA file

**Example:**

```
primalbedtools validate primers.bed reference.fasta
```

### downgrade

Downgrade a BED file from v2 to v1 primer name format.

```
primalbedtools downgrade <bed_file> [--merge-alts]
```

**Arguments:**

* `bed`: Input BED file
* `--merge-alts`: Merge alternative primers (removes \_alt suffixes)

**Example:**

```
# Downgrade with alternative primers
primalbedtools downgrade primers.v2.bed > primers.v1.bed

# Downgrade without alternative primers
primalbedtools downgrade primers.v2.bed --merge-alts > primers.v1.merged.bed
```

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)