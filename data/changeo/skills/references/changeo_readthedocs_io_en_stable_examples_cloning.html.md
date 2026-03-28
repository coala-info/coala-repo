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

* [Using IgBLAST](igblast.html)
* [Parsing IMGT output](imgt.html)
* [Parsing 10X Genomics V(D)J data](10x.html)
* [Filtering records](filtering.html)
* Clustering sequences into clonal groups
  + [Example data](#example-data)
  + [Determining a clustering threshold](#determining-a-clustering-threshold)
  + [Assigning clones](#assigning-clones)
* [Reconstructing germline sequences](germlines.html)
* [Generating MiAIRR compliant GenBank/TLS submissions](genbank.html)

Methods

* [Clonal clustering methods](../methods/clustering.html)
* [Reconstruction of germline sequences from alignment data](../methods/germlines.html)

About

* [Contact](../info.html)
* [Citation](../info.html#citation)
* [License](../info.html#license)

[changeo](../index.html)

* Clustering sequences into clonal groups
* [View page source](../_sources/examples/cloning.rst.txt)

---

# Clustering sequences into clonal groups[](#clustering-sequences-into-clonal-groups "Link to this heading")

## Example data[](#example-data "Link to this heading")

We have hosted a small example data set resulting from the
[UMI barcoded MiSeq workflow](https://presto.readthedocs.io/en/stable/workflows/Stern2014_Workflow.html)
described in the [pRESTO](http://presto.readthedocs.io) documentation. The files can be
downloded from here:

[Change-O Example Files](http://clip.med.yale.edu/immcantation/examples/AIRR_Example.tar.gz)

The following examples use the `HD13M_db-pass.tsv` database file provided in
the example bundle, which has already undergone the [IMGT](imgt.html#imgt)/[IgBLAST](igblast.html#igblast)
parsing and [filtering](filtering.html#filtering-functional) operations.

## Determining a clustering threshold[](#determining-a-clustering-threshold "Link to this heading")

Before running [DefineClones.py](../tools/DefineClones.html#defineclones), it is important to determine an
appropriate threshold for trimming the hierarchical clustering into B cell
clones. The [distToNearest](http://shazam.readthedocs.io/en/stable/vignettes/DistToNearest-Vignette)
function in the [SHazaM](http://shazam.readthedocs.io) R package calculates
the distance between each sequence in the data and its nearest-neighbor. The
resulting distribution should be bimodal, with the first mode representing sequences
with clonal relatives in the dataset and the second mode representing singletons.
The ideal threshold for separating clonal groups is the value that separates
the two modes of this distribution and can be found using the
[findThreshold](http://shazam.readthedocs.io/en/stable/vignettes/DistToNearest-Vignette)
function in the [SHazaM](http://shazam.readthedocs.io) R package. The
[distToNearest](http://shazam.readthedocs.io/en/stable/vignettes/DistToNearest-Vignette)
function allows selection of all parameters that are available in [DefineClones.py](../tools/DefineClones.html#defineclones).
Using the length normalization parameter ensures that mutations are weighted equally
regardless of junction sequence length. The distance to nearest-neighbor distribution
for the example data is shown below. The threshold is approximately `0.16` - indicated
by the red dotted line.

[![../_images/cloning_threshold.svg](../_images/cloning_threshold.svg)](../_images/cloning_threshold.svg)

See also

For additional details see the vignette on
[tuning clonal assignment thresholds](http://shazam.readthedocs.io/en/stable/vignettes/DistToNearest-Vignette).

## Assigning clones[](#assigning-clones "Link to this heading")

There are several parameter choices when grouping Ig sequences into B cell
clones. The argument `--act set`
accounts for ambiguous V gene and J gene calls when grouping similar sequences. The
distance metric `--model ham`
is nucleotide Hamming distance. Because the threshold was generated using length
normalized distances, the `--norm len` argument is
selected with the previously determined threshold `--dist 0.16`:

```
DefineClones.py -d HD13M_db-pass.tsv --act set --model ham \
    --norm len --dist 0.16
```

Note

Because T cells don’t undergo SHM, non-zero nucleotide distances suggest sequences
orginate from a different ancestor. To identify TCR clones, use –dist 0 or a
very low distance value to allow for sequencing error.

[Previous](filtering.html "Filtering records")
[Next](germlines.html "Reconstructing germline sequences")

---

© Copyright Kleinstein Lab, Yale University, 2025.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).