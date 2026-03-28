[HTSeq](index.html)

latest

* [Home](index.html)
* [Overview](overview.html)
* [Installation](install.html)
* [A tour through HTSeq](tour.html)
* [Tutorials](tutorials.html)
* [Counting reads](counting.html)
* Reference API
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

* Reference API
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/refoverview.rst)

---

# Reference API[](#reference-api "Permalink to this heading")

This page offers a brief overview over all classes and functions offered by HTSeq.

## Parser and record classes[](#parser-and-record-classes "Permalink to this heading")

For all supported file formats, parser classes (called `Reader`) are provided. These classes all
instatiated by giving a file name or an open file or stream and the function as iterator generators,
i.e., the parser objects can be used, e.g., in a `for` loop to yield a sequence of objects, each
desribing one record. The table gives the parse class and the record class yielded. For details,
see the linked documentation

For most formats, functionality for writing files of the format is provided. See the detailed documentation
as these methods and classes have varying semantics.

| File format | typical content | Parser class for reading | Record class yielded by parser | Method/class method for writing |
| --- | --- | --- | --- | --- |
| FASTA | DNA sequences | [`FastaReader`](sequences.html#HTSeq.FastaReader "HTSeq.FastaReader") | [`Sequence`](sequences.html#HTSeq.Sequence "HTSeq.Sequence") | `Sequence.write_to_fasta_file()` |
| FASTQ | sequenced reads | [`FastqReader`](sequences.html#HTSeq.FastqReader "HTSeq.FastqReader") | [`SequenceWithQualities`](sequences.html#HTSeq.SequenceWithQualities "HTSeq.SequenceWithQualities") | [`SequenceWithQuality.write_to_fastq_file()`](sequences.html#HTSeq.SequenceWithQuality.write_to_fastq_file "HTSeq.SequenceWithQuality.write_to_fastq_file") |
| GFF (incl. GFF3 and GTF) | genomic annotation | [`GFF_Reader`](features.html#HTSeq.GFF_Reader "HTSeq.GFF_Reader") | [`GenomicFeature`](features.html#HTSeq.GenomicFeature "HTSeq.GenomicFeature") | [`GenomicFeature.get_gff_line()`](features.html#HTSeq.GenomicFeature.get_gff_line "HTSeq.GenomicFeature.get_gff_line") |
| BED | score data or annotation | [`BED_Reader`](otherparsers.html#HTSeq.BED_Reader "HTSeq.BED_Reader") | [`GenomicFeature`](features.html#HTSeq.GenomicFeature "HTSeq.GenomicFeature") |  |
| Wiggle (incl. BedGraph) | score data on a genome | [`WiggleReader`](otherparsers.html#HTSeq.WiggleReader "HTSeq.WiggleReader") | pair: ([`GenomicInterval`](genomic.html#HTSeq.GenomicInterval "HTSeq.GenomicInterval"), float) | [`GenomicArray.write_bedgraph_file()`](genomic.html#HTSeq.GenomicArray.write_bedgraph_file "HTSeq.GenomicArray.write_bedgraph_file") |
| SAM | aligned reads | `SAM_Reader` | [`SAM_Alignment`](alignments.html#HTSeq.SAM_Alignment "HTSeq.SAM_Alignment") | [`SAM_Alignment.get_sam_line()`](alignments.html#HTSeq.SAM_Alignment.get_sam_line "HTSeq.SAM_Alignment.get_sam_line") |
| BAM | aligned reads | [`BAM_Reader`](alignments.html#HTSeq.BAM_Reader "HTSeq.BAM_Reader") | [`SAM_Alignment`](alignments.html#HTSeq.SAM_Alignment "HTSeq.SAM_Alignment") | `BAM_Writer` |
| VCF | variant calls | [`VCF_Reader`](otherparsers.html#HTSeq.VCF_Reader "HTSeq.VCF_Reader") | [`VariantCall`](otherparsers.html#HTSeq.VariantCall "HTSeq.VariantCall") |  |
| Bowtie (legacy format) | aligned reads | [`BowtieReader`](alignments.html#HTSeq.BowtieReader "HTSeq.BowtieReader") | [`BowtieAlignment`](alignments.html#HTSeq.BowtieAlignment "HTSeq.BowtieAlignment") |  |
| SolexaExport (legacy format) | aligned reads | [`SolexaExportReader`](alignments.html#HTSeq.SolexaExportReader "HTSeq.SolexaExportReader") | [`SolexaExportAlignment`](alignments.html#HTSeq.SolexaExportAlignment "HTSeq.SolexaExportAlignment") |  |

Most parser classes are sub-classes of class [`FileOrSequence`](misc.html#HTSeq.FileOrSequence "HTSeq.FileOrSequence"), which users will, however, rarely use directly.

## Specifying genomic positions and intervals[](#specifying-genomic-positions-and-intervals "Permalink to this heading")

The class [`GenomicInterval`](genomic.html#HTSeq.GenomicInterval "HTSeq.GenomicInterval") specifies an interval on a chromosome (or contig or the like). It is defined by specifying the chromosome (or contig) name,
the start and the end and the strand. Convenience methods are offered for different ways of accessing this information, and for tetsing
for overlap between intervals. A [`GenomicPosition`](genomic.html#HTSeq.GenomicPosition "HTSeq.GenomicPosition"), technically a GenomicInterval of length 1, refers to a single nucleotide or base-pair
position.

Objects of these classes are used internally wherever intervals or positions are represented, especially in record classes and as
index keys to genomic array.

See page [Positions, intervals and arrays](genomic.html#genomic) for details.

## Genomic arrays[](#genomic-arrays "Permalink to this heading")

The classes [`GenomicArray`](genomic.html#HTSeq.GenomicArray "HTSeq.GenomicArray") and [`GenomicArrayOfSets`](genomic.html#HTSeq.GenomicArrayOfSets "HTSeq.GenomicArrayOfSets") are container classes to store data associated with genomic positions or intervals.

See page [Positions, intervals and arrays](genomic.html#genomic) for details.

## Special features for SAM/BAM files[](#special-features-for-sam-bam-files "Permalink to this heading")

The class [`CigarOperation`](alignments.html#HTSeq.CigarOperation "HTSeq.CigarOperation") offers a convenient way to handle the information encoded in the CIGAR field of SAM files.

The functions [`pair_SAM_alignments()`](alignments.html#HTSeq.pair_SAM_alignments "HTSeq.pair_SAM_alignments") and [`pair_SAM_alignments_with_buffer()`](alignments.html#HTSeq.pair_SAM_alignments_with_buffer "HTSeq.pair_SAM_alignments_with_buffer") help to `pair up` the records
in a SAM file that describe a pair of alignments for mated reads from the same DNA fragment.

Similarly, the function [`bundle_multiple_alignments()`](alignments.html#HTSeq.bundle_multiple_alignments "HTSeq.bundle_multiple_alignments") bundles multiple alignment record pertaining to the same read or read pair.

See page [Read alignments](alignments.html#alignments) for details.

[Previous](counting.html "Counting reads")
[Next](sequences.html "Sequences and FASTA/FASTQ files")

---

© Copyright 2010-2022, the HTSeq team.
Revision `726a1432`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).