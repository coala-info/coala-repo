[HTSeq](index.html)

latest

* [Home](index.html)
* [Overview](overview.html)
* [Installation](install.html)
* A tour through HTSeq
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

* A tour through HTSeq
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/tour.rst)

---

# A tour through HTSeq[](#a-tour-through-htseq "Permalink to this heading")

In the analysis of high-throughput sequencing data, it is often necessary to
write custom scripts to form the “glue” between tools or to perform specific
analysis tasks. HTSeq is a Python package to facilitate this.

This tour demonstrates the
functionality of HTSeq by performing a number of common analysis tasks:

* Getting statistical summaries about the base-call quality scores to
  study the data quality.
* Calculating a coverage vector and exporting it for visualization in
  a genome browser.
* Reading in annotation data from a GFF file.
* Assigning aligned reads from an RNA-Seq experiments to exons and
  genes.

The following description assumes that the reader is familiar with Python and with HTS
data. (For a good and not too lengthy introduction to Python, read the Python Tutorial
on the Python web site.)

If you want to try out the examples on your own system, you can download the
example files used from here: [HTSeq\_example\_data.tgz](http://www-huber.embl.de/users/anders/HTSeq/HTSeq_example_data.tgz)

## Reading in reads[](#reading-in-reads "Permalink to this heading")

In the example data, a FASTQ file is provided with example reads from a yeast RNA-Seq
experiment. The file `yeast_RNASeq_excerpt_sequence.txt` is an excerpt of the
`_sequence.txt` file produced by the SolexaPipeline software. We can access it from
HTSeq with

```
>>> import HTSeq
>>> fastq_file = HTSeq.FastqReader("yeast_RNASeq_excerpt_sequence.txt", "solexa")
```

The first argument is the file name. The optional second argument indicates
the encoding for the quality string. If you omit, the default (“phred”) is used. The
example data, however, is from an older experiment, and hence encoded in the
offset-64 format that the Solexa/Illumina software pipeline used before
version 1.8. (A third option is “solexa\_old”, for data from the Solexa pipeline
prior to version 1.3.)

The variable `fastq_file` is now an object of class [`FastqReader`](sequences.html#HTSeq.FastqReader "HTSeq.FastqReader"), which
refers to the file:

```
>>> fastq_file
<FastqReader object, connected to file name 'yeast_RNASeq_excerpt_sequence.txt'>
```

When used in a `for` loop, it generates an iterator of objects representing the
reads. Here, we use the `islice` function from `itertools` to cut after 10
reads.

```
>>> import itertools
>>> for read in itertools.islice(fastq_file, 10):
...    print(read)
CTTACGTTTTCTGTATCAATACTCGATTTATCATCT
AATTGGTTTCCCCGCCGAGACCGTACACTACCAGCC
TTTGGACTTGATTGTTGACGCTATCAAGGCTGCTGG
ATCTCATATACAATGTCTATCCCAGAAACTCAAAAA
AAAGTTCGAATTAGGCCGTCAACCAGCCAACACCAA
GGAGCAAATTGCCAACAAGGAAAGGCAATATAACGA
AGACAAGCTGCTGCTTCTGTTGTTCCATCTGCTTCC
AAGAGGTTTGAGATCTTTGACCACCGTCTGGGCTGA
GTCATCACTATCAGAGAAGGTAGAACATTGGAAGAT
ACTTTTAAAGATTGGCCAAGAATTGGGGATTGAAGA
```

Of course, there is more to a read than its sequence. The variable `read` still
contains the tenth read, and we can examine it:

```
>>> read
<SequenceWithQualities object 'HWI-EAS225:1:10:1284:142#0/1'>
```

A [`Sequence`](sequences.html#HTSeq.Sequence "HTSeq.Sequence") object has two slots, called [`seq`](sequences.html#HTSeq.Sequence.seq "HTSeq.Sequence.seq") and
[`name`](sequences.html#HTSeq.Sequence.name "HTSeq.Sequence.name"). This object is a [`SequenceWithQualities`](sequences.html#HTSeq.SequenceWithQualities "HTSeq.SequenceWithQualities"),
and it also has a slot `qual`:

```
>>> read.name
'HWI-EAS225:1:10:1284:142#0/1'
>>> read.seq
b'ACTTTTAAAGATTGGCCAAGAATTGGGGATTGAAGA'
>>> read.qual
array([33, 33, 33, 33, 33, 33, 29, 27, 29, 32, 29, 30, 30, 21, 22, 25, 25,
       25, 23, 28, 24, 24, 29, 29, 29, 25, 28, 24, 24, 26, 25, 25, 24, 24,
       24, 24], dtype=uint8)
```

The values in the quality array are, for each base in the sequence, the Phred
score for the correctness of the base.

As a first simple example for the use of HTSeq, we now calculate the average
quality score for each position in the reads by adding up the `qual` arrays
from all reads and the dividing by the number of reads. We sum everything up in
the variable `qualsum`, a `numpy` array of integers:

```
>>> import numpy
>>> len(read)
36
>>> qualsum = numpy.zeros(len(read), int)
```

Then we loop through the fastq file, adding up the quality scores and
counting the reads:

```
>>> nreads = 0
>>> for read in fastq_file:
...    qualsum += read.qual
...    nreads += 1
```

The average qualities are hence:

```
>>> qualsum / float(nreads)
array([31.56838274,  30.08288332,  29.4375375 ,  29.00432017,
       28.55290212,  28.26825073,  28.46681867,  27.59082363,
       27.34097364,  27.57330293,  27.11784471,  27.19432777,
       26.84023361,  26.76267051,  26.44885795,  26.79135165,
       26.42901716,  26.49849994,  26.13604544,  25.95823833,
       25.54922197,  26.20460818,  25.42333693,  25.72298892,
       25.04164167,  24.75151006,  24.48561942,  24.27061082,
       24.10720429,  23.68026721,  23.52034081,  23.49437978,
       23.11076443,  22.5576223 ,  22.43549742,  22.62354494])
```

If you have [matplotlib](http://matplotlib.sourceforge.net/) installed, you can plot these numbers.

```
>>> from matplotlib import pyplot
>>> pyplot.plot(qualsum / nreads)
>>> pyplot.show()
```

![_images/qualplot.png](_images/qualplot.png)

This is a very simple way of looking at the quality scores. For more sophisticated
quality-control techniques, see the Chapter [Quality Assessment with htseq-qa](qa.html#qa).

Instead of a FASTQ file, you might have a SAM file, with the reads already aligned.
The SAM\_Reader class can read such data.

```
>>> alignment_file = HTSeq.SAM_Reader("yeast_RNASeq_excerpt.sam")
```

If we are only interested in the qualities, we can rewrite the commands from above
to use the `alignment_file`:

```
>>> nreads = 0
>>> for aln in alignment_file:
...    qualsum += aln.read.qual
...    nreads += 1
```

We have simple replaced the [`FastqReader`](sequences.html#HTSeq.FastqReader "HTSeq.FastqReader") with a [`SolexaExportReader`](alignments.html#HTSeq.SolexaExportReader "HTSeq.SolexaExportReader"), which
iterates, when used in a `for` loop, over [`SolexaExportAlignment`](alignments.html#HTSeq.SolexaExportAlignment "HTSeq.SolexaExportAlignment") objects. Each of
these contain a field [`read`](alignments.html#HTSeq.Alignment.read "HTSeq.Alignment.read") that contains the [`SequenceWithQualities`](sequences.html#HTSeq.SequenceWithQualities "HTSeq.SequenceWithQualities")
object, as before. There are more parses, for example the `SAM_Reader` that can read SAM
files, and generates [`SAM_Alignment`](alignments.html#HTSeq.SAM_Alignment "HTSeq.SAM_Alignment") objects. As all [`Alignment`](alignments.html#HTSeq.Alignment "HTSeq.Alignment") objects
contain a [`read`](alignments.html#HTSeq.Alignment.read "HTSeq.Alignment.read") slot with the [`SequenceWithQualities`](sequences.html#HTSeq.SequenceWithQualities "HTSeq.SequenceWithQualities"), we can use the same
code with any alignment file for which a parser has been provided, and all we have
to change is the name of the reader class in the first line.

The other fields that all [`Alignment`](alignments.html#HTSeq.Alignment "HTSeq.Alignment") objects contain, is a Boolean called
[`aligned`](alignments.html#HTSeq.Alignment.aligned "HTSeq.Alignment.aligned") that tells us whether the read has been aligned
at all, and a field called [`iv`](alignments.html#HTSeq.Alignment.iv "HTSeq.Alignment.iv")
(for “interval”) that shows where the read was aligned to. We use this information in
the next section.

## Reading and writing BAM files[](#reading-and-writing-bam-files "Permalink to this heading")

HTSeq exposes the samtools API through [pysam](https://pysam.readthedocs.io/en/latest/), enabling you to read and write BAM files.

A simple example of the usage is given here:

```
>>> bam_reader = HTSeq.BAM_Reader("SRR001432_head_sorted.bam")
>>> for a in itertools.islice(bam_reader, 5):  # printing first 5 reads
...    print(a)
<SAM_Alignment object: Read 'SRR001432.165255 USI-EAS21_0008_3445:8:4:718:439 length=25' aligned to 1:[29267,29292)/->
<SAM_Alignment object: Read 'SRR001432.238475 USI-EAS21_0008_3445:8:6:888:446 length=25' aligned to 1:[62943,62968)/->
<SAM_Alignment object: Read 'SRR001432.116075 USI-EAS21_0008_3445:8:3:657:64 length=25' aligned to 1:[86980,87005)/->
<SAM_Alignment object: Read 'SRR001432.159692 USI-EAS21_0008_3445:8:4:618:821 length=25' aligned to 1:[91360,91385)/->
<SAM_Alignment object: Read 'SRR001432.249247 USI-EAS21_0008_3445:8:6:144:741 length=25' aligned to 1:[97059,97084)/->
```

```
>>> bam_writer = HTSeq.BAM_Writer.from_BAM_Reader("region.bam", bam_reader) #set-up BAM_Writer with same header as reader
>>> for a in bam_reader.fetch(region = "1:249000000-249200000"): #fetching reads in a region
...    print("Writing Alignment", a, "to file", bam_writer.filename)
...    bam_writer.write(a)
Writing Alignment <SAM_Alignment object: Read 'SRR001432.104735 USI-EAS21_0008_3445:8:3:934:653 length=25' aligned to 1:[249085369,249085394)/-> to file region.bam
Writing Alignment <SAM_Alignment object: Read 'SRR001432.280764 USI-EAS21_0008_3445:8:7:479:581 length=25' aligned to 1:[249105864,249105889)/-> to file region.bam
...
Writing Alignment <SAM_Alignment object: Read 'SRR001432.248967 USI-EAS21_0008_3445:8:6:862:756 length=25' aligned to 1:[249167916,249167941)/-> to file region.bam
>>> bam_writer.close()
```

## Genomic intervals and genomic arrays[](#genomic-intervals-and-genomic-arrays "Permalink to this heading")

### Genomic intervals[](#genomic-intervals "Permalink to this heading")

At the end of the previous section, we looped through a SAM file. In the for loop,
the `SAM_Reader` object yields for each alignment line in the SAM file an
object of class [`SAM_Alignment`](alignments.html#HTSeq.SAM_Alignment "HTSeq.SAM_Alignment"). Let’s have closer look at such an object,
still found in the variable `aln`:

```
>>> aln
<SAM_Alignment object: Read 'HWI-EAS225:1:11:76:63#0/1' aligned to IV:[246048,246084)/+>
```

Every alignment object has a slot `read`, that contains a [`SequenceWithQualities`](sequences.html#HTSeq.SequenceWithQualities "HTSeq.SequenceWithQualities") object as
described above

```
>>> aln.read
<SequenceWithQualities object 'HWI-EAS225:1:11:76:63#0/1'>
>>> aln.read.name
'HWI-EAS225:1:11:76:63#0/1'
>>> aln.read.seq
b'ACTGTAAATACTTTTCAGAAGAGATTTGTAGAATCC'
>>> aln.read.qualstr
b'BBBB@B?AB?>BAAA@A@>=?=?9=?=;9>988<::'
>>> aln.read.qual
array([33, 33, 33, 33, 31, 33, 30, 32, 33, 30, 29, 33, 32, 32, 32, 31, 32,
       31, 29, 28, 30, 28, 30, 24, 28, 30, 28, 26, 24, 29, 24, 23, 23, 27,
       25, 25], dtype=uint8)
```

Furthermore, every alignment object has a slot `iv` (for “interval”) that describes where
the read was aligned to (if it was aligned). To hold this
information, an object of class [`GenomicInterval`](genomic.html#HTSeq.GenomicInterval "HTSeq.GenomicInterval")
is used that has slots as follows:

```
>>> aln.iv
<GenomicInterval object 'IV', [246048,246084), strand '+'>
>>> aln.iv.chrom
'IV'
>>> aln.iv.start
246048
>>> aln.iv.end
246084
>>> aln.iv.strand
'+'
```

Note that all coordinates in HTSeq are zero-based (following Python convention), i.e.
the first base of a chromosome has index 0. Also, all intervals are half-open, i.e.,
the `end` position is not included. The strand can be one of `'+'`, `'-'`,
and `'.'`, where the latter indicates that the strand is not defined or not of interest.

Apart from these slots,
a [`GenomicInterval`](genomic.html#HTSeq.GenomicInterval "HTSeq.GenomicInterval") object has a number of convenience functions, see the reference.

Note that a SAM file may contain reads that could not be aligned. For these, the
iv slot contains None. To test whether an alignment is present, you can also
query the slot aligned, which is a Boolean.

### Genomic Arrays[](#genomic-arrays "Permalink to this heading")

The [`GenomicArray`](genomic.html#HTSeq.GenomicArray "HTSeq.GenomicArray") data structure is a convenient way to store and
retrieve information associated with a genomic position or genomic interval. In
a GenomicArray, data (either simple scalar data like a number) or can be stored
at a place identified by a GenomicInterval. We demonstrate with a toy example.

Assume you have a genome with three chromosomes with the following lengths (in bp):

```
>>> chromlens = {'chr1': 3000, 'chr2': 2000, 'chr1': 1000}
```

We wish to store integer data (typecode “i”)

```
>>> ga = HTSeq.GenomicArray(chromlens, stranded=False, typecode="i")
```

Now, we can assign the value 5 to an interval:

```
>>> iv = HTSeq.GenomicInterval("chr1", 100, 120, ".")
>>> ga[iv] = 5
```

We may want to add the value 3 to an interval overlapping with the previous one:

```
>>> iv = HTSeq.GenomicInterval("chr1", 110, 135, ".")
>>> ga[iv] += 3
```

To see the effect of this, we read out an interval encompassing the region that
we changed. To display the data, we convert to a list:

```
>>> iv = HTSeq.GenomicInterval("chr1", 90, 140, ".")
>>> list(ga[iv])
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 8, 8, 8,
 8, 8, 8, 8, 8, 8, 8, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 0,
 0, 0, 0, 0]
```

It would be wasteful to store all these repeats of the same value as it
is displayed here. Hence, GenomicArray objects use by default so-called
StepVectors that store the data internally in “steps” of constant value.
Often, reading out the data that way is useful, too:

```
>>> for iv2, value in ga[iv].steps():
...    print(iv2, value)
...
chr1:[90,100)/. 0
chr1:[100,110)/. 5
chr1:[110,120)/. 8
chr1:[120,135)/. 3
chr1:[135,140)/. 0
```

If the steps become very small, storing them instead of just the unrolled data may
become inefficient. In this case, GenomicArrays should be instantiated with
storage mode `ndarray` to get a normal numpy array as backend, or with storage
mode `memmap` to use a file/memory-mapped numpy array (see reference for details).

In the following section, we demonstrate how a GenomicArray can be used to
calculate a coverage vector. In the section after that, we see how a GenomicArray
with typ