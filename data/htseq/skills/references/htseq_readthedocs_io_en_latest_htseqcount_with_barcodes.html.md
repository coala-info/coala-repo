[HTSeq](index.html)

latest

* [Home](index.html)
* [Overview](overview.html)
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
* `htseq-count-barcodes`: counting reads with cell barcodes and UMIs
* [Quality Assessment with `htseq-qa`](qa.html)
* [Version history](history.html)
* [Contributing](contrib.html)

[HTSeq](index.html)

* `htseq-count-barcodes`: counting reads with cell barcodes and UMIs
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/htseqcount_with_barcodes.rst)

---

# `htseq-count-barcodes`: counting reads with cell barcodes and UMIs[](#htseq-count-barcodes-counting-reads-with-cell-barcodes-and-umis "Permalink to this heading")

This script is similar to `htseq-count`, but is designed to operate on a single SAM/BAM/CRAM file that contains reads from many cells, distinguished by a cell barcode in the read name and possibly a unique molecular identifier (UMI).

To keep the documentation simple, this page does not repeat the explanations found for `htseq-count` at [htseq-count: counting reads within features](htseqcount.html#htseqcount) and focuses on the differences instead.

* Unlike `htseq-count`, only one read file is accepted.
* No multicore support is available ATM. Because barcoded, position-sorted BAM files are not trivially parallelizable, this feature is a little challenging to implement, however pull requests (PRs) on Github are welcome.
* The main target for this script are BAM files produced by 10X Genomics’ `cellranger` pipeline. If you have a different application and would like to use `htseq-count-barcodes`, please open an issue on Github and we’ll be happy to consider adding it.

[Previous](htseqcount.html "htseq-count: counting reads within features")
[Next](qa.html "Quality Assessment with htseq-qa")

---

© Copyright 2010-2022, the HTSeq team.
Revision `726a1432`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).