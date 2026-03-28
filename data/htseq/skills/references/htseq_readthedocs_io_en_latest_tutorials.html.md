[HTSeq](index.html)

latest

* [Home](index.html)
* [Overview](overview.html)
* [Installation](install.html)
* [A tour through HTSeq](tour.html)
* Tutorials
  + [Tutorial: Using Fasta/Fastq parsers](tutorials/fastx_reader.html)
  + [Tutorial: Using the SAM/BAM/CRAM parsers](tutorials/bam_reader.html)
  + [Tutorial: StepVector versus StretchVector](tutorials/step_vs_stretch_vector.html)
  + [Tutorial: Transcription start sites (TSS)](tutorials/tss.html)
  + [Tutorial: High C data exploration](tutorials/highc.html)
  + [Opening the black box of `htseq-count`](tutorials/exon_example.html)
  + [Quantifying exon-level expression with `htseq-count`](tutorials/tutorial_exon_level.html)
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

* Tutorials
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/tutorials.rst)

---

# Tutorials[](#tutorials "Permalink to this heading")

This page contains a few tutorials to help you familiarize yourself with `HTSeq`, including `htseq-count` and its barcode sibiling `htseq-count-barcodes`.

## Parsers[](#parsers "Permalink to this heading")

* [Tutorial: Using Fasta/Fastq parsers](tutorials/fastx_reader.html#tutorial-fastx): Simple tutorial on hadling fasta and fastq files with `HTSeq`.
* [Tutorial: Using the SAM/BAM/CRAM parsers](tutorials/bam_reader.html#tutorial-bam): Simple tutorial on handling SAM/BAM/CRAM files.
* [Tutorial: StepVector versus StretchVector](tutorials/step_vs_stretch_vector.html#step-vs-stretch): Explanation of the different data structures used to store sparse genomic data.

## Workflows[](#workflows "Permalink to this heading")

* [Tutorial: Transcription start sites (TSS)](tutorials/tss.html#tss): TSS example for the `HTSeq` API
* [Tutorial: High C data exploration](tutorials/highc.html#tutorial-highc): Chromatin conformation example for the `HTSeq` API

## Scripts[](#scripts "Permalink to this heading")

* [Opening the black box of htseq-count](tutorials/exon_example.html#tutorial-htseq): Explanation of the inner workings of `htseq-count`
* [Quantifying exon-level expression with htseq-count](tutorials/tutorial_exon_level.html#tutorial-htseq-exon): Calling `htseq-count` at the exon level.

[Previous](tour.html "A tour through HTSeq")
[Next](tutorials/fastx_reader.html "Tutorial: Using Fasta/Fastq parsers")

---

© Copyright 2010-2022, the HTSeq team.
Revision `726a1432`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).