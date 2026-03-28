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
* Other parsers
* [Miscellaneous](misc.html)
* [`htseq-count`: counting reads within features](htseqcount.html)
* [`htseq-count-barcodes`: counting reads with cell barcodes and UMIs](htseqcount_with_barcodes.html)
* [Quality Assessment with `htseq-qa`](qa.html)
* [Version history](history.html)
* [Contributing](contrib.html)

[HTSeq](index.html)

* Other parsers
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/otherparsers.rst)

---

# Other parsers[](#other-parsers "Permalink to this heading")

## `VCF_Reader` and `VariantCall`[](#vcf-reader-and-variantcall "Permalink to this heading")

VCF is a text file format (most likely stored in a compressed manner). It contains meta-information lines, a header line, and then data lines each containing information about a position in the genome.

There is an option whether to contain genotype information on samples for each position or not.

See the definitions at

As usual, there is a parser class, called **VCF\_Reader**, that can generate an
iterator of objects describing the structural variant calls. These objects are of type [`VariantCall`](#HTSeq.VariantCall "HTSeq.VariantCall")
and each describes one line of a VCF file. See below for an example.

*class* HTSeq.VCF\_Reader(*filename\_or\_sequence*)[](#HTSeq.VCF_Reader "Permalink to this definition")
:   As a subclass of [`FileOrSequence`](misc.html#HTSeq.FileOrSequence "HTSeq.FileOrSequence"), VCF\_Reader can be initialized either
    with a file name or with an open file or another sequence of lines.

    When requesting an iterator, it generates objects of type [`VariantCall`](#HTSeq.VariantCall "HTSeq.VariantCall").

    > metadata[](#HTSeq.VCF_Reader.metadata "Permalink to this definition")
    > :   VCF\_Reader skips all lines starting with a single ‘#’ as this marks
    >     a comment. However, lines starying with ‘##’ contain meta data (Information about filters, and the fields in the ‘info’-column).
    >
    > parse\_meta(*header\_filename=None*)[](#HTSeq.VCF_Reader.parse_meta "Permalink to this definition")
    > :   The VCF\_Reader normally does not parse the meta-information and also the [`VariantCall`](#HTSeq.VariantCall "HTSeq.VariantCall") does not contain unpacked metainformation. The function parse\_meta reads the header information either from the attached [`FileOrSequence`](misc.html#HTSeq.FileOrSequence "HTSeq.FileOrSequence") or from a file connection being opened to a provided ‘header-filename’. This is important if you want to access sample-specific information for the :class`VariantCall`s in your .vcf-file.
    >
    > make\_info\_dict()[](#HTSeq.VCF_Reader.make_info_dict "Permalink to this definition")
    > :   This function will parse the info string and create the attribute `infodict` which contains a dict
    >     with key:value-pairs containig the type-information for each entry of the [`VariantCall`](#HTSeq.VariantCall "HTSeq.VariantCall")’s info field.

*class* HTSeq.VariantCall(*line*, *nsamples=0*, *sampleids=[]*)[](#HTSeq.VariantCall "Permalink to this definition")
:   A VariantCall object always contains the following attributes:

    > alt[](#HTSeq.VariantCall.alt "Permalink to this definition")
    > :   The alternative base(s) of the [`VariantCall`](#HTSeq.VariantCall "HTSeq.VariantCall"). This is a list containing all called alternatives.
    >
    > chrom[](#HTSeq.VariantCall.chrom "Permalink to this definition")
    > :   The Chromosome on which the [`VariantCall`](#HTSeq.VariantCall "HTSeq.VariantCall") was called.
    >
    > filter[](#HTSeq.VariantCall.filter "Permalink to this definition")
    > :   This specifies if the [`VariantCall`](#HTSeq.VariantCall "HTSeq.VariantCall") passed all the filters given in the .vcf-header (value=PASS) or
    >     contains a list of filters that failed (the filter-id’s are specified in the header also).
    >
    > format[](#HTSeq.VariantCall.format "Permalink to this definition")
    > :   Contains the format string specifying which per-sample information is stored
    >     in [`VariantCall.samples`](#HTSeq.VariantCall.samples "HTSeq.VariantCall.samples").
    >
    > id[](#HTSeq.VariantCall.id "Permalink to this definition")
    > :   The id of the [`VariantCall`](#HTSeq.VariantCall "HTSeq.VariantCall"), if it has been found in any database, for unknown variants this will be
    >     “.”.
    >
    > info[](#HTSeq.VariantCall.info "Permalink to this definition")
    > :   This will contain either the string version of the info field for this [`VariantCall`](#HTSeq.VariantCall "HTSeq.VariantCall") or a dict with the
    >     parsed and processed info-string.
    >
    > pos[](#HTSeq.VariantCall.pos "Permalink to this definition")
    > :   A [`HTSeq.GenomicPosition`](genomic.html#HTSeq.GenomicPosition "HTSeq.GenomicPosition") that specifies the position of the [`VariantCall`](#HTSeq.VariantCall "HTSeq.VariantCall").
    >
    > qual[](#HTSeq.VariantCall.qual "Permalink to this definition")
    > :   The quality of the [`VariantCall`](#HTSeq.VariantCall "HTSeq.VariantCall").
    >
    > ref[](#HTSeq.VariantCall.ref "Permalink to this definition")
    > :   The reference base(s) of the [`VariantCall`](#HTSeq.VariantCall "HTSeq.VariantCall").
    >
    > samples[](#HTSeq.VariantCall.samples "Permalink to this definition")
    > :   A dict mapping sample-id’s to subdicts which use the [`VariantCall.format`](#HTSeq.VariantCall.format "HTSeq.VariantCall.format") as
    >     keys to store the per-sample information.
    >
    > unpack\_info(*infodict*)[](#HTSeq.VariantCall.unpack_info "Permalink to this definition")
    > :   This function parses the info-string and replaces it with a dict rperesentation if the infodict of the
    >     originating VCF\_Reader is provided.

Example Workflow for reading the dbSNP in VCF-format (obtained from dbSNP <ftp://ftp.ncbi.nih.gov/snp/organisms/human\_9606/VCF/v4.0/00-All.vcf.gz>\_):

```
>>> vcfr = HTSeq.VCF_Reader( "00-All.vcf.gz" )
>>> vcfr.parse_meta()
>>> vcfr.make_info_dict()
>>> for vc in vcfr:
...    print vc,
1:10327:'T'->'C'
1:10433:'A'->'AC'
1:10439:'AC'->'A'
1:10440:'C'->'A'
```

*FIXME* The example above is not run, as the example file is still missing!

## Wiggle Reader[](#wiggle-reader "Permalink to this heading")

The [Wiggle format](http://genome.ucsc.edu/goldenPath/help/wiggle.html) (file extension often `.wig`) is a format to describe numeric scores assigned to base-pair positions on a genome.
The class [`WiggleReader`](#HTSeq.WiggleReader "HTSeq.WiggleReader") is parser for such files.

*class* HTSeq.WiggleReader(*filename\_or\_sequence*, *verbose=True*)[](#HTSeq.WiggleReader "Permalink to this definition")
:   The class is instatiated with the file name of a Wiggle file, or a sequence of lines in Wiggle format. A `WiggleReader`
    object generates an iterator, which yields pairs of the form `(iv, score)`, where `iv` is a [`GenomicInterval`](genomic.html#HTSeq.GenomicInterval "HTSeq.GenomicInterval")
    object and `score` is a `float` with the score that the file assigns to the specified interval. If `verbose` is set to
    True, the user is alerted to skipped lines (comments or `browser` lines) by a message printed to the standard output.

## BED Reader[](#bed-reader "Permalink to this heading")

The [BED format](http://genome.ucsc.edu/FAQ/FAQformat.html#format1) is a format originally used to describe gene models but is also commonly used to describe other genomic features.

*class* HTSeq.BED\_Reader(*filename\_or\_sequence*)[](#HTSeq.BED_Reader "Permalink to this definition")
:   The class is instatiated with the file name of a BED file, or a sequence of lines in BED format. A `BED_Reader`
    object generates an iterator, which yields a [`GenomicFeature`](features.html#HTSeq.GenomicFeature "HTSeq.GenomicFeature") object for each line in the BED file (except for
    lines starting with `track`, which are skipped).

    The attributes of the yielded `GenomicFeature` objects are as follows:

    `iv`
    :   a [`GenomicInterval`](genomic.html#HTSeq.GenomicInterval "HTSeq.GenomicInterval") object with the coordinates as given by the 1st, 2nd, 3rd, and 6th column of the BED file. If the
        BED file has less than 6 columns, the strand is set to “`.`”.

    `name`
    :   the name of feature as given in the 4th column, or `unnamed`, if the file has only three columns

    `type`
    :   always the string `BED line`

    `score`
    :   a float with the score as given by the 5th column (or `None` if the BED file has less 5 columns).

    `thick`
    :   a [`GenomicInterval`](genomic.html#HTSeq.GenomicInterval "HTSeq.GenomicInterval") object containg the “thick” part of the feature, as specified by the 6th and 7th column, with chromosome
        and strand copied from `iv` (or `None` if the BED file has less 7 columns).

    `itemRgb`
    :   a list of three `int` values, taken from the 8th column (`None` if the BED file has less 8 columns). In a BED file, this triple
        is meant to specify the colour in which the feature should be drawn in a browser.

## BigWig Reader[](#bigwig-reader "Permalink to this heading")

The [BigWig format](http://genome.ucsc.edu/goldenPath/help/bigWig.html) is a binary, compressed version of both Wiggle and bedGraph.
`HTSeq` supports it via [pyBigWig](https://github.com/deeptools/pyBigWig) (a great library, btw, thank you!), mainly for use
with [`GenomicArray`](genomic.html#HTSeq.GenomicArray "HTSeq.GenomicArray") instances, i.e. sparse data on genomic intervals.

*class* HTSeq.BigWig\_Reader(*filename*)[](#HTSeq.BigWig_Reader "Permalink to this definition")
:   This class is instantiated with the name of or path to a BigWig file.
    The file is opened upon instantiation, and the class can be used as a context manager
    (i.e. using “with”).

Methods
:   BigWig\_Reader.chroms()[](#HTSeq.BigWig_Reader.chroms "Permalink to this definition")
    :   Return the list of chromosomes and their lengths, as a dictionary.

        Example:

        bw.chroms() -> {‘chr1’: 4568999, ‘chr2’: 87422, …}

    HTSeq.intervals(*self*, *chrom*, *strand='.'*, *raw=False*)[](#HTSeq.intervals "Permalink to this definition")
    :   Lazy iterator over genomic intervals

        Args:
        :   `chrom (str)`: The chromosome/scaffold to find intervals for.

            `strand ('.', '+', or '-')`: Strandedness of the yielded [`GenomicInterval`](genomic.html#HTSeq.GenomicInterval "HTSeq.GenomicInterval"). If raw=True, this argument is ignored.

            `raw (bool)`: If `True`, return the raw triplet from pyBigWig. If `False`, return the result wrapped in a GenomicInterval with the appropriate strandedness.

[Previous](features.html "Features")
[Next](misc.html "Miscellaneous")

---

© Copyright 2010-2022, the HTSeq team.
Revision `726a1432`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).