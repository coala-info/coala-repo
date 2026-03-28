[changeo
![Logo](../_static/changeo.png)](../index.html)

* [Immcantation Portal](http://immcantation.readthedocs.io)

Getting Started

* [Overview](../overview.html)
* [Download](../install.html)
* [Installation](../install.html#installation)
* [Contributing](../contributing.html)
* [Data Standards](../standard.html)
* [Release Notes](../news.html)

Usage Documentation

* [Commandline Usage](../usage.html)
* [API](../api.html)

Examples

* [Using IgBLAST](../examples/igblast.html)
* [Parsing IMGT output](../examples/imgt.html)
* [Parsing 10X Genomics V(D)J data](../examples/10x.html)
* [Filtering records](../examples/filtering.html)
* [Clustering sequences into clonal groups](../examples/cloning.html)
* [Reconstructing germline sequences](../examples/germlines.html)
* [Generating MiAIRR compliant GenBank/TLS submissions](../examples/genbank.html)

Methods

* [Clonal clustering methods](clustering.html)
* Reconstruction of germline sequences from alignment data

About

* [Contact](../info.html)
* [Citation](../info.html#citation)
* [License](../info.html#license)

[changeo](../index.html)

* Reconstruction of germline sequences from alignment data
* [View page source](../_sources/methods/germlines.rst.txt)

---

# Reconstruction of germline sequences from alignment data[](#reconstruction-of-germline-sequences-from-alignment-data "Link to this heading")

The [CreateGermlines.py](../tools/CreateGermlines.html#creategermlines) tool takes the individual segment alignment information for
each sequence and reconstructs a full length germline sequence from the V(D)J
reference sequences.

To reconstruct the germline, [CreateGermlines.py](../tools/CreateGermlines.html#creategermlines) trims V(D)J germline segments
and N/P regions by alignment length and concatenates them together. It puts Ns
in the untemplated N/P regions and optionally masks the D with Ns
(`-g dmask`). [CreateGermlines.py](../tools/CreateGermlines.html#creategermlines) also looks for and
corrects cases where the alignment tool assigned the same part of the input sequence
to two different regions (eg, assigning the same nucleotides to N/P and J).

At the end of the germline reconstruction process, each sequence has been assigned
a germline specific to the sequence.

When the (`--cloned`) flag is specified, the
process is the same except it is clone specific and results in the
creation of one germline per clone. [CreateGermlines.py](../tools/CreateGermlines.html#creategermlines) selects first a
single V and J allele to use as the germline from all the assigned
annotations in each clone. The selection is made by simple majority rule of all
the allele calls in the clone. After the germline reconstruction process, all
sequences belonging to the same clone have been assigned the same germline.

[Previous](clustering.html "Clonal clustering methods")
[Next](../info.html "Contact")

---

© Copyright Kleinstein Lab, Yale University, 2025.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).