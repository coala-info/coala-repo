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
* Miscellaneous
* [`htseq-count`: counting reads within features](htseqcount.html)
* [`htseq-count-barcodes`: counting reads with cell barcodes and UMIs](htseqcount_with_barcodes.html)
* [Quality Assessment with `htseq-qa`](qa.html)
* [Version history](history.html)
* [Contributing](contrib.html)

[HTSeq](index.html)

* Miscellaneous
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/misc.rst)

---

# Miscellaneous[](#miscellaneous "Permalink to this heading")

## `FileOrSequence`[](#fileorsequence "Permalink to this heading")

*class* HTSeq.FileOrSequence(*filename\_or\_sequence*)[](#HTSeq.FileOrSequence "Permalink to this definition")
:   This class is a a canvenience wrapper around a file.

    The construcutor takes one argument, which may either be a string,
    which is interpreted as a file name (possibly with path), or a
    connection, by which we mean a text file opened for reading, or
    any other object that can provide an iterator over strings
    (lines of the file).

    The advantage of passing a file name instead of an already opened file
    is that if an iterator is requested several times, the file will be
    re-opened each time. If the file is already open, its lines can be read
    only once, and then, the iterator stays exhausted.

    Furthermore, if a file name is passed that end in “.gz” or “.gzip”
    (case insensitive), it is transparently gunzipped.

    fos[](#HTSeq.FileOrSequence.fos "Permalink to this definition")
    :   The argument passed to the constructor, i.e., a filename or a sequence

    line\_no[](#HTSeq.FileOrSequence.line_no "Permalink to this definition")
    :   The line number (1-based) of the most recently read line. Initially None.

    get\_line\_number\_string()[](#HTSeq.FileOrSequence.get_line_number_string "Permalink to this definition")
    :   Returns a string describing the position in the file. Useful for error messages.

## Version[](#version "Permalink to this heading")

HTSeq.\_\_version\_\_[](#HTSeq.__version__ "Permalink to this definition")
:   a string containing the current version

[Previous](otherparsers.html "Other parsers")
[Next](htseqcount.html "htseq-count: counting reads within features")

---

© Copyright 2010-2022, the HTSeq team.
Revision `726a1432`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).