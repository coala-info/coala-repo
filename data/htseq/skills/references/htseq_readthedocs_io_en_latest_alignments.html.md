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
* Read alignments
* [Features](features.html)
* [Other parsers](otherparsers.html)
* [Miscellaneous](misc.html)
* [`htseq-count`: counting reads within features](htseqcount.html)
* [`htseq-count-barcodes`: counting reads with cell barcodes and UMIs](htseqcount_with_barcodes.html)
* [Quality Assessment with `htseq-qa`](qa.html)
* [Version history](history.html)
* [Contributing](contrib.html)

[HTSeq](index.html)

* Read alignments
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/alignments.rst)

---

# Read alignments[](#read-alignments "Permalink to this heading")

## Concepts[](#concepts "Permalink to this heading")

There are a large number of different tools to align short reads to a reference. Most of
them use their own output format, even though the [SAM format](http://samtools.sourceforge.net/SAM1.pdf) seems to become the common
standard now that many of the newer tools use it.

HTSeq aims to offer a uniform way to analyse alignments from different tools. To this end,
for all supported alignment formats a parse class is offered that reads an alignment file
and generates an iterator over the individual alignment records. These are represented as
objects of a sub-class of [`Alignment`](#HTSeq.Alignment "HTSeq.Alignment") and hence all offer a common interface.

So, you can easily write code that should work for all aligner formats. As a simple example,
consider this function that counts the number of reads falling on each chromosome:

```
>>> import collections
>>> def count_in_chroms( alignments ):
...     counts = collections.defaultdict( lambda: 0 )
...     for almnt in alignments:
...         if almnt.aligned:
...             counts[ almnt.iv.chrom ] += 1
...     return counts
```

If you have a SAM file (e.g., from BWA or BowTie), you can call it with:

```
>>> sorted(count_in_chroms(HTSeq.BAM_Reader("yeast_RNASeq_excerpt.sam")).items())
[('2-micron', 46), ('I', 362), ('II', 1724), ('III', 365), ('IV', 3015),
 ('IX', 648), ('V', 999), ('VI', 332), ('VII', 2316), ('VIII', 932),
 ('X', 1129), ('XI', 1170), ('XII', 4215), ('XIII', 1471), ('XIV', 1297),
 ('XV', 2133), ('XVI', 1509)]
```

If, however, you have done your alignment with Eland from the SolexaPipeline, which
uses the “Solexa export” format, you can use the same function, only using [`SolexaExportReader`](#HTSeq.SolexaExportReader "HTSeq.SolexaExportReader")
instead of [`BAM_Reader`](#HTSeq.BAM_Reader "HTSeq.BAM_Reader"):

```
>>> count_in_chroms( HTSeq.SolexaExportReader( "mydata_export.txt" ) )
```

Both class generate iterators of similar objects. On the other hand, some formats contain more information
and then the `Alignment` objects from these contain additional fields.

## Parser classes[](#parser-classes "Permalink to this heading")

Depending on the format of your alignment file, choose from the following parsers:

*class* HTSeq.BowtieReader(*filename\_or\_sequence*)[](#HTSeq.BowtieReader "Permalink to this definition")

*class* HTSeq.BAM\_Reader(*filename\_or\_sequence*)[](#HTSeq.BAM_Reader "Permalink to this definition")

*class* HTSeq.SolexaExportReader(*filename\_or\_sequence*)[](#HTSeq.SolexaExportReader "Permalink to this definition")

All of these are derived from [`FileOrSequence`](misc.html#HTSeq.FileOrSequence "HTSeq.FileOrSequence"). When asked for an iterator,
they yield `Alignment` objects of types [`BowtieAlignment`](#HTSeq.BowtieAlignment "HTSeq.BowtieAlignment"), [`SAM_Alignment`](#HTSeq.SAM_Alignment "HTSeq.SAM_Alignment"),
or [`SolexaExportAlignment`](#HTSeq.SolexaExportAlignment "HTSeq.SolexaExportAlignment"). See below for their properties.

Adding support for a new format is very easy. Ask me if you need something and
I can probably add it right-away.
Alternatively, you can convert your format to the SAM format. The [SAMtools](http://samtools.sourceforge.net/)
contain Perl skripts to convert nearly all common formats.

> BAM\_Reader.peek( num = 1 ):
> :   Peek into a SAM file or connection, reporting the first `num` records.
>     If you then call an iterator on the `BAM_Reader`, the record will
>     be yielded again.

## `Alignment` and `AlignmentWithSequenceReversal`[](#alignment-and-alignmentwithsequencereversal "Permalink to this heading")

*class* HTSeq.Alignment(*read*, *iv*)[](#HTSeq.Alignment "Permalink to this definition")
:   This is the base class of all Alignment classes. Any class derived
    from `Alignment` has at least the following attributes:

    read[](#HTSeq.Alignment.read "Permalink to this definition")
    :   The read. An object of type `SequenceWithQuality`. See there for the sub-attributes.

        Note that some aligners store the reverse complement of the read if it was
        aligned to the ‘-’ strand. In this case, the parser revers-complements the read
        again, so that you can be sure that the read is always presented as it was sequenced
        (see also [`AlignmentWithSequenceReversal`](#HTSeq.AlignmentWithSequenceReversal "HTSeq.AlignmentWithSequenceReversal")).

    aligned[](#HTSeq.Alignment.aligned "Permalink to this definition")
    :   A boolean. Some formats (e.g., those of Maq and Bowtie) contain only aligned
        reads (and the aligner collects the
        unaligned reads in a seperate FASTQ file if requested). For these formats, `aligned`
        is always `True`. Other formats (e.g., SAM and Solexa Export) list all reads, including those which could
        not be aligned. In that case, check `aligned` to see whether the read has an
        alignment.

    iv[](#HTSeq.Alignment.iv "Permalink to this definition")
    :   An object of class [`GenomicInterval`](genomic.html#HTSeq.GenomicInterval "HTSeq.GenomicInterval") or `None`.

        The genomic interval to which the read was aligned (or `None` if `aligned=False`).
        See [`GenomicInterval`](genomic.html#HTSeq.GenomicInterval "HTSeq.GenomicInterval") for the sub-attributes. Note that different formats
        have different conventions for genomic coordinates. The parser class takes care
        of normalizing this, so that `iv` always adheres to the conventions outlined
        in :class:GenomicInterval. Especially, all coordinates are counted from zero, not one.

    paired\_end[](#HTSeq.Alignment.paired_end "Permalink to this definition")
    :   A boolean. True if the read stems from a paired-end sequencing run. (Note: At the moment
        paired-end data is only supported for the SAM format.)

*class* HTSeq.AlignmentWithSequenceReversal(*read\_as\_aligned*, *iv*)[](#HTSeq.AlignmentWithSequenceReversal "Permalink to this definition")
:   Some aligners store the reverse complement of the read if it was
    aligned to the ‘-’ strand. For these aligners, the Alignment class is derived
    from `AlignmentWithSequenceReversal`, which undoes the reverse-complement if necessary
    to ensure that the `read` attribute always presents the read in the ordder in which
    it was sequenced.

    To get better performance, this is done via lazy evaluation, i.e., the
    reverse complement is only calculated when the `read` attribute is accessed
    for the first time. The original read as read from the file is stored as well. You
    can access both with these attributes:

    read\_as\_aligned[](#HTSeq.AlignmentWithSequenceReversal.read_as_aligned "Permalink to this definition")
    :   A [`SequenceWithQualities`](sequences.html#HTSeq.SequenceWithQualities "HTSeq.SequenceWithQualities") object. The read as it was found in the file.

    read\_as\_sequenced[](#HTSeq.AlignmentWithSequenceReversal.read_as_sequenced "Permalink to this definition")
    :   A [`SequenceWithQualities`](sequences.html#HTSeq.SequenceWithQualities "HTSeq.SequenceWithQualities") object. The read as it was sequenced,
        i.e., an alias for [`Alignment.read`](#HTSeq.Alignment.read "HTSeq.Alignment.read").

## Format-specific Alignment classes[](#format-specific-alignment-classes "Permalink to this heading")

Note: All format-specific Alignment classes take a string as argument for their constructor. This
is a line from the alignment file describing the alignment and is passed in by the corresponding
`Reader` object. As you do not create `Alignment` objects yourself but get them from the `Reader`
object you typically never call the constructor yourself.

*class* HTSeq.BowtieAlignment(*bowtie\_line*)[](#HTSeq.BowtieAlignment "Permalink to this definition")
:   `BowtieAlignment` objects contain all the attributes from [`Alignment`](#HTSeq.Alignment "HTSeq.Alignment") and
    [`AlignmentWithSequenceReversal`](#HTSeq.AlignmentWithSequenceReversal "HTSeq.AlignmentWithSequenceReversal"), and, in addition, these:

    reserved[](#HTSeq.BowtieAlignment.reserved "Permalink to this definition")
    :   A string. The `reserved` field from the Bowtie output file. See the Bowtie manual for its meaning.

    substitutions[](#HTSeq.BowtieAlignment.substitutions "Permalink to this definition")
    :   A string. The substitutions string that describes mismatches in the format `22:A>C, 25:C>T`
        to indicate a change from A to C in position 22 and from C to T in position 25.
        No further parsing for this is offered yet.

*class* HTSeq.SAM\_Alignment(*line*)[](#HTSeq.SAM_Alignment "Permalink to this definition")
:   `SAM_Alignment` objects contain all the attributes from [`Alignment`](#HTSeq.Alignment "HTSeq.Alignment") and
    [`AlignmentWithSequenceReversal`](#HTSeq.AlignmentWithSequenceReversal "HTSeq.AlignmentWithSequenceReversal"), and, in addition, these:

    aQual[](#HTSeq.SAM_Alignment.aQual "Permalink to this definition")
    :   An int. The alignment quality score in Phread style encoding.

    cigar[](#HTSeq.SAM_Alignment.cigar "Permalink to this definition")
    :   A list of [`CigarOperation`](#HTSeq.CigarOperation "HTSeq.CigarOperation") objects, as parsed from the extended CIGAR string. See
        [`CigarOperation`](#HTSeq.CigarOperation "HTSeq.CigarOperation") for details.

    not\_primary\_alignment[](#HTSeq.SAM_Alignment.not_primary_alignment "Permalink to this definition")
    :   A boolean. Whether the alignment is secondary. (See SAM format reference, flag 0x0100. See also supplementary alignments, flag 0x0800.)

    failed\_platform\_qc[](#HTSeq.SAM_Alignment.failed_platform_qc "Permalink to this definition")
    :   A boolean. Whether the read failed a platform quality check. (See SAM format reference, flag 0x0200.)

    pcr\_or\_optical\_duplicate[](#HTSeq.SAM_Alignment.pcr_or_optical_duplicate "Permalink to this definition")
    :   A boolean. Whether the read is a PCR or optical duplicate. (See SAM format reference, flag 0x0400.)

    supplementary[](#HTSeq.SAM_Alignment.supplementary "Permalink to this definition")
    :   A boolean. Whether the alignment is supplementary. (See SAM format reference, flag 0x0800.)

    These methods access the optional fields:

    optional\_field(*tag*)[](#HTSeq.SAM_Alignment.optional_field "Permalink to this definition")
    :   Returns the optional field `tag`. See SAM format reference for the defined tags (which
        are two-letter strings).

    optional\_fields[](#HTSeq.SAM_Alignment.optional_fields "Permalink to this definition")
    :   Returns a dict with all optional fields, using their tags as keys.

    This method is useful to write out a SAM file:

    get\_sam\_line()[](#HTSeq.SAM_Alignment.get_sam_line "Permalink to this definition")
    :   Constructs a SAM line to describe the alignment, which is returned as a string.

    **Paired-end support**

    > SAM\_Alignment objects can represent paired-end data. If [`Alignment.paired_end`](#HTSeq.Alignment.paired_end "HTSeq.Alignment.paired_end") is True,
    > the following fields may be used:
    >
    > mate\_aligned[](#HTSeq.SAM_Alignment.mate_aligned "Permalink to this definition")
    > :   A boolean. Whether the mate was aligned
    >
    > pe\_which[](#HTSeq.SAM_Alignment.pe_which "Permalink to this definition")
    > :   A string. Takes one of the values “first”, “second”, “unknown” and “not\_paired\_end”, to indicate
    >     whether the read stems from the first or second pass of the paired-end sequencing.
    >
    > proper\_pair[](#HTSeq.SAM_Alignment.proper_pair "Permalink to this definition")
    > :   Boolean. Whether the mates form a proper pair. (See SAM format reference, flag 0x0002.)
    >
    > mate\_start[](#HTSeq.SAM_Alignment.mate_start "Permalink to this definition")
    > :   A [`GenomicPosition`](genomic.html#HTSeq.GenomicPosition "HTSeq.GenomicPosition") object. The start (i.e., left-most position) of the mate’s alignment.
    >     Note that mate\_start.strand is opposite to iv.strand for proper pairs.
    >
    > inferred\_insert\_size[](#HTSeq.SAM_Alignment.inferred_insert_size "Permalink to this definition")
    > :   An int. The inferred size of the insert between the reads.

HTSeq.pair\_SAM\_alignments(*alnmt\_seq*)[](#HTSeq.pair_SAM_alignments "Permalink to this definition")
:   This function takes a generator of [`SAM_Alignment`](#HTSeq.SAM_Alignment "HTSeq.SAM_Alignment") objects (e.g.,
    a [`BAM_Reader`](#HTSeq.BAM_Reader "HTSeq.BAM_Reader") object) and yields a sequence of pairs of alignments.
    A typical use may be:

    ```
    for first, second in HTSeq.BAM_Reader( "some_paired_end_data.sam" ):
        print("Pair, consisting of")
        print("   ", first)
        print("   ", second)
    ```

    Here, `first` and `second` are [`SAM_Alignment`](#HTSeq.SAM_Alignment "HTSeq.SAM_Alignment") objects, representing two reads
    of the same cluster. For this to work, the SAM file has to be arranged such that
    paired reads are always in adjacent lines. As the SAM format requires that the query names
    (first column of the SAM file) is the same for mate pairs, this arrangement can easily be
    achieved by sorting the SAM file lines lexicographically.

    Special care is taken to properly pair up multiple alignment lines for the same read.

    In the SAM format, alignments for paired-end reads must be reported in paired alignment
    records. If the mate of an alignment record is missing, this fact is counted and, at the
    end, a warning stating the number of such violating reads is issued. The singleton
    alignments are yielded as pairs, with the alignment in the first or second
    element of the pair (depending on the sequencing pass it originates from) and the other
    element is set to `None`.

HTSeq.pair\_SAM\_alignments\_with\_buffer(*alignments*, *max\_buffer\_size=3000000*)[](#HTSeq.pair_SAM_alignments_with_buffer "Permalink to this definition")
:   This function pai