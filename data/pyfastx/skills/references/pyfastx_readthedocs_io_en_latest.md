pyfastx

Contents:

* [Installation](installation.html)
* [FASTX](usage.html)
* [FASTA](usage.html#fasta)
* [Sequence](usage.html#sequence)
* [FASTQ](usage.html#fastq)
* [Read](usage.html#read)
* [FastaKeys](usage.html#fastakeys)
* [FastqKeys](usage.html#fastqkeys)
* [Command line interface](commandline.html)
* [Multiple processes](advance.html)
* [Drawbacks](drawbacks.html)
* [Changelog](changelog.html)
* [API Reference](api_reference.html)
* [Acknowledgements](acknowledgements.html)

pyfastx

* Welcome to pyfastx’s documentation!
* [View page source](_sources/index.rst.txt)

---

# Welcome to pyfastx’s documentation![](#welcome-to-pyfastx-s-documentation "Link to this heading")

[![Action](https://github.com/lmdu/pyfastx/actions/workflows/main.yml/badge.svg)](https://github.com/lmdu/pyfastx/actions/workflows/main.yml)
[![Readthedocs](https://readthedocs.org/projects/pyfastx/badge/?version=latest)](https://pyfastx.readthedocs.io/en/latest/?badge=latest)
[![Codecov](https://codecov.io/gh/lmdu/pyfastx/branch/master/graph/badge.svg)](https://codecov.io/gh/lmdu/pyfastx)
[![PyPI](https://img.shields.io/pypi/v/pyfastx.svg)](https://pypi.org/project/pyfastx)
[![Pyver](https://img.shields.io/pypi/pyversions/pyfastx.svg)](https://pypi.org/project/pyfastx)
[![Wheel](https://img.shields.io/pypi/wheel/pyfastx.svg)](https://pypi.org/project/pyfastx)
[![Codacy](https://api.codacy.com/project/badge/Grade/80790fa30f444d9d9ece43689d512dae)](https://app.codacy.com/gh/lmdu/pyfastx/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
[![Language](https://img.shields.io/pypi/implementation/pyfastx)](https://pypi.org/project/pyfastx)
[![Downloads](https://img.shields.io/pypi/dm/pyfastx)](https://pypi.org/project/pyfastx)
[![License](https://img.shields.io/pypi/l/pyfastx)](https://pypi.org/project/pyfastx)
[![Bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat)](http://bioconda.github.io/recipes/pyfastx/README.html)

The `pyfastx` is a lightweight Python C extension that enables users to randomly access to sequences from plain and **gzipped** FASTA/Q files. This module aims to provide simple APIs for users to extract sequence from FASTA and reads from FASTQ by identifier and index number. The `pyfastx` will build indexes stored in a sqlite3 database file for random access to avoid consuming excessive amount of memory. In addition, the `pyfastx` can parse standard (*sequence is spread into multiple lines with same length*) and nonstandard (*sequence is spread into one or more lines with different length*) FASTA format. This module used [kseq.h](https://github.com/attractivechaos/klib/blob/master/kseq.h) written by [@attractivechaos](https://github.com/attractivechaos) in [klib](https://github.com/attractivechaos/klib) project to parse plain FASTA/Q file and zran.c written by [@pauldmccarthy](https://github.com/pauldmccarthy) in project [indexed\_gzip](https://github.com/pauldmccarthy/indexed_gzip) to index gzipped file for random access.

This project was heavily inspired by [@mdshw5](https://github.com/mdshw5)’s project [pyfaidx](https://github.com/mdshw5/pyfaidx) and [@brentp](https://github.com/brentp)’s project [pyfasta](https://github.com/brentp/pyfasta).

**Features**

* Single file for the Python extension
* Lightweight, memory efficient for parsing FASTA file
* Fast random access to sequences from **gzipped** FASTA file
* Read sequences from FASTA file line by line
* Calculate assembly N50 and L50
* Calculate GC content and nucleotides composition
* Extract reverse, complement and antisense sequence
* Excellent compatibility, support for parsing nonstandard FASTA file
* Support for random access reads from FASTQ file

Contents:

* [Installation](installation.html)
  + [Install from PyPI](installation.html#install-from-pypi)
  + [Install from source](installation.html#install-from-source)
* [FASTX](usage.html)
  + [Iterate over sequences in FASTA](usage.html#iterate-over-sequences-in-fasta)
  + [Iterate over reads in FASTQ](usage.html#iterate-over-reads-in-fastq)
* [FASTA](usage.html#fasta)
  + [Read FASTA file](usage.html#read-fasta-file)
  + [FASTA records iteration](usage.html#fasta-records-iteration)
  + [Get FASTA information](usage.html#get-fasta-information)
  + [Get longest and shortest sequence](usage.html#get-longest-and-shortest-sequence)
  + [Calculate N50 and L50](usage.html#calculate-n50-and-l50)
  + [Get sequence mean and median length](usage.html#get-sequence-mean-and-median-length)
  + [Get sequence counts](usage.html#get-sequence-counts)
  + [Get subsequences](usage.html#get-subsequences)
  + [Get flank sequences](usage.html#get-flank-sequences)
  + [Key function](usage.html#key-function)
* [Sequence](usage.html#sequence)
  + [Get a sequence from FASTA](usage.html#get-a-sequence-from-fasta)
  + [Get sequence information](usage.html#get-sequence-information)
  + [Sequence slice](usage.html#sequence-slice)
  + [Reverse and complement sequence](usage.html#reverse-and-complement-sequence)
  + [Read sequence line by line](usage.html#read-sequence-line-by-line)
  + [Search for subsequence](usage.html#search-for-subsequence)
* [FASTQ](usage.html#fastq)
  + [Read FASTQ file](usage.html#read-fastq-file)
  + [FASTQ records iteration](usage.html#fastq-records-iteration)
  + [Get FASTQ information](usage.html#get-fastq-information)
* [Read](usage.html#read)
  + [Get read from FASTQ](usage.html#get-read-from-fastq)
  + [Get read information](usage.html#get-read-information)
* [FastaKeys](usage.html#fastakeys)
  + [Get fasta keys](usage.html#get-fasta-keys)
  + [Sort keys](usage.html#sort-keys)
  + [Filter keys](usage.html#filter-keys)
  + [Clear filter and sort order](usage.html#clear-filter-and-sort-order)
* [FastqKeys](usage.html#fastqkeys)
  + [Get fastq keys](usage.html#get-fastq-keys)
* [Command line interface](commandline.html)
  + [Build index](commandline.html#build-index)
  + [Show statistics information](commandline.html#show-statistics-information)
  + [Split FASTA/Q file](commandline.html#split-fasta-q-file)
  + [Convert FASTQ to FASTA file](commandline.html#convert-fastq-to-fasta-file)
  + [Get subsequence with region](commandline.html#get-subsequence-with-region)
  + [Sample sequences](commandline.html#sample-sequences)
  + [Extract sequences](commandline.html#extract-sequences)
* [Multiple processes](advance.html)
  + [Example one](advance.html#example-one)
* [Drawbacks](drawbacks.html)
* [Changelog](changelog.html)
  + [Version 2.1.0 (2024-02-28)](changelog.html#version-2-1-0-2024-02-28)
  + [Version 2.0.2 (2023-11-25)](changelog.html#version-2-0-2-2023-11-25)
  + [Version 2.0.1 (2023-09-18)](changelog.html#version-2-0-1-2023-09-18)
  + [Version 2.0.0 (2023-09-05)](changelog.html#version-2-0-0-2023-09-05)
  + [Version 1.1.0 (2023-04-19)](changelog.html#version-1-1-0-2023-04-19)
  + [Version 1.0.1 (2023-03-28)](changelog.html#version-1-0-1-2023-03-28)
  + [Version 1.0.0 (2023-03-24)](changelog.html#version-1-0-0-2023-03-24)
  + [Version 0.9.1 (2022-12-31)](changelog.html#version-0-9-1-2022-12-31)
  + [Version 0.9.0 (2022-12-30)](changelog.html#version-0-9-0-2022-12-30)
  + [Older versions](changelog.html#older-versions)
* [API Reference](api_reference.html)
  + [pyfastx.version](api_reference.html#pyfastx-version)
  + [pyfastx.Fasta](api_reference.html#pyfastx-fasta)
  + [pyfastx.Sequence](api_reference.html#pyfastx-sequence)
  + [pyfastx.Fastq](api_reference.html#pyfastx-fastq)
  + [pyfastx.Read](api_reference.html#pyfastx-read)
  + [pyfastx.Fastx](api_reference.html#pyfastx-fastx)
  + [pyfastx.FastaKeys](api_reference.html#pyfastx-fastakeys)
  + [pyfastx.FastqKeys](api_reference.html#pyfastx-fastqkeys)
* [Acknowledgements](acknowledgements.html)

# Indices and tables[](#indices-and-tables "Link to this heading")

* [Index](genindex.html)
* [Module Index](py-modindex.html)
* [Search Page](search.html)

[Next](installation.html "Installation")

---

© Copyright 2023, Lianming Du.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).