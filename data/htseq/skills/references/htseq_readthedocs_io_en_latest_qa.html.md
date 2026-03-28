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
* [`htseq-count-barcodes`: counting reads with cell barcodes and UMIs](htseqcount_with_barcodes.html)
* Quality Assessment with `htseq-qa`
* [Version history](history.html)
* [Contributing](contrib.html)

[HTSeq](index.html)

* Quality Assessment with `htseq-qa`
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/qa.rst)

---

# Quality Assessment with `htseq-qa`[](#quality-assessment-with-htseq-qa "Permalink to this heading")

The Python script `htseq-qa` takes a file with sequencing reads (either
raw or aligned reads) and produces a PDF file with useful plots to assess
the technical quality of a run.

## Plot[](#plot "Permalink to this heading")

Here is a typical plot:

[![_images/qa_example.png](_images/qa_example.png)](_images/qa_example.png)

The plot is made from a SAM file, which contained aligned and unalignable reads.
The left column is made from the non-aligned, the right column from the aligned
reads. The header informs you about the name of the SAM file, and the number of
reads.

The upper row shows how often which base was called for each position in the
read. In this sample, the non-alignable reads have a clear excess in A. The
aligned reads have a balance between complementing reads: A and C (reddish colours)
have equal levels, and so do C and G (greenish colours). The sequences seem to be AT
rich. Furthermore, nearly all aligned reads start with a T, followed by an A, and then,
a C in 70% and an A in 30% of the reads. Such an imbalance would be reason for concern
if it has no good explanation. Here, the reason is that the fragmentation of the sample
was done by enzyme digestion.

The lower half shows the abundance of base-call quality scores at the different positions
in the read. Nearly all aligned reads have a quality of 34 over their whole length, while
for the non-aligned reads, some reads have lower quality scores towards their ends.

## Usage[](#usage "Permalink to this heading")

Note that `htseq-qa` needs matplotlib to produce the plot, so you need to install this
module, as described [here](http://matplotlib.sourceforge.net/users/installing.html) on the matplotlib web site.

After you have installed HTSeq (see [Installation](install.html#install)) and matplotlib, you can run `htseq-qa` from
the command line:

```
htseq-qa [options] read_file
```

If the file `htseq-qa` is not in your path, you can, alternatively, call the script with

```
python -m HTSeq.scripts.qa [options] read_file
```

The read\_file is either a FASTQ file or a SAM file. For a SAM file, a plot with two columns
is produced as above, for a FASTQ file, you get only one column.

The output is written into a file with the same name as read\_file, with the suffix `.pdf`
added. View it with a PDF viewer such as the Acrobat Reader.

### Options[](#options "Permalink to this heading")

-t <type>, --type=<type>[](#cmdoption-htseq-qa-t "Permalink to this definition")
:   The file type of the read\_file. Supported values for <type> are:

    * `sam`: a SAM file (Note that the [SAMtools](http://samtools.sourceforge.net/) contain Perl scripts to convert
      most alignment formats to SAM)
    * `solexa-export`: an `_export.txt` file as produced by the SolexaPipeline
      software after aligning with Eland (`htseq-qa` expects the new Solexa quality
      encoding as produced by version 1.3 or newer of the SolexaPipeline)
    * `fastq`: a FASTQ file with standard (Sanger or Phred) quality encoding
    * `solexa-fastq`: a FASTQ file with Solexa quality encoding, as produced by
      the SolexaPipeline after base-calling with Bustard (`htseq-qa` expects
      the new Solexa quality encoding as produced by version 1.3 or newer
      of the SolexaPipeline)

-o <outfile>, --outfile=<outfile>[](#cmdoption-htseq-qa-o "Permalink to this definition")
:   output filename (default is <read\_file>``.pdf``)

-r <readlen>, --readlength=<readlen>[](#cmdoption-htseq-qa-r "Permalink to this definition")
:   the maximum read length (when not specified, the
    script guesses from the file

-g <gamma>, --gamma=<gamma>[](#cmdoption-htseq-qa-g "Permalink to this definition")
:   the gamma factor for the contrast adjustment of the
    quality score plot

-n, --nosplit[](#cmdoption-htseq-qa-n "Permalink to this definition")
:   do not split reads in unaligned and aligned ones, i.e., produce
    a one-column plot

-m, --maxqual[](#cmdoption-htseq-qa-m "Permalink to this definition")
:   the maximum quality score that appears in the data (default: 40)

-h, --help[](#cmdoption-htseq-qa-h "Permalink to this definition")
:   Show a usage summary and exit

[Previous](htseqcount_with_barcodes.html "htseq-count-barcodes: counting reads with cell barcodes and UMIs")
[Next](history.html "Version history")

---

© Copyright 2010-2022, the HTSeq team.
Revision `726a1432`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).