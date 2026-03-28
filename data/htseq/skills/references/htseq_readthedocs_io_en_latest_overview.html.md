[HTSeq](index.html)

latest

* [Home](index.html)
* Overview
* [Installation](install.html)
* [A tour through HTSeq](tour.html)
* [Tutorials](tutorials.html)
* [Counting reads](counting.html)
* [Reference API](refoverview.html)
* [Sequences and FASTA/FASTQ files](sequences.html)
* [Positions, intervals and arrays](genomic.html)
* [Read alignments](alignments.html)
* [Features](features.html)
* [Other parsers](otherparsers.html)
* [Miscellaneous](misc.html)
* [`htseq-count`: counting reads within features](htseqcount.html)
* [`htseq-count-barcodes`: counting reads with cell barcodes and UMIs](htseqcount_with_barcodes.html)
* [Quality Assessment with `htseq-qa`](qa.html)
* [Version history](history.html)
* [Contributing](contrib.html)

[HTSeq](index.html)

* Overview
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/overview.rst)

---

# Overview[](#overview "Permalink to this heading")

* [Installation](install.html#install)

  Download links and installation instructions can be found here
* [A tour through HTSeq](tour.html#tour)

  The Tour shows you how to get started. It explains how to install HTSeq, and then
  demonstrates typical analysis steps with explicit examples. Read this first, and
  then see the Reference for details.
* [Tutorial: Transcription start sites (TSS)](tutorials/tss.html#tss)

  This chapter explains typical usage patterns for HTSeq by explaining in detail
  three different solutions to the same programming task.
* [Counting reads](counting.html#counting)

  This chapter explorer in detail the use case of counting the overlap of reads
  with annotation features and explains how to implement custom logic by
  writing on’s own customized counting scripts
* Reference documentation

  The various classes of HTSeq are described here.

  + [Reference API](refoverview.html#refoverview)

    A brief overview over all classes.
  + [Sequences and FASTA/FASTQ files](sequences.html#sequences)

    In order to represent sequences and reads (i.e., sequences with base-call quality
    information), the classes [`Sequence`](sequences.html#HTSeq.Sequence "HTSeq.Sequence") and [`SequenceWithQualities`](sequences.html#HTSeq.SequenceWithQualities "HTSeq.SequenceWithQualities") are used.
    The classes [`FastaReader`](sequences.html#HTSeq.FastaReader "HTSeq.FastaReader") and [`FastqReader`](sequences.html#HTSeq.FastqReader "HTSeq.FastqReader") allow to parse FASTA and FASTQ
    files.
  + [Positions, intervals and arrays](genomic.html#genomic)

    The classes [`GenomicInterval`](genomic.html#HTSeq.GenomicInterval "HTSeq.GenomicInterval") and [`GenomicPosition`](genomic.html#HTSeq.GenomicPosition "HTSeq.GenomicPosition") represent intervals and
    positions in a genome. The class [`GenomicArray`](genomic.html#HTSeq.GenomicArray "HTSeq.GenomicArray") is an all-purpose container
    with easy access via a genomic interval or position, and [`GenomicArrayOfSets`](genomic.html#HTSeq.GenomicArrayOfSets "HTSeq.GenomicArrayOfSets")
    is a special case useful to deal with genomic features (such as genes, exons,
    etc.)
  + [Read alignments](alignments.html#alignments)

    To process the output from short read aligners in various formats (e.g., SAM),
    the classes described here are used, to represent output files and alignments,
    i.e., reads with their alignment information.
  + [Features](features.html#features)

    The classes [`GenomicFeature`](features.html#HTSeq.GenomicFeature "HTSeq.GenomicFeature") and [`GFF_Reader`](features.html#HTSeq.GFF_Reader "HTSeq.GFF_Reader") help to deal with genomic
    annotation data.
  + [Other parsers](otherparsers.html#otherparsers)

    This page describes classes to parse VCF, Wiggle and BED files.
  + [Miscellaneous](misc.html#misc)
* Scripts

  The following scripts can be used without any Python knowledge.

  + [Quality Assessment with htseq-qa](qa.html#qa)

    Given a FASTQ or SAM file, this script produces a PDF file with plots depicting
    the base calls and base-call qualities by position in the read. This is useful to
    assess the technical quality of a sequencing run.
  + [htseq-count: counting reads within features](htseqcount.html#htseqcount)

    Given one/multiple SAM/BAM/CRAM files with alignments and a GTF file with genomic
    features, this script counts how many reads map to each feature. This script is
    especially popular for bulk and single-cell RNA-Seq analysis.
  + [htseq-count-barcodes: counting reads with cell barcodes and UMIs](htseqcount_with_barcodes.html#htseqcount-with-barcodes)

    Similar to htseq-count, but for a single SAM/BAM/CRAM file containing reads with
    cell and molecular barcodes (e.g. 10X Genomics cellranger output). This script
    enables customization of single-cell RNA-Seq pipelines, e.g. to quantify exon-level
    expression or simply to obtain a count matrix that contains chromosome information
    additional feature metadata.
* Appendices

> * [Version history](history.html#history)

> * [Contributing](contrib.html#contrib)

> * [Table of Contents](index.html#tableofcontents)

[Previous](index.html "HTSeq: High-throughput sequence analysis in Python")
[Next](install.html "Installation")

---

© Copyright 2010-2022, the HTSeq team.
Revision `726a1432`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).