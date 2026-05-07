[ ]
[ ]

[Skip to content](#assembly_finder)

assembly finder

Home

Initializing search

[metagenlab/assembly\_finder](https://github.com/metagenlab/assembly_finder "Go to repository")

assembly finder

[metagenlab/assembly\_finder](https://github.com/metagenlab/assembly_finder "Go to repository")

* [ ]

  Home

  [Home](.)

  Table of contents
  + [Installation](#installation)
  + [Usage](#usage)

    - [Taxon](#taxon)
    - [Taxa](#taxa)
    - [Accessions](#accessions)
  + [Command-line options](#command-line-options)
* [Inputs](inputs/)
* [Outputs](outputs/)
* [Examples](examples/)

Table of contents

* [Installation](#installation)
* [Usage](#usage)

  + [Taxon](#taxon)
  + [Taxa](#taxa)
  + [Accessions](#accessions)
* [Command-line options](#command-line-options)

# assembly\_finder

[![tests](https://github.com/metagenlab/assembly_finder/actions/workflows/unit-tests.yml/badge.svg)](https://github.com/metagenlab/assembly_finder/actions/workflows/unit-tests.yml)
[![docs](https://github.com/metagenlab/assembly_finder/actions/workflows/build-docs.yml/badge.svg)](https://github.com/metagenlab/assembly_finder/actions/workflows/build-docs.yml)
[![docker](https://github.com/metagenlab/assembly_finder/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/metagenlab/assembly_finder/actions/workflows/docker-publish.yml)

[![snaketool](https://img.shields.io/static/v1?label=CLI&message=Snaketool&color=blueviolet)](https://github.com/beardymcjohnface/Snaketool)
[![license](https://img.shields.io/github/license/metagenlab/assembly_finder.svg)](https://github.com/metagenlab/assembly_finder/blob/main/LICENSE)
[![version](https://img.shields.io/conda/vn/bioconda/assembly_finder)](http://bioconda.github.io/recipes/assembly_finder/README.html)
[![downloads](https://img.shields.io/conda/dn/bioconda/assembly_finder)](https://anaconda.org/bioconda/assembly_finder)

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.13353494.svg)](https://zenodo.org/doi/10.5281/zenodo.13353494)

`assembly_finder` is a [Snakemake](https://github.com/snakemake/snakemake) CLI wrapper for [NCBI datasets](https://github.com/ncbi/datasets), written with [Snaketool](https://github.com/beardymcjohnface/Snaketool), for easy genome assembly downloads.

## Installation

## Usage

### Taxon

* Download staphylococcus aureus **reference genome**

```
assembly_finder -i staphylococcus_aureus --reference
```

or

```
assembly_finder -i 1280 -r
```

### Taxa

* Find reference genomes for multiple taxa

```
assembly_finder -i 1290,1813735,114185 --reference
```

or

```
assembly_finder -i taxa.txt --reference
```

with `taxa.txt`:

```
1280
1813735
114185
```

### Accessions

* Download staphylococcus aureus **reference genome** using its assembly accession

```
assembly_finder --acc -i GCF_000013425.1
```

* Download multiple accessions

```
assembly_finder --acc -i GCF_003812505.1,GCF_001618865.1,GCF_000287275.1
```

or

```
assembly_finder -i accessions.txt
```

with `accessions.txt`:

```
GCF_003812505.1
GCF_001618865.1
GCF_000287275.1
```

## Command-line options

![assembly_finder -h](images/af-help.svg)

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)