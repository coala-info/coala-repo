[plastid](index.html)

latest

Getting started

* [Getting started](quickstart.html)
* [Tour](tour.html)
* [Installation](installation.html)
* [Demo dataset](test_dataset.html)
* [List of command-line scripts](scriptlist.html)

User manual

* [Tutorials](examples.html)
* [Module documentation](generated/plastid.html)
* [Frequently asked questions](FAQ.html)
* [Glossary of terms](glossary.html)
* [References](zreferences.html)

Developer info

* [Contributing](devinfo/contributing.html)
* [Entrypoints](devinfo/entrypoints.html)

Other information

* [Citing `plastid`](citing.html)
* [License](license.html)
* [Change log](CHANGES.html)
* Related resources
  + [Toolkits for interactive analysis of sequencing data](#toolkits-for-interactive-analysis-of-sequencing-data)
  + [Ribosome profiling](#ribosome-profiling)
  + [Differential gene expression](#differential-gene-expression)
  + [General-purpose manipulation](#general-purpose-manipulation)
  + [Genome browsers](#genome-browsers)
* [Contact](contact.html)

[plastid](index.html)

* »
* Related resources
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/related.rst)

---

# Related resources[¶](#related-resources "Permalink to this headline")

If you are interested in [`plastid`](generated/plastid.html#module-plastid "plastid"), the following projects might also
be helpful for you:

## Toolkits for interactive analysis of sequencing data[¶](#toolkits-for-interactive-analysis-of-sequencing-data "Permalink to this headline")

[Bioconductor](http://www.bioconductor.org/)
:   The [R](http://www.r-project.org) community’s massive toolset for computational biology

[HTSeq](http://www-huber.embl.de/users/anders/HTSeq/doc/overview.html)
:   A Python package designed for analysis of high-throughput
    sequencing data.

[metaseq](https://pythonhosted.org/metaseq/)
:   A Python package for analysis of genomics data. It is very
    similar in intent to [`plastid`](generated/plastid.html#module-plastid "plastid") in that it introduces
    simple, unified APIs to access genomic data of many file
    types. In addition, it includes nice plotting utilities
    for interactive analysis

## Ribosome profiling[¶](#ribosome-profiling "Permalink to this headline")

[ORF-RATER](http://github.com/alexfields/ORF-RATER)
:   Weissman lab tool to annotate potentially overlapping constellations of ORFs
    using ribosome profiling data, an estimate their respective amounts. See
    [[FRJ+15](zreferences.html#id3 "Alexander P. Fields, Edwin H. Rodriguez, Marko Jovanovic, Noam Stern-Ginossar, Brian J. Haas, Philipp Mertins, Raktima Raychowdhury, Nir Hacohen, Steven A. Carr, Nicholas T. Ingolia, Aviv Regev, and Jonathan S. Weissman. A Regression-Based Analysis of Ribosome-Profiling Data Reveals a Conserved Complexity to Mammalian Translation. Molecular Cell, 60(5):816-827, Mar 2015. URL: http://www.cell.com/article/S1097276515009053/abstract (visited on 2015-12-08), doi:10.1016/j.molcel.2015.11.013.")].

[ribogalaxy](http://ribogalaxy.ucc.ie)
:   A web-based platform for analysis of [ribosome profiling](glossary.html#term-ribosome-profiling)
    data, integrating [riboseqr](http://bioconductor.org/packages/release/bioc/html/riboSeqR.html), [galaxy](https://galaxyproject.org/), and other tools.

[riboseqr](http://bioconductor.org/packages/release/bioc/html/riboSeqR.html)
:   A toolkit for analysis of [ribosome profiling](glossary.html#term-ribosome-profiling) data,
    written in [R](http://www.r-project.org). It implements many standard workflows.

## Differential gene expression[¶](#differential-gene-expression "Permalink to this headline")

[DESeq2](http://bioconductor.org/packages/release/bioc/html/DESeq2.html)
:   Statistical models for assessment of differential gene expression,
    applicable to RNA-seq, [ribosome profiling](glossary.html#term-ribosome-profiling), and many other
    types of [high-throughput sequencing](glossary.html#term-high-throughput-sequencing) data

    [DESeq2](http://bioconductor.org/packages/release/bioc/html/DESeq2.html) can be used to test for significant differences in expression
    counts obtained using the [`cs`](generated/plastid.bin.cs.html#module-plastid.bin.cs "plastid.bin.cs") or
    [`counts_in_region`](generated/plastid.bin.counts_in_region.html#module-plastid.bin.counts_in_region "plastid.bin.counts_in_region") scripts

[cufflinks](http://cole-trapnell-lab.github.io/cufflinks/)
:   A software suite for transcript assembly and differential expression
    analysis of RNA-seq data

[kallisto](http://pachterlab.github.io/kallisto/)
:   Software for measurement of gene expression from RNA-seq data

## General-purpose manipulation[¶](#general-purpose-manipulation "Permalink to this headline")

[Samtools](http://www.htslib.org/)
:   Manipulate read alignments in SAM and [BAM](http://samtools.github.io/hts-specs/) files on the command line

[Pysam](http://pysam.readthedocs.io/en/latest/)
:   Python bindings for [Samtools](http://www.htslib.org/). [`plastid`](generated/plastid.html#module-plastid "plastid") uses [Pysam](http://pysam.readthedocs.io/en/latest/) internally
    for parsing of [BAM](http://samtools.github.io/hts-specs/) and [tabix](http://samtools.github.io/hts-specs/)-compressed files

[bedtools](http://bedtools.readthedocs.io/)
:   Fast command-line tools that perform arithmetic on annotations of continuous
    genomic features, and that count read coverage and/or other properties
    for those regions

[pybedtools](https://pythonhosted.org/pybedtools)
:   Python bindings for [bedtools](http://bedtools.readthedocs.io/)

[Jim Kent’s utilities](https://github.com/ENCODE-DCC/kentUtils/tree/master/src/product/scripts)
:   Convert text-based genomic files to randomly accessible, indexed binary
    formats (e.g. [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1) to [BigBed](http://genome.ucsc.edu/goldenPath/help/bigBed.html), [wiggle](http://genome.ucsc.edu/goldenpath/help/wiggle.html) and [bedGraph](http://genome.ucsc.edu/goldenpath/help/bedgraph.html)
    to [BigWig](http://genome.ucsc.edu/goldenPath/help/bigWig.html), [FASTA](https://en.wikipedia.org/wiki/FASTA_format) to [2bit](twobit), et c)

## Genome browsers[¶](#genome-browsers "Permalink to this headline")

[Integrative Genome Viewer](IGV)
:   A lightweight and versatile genome browser created
    by the [Broad Institute](www.broadinstitute.org). [IGV](https://www.broadinstitute.org/igv/) is suitable
    for laptops & desktops.

[UCSC Genome Browser](https://genome.ucsc.edu)
:   A web-based genome browser developed by University of California,
    Santa Cruz. The [UCSC Genome Browser](https://genome.ucsc.edu) integrates with UCSC’s large
    database of genomes, annotations, and tracks of quantitive data.
    It also offers many tools for visualization and manipulation
    of genomics data.

[Previous](CHANGES.html "Change log")
[Next](contact.html "Contact")

---

© Copyright 2014-2022, Joshua G. Dunn.
Revision `d97f239d`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).