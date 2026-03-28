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
* `htseq-count`: counting reads within features
* [`htseq-count-barcodes`: counting reads with cell barcodes and UMIs](htseqcount_with_barcodes.html)
* [Quality Assessment with `htseq-qa`](qa.html)
* [Version history](history.html)
* [Contributing](contrib.html)

[HTSeq](index.html)

* `htseq-count`: counting reads within features
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/htseqcount.rst)

---

# `htseq-count`: counting reads within features[](#htseq-count-counting-reads-within-features "Permalink to this heading")

Given a file with aligned sequencing reads and a list of genomic
features, a common task is to count how many reads map to each feature.

A feature is here an interval (i.e., a range of positions) on a chromosome
or a union of such intervals.

In the case of RNA-Seq, the features are typically genes, where each gene
is considered here as the union of all its exons. One may also consider
each exon as a feature, e.g., in order to check for alternative splicing.
For comparative ChIP-Seq, the features might be binding region from a
pre-determined list.

Special care must be taken to decide how to deal with reads that align to or
overlap with more than one feature. The `htseq-count` script allows to
choose between three modes. Of course, if none of these fits your needs,
you can write your own script with HTSeq. See the chapter [A tour through HTSeq](tour.html#tour) for a
step-by-step guide on how to do so. See also the FAQ at the end, if the
following explanation seems too technical.

The three overlap resolution modes of `htseq-count` work as follows. For
each position i in the read, a set S(i) is defined as the set of all
features overlapping position i. Then, consider the set S, which is
(with i running through all position within the read or a read pair)

* the union of all the sets S(i) for mode `union`. This mode is recommended for most use cases.
* the intersection of all the sets S(i) for mode `intersection-strict`.
* the intersection of all non-empty sets S(i) for mode `intersection-nonempty`.

If S contains precisely one feature, the read (or read pair) is counted for this feature. If
S is empty, the read (or read pair) is counted as `no_feature`. If S
contains more than one feature, `htseq-count` behaves differently based on
the `--nonunique` option:

* `--nonunique none` (default): the read (or read pair) is counted as
  `ambiguous` and not counted for any features. Also, if the read (or read
  pair) aligns to more than one location in the reference, it is scored as
  `alignment_not_unique`.
* `--nonunique all`: the read (or read pair) is counted as `ambiguous`
  and is also counted in all features to which it was assigned. Also, if the
  read (or read pair) aligns to more than one location in the reference, it is
  scored as `alignment_not_unique` and also separately for each location.
* `--nonunique fraction`: the read (or read pair) is counted as `ambiguous`
  and is also counted fractionally in all features to which it was assigned. For
  example, if the read overlaps with 3 features, it will be counted 1/3 to each of them.
* `--nonunique random`: the read (or read pair) is counted as `ambiguous`
  and is also counted uniformly at random to `one of` the features to which it was
  assigned.

Notice that when using `--nonunique all` the sum of all counts will not
be equal to the number of reads (or read pairs), because those with multiple
alignments or overlaps get scored multiple times. By contrast, with
`--nonunique fraction` or `--nonunique random`, the sum of all counts
will be equal to the number of reads (or read pairs).

The following figure illustrates the effect of these three modes and the
`--nonunique` option:

![_images/count_modes.png](_images/count_modes.png)

## Usage[](#usage "Permalink to this heading")

After you have installed HTSeq (see [Installation](install.html#install)), you can run `htseq-count` from
the command line:

```
htseq-count [options] <alignment_files> <gtf_file>
```

If the file `htseq-count` is not in your path, you can, alternatively, call the script with

```
python -m HTSeq.scripts.count [options] <alignment_files> <gtf_file>
```

The `<alignment_files>` are one or more files containing the aligned reads in
SAM/BAM/CRAM format. Under the hood, we use [pysam](https://pysam.readthedocs.io/en/latest/) for automatic file type detection,
so whatever [pysam](https://pysam.readthedocs.io/en/latest/) can parse we can too ([SAMtools](http://www.htslib.org/) can convert most alignment formats
to one of these.) Make sure to use a splicing-aware aligner such as [STAR](https://github.com/alexdobin/STAR).
htseq-count makes full use of the information in the CIGAR field.

To read from standard input, use `-` as `<alignment_files>`.

If you have paired-end data, pay attention to the `-r` option described below.

The `<gtf_file>` contains the features in the [GTF format](http://www.sanger.ac.uk/resources/software/gff/spec.html).

The script outputs a table with counts for each feature, followed by
the special counters, which count reads that were not counted for any feature
for various reasons. The names of the special counters all start with
a double underscore, to facilitate filtering. (Note: The double unscore
was absent up to version 0.5.4). The special counters are:

* `__no_feature`: reads (or read pairs) which could not be assigned to any feature
  (set S as described above was empty).
* `__ambiguous`: reads (or read pairs) which could have been assigned to more than
  one feature and hence were not counted for any of these, unless the
  `--nonunique all` option was used (set S had more than one element).
* `__too_low_aQual`: reads (or read pairs) which were skipped due to the `-a`
  option, see below
* `__not_aligned`: reads (or read pairs) in the SAM file without alignment
* `__alignment_not_unique`: reads (or read pairs) with more than one reported alignment.
  These reads are recognized from the `NH` optional SAM field tag.
  (If the aligner does not set this field, multiply aligned reads will
  be counted multiple times, unless they getv filtered out by due to the `-a` option.)
  Note that if the `--nonunique all` option was used, these reads (or read pairs)
  are still assigned to features.

*Important:* The default for strandedness is *yes*. If your RNA-Seq data has not been made
with a strand-specific protocol, this causes half of the reads to be lost.
Hence, make sure to set the option `--stranded=no` unless you have strand-specific
data!

*Important:* For paired-end reads, although position-sorted BAM files are supported, unsorted BAM files (i.e. in which the two reads of the pair are in consecutive lines of the BAM file) are highly recommended for htseq-count. If you are having trouble or unexpected results, sort your BAM file by name and try again.

### Options[](#options "Permalink to this heading")

-f <format>, --format=<format>[](#cmdoption-htseq-count-f "Permalink to this definition")
:   Format of the input data. Possible values are `sam` (for text SAM files)
    and `bam` (for binary BAM files). Default is `sam`.

    DEPRECATED: Modern versions of samtools/htslibs, which HTSeq uses to access
    SAM/BAM/CRAM files, have automatic file type detection. This flag will be
    removed in future versions of htseq-count.

-r <order>, --order=<order>[](#cmdoption-htseq-count-r "Permalink to this definition")
:   For paired-end data, the alignment have to be sorted either by read name or
    by alignment position. If your data is not sorted, use the `samtools sort`
    function of `samtools` to sort it. Use this option, with `name` or `pos`
    for `<order>` to indicate how the input data has been sorted. The default
    is `name`.

    If `name` is indicated, `htseq-count` expects all the alignments for the
    reads of a given read pair to appear in adjacent records in the input data.
    For `pos`, this is not expected; rather, read alignments whose mate alignment
    have not yet been seen are kept in a buffer in memory until the mate is found.
    While, strictly speaking, the latter will also work with unsorted data, sorting
    ensures that most alignment mates appear close to each other in the data
    and hence the buffer is much less likely to overflow.

--max-reads-in-buffer=<number>[](#cmdoption-htseq-count-max-reads-in-buffer "Permalink to this definition")
:   When <alignment\_file> is paired end sorted by position, allow only so many
    reads to stay in memory until the mates are found (raising this number will use
    more memory). Has no effect for single end or paired end sorted by name.
    (default: `30000000`)

-s <yes/no/reverse>, --stranded=<yes/no/reverse>[](#cmdoption-htseq-count-s "Permalink to this definition")
:   Whether the data is from a strand-specific assay (default: `yes`)

    For `stranded=no`, a read is considered overlapping with a feature regardless
    of whether it is mapped to the same or the opposite strand as the feature.
    For `stranded=yes` and single-end reads, the read has to be mapped to the same
    strand as the feature. For paired-end reads, the first
    read has to be on the same strand and the second read on the opposite strand.
    For `stranded=reverse`, these rules are reversed.

-a <minaqual>, --a=<minaqual>[](#cmdoption-htseq-count-a "Permalink to this definition")
:   Skip all reads with MAPQ alignment quality lower than the given
    minimum value (default: 10). MAPQ is the 5th column of a SAM/BAM
    file and its usage depends on the software used to map the reads.

-t <feature type>, --type=<feature type>[](#cmdoption-htseq-count-t "Permalink to this definition")
:   Feature type (3rd column in GTF file) to be used, all
    features of other type are ignored (default, suitable
    for RNA-Seq analysis using an [Ensembl GTF](http://mblab.wustl.edu/GTF22.html) file: `exon`)

-i <id attribute>, --idattr=<id attribute>[](#cmdoption-htseq-count-i "Permalink to this definition")
:   GTF attribute to be used as feature ID. Several GTF lines with the same
    feature ID will be considered as parts of the same feature. The feature ID
    is used to identity the counts in the output table. The default, suitable
    for RNA-Seq analysis using an Ensembl GTF file, is `gene_id`.

--additional-attr=<id attributes>[](#cmdoption-htseq-count-additional-attr "Permalink to this definition")
:   Additional feature attributes, which will be printed as an additional column
    after the primary attribute column but before the counts column(s). The
    default is none, a suitable value to get gene names using an Ensembl GTF
    file is `gene_name`. To use more than one additional attribute, repeat
    the option in the command line more than once, with a single attribute each
    time, e.g. `--additional-attr=gene_name --additional_attr=exon_number`.

--add-chromosome-info[](#cmdoption-htseq-count-add-chromosome-info "Permalink to this definition")
:   Store information about the chromosome of each feature as an additional
    attribute (e.g. column in the TSV output file).

--feature-query=<query>[](#cmdoption-htseq-count-feature-query "Permalink to this definition")
:   Restrict to features descibed in this expression. Currently supports a single
    kind of expression: attribute == “one attr” to restrict the GFF to a single
    gene or transcript, e.g. –feature-query ‘gene\_name == “ACTB”’ - notice the
    single quotes around the argument of this option and the double quotes around
    the gene name. Broader queries might become available in the future.

-m <mode>, --mode=<mode>[](#cmdoption-htseq-count-m "Permalink to this definition")
:   Mode to handle reads overlapping more than one feature. Possible values for
    <mode> are `union`, `intersection-strict` and `intersection-nonempty`
    (default: `union`)

--nonunique=<nonunique mode>[](#cmdoption-htseq-count-nonunique "Permalink to this definition")
:   Mode to handle reads that align to or are assigned to more than one feature
    in the overlap <mode> of choice (see -m option). <nonunique mode> are
    `none`, `all`, `fraction`, and `random` (default: `none`)

--secondary-alignments=<mode>[](#cmdoption-htseq-count-secondary-alignments "Permalink to this definition")
:   Mode to handle secondary alignments (SAM flag 0x100). <mode> can be
    `score` and `ignore` (default: `score`)

--supplementary-alignments=<mode>[](#cmdoption-htseq-count-supplementary-alignments "Permalink to this definition")
:   Mode to handle supplementary/chimeric alignments (SAM flag 0x800). <mode>
    can be `score` and `ignore` (default: `score`)

-o <samout>, --samout=<samout>[](#cmdoption-htseq-count-o "Permalink to this definition")
:   Write out all SAM alignment records into SAM files (one per input file
    needed), annotating each line with its feature assignment (as an optional
    field with tag ‘XF’)

-c <countsoutput>, --counts\_output=<countsoutput>[](#cmdoption-htseq-count-c "Permalink to this definition")
:   Filename to output the counts to instead of stdout. File format is autodetected
    based on the filename suffix (extension). Supported formats: tsv, csv, mtx,
    h5ad, loom. You need anndata for h5ad and loompy for loom support. For mtx,
    h5ad, and loom formats, the data type is float32.

--counts-output-sparse[](#cmdoption-htseq-count-counts-output-sparse "Permalink to this definition")
:   Store the counts as a sparse matrix. Only used for the following output file
    formats: mtx, h5ad, loom.

-n <n>, --nprocesses=<n>[](#cmdoption-htseq-count-n "Permalink to this definition")
:   Number of parallel CPU processes to use (default: 1).
    This option is useful to process several input files at once.
    Each file will use only 1 CPU. It is possible, of course, to
    split a very large input SAM/BAM files into smaller chunks upstream
    to make use of this option.

-p <samout\_format>, --samout-format=<samout\_format>[](#cmdoption-htseq-count-p "Permalink to this definition")
:   Format to use with the –samout option, can be `bam` or `sam`
    (default: `sam`).

-q, --quiet[](#cmdoption-htseq-count-q "Permalink to this definition")
:   Suppress progress report and warnings

-h, --help[](#cmdoption-htseq-count-h "Permalink to this definition")
:   Show a usage summary and exit

--version[](#cmdoption-htseq-count-version "Permalink to this definition")
:   Show software version and exit

### Frequenctly asked questions[](#frequenc