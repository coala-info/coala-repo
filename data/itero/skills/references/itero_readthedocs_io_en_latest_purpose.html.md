[itero](index.html)

latest

Contents:

* Purpose
  + [Who wrote this?](#who-wrote-this)
  + [How do I report bugs?](#how-do-i-report-bugs)
* [Installation](installation.html)
* [Running itero](running.html)

* [License](license.html)
* [Changelog](changelog.html)
* [Funding](funding.html)

[itero](index.html)

* [Docs](index.html) »
* Purpose
* [Edit on GitHub](https://github.com/faircloth-lab/itero/blob/master/docs/purpose.rst)

---

# Purpose[¶](#purpose "Permalink to this headline")

[itero](https://github.com/faircloth-lab/itero) is a program what wraps a workflow for guided- or reference-based assembly of target enrichment data. This approach to assembly is also “iterative”, meaning that the assembly proceeds through several, iterations (hence “itero”). I wrote [itero](https://github.com/faircloth-lab/itero) for a variety of reasons:

* “traditional” DNA assembly programs performed poorly with target enrichment data (from UCE loci)
* existing DNA assembly approaches had relatively high assembly error
* existing guided assembly programs were hard to install and run
* some existing guided assembly programs were **slow**

[itero](https://github.com/faircloth-lab/itero) attempts to fix some of these problems. At its heart, [itero](https://github.com/faircloth-lab/itero) uses an input file of “seeds”, against which it will try to assemble raw-read data from [Illumina](http://www.illumina.com/) instruments. Alignment of reads-to-seeds uses [bwa](http://bio-bwa.sourceforge.net/), the BAM file is split with [samtools](http://www.htslib.org/) and [bedtools](http://bedtools.readthedocs.io/en/latest/), and locus-specific reads are then assembled using [spades](http://bioinf.spbau.ru/spades) (with error correction turned on during the final round). Then, the entire process repeats itself.

To increase assembly speed, [itero](https://github.com/faircloth-lab/itero) takes advantage of multiple cores (on single nodes) using [python](http://www.python.org) multiprocessing and MPI (on HPC systems) using the excellent [schwimmbad](https://github.com/adrn/schwimmbad) library.

## Who wrote this?[¶](#who-wrote-this "Permalink to this headline")

This documentation was written primarily by Brant Faircloth
(<http://faircloth-lab.org>). Brant is also responsible for the development of
most of the [itero](https://github.com/faircloth-lab/itero) code. Bugs within the code are usually his.

## How do I report bugs?[¶](#how-do-i-report-bugs "Permalink to this headline")

To report a bug, please post an issue to
<https://github.com/faircloth-lab/itero/issues>. Please also ensure that you
are using one of the “supported” platforms:

* Apple OSX 10.9.x
* CentOS 7.x

and that you have installed [itero](https://github.com/faircloth-lab/itero) and dependencies using [conda](http://docs.continuum.io/conda/), as described
in the [Installation](installation.html#installation) section.

[Next](installation.html "Installation")
 [Previous](index.html "itero: guided contig assembly for target enrichment data")

---

© Copyright 2018, Brant C. Faircloth
Revision `25c7fb69`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).