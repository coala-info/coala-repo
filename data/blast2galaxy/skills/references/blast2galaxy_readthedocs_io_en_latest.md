[ ]
[ ]

[Skip to content](#blast2galaxy-documentation)

blast2galaxy Documentation

Introduction

[blast2galaxy](https://github.com/IPK-BIT/blast2galaxy "Go to repository")

blast2galaxy Documentation

[blast2galaxy](https://github.com/IPK-BIT/blast2galaxy "Go to repository")

* [ ]
  [Introduction](.)
* [Installation](installation/)
* [Configuration](configuration/)
* [ ]

  Usage

  Usage
  + [CLI Usage](usage_cli/)
  + [API Usage](usage_api/)
* [Tutorial](tutorial/)
* [CLI Reference](cli/)
* [API Reference](api/)

# blast2galaxy Documentation

* blast2galaxy provides a Python API and CLI to perform BLAST+ and DIAMOND queries against Galaxy servers that have the NCBI BLAST+ tools [[1]](#1) and/or DIAMOND [[2]](#2) installed
* It is available as:

  + [PyPI package (pip)](https://pypi.org/project/blast2galaxy/)
  + [Bioconda package](https://bioconda.github.io/recipes/blast2galaxy/README.html)
  + [Biocontainers image](https://quay.io/repository/biocontainers/blast2galaxy?tab=tags)
* blast2galaxy is tested to be working with the following Python versions: `3.10`, `3.11`, `3.12`
* Please read the [CLI Reference](cli/) if you want to use blast2galaxy on the command line as drop-in replacement for NCBI BLAST+ tools or DIAMOND
  or read the [API Reference](api/) if you want to use blast2galaxy inside a Python application to perform BLAST or DIAMOND queries against a Galaxy server.

![Screenshot](figure_1_v3.png)

### References

[1] Peter J. A. Cock, John M. Chilton, Björn Grüning, James E. Johnson, Nicola Soranzo, NCBI BLAST+ integrated into Galaxy, GigaScience, Volume 4, Issue 1, December 2015, s13742-015-0080-7, <https://doi.org/10.1186/s13742-015-0080-7>

[2] Buchfink, B., Reuter, K. & Drost, HG. Sensitive protein alignments at tree-of-life scale using DIAMOND. Nat Methods 18, 366–368 (2021). <https://doi.org/10.1038/s41592-021-01101-x>

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)