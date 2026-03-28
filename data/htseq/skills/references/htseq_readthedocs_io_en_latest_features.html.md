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
* Features
* [Other parsers](otherparsers.html)
* [Miscellaneous](misc.html)
* [`htseq-count`: counting reads within features](htseqcount.html)
* [`htseq-count-barcodes`: counting reads with cell barcodes and UMIs](htseqcount_with_barcodes.html)
* [Quality Assessment with `htseq-qa`](qa.html)
* [Version history](history.html)
* [Contributing](contrib.html)

[HTSeq](index.html)

* Features
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/features.rst)

---

# Features[](#features "Permalink to this heading")

The easiest way to work with annotation is to use [`GenomicArray`](genomic.html#HTSeq.GenomicArray "HTSeq.GenomicArray") with `typecode=='O'`
or [`GenomicArrayOfSets`](genomic.html#HTSeq.GenomicArrayOfSets "HTSeq.GenomicArrayOfSets"). If you have your annotation in a flat file, with each
line describing a feature and giving its coordinates, you can read in the file line for line,
parse it (see the standard Python module `csv`), use the information on chromosome, start,
end and strand to create a [`GenomicInterval`](genomic.html#HTSeq.GenomicInterval "HTSeq.GenomicInterval") object and then store the data from the line
in the genomic array at the place indicated by the genomic interval.

For example, if you have data in a tab-separated file as follows:

```
>>> for line in open("feature_list.txt"):
...     print(line)
chr2  100    300     +       "gene A"
chr2 200     400     -       "gene B"
chr3 150     270     +       "gene C"
```

Then, you could load this information as follows:

```
>>> import csv
>>> genes = HTSeq.GenomicArray(["chr1", "chr2", "chr3"], typecode='O')
>>> for (chrom, start, end, strand, name) in \
...        csv.reader(open("feature_list.txt"), delimiter="\t"):
...     iv = HTSeq.GenomicInterval(chrom, int(start), int(end), strand)
...     genes[iv] = name
```

Now, to see whether there is a feature at a given [`GenomicPosition`](genomic.html#HTSeq.GenomicPosition "HTSeq.GenomicPosition"), you just query the
genomic array:

```
>>> print(genes[HTSeq.GenomicPosition("chr3", 100, "+")])
None
>>> print(genes[HTSeq.GenomicPosition("chr3", 200, "+")])
gene C
```

See [`GenomicArray`](genomic.html#HTSeq.GenomicArray "HTSeq.GenomicArray") and [`GenomicArrayOfSets`](genomic.html#HTSeq.GenomicArrayOfSets "HTSeq.GenomicArrayOfSets") for more sophisticated use.

## `GFF_Reader` and `GenomicFeature`[](#gff-reader-and-genomicfeature "Permalink to this heading")

One of the most common format for annotation data is [GFF](http://www.sanger.ac.uk/resources/software/gff/spec.html) (which includes [GTF](http://mblab.wustl.edu/GTF22.html) as
a sub-type). Hence, a parse for GFF files is included in HTSeq.

As usual, there is a parser class, called **GFF\_Reader**, that can generate an
iterator of objects describing the features. These objects are of type :class`GenomicFeature`
and each describes one line of a GFF file. See Section [A tour through HTSeq](tour.html#tour) for an example.

*class* HTSeq.GFF\_Reader(*filename\_or\_sequence*, *end\_included=True*)[](#HTSeq.GFF_Reader "Permalink to this definition")
:   As a subclass of [`FileOrSequence`](misc.html#HTSeq.FileOrSequence "HTSeq.FileOrSequence"), GFF\_Reader can be initialized either
    with a file name or with an open file or another sequence of lines.

    When requesting an iterator, it generates objects of type [`GenomicFeature`](#HTSeq.GenomicFeature "HTSeq.GenomicFeature").

    The GFF specification is unclear on whether the end coordinate marks the last
    base-pair of the feature (closed intervals, `end_included=True`) or the one
    after (half-open intervals, `end_included=False`). The default, True, is
    correct for Ensembl GTF files. If in doubt, look for a CDS or stop\_codon
    feature in you GFF file. Its length should be divisible by 3. If “end-start”
    is divisible by 3, you need `end_included=False`. If “end-start+1” is
    divisible by 3, you need `end_included=True`.

    GFF\_Reader will convert the coordinates from GFF standard (1-based, end
    maybe included) to HTSeq standard (0-base, end not included) by subtracting
    1 from the start position. This is also Python’s indexing standard. If
    `end_included=False`, the end was one-after already in the GFF, so HTSeq
    will also subtract 1 from the end position.

    > metadata[](#HTSeq.GFF_Reader.metadata "Permalink to this definition")
    > :   GFF\_Reader skips all lines starting with a single ‘#’ as this marks
    >     a comment. However, lines starying with ‘##’ contain meta data (at least
    >     accoring to the Sanger Institute’s version of the GFF standard.) Such meta
    >     data has the format `##key value`. When a metadata line is encountered,
    >     it is added to the `metadata` dictionary.

*class* HTSeq.GenomicFeature(*name*, *type\_*, *interval*)[](#HTSeq.GenomicFeature "Permalink to this definition")
:   A GenomicFeature object always contains the following attributes:

    > name[](#HTSeq.GenomicFeature.name "Permalink to this definition")
    > :   A name of ID for the feature. As the GFF format does not have a dedicated
    >     field for this, the value of the first attribute in the *attributes* column is
    >     assumed to be the name of ID.
    >
    > type[](#HTSeq.GenomicFeature.type "Permalink to this definition")
    > :   The type of the feature, i.e., a string like `"exon"` or `"gene"`. For GFF
    >     files, the 3rd column (*feature*) is taken as the type.
    >
    > interval[](#HTSeq.GenomicFeature.interval "Permalink to this definition")
    > :   The interval that the feature covers on the genome. For GFF files, this information is taken
    >     from the first (*seqname*), the forth (*start*), the fifth (*end*), and the seventh (*strand*)
    >     column.

    When created by a [`GFF_Reader`](#HTSeq.GFF_Reader "HTSeq.GFF_Reader") object, the following attributes are also present, with the information
    from the remaining GFF columns:

    > source[](#HTSeq.GenomicFeature.source "Permalink to this definition")
    > :   The 2nd column, denoted *source* in the specification, and intended to specify the
    >     data source.
    >
    > frame[](#HTSeq.GenomicFeature.frame "Permalink to this definition")
    > :   The 8th column (*frame*), giving the reading frame in case of a coding feature. Its value
    >     is an integer (0, 1, or 2), or the string `'.'` in case that a frame is not specified or would not make sense.
    >
    > score[](#HTSeq.GenomicFeature.score "Permalink to this definition")
    > :   The 6th column (*score*), giving some numerical score for the feature. Its value
    >     is a float, or `'.'` in case that a score is not specified or would not make sense
    >
    > attr[](#HTSeq.GenomicFeature.attr "Permalink to this definition")
    > :   The last (9th) column of a GFF file contains *attributes*, i.e. a list of name/value pairs.
    >     These are transformed into a dict, such that, e.g., `gf.attr['gene_id']` gives the value
    >     of the attribute `gene_id` in the feature described by `GenomicFeature` object `gf`.
    >     The parser for the attribute field is reasonably flexible to deal with format variations
    >     (it was never clearly established whetehr name and value should be sperarated by a colon or an
    >     equal sign, and whether quotes need to be used) and also does a URL style decoding, as is often
    >     required.

    In order to write a GFF file from a sequence of features, this method is provided:

    > get\_gff\_line(*with\_equal\_sign=False*)[](#HTSeq.GenomicFeature.get_gff_line "Permalink to this definition")
    > :   Returns a line to describe the feature in the GFF format. This works even if the optional
    >     attributes given above are missing. Call this for each of your `GenomicFeature` objects
    >     and write the lines into a file to get a GFF file.

HTSeq.parse\_GFF\_attribute\_string(*attrStr*, *extra\_return\_first\_value=False*)[](#HTSeq.parse_GFF_attribute_string "Permalink to this definition")
:   This is the function that [`GFF_Reader`](#HTSeq.GFF_Reader "HTSeq.GFF_Reader") uses to parse the attribute column. (See [`GenomicFeature.attr`](#HTSeq.GenomicFeature.attr "HTSeq.GenomicFeature.attr").)
    It returns a dict, or, if requested, a pair of the dict and the first value.

HTSeq.make\_feature\_genomicarrayofsets(*feature\_sequence*, *id\_attribute*, *feature\_type=None*, *feature\_query=None*, *additional\_attributes=None*, *stranded=False*, *verbose=False*, *add\_chromosome\_info=False*)[](#HTSeq.make_feature_genomicarrayofsets "Permalink to this definition")
:   Organize a sequence of Feature objects into a GenomicArrayOfSets.

    Parameters
    :   * **feature\_sequence** (*iterable* *of* *Feature*) – A sequence of features, e.g. as obtained from GFF\_reader(‘myfile.gtf’)
        * **id\_attribute** (*string* *or* *sequence* *of* *strings*) – An attribute to use to identify the feature in the output data structures (e.g.
          ‘gene\_id’). If this is a list, the combination of all those attributes, separated
          by colons (:), will be used as an identifier. For instance,
          [‘gene\_id’, ‘exon\_number’] uniquely identifies specific exons.
        * **feature\_type** (*string* *or* *None*) – If None, collect all features. If a string, restrict to only one type of features,
          e.g. ‘exon’.
        * **feature\_query** (*string* *or* *None*) – If None, all features of the selected types will be collected. If a string, it has
          to be in the format: <feature\_attribute> == <attr\_value>, e.g. ‘gene\_id == “Fn1”’
          (note the double quotes inside). Then only that feature will be collected. Using
          this argument is more efficient than collecting all features and then pruning it
          down to a single one.
        * **additional\_attributes** (*list* *or* *None*) – A list of additional attributes to be collected into a separate dict for the same
          features, for instance [‘gene\_name’]
        * **stranded** (*bool*) – Whether to keep strandedness information
        * **verbose** (*bool*) – Whether to output progress and error messages
        * **add\_chromosome\_info** (*bool*) – Whether to add chromosome information for each feature. If this option is True,
          the fuction appends at the end of the “additional\_attributes” list a
          “Chromosome” attribute.

    Returns
    :   A dict with two keys, ‘features’ with the GenomicArrayOfSets populated
        with the features, and ‘attributes’ which is itself a dict with
        the id\_attribute as keys and the additional attributes as values.

    Example: Let’s say you load the C. elegans GTF file from Ensembl and make a
    feature dict:

    ```
    >>> gff = HTSeq.GFF_Reader("Caenorhabditis_elegans.WS200.55.gtf.gz")
    >>> worm_features = HTSeq.make_feature_genomicarrayofsets(gff, 'gene_id')
    ```

    (This command may take a few minutes to deal with the 430,000 features
    in the GTF file. Note that you may need a lot of RAM if you have millions
    of features.)

    This function is related but distinct from `HTSeq.make_feature_dict`. This
    function is used in htseq-count and its barcoded twin to count gene
    expression because the output GenomicArrayofSets is very efficient. You
    can use it in performance-critical scans of GFF files.

[Previous](alignments.html "Read alignments")
[Next](otherparsers.html "Other parsers")

---

© Copyright 2010-2022, the HTSeq team.
Revision `726a1432`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).