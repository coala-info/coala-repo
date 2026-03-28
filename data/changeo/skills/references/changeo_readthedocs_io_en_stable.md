changeo
![Logo](_static/changeo.png)

* [Immcantation Portal](http://immcantation.readthedocs.io)

Getting Started

* [Overview](overview.html)
* [Download](install.html)
* [Installation](install.html#installation)
* [Contributing](contributing.html)
* [Data Standards](standard.html)
* [Release Notes](news.html)

Usage Documentation

* [Commandline Usage](usage.html)
* [API](api.html)

Examples

* [Using IgBLAST](examples/igblast.html)
* [Parsing IMGT output](examples/imgt.html)
* [Parsing 10X Genomics V(D)J data](examples/10x.html)
* [Filtering records](examples/filtering.html)
* [Clustering sequences into clonal groups](examples/cloning.html)
* [Reconstructing germline sequences](examples/germlines.html)
* [Generating MiAIRR compliant GenBank/TLS submissions](examples/genbank.html)

Methods

* [Clonal clustering methods](methods/clustering.html)
* [Reconstruction of germline sequences from alignment data](methods/germlines.html)

About

* [Contact](info.html)
* [Citation](info.html#citation)
* [License](info.html#license)

changeo

* Change-O - Repertoire clonal assignment toolkit
* [View page source](_sources/index.rst.txt)

---

Attention

As of v1.0.0 the default file format will be the
[Adaptive Immune Receptor Repertoire (AIRR) Community Rearrangement standard](http://docs.airr-community.org).
The legacy Change-O format will still be supported through the `--format changeo`
argument. See the [Release Notes](news.html#news) for more details.

[![https://img.shields.io/pypi/dm/changeo](https://img.shields.io/pypi/dm/changeo)](https://pypi.org/project/changeo)
[![https://img.shields.io/static/v1?label=AIRR-C%20sw-tools%20v1&message=compliant&color=008AFF&labelColor=000000&style=plastic](https://img.shields.io/static/v1?label=AIRR-C%20sw-tools%20v1&message=compliant&color=008AFF&labelColor=000000&style=plastic)](https://docs.airr-community.org/en/stable/swtools/airr_swtools_standard.html)

# Change-O - Repertoire clonal assignment toolkit[](#change-o-repertoire-clonal-assignment-toolkit "Link to this heading")

Change-O is a collection of tools for processing the output of V(D)J alignment
tools, assigning clonal clusters to immunoglobulin (Ig) sequences, and
reconstructing germline sequences.

Dramatic improvements in high-throughput sequencing technologies now enable
large-scale characterization of Ig repertoires, defined as the collection of
trans-membrane antigen-receptor proteins located on the surface of B cells and
T cells. Change-O is a suite of utilities to facilitate advanced analysis of
Ig and TCR sequences following germline segment assignment. Change-O
handles output from IMGT/HighV-QUEST and IgBLAST, and provides a wide variety of
clustering methods for assigning clonal groups to Ig sequences. Record sorting,
grouping, and various database manipulation operations are also included.

**IMPORTANT!**
Active development of Change-O has moved to <https://github.com/immcantation/changeo>

Getting Started

* [Overview](overview.html)
* [Download](install.html)
* [Installation](install.html#installation)
* [Contributing](contributing.html)
* [Data Standards](standard.html)
* [Release Notes](news.html)

Usage Documentation

* [Commandline Usage](usage.html)
* [API](api.html)

Examples

* [Using IgBLAST](examples/igblast.html)
* [Parsing IMGT output](examples/imgt.html)
* [Parsing 10X Genomics V(D)J data](examples/10x.html)
* [Filtering records](examples/filtering.html)
* [Clustering sequences into clonal groups](examples/cloning.html)
* [Reconstructing germline sequences](examples/germlines.html)
* [Generating MiAIRR compliant GenBank/TLS submissions](examples/genbank.html)

Methods

* [Clonal clustering methods](methods/clustering.html)
* [Reconstruction of germline sequences from alignment data](methods/germlines.html)

About

* [Contact](info.html)
* [Citation](info.html#citation)
* [License](info.html#license)

## Indices[](#indices "Link to this heading")

* [Index](genindex.html)
* [Module Index](py-modindex.html)

[Next](overview.html "Overview")

---

© Copyright Kleinstein Lab, Yale University, 2025.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).