### Navigation

* [index](../genindex.html "General Index")
* [previous](faq.html "FAQ") |
* [bedtools v2.31.0](../index.html) »

# Related software[¶](#related-software "Permalink to this headline")

Bedtools has been used as an engine behind other genomics software and has been
integrated into widely used tools such as Galaxy and IGV. Below is a likely
incomplete list. If you know of others, please let us know, or better yet,
edit the document on GitHub and send us a pull request. You can do this by
clicking on the “Edit and improve this document” link in the lower lefthand
corner.

## IGV[¶](#igv "Permalink to this headline")

Bedtools is now integrated into the IGV genome viewer as of IGV version 2.2. We
are actively working withe IGV development team to improve and expand this
integration. See
[here](http://www.broadinstitute.org/igv/IGV2.2.x)
and
[here](https://www.broadinstitute.org/software/igv/bedtools) for details.

> ![../_images/bedtoolsMenu.png](../_images/bedtoolsMenu.png)

## Galaxy[¶](#galaxy "Permalink to this headline")

[Galaxy](https://main.g2.bx.psu.edu/) has its own tools for working with
genomic intervals under the “Operate on Genomic Intervals” section. A subset
of complementary Bedtools utilities have also been made available on Galaxy in
an effort to provide functionality that isn’t available with the native Galaxy
tools.

> ![../_images/galaxy-bedtools.png](../_images/galaxy-bedtools.png)

## Pybedtools[¶](#pybedtools "Permalink to this headline")

[Pybedtools](http://pypi.python.org/pypi/pybedtools) is a really fantastic
Python library that wraps (and extends upon) the bedtools utilities and exposes
them for easy use and new tool development using Python. Pybedtools is actively
maintained by Ryan Dale.

## MISO[¶](#miso "Permalink to this headline")

[MISO](http://genes.mit.edu/burgelab/miso/) is “a probabilistic framework
that quantitates the expression level of alternatively spliced genes from
RNA-Seq data, and identifies differentially regulated isoforms or exons across
samples.” A subset of the functionality in MISO depends upon `bedtools`. MISO
is developed by Yarden Katz.

## RetroSeq[¶](#retroseq "Permalink to this headline")

[RetroSeq](http://bioinformatics.oxfordjournals.org/content/early/2012/12/10/bioinformatics.bts697.abstract)
is “a tool for discovery and genotyping of transposable element variants (TEVs)
(also known as mobile element insertions) from next-gen sequencing reads aligned
to a reference genome in BAM format”. RetroSeq is developed by Thomas Keane.
Source code can be obtained on [GitHub](https://github.com/tk2/RetroSeq).

## Intersphinx documentation[¶](#intersphinx-documentation "Permalink to this headline")

BEDTools documentation pages are available via Intersphinx (<http://sphinx-doc.org/ext/intersphinx.html>).
To enable this, add the following to conf.py in a Sphinx project:

> intersphinx\_mapping = {‘bedtools’: (’<http://bedtools.readthedocs.org/en/latest/>’, None)}

BEDtools documentation links can then be generated with e.g.:

> [BEDTools:map](https://bedtools.readthedocs.io/en/latest/content/tools/map.html#map "(in bedtools v2.31.0)")

Please enable JavaScript to view the [comments powered by Disqus.](http://disqus.com/?ref_noscript)
[comments powered by Disqus](http://disqus.com)

[![Logo](../_static/bedtools.swiss.png)](../index.html)

### [Table of Contents](../index.html)

* Related software
  + [IGV](#igv)
  + [Galaxy](#galaxy)
  + [Pybedtools](#pybedtools)
  + [MISO](#miso)
  + [RetroSeq](#retroseq)
  + [Intersphinx documentation](#intersphinx-documentation)

#### Previous topic

[FAQ](faq.html "previous chapter")

### This Page

* [Show Source](../_sources/content/related-tools.rst.txt)

### Quick search

### Navigation

* [index](../genindex.html "General Index")
* [previous](faq.html "FAQ") |
* [bedtools v2.31.0](../index.html) »

© Copyright 2009 - 2023, Aaron R. Quinlan.
Last updated on May 29, 2023.