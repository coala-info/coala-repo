[phyluce](index.html)

Contents:

* Purpose
  + [Longer-term goals (v2.0.0+ and beyond)](#longer-term-goals-v2-0-0-and-beyond)
  + [Who wrote this?](#who-wrote-this)
  + [How do I report bugs?](#how-do-i-report-bugs)
* [Installation](installation.html)
* [Phyluce Tutorials](tutorials/index.html)
* [Phyluce in Daily Use](daily-use/index.html)

* [Citing](citing.html)
* [License](license.html)
* [Attributions](attributions.html)
* [Funding](funding.html)
* [Acknowledgements](ack.html)

[phyluce](index.html)

* Purpose
* [View page source](_sources/purpose.rst.txt)

---

# Purpose[](#purpose "Link to this heading")

[Phylogenomics](http://en.wikipedia.org/wiki/Phylogenomics) offers the possibility of helping to resolve the [Tree of
Life](http://en.wikipedia.org/wiki/Tree_of_Life). To do this, we often need either very cheap sources of organismal
genome data or decent methods of subsetting larger genomes (e.g., vertebrates; 1
Gbp) such that we can collect data from across the genome in an efficient and
economical fashion, find the regions of each genome that are shared among
organisms, and attempt to infer the evolutionary history of the organisms in
which we’re interested using the data we collect.

Genome reduction techniques offer one way to collect these types of data from
both small- and large-genome organisms. These “reduction” techniques include
various flavors of [amplicon sequencing](http://www.ncbi.nlm.nih.gov/pubmed/18274529), [RAD-seq](http://en.wikipedia.org/wiki/Restriction_site_associated_DNA_markers) (**R**estriction site
**A**ssociated **D**NA markers), [RNA-seq](http://en.wikipedia.org/wiki/RNA-Seq) (transcriptome sequencing), and
sequence capture methods.

[phyluce](https://github.com/faircloth-lab/phyluce) is a software package for working with data generated from sequence
capture of UCE (**u**ltra-**c**onserved **e**lement) loci, as first
published in [[BCF2012]](citing.html#bcf2012). Specifically, [phyluce](https://github.com/faircloth-lab/phyluce) is a suite of programs to:

* assemble raw sequence reads from Illumina platforms into contigs
* determine which contigs represent UCE loci
* filter potentially paralagous UCE loci
* generate different sets of UCE loci across taxa of interest

Additionally, [phyluce](https://github.com/faircloth-lab/phyluce) is capable of the following tasks, which are generally
suited to any number of phylogenomic analyses:

* produce large-scale alignments of these loci in parallel
* manipulate alignment data prior to further analysis
* convert alignment data between formats
* compute statistics on alignments and other data

[phyluce](https://github.com/faircloth-lab/phyluce) is written to process data/individuals/samples/species in parallel,
where possible, to speed execution. Parallelism is achieved through the use
of the [Python](http://www.python.org) [multiprocessing](http://docs.python.org/2/library/multiprocessing.html) module, and most computations are suited to
workstation-class machines or servers (i.e., rather than clusters). Where
cluster-based analyses are needed, [phyluce](https://github.com/faircloth-lab/phyluce) will produce the necessary outputs
for input to the cluster/program that you are running so that you can setup
the run according to your cluster design, job scheduling system, etc. Clusters
are simply too heterogenous to do a good job at this part of the analytical
workflow.

## Longer-term goals (v2.0.0+ and beyond)[](#longer-term-goals-v2-0-0-and-beyond "Link to this heading")

We are also working towards adding:

* simplify the [CLI](http://en.wikipedia.org/wiki/Command-line_interface) (command-line interface) of [phyluce](https://github.com/faircloth-lab/phyluce)
* add additioanl `workflows` for multi-step analyses

## Who wrote this?[](#who-wrote-this "Link to this heading")

This documentation was written primarily by Brant Faircloth
(<http://faircloth-lab.org>). Brant is also responsible for the development of
most of the [phyluce](https://github.com/faircloth-lab/phyluce) code. Bugs within the code are usually his.

You can find additional authors and contributors in the [Attributions](attributions.html#attributions)
section.

## How do I report bugs?[](#how-do-i-report-bugs "Link to this heading")

To report a bug, please post an issue to
<https://github.com/faircloth-lab/phyluce/issues>. Please also ensure that you
are using one of the “supported” operating systems and a supported installation
method. Please see the [Installation](installation.html#installation) section for more details.

[Previous](index.html "phyluce: software for UCE (and general) phylogenomics")
[Next](installation.html "Installation")

---

© Copyright 2012-2024, Brant C. Faircloth.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).