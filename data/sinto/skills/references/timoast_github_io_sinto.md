sinto

* [Installation](installation.html)
* [User guide](basic_usage.html)
* [Processing scATAC-seq data](scatac.html)

sinto

* Sinto: single-cell analysis tools
* [View page source](_sources/index.rst.txt)

---

# Sinto: single-cell analysis tools[](#sinto-single-cell-analysis-tools "Link to this heading")

[![https://github.com/timoast/sinto/workflows/pytest/badge.svg](https://github.com/timoast/sinto/workflows/pytest/badge.svg)](https://github.com/timoast/sinto/actions)
[![https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat)](http://bioconda.github.io/recipes/sinto/README.html)
[![https://badge.fury.io/py/sinto.svg](https://badge.fury.io/py/sinto.svg)](https://badge.fury.io/py/sinto)
[![https://pepy.tech/badge/sinto](https://pepy.tech/badge/sinto)](https://pepy.tech/project/sinto)

Sinto is a toolkit for processing aligned single-cell data. Sinto includes functions to:

* Subset reads from a BAM file by cell barcode
* Create a scATAC-seq fragments file from a BAM file
* Add read tags to a BAM file according to cell barcode information
* Add read groups based on read tags
* Copy or move read tags to another read tag
* Copy cell barcodes to/from read names or read tags
* Add cell barcodes to FASTQ read names

Report issues and view source code [here](https://github.com/timoast/sinto).

Major version changes indicate new functionality
or breaking changes to existing functionality.

Minor version changes indicate bug fixes or
performance improvements to existing functionality
without breaking compatibility with previous versions.

## Version 0.10[](#version-0-10 "Link to this heading")

### 0.10.1[](#id1 "Link to this heading")

* Fixed bug in gzip file loading (<https://github.com/timoast/sinto/issues/67>)
* Fixed `NoneType` errors in `barcode` function (<https://github.com/timoast/sinto/pull/65>; @bgruening)

### 0.10.0[](#id2 "Link to this heading")

* Add ability to perform barcode correction in `barcode` (<https://github.com/timoast/sinto/pull/61>; @dawe)

## Version 0.9[](#version-0-9 "Link to this heading")

### 0.9.0[](#id3 "Link to this heading")

* Add `blocks` command to create block file from BAM file.

## Version 0.8[](#version-0-8 "Link to this heading")

### 0.8.4[](#id4 "Link to this heading")

* Include unmapped reads in output of `filterbarcodes` (<https://github.com/timoast/sinto/issues/55>)

### 0.8.3[](#id5 "Link to this heading")

* Fixed bug in BAM file chunking that caused some entries to be duplicated (<https://github.com/timoast/sinto/issues/51>)
* Properly set minimum Python version (<https://github.com/timoast/sinto/issues/53>)
* Fix bug in `filterbarcodes` when no `RG` tags in BAM file (<https://github.com/timoast/sinto/issues/52>)

### 0.8.2[](#id6 "Link to this heading")

* Fixed bug in `filterbarcodes` when cell barcode in the middle of the read name (<https://github.com/timoast/sinto/issues/46>)

### 0.8.1[](#id7 "Link to this heading")

* Fixed bug in `nametotag` when cell barcode in the middle of the read name (<https://github.com/timoast/sinto/issues/46>)
* Remove need for samtools in path (<https://github.com/timoast/sinto/issues/41>)
* Added `--outdir` parameter to `filterbarcodes`
* Added `--sam` parameter to `filterbarcodes`
* Fixed bug in `filterbarcodes` and `addtags` causing read groups to be modified (<https://github.com/timoast/sinto/issues/17>)

### 0.8.0[](#id8 "Link to this heading")

* Added `tagtoname` and `nametotag` commands to copy cell barcodes to/from read tags or read names

## Version 0.7[](#version-0-7 "Link to this heading")

### 0.7.6[](#id9 "Link to this heading")

* Added `--collapse_within` parameter to `fragments` function to enable only collapsing PCR duplicates if the cell barcode is the same (<https://github.com/timoast/sinto/issues/36>)
* Added tests for `fragments` function and associated small test dataset

### 0.7.5[](#id10 "Link to this heading")

* Added `--shift_plus` and `--shift_minus` parameters to configure Tn5 shift applied in `fragments` function (<https://github.com/timoast/sinto/issues/33>)

### 0.7.4[](#id11 "Link to this heading")

* Fixed bug causing some fragments at the end of contigs to be dropped (<https://github.com/timoast/sinto/issues/31>)

### 0.7.3[](#id12 "Link to this heading")

* Fixed error in soft clipping for `fragments` function (<https://github.com/timoast/sinto/issues/29>)

### 0.7.2[](#id13 "Link to this heading")

* Added `min_distance` parameter to `fragments`
* Fixed bug in soft clipping for `fragments` function

### 0.7.1[](#id14 "Link to this heading")

* Code style update for `tagtotag` and `tagtorg`
* Fix bug in `filterbarcodes` and `addtags` that caused lines in BAM header to be duplicated (<https://github.com/timoast/sinto/issues/15>)

### 0.7.0[](#id15 "Link to this heading")

* New `tagtotag` function to copy or move read tags

## Version 0.6[](#version-0-6 "Link to this heading")

### 0.6.1[](#id16 "Link to this heading")

* Bug fixes for `barcode` function
* Allow running `barcode` on unzipped FASTQ files

### 0.6.0[](#id17 "Link to this heading")

* New `barcode` function to add cell barcodes to read names in FASTQ file

## Version 0.5[](#version-0-5 "Link to this heading")

### 0.5.1[](#id18 "Link to this heading")

* Fix bug in `utils.read_cell_barcode_file` when same cell appears on multiple lines

### 0.5.0[](#id19 "Link to this heading")

* Add `tagtorg` command to add read groups to BAM according to cell barcode.

## Version 0.4[](#version-0-4 "Link to this heading")

### 0.4.3[](#id20 "Link to this heading")

* Throw error if file is not present for `filterbarcodes` and `addtags`

### 0.4.2[](#id21 "Link to this heading")

* Fix bug when cell barcode is None for `fragments` function.

### 0.4.1[](#id22 "Link to this heading")

* Increase recursion limit to prevent error when running on genomes
  with >1000 scaffolds.

### 0.4.0[](#id23 "Link to this heading")

* Removed `sam` parameter from `filterbarcodes`
* Allow multiple groups of cells to be specified in `filterbarcodes`.
  This will create a separate BAM file for each unique group of cells.

## Version 0.3[](#version-0-3 "Link to this heading")

### 0.3.4[](#id24 "Link to this heading")

* Memory improvements for `fragments` function

### 0.3.3[](#id25 "Link to this heading")

* Bug fix for `fragments` function when using chromosome containing zero fragments

### 0.3.2[](#id26 "Link to this heading")

* Added `--barcodetag` and `--barcode_regex` arguments to `filterbarcodes`

### 0.3.1[](#id27 "Link to this heading")

* Better handling of BAM file opening/closing
* Add `max_distance` parameter to `fragments` to remove fragments over a certain length

### 0.3.0[](#id28 "Link to this heading")

* added `fragments` function to create scATAC fragment file from BAM file
* removed use of versioneer for version tracking

## Version 0.2[](#version-0-2 "Link to this heading")

* added `addtags` function to add read tags to BAM file for different groups of cells

## Version 0.1[](#version-0-1 "Link to this heading")

First release. Functionality:

* `filterbarcodes`

[Next](installation.html "Installation")

---

© Copyright 2020, Tim Stuart, Warren W. Kretzschmar.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).