[plastid](index.html)

latest

Getting started

* Getting started
  + [A genome sequence & annotation](#a-genome-sequence-annotation)
  + [Aligned sequence data](#aligned-sequence-data)
  + [Other background info](#other-background-info)
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
* [Related resources](related.html)
* [Contact](contact.html)

[plastid](index.html)

* »
* Getting started
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/quickstart.rst)

---

# Getting started[¶](#getting-started "Permalink to this headline")

Genomic analysis requires some setup. This page provides a quick overview
of those pieces.

To get started, you need:

* [A genome sequence & annotation](#a-genome-sequence-annotation)
* [Aligned sequence data](#aligned-sequence-data)
* [Other background info](#other-background-info)

For those looking to try [`plastid`](generated/plastid.html#module-plastid "plastid") out, or to explore sequencing concepts,
we have included a [Demo dataset](test_dataset.html), which includes sequence and annotation
for the hCMV genome, and [ribosome profiling](glossary.html#term-ribosome-profiling) and RNA-seq datasets.

For those setting up their own data, please continue reading:

## [A genome sequence & annotation](#id1)[¶](#a-genome-sequence-annotation "Permalink to this headline")

The starting point for most genomics research is to obtain a genome sequence
and matching [genome annotation](glossary.html#term-annotation). Good sources for these
include:

> * Mammal genomes: [UCSC](https://genome.ucsc.edu), [Ensembl](http://www.ensembl.org), [ENCODE](https://www.encodeproject.org/), and [GENCODE](www.gencodegenes.org)
> * Fly genomes: [FlyBase](http://flybase.org), [modENCODE](http://www.modencode.org)
> * *S. cerevisiae*: [SGD](http://www.yeastgenome.org)

It is critical that the genome sequence and feature annotations use the same
coordinates, so be sure to download corresponding versions from a single build
(i.e. it is unhelpful to mix mouse the *mm9* genome sequence with the *mm10*
annotation).

Often it is useful to do some pre-processing of files once they have been
downloaded. Detailed discussion is provided in [Setting up a genome for analysis](examples/a1_genome_setup.html)

## [Aligned sequence data](#id2)[¶](#aligned-sequence-data "Permalink to this headline")

The starting point for analysis with `Plastid` is aligned sequence data,
preferably in [BAM](http://samtools.github.io/hts-specs/) format.

An brief overview of the relevant steps in setting up alignments and exploring
data may be found in [A simple alignment and quantitation workflow](examples/a2_sample_processing.html).

That said, choice of alignment parameters merits careful consideration, which
is a weighty topic, beyond the scope of this tutorial. For a more detailed
discussion, see the documentation for the read alignment program you use (e.g.
[Bowtie](http://bowtie-bio.sourceforge.net/manual.shtml), [Bowtie 2](http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml), [Tophat](http://tophat.cbcb.umd.edu/), [bwa](http://bio-bwa.sourceforge.net), [STAR](https://github.com/alexdobin/STAR)).

## [Other background info](#id3)[¶](#other-background-info "Permalink to this headline")

Most of the [`plastid`](generated/plastid.html#module-plastid "plastid") documentation assumes familiarty with a handful
of concepts and conventions. We encourage those new to sequencing analysis
to check the [Tutorials](examples.html) and [Glossary of terms](glossary.html) as needed.

[Previous](index.html "Welcome!")
[Next](tour.html "Tour")

---

© Copyright 2014-2022, Joshua G. Dunn.
Revision `d97f239d`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).