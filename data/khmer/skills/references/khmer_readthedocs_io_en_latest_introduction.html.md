### Navigation

* [index](genindex.html "General Index")
* [next](contributors.html "Contributors and Acknowledgements") |
* [previous](index.html "The khmer software for advanced biological sequencing data analysis") |
* [khmer 3.0.0a1+98.gfe0ce11 documentation](index.html) »

## Contents

* Introduction to khmer
  + [Introduction](#introduction)
  + [Using khmer](#using-khmer)
  + [Practical considerations](#practical-considerations)
  + [Copyright and license](#copyright-and-license)

#### Previous topic

[The khmer software for advanced biological sequencing data analysis](index.html "previous chapter")

#### Next topic

[Contributors and Acknowledgements](contributors.html "next chapter")

### This Page

* [Show Source](_sources/introduction.rst.txt)

1. [Docs](index.html)
2. Introduction to khmer

# Introduction to khmer[¶](#introduction-to-khmer "Permalink to this headline")

## Introduction[¶](#introduction "Permalink to this headline")

khmer is a software library and toolkit for k-mer based analysis and transformation of nucleotide sequence data.
The primary focus of development has been scaling assembly of metagenomes and transcriptomes.

khmer supports a number of transformations, both inexact transformations (abundance filtering; error trimming) and exact transformations (graph-size filtering, to throw away disconnected reads; partitioning, to split reads into disjoint sets).
All of these transformations operate with constant memory consumption (with the exception of partitioning), and typically require less memory than is required to assemble the data.

Most of khmer is built around a single underlying probabilistic data structure known as a [Bloom filter](http://en.wikipedia.org/wiki/Bloom_filter) (also see [Count-Min Sketch](http://dimacs.rutgers.edu/~graham/pubs/papers/cm-full.pdf) and [These Are Not The k-mers You’re Looking For](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4111482/)).
In khmer this data structure is implemented as a set of hash tables, each of different size, with no collision detection.
These hash tables can store either the presence (Bloom filter) or frequency (Count-Min Sketch) of specific k-mers.
The lack of collision detection means that the data structure may report a k-mer as being *present* when it is not, in fact, in the data set.
However, it will never incorrectly report a k-mer as being absent when it *truly is* present.
This one-sided error makes the Bloom filter very useful for certain kinds of operations.

khmer supports arbitrarily large k-sizes, although certain graph-based operations are limited to k <= 32.

The khmer core library is implemented in C++, while all of the khmer scripts and tests access the core library via a Python wrapper.

Tutorials highlighting khmer are available at [khmer-protocols](http://khmer-protocols.readthedocs.io) and [khmer-recipes](http://khmer-recipes.readthedocs.io).
The former provides detailed protocols for using khmer to analyze either a transcriptome or a metagenome.
The latter provides individual recipes for using khmer in a variety of sequence-oriented tasks such as extracting reads by coverage, estimating a genome or metagenome size from unassembled reads, and error-trimming reads via streaming k-mer abundance.

## Using khmer[¶](#using-khmer "Permalink to this headline")

khmer comes “out of the box” with a number of scripts that make it immediately useful for a few different operations, including (but not limited to) the following.

> * normalizing read coverage (“digital normalization”)
> * dividing reads into disjoint sets that do not connect (“partitioning”)
> * eliminating reads that will not be used by a de Bruijn graph assembler;
> * removing reads with low- or high-abundance k-mers;
> * trimming reads of certain kinds of sequencing errors;
> * counting k-mers and estimating data set coverage based on k-mer counts;
> * running Velvet and calculating assembly statistics;
> * converting FASTQ to FASTA;
> * converting between paired and interleaved formats for paired FASTQ data

## Practical considerations[¶](#practical-considerations "Permalink to this headline")

The most important thing to think about when using khmer is whether or not the transformation or filter you’re applying is appropriate for the data you’re trying to assemble.
For example, two of the most powerful operations available in khmer, graph-size filtering and graph partitioning, only make sense for assembly datasets with many theoretically unconnected components.
This is typical of metagenomic data sets.
Also, while digital normalization can be helpful for transcriptome *assembly*, it is inappropriate for other RNA-seq applications, such as differential expression analysis, that rely on signal from variable coverage.

The second most important consideration is memory usage.
The effectiveness of all of the Bloom filter-based functions (which is everything interesting in khmer!) depends critically on having enough memory to do a good job.
See [Setting khmer memory usage](user/choosing-table-sizes.html) for more information.

## Copyright and license[¶](#copyright-and-license "Permalink to this headline")

Portions of khmer are Copyright California Institute of Technology, where the exact counting code was first developed.
All other code developed through 2014 is copyright Michigan State University.
Portions are copyright Michigan State University and Regents of the University of California.
All the code is freely available for use and re-use under the BSD License.
Distribution, modification and redistribution, incorporation into other software, and pretty much everything else is allowed.

Please enable JavaScript to view the [comments powered by Disqus.](http://disqus.com/?ref_noscript)
[comments powered by Disqus](http://disqus.com)

[The khmer software for advanced biological sequencing data analysis](index.html "previous chapter (use the left arrow)")

[Contributors and Acknowledgements](contributors.html "next chapter (use the right arrow)")

### Navigation

* [index](genindex.html "General Index")
* [next](contributors.html "Contributors and Acknowledgements") |
* [previous](index.html "The khmer software for advanced biological sequencing data analysis") |
* [khmer 3.0.0a1+98.gfe0ce11 documentation](index.html) »

© Copyright 2010-2014 the authors.. Created using [Sphinx](http://sphinx.pocoo.org/).