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
* Positions, intervals and arrays
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

* Positions, intervals and arrays
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/genomic.rst)

---

# Positions, intervals and arrays[](#positions-intervals-and-arrays "Permalink to this heading")

## `GenomicPosition`[](#genomicposition "Permalink to this heading")

A `GenomicPosition` represents the position of a single base or base pair, i.e., it is
an interval of length 1, and hence, the class is a subclass of :class:GenomicInterval.

*class* HTSeq.GenomicPosition(*chrom*, *pos*, *strand='.'*)[](#HTSeq.GenomicPosition "Permalink to this definition")
:   The initialisation is as for a :class:GenomicInterval object, but no `length` argument is passed.

Attributes

> HTSeq.pos[](#HTSeq.pos "Permalink to this definition")
> :   **pos** is an alias for [`GenomicInterval.start_d`](#HTSeq.GenomicInterval.start_d "HTSeq.GenomicInterval.start_d").
>
> All other attributes of [`GenomicInterval`](#HTSeq.GenomicInterval "HTSeq.GenomicInterval") are still exposed. Refrain from
> using them, unless you want to use the object as an interval, not as a position.
> Some of them are now read-only to prevent the length to be changed.

## `GenomicInterval`[](#genomicinterval "Permalink to this heading")

A genomic interval is a consecutive stretch on a genomic sequence such as a chromosome.
It is represented by a `GenomicInterval` object.

Instantiation
:   *class* HTSeq.GenomicInterval(*chrom*, *start*, *end*, *strand*)[](#HTSeq.GenomicInterval "Permalink to this definition")
    :   `chrom` (string)
        :   The name of a sequence (i.e., chromosome, contig, or the like).

        `start` (int)
        :   The start of the interval. Even on the reverse strand,
            this is always the smaller of the two values ‘start’ and ‘end’.
            Note that all positions should be given and interpreted as 0-based value!

        `end` (int)
        :   The end of the interval. Following Python convention for
            ranges, this in one more than the coordinate of the last base
            that is considered part of the sequence.

        `strand` (string)
        :   The strand, as a single character, `'+'`, `'-'`, or `'.'`.
            `'.'` indicates that the strand is irrelevant.

Representation and string conversion
:   The class’s `__str__` method gives a space-saving description of the
    interval, the `__repr__` method is a bit more verbose:

    ```
    >>> iv = HTSeq.GenomicInterval("chr3", 123203, 127245, "+")
    >>> print(iv)
    chr3:[123203,127245)/+
    >>> iv
    <GenomicInterval object 'chr3', [123203,127245), strand '+'>
    ```

Attributes

> GenomicInterval.chrom[](#HTSeq.GenomicInterval.chrom "Permalink to this definition")
>
> GenomicInterval.start[](#HTSeq.GenomicInterval.start "Permalink to this definition")
>
> GenomicInterval.end[](#HTSeq.GenomicInterval.end "Permalink to this definition")
>
> GenomicInterval.strand[](#HTSeq.GenomicInterval.strand "Permalink to this definition")
> :   as above
>
> GenomicInterval.start\_d[](#HTSeq.GenomicInterval.start_d "Permalink to this definition")
> :   The “directional start” position. This is the position of the
>     first base of the interval, taking the strand into account. Hence,
>     this is the same as `start` except when `strand == '-'`, in which
>     case it is `end-1`.
>
>     Note that if you set `start_d`, both `start` and `end` are changed,
>     such that the interval gets the requested new directional start and its
>     length stays unchanged.
>
> GenomicInterval.end\_d[](#HTSeq.GenomicInterval.end_d "Permalink to this definition")
> :   The “directional end”: The same as `end`, unless `strand=='-'`,
>     in which case it is `start-1`. This convention allows to go from
>     `start_d` to `end_d` (not including, as usual in Python, the last
>     value) and get all bases in “reading” direction.
>
>     `end_d` is not writable.
>
> GenomicInterval.length[](#HTSeq.GenomicInterval.length "Permalink to this definition")
> :   The length is calculated as end - start. If you set the length,
>     `start_d` will be preserved, i.e., `end` is changed,
>     unless the strand is `-`, in which case `start` is changed.
>
> GenomicInterval.start\_as\_pos[](#HTSeq.GenomicInterval.start_as_pos "Permalink to this definition")
>
> GenomicInterval.end\_as\_pos[](#HTSeq.GenomicInterval.end_as_pos "Permalink to this definition")
>
> GenomicInterval.start\_d\_as\_pos[](#HTSeq.GenomicInterval.start_d_as_pos "Permalink to this definition")
>
> GenomicInterval.end\_d\_as\_pos[](#HTSeq.GenomicInterval.end_d_as_pos "Permalink to this definition")
> :   These attributes return [`GenomicPosition`](#HTSeq.GenomicPosition "HTSeq.GenomicPosition") objects referring to the
>     respective positions.

Directional instantiation
:   HTSeq.GenomicInterval\_from\_directional(*chrom*, *start\_d*, *length*, *strand='.'*)[](#HTSeq.GenomicInterval_from_directional "Permalink to this definition")
    :   This function allows to create a new `GenomicInterval` object specifying
        directional start and length instead of start and end.

Methods
:   GenomicInterval.is\_contained\_in(*iv*)[](#HTSeq.GenomicInterval.is_contained_in "Permalink to this definition")

    GenomicInterval.contains(*iv*)[](#HTSeq.GenomicInterval.contains "Permalink to this definition")

    GenomicInterval.overlaps(*iv*)[](#HTSeq.GenomicInterval.overlaps "Permalink to this definition")
    :   These methods test whether the object is contained in, contains, or overlaps
        the second `GenomicInterval` object `iv`.

        For any of of these conditions
        to be true, the `start` and `end` values have to be appropriate, and furthermore,
        the `chrom` values have to be equal and the `strand` values consistent. The latter
        means that the strands have to be the same if both intervals have strand
        information. However, if at least one of the objects has `strand == '.'`,
        the strand information of the other object is disregarded.

        Note that all three methods return `True` for identical intervals.

    GenomicInterval.range(*step=1*)[](#HTSeq.GenomicInterval.range "Permalink to this definition")

    GenomicInterval.range\_d(*step=1*)[](#HTSeq.GenomicInterval.range_d "Permalink to this definition")
    :   These methods yield iterators of :class:GenomicPosition objects from
        `start` to `end` (or, for `range_d` from `start_d` to `end_d`).

    GenomicInterval.extend\_to\_include(*iv*)[](#HTSeq.GenomicInterval.extend_to_include "Permalink to this definition")
    :   Change the object’s `start` end `end` values such that `iv` becomes contained.

Special methods

> `GenomicInterval` implements the methods necessary for
>
> * obtaining a copy of the object (the `copy` method)
> * pickling the object
> * representing the object and converting it to a string (see above)
> * comparing two GenomicIntervals for equality and inequality
> * hashing the object

## `GenomicArray`[](#genomicarray "Permalink to this heading")

A `GenomicArray` is a collection of `ChromVector` objects, either one or two
for each chromosome of a genome. It allows to access the data in these
transparently via [`GenomicInterval`](#HTSeq.GenomicInterval "HTSeq.GenomicInterval") objects.

**Note: ``GenomicArray``’s interface changed significantly in version 0.5.0. Please
see the Version History page.**

Instantiation
:   *class* HTSeq.GenomicArray(*chroms*, *stranded=True*, *typecode='d'*, *storage='step'*, *memmap\_dir=''*)[](#HTSeq.GenomicArray "Permalink to this definition")

    Creates a `GenomicArray`.

    If `chroms` is a list of chromosome names, two (or one, see below) `ChromVector`
    objects for each chromosome are created, with start index 0 and indefinite
    length. If `chroms` is a `dict`, the keys are used for the chromosome names
    and the values should be the lengths of the chromosome, i.e., the ChromVectors
    index ranges are then from 0 to these lengths. (Note that the term chromosome
    is used only for convenience. Of course, you can as well specify contig IDs
    or the like.) Finally, if `chroms` is the string `"auto"`, the GenomicArray
    is created without any chromosomes but whenever the user attempts to assign a
    value to a yet unknown chromosome, a new one is automatically created with
    [`GenomicArray.add_chrom()`](#HTSeq.GenomicArray.add_chrom "HTSeq.GenomicArray.add_chrom").

    If `stranded` is `True`, two `StepVector` objects are created for each chromosome,
    one for the ‘+’ and one for the ‘-’ strand. For `stranded == False`, only one
    `StepVector` per chromosome is used. In that case, the strand argument of
    all `GenomicInterval` objects that are used later to specify regions in the
    `GenomicArray` are ignored.

    The `typecode` determines the data type and is as in `numpy`, i.e.:

    > * `'d'` for float values (C type ‘double’),
    > * `'i'` for int values,
    > * `'b'` for Boolean values,
    > * `'O'` for arbitrary Python objects as value.

    The storage mode determines how the ChromVectors store the data internally:

    > * mode `'step'`: A step vector is used. This is the default and useful
    >   for large amounts of data which may stay constant along a range of indices.
    >   Each such step is stored internally as a node in a red-black tree.
    > * mode `'ndarray'`: A 1D numpy array is used internally. This is useful
    >   if the data changes a lot, and steps are hence inefficient. Using this mode
    >   requires that chromosome lengths are specified.
    > * mode `memmap`: This is useful for large amounts of data with very short
    >   steps, where `step` is inefficient, but a numpy vectors would not fit
    >   into memory. A numpy memmap is used that stores the whole vector in a
    >   file on disk and transparently maps into memory windows of the data. This
    >   mode requires chromosome lengths, and specification of a directory, via
    >   the `memmap_dir` argument, to store the temporary files in. It is not
    >   suitable for type code `O`.

Attributes

> GenomicArray.stranded[](#HTSeq.GenomicArray.stranded "Permalink to this definition")
>
> GenomicArray.typecode[](#HTSeq.GenomicArray.typecode "Permalink to this definition")
> :   see above
>
> GenomicArray.chrom\_vectors[](#HTSeq.GenomicArray.chrom_vectors "Permalink to this definition")
> :   a dict of dicts of `ChromVector` objects, using the chromosome
>     names, and the strand as keys:
>
>     ```
>     .. doctest::
>     ```
>
>     ```
>     >>> ga = HTSeq.GenomicArray(["chr1", "chr2"], stranded=False)
>     >>> sorted(ga.chrom_vectors.items())
>     [('chr1', {'.': <ChromVector object, chr1:[0,Inf)/., step>}),
>      ('chr2', {'.': <ChromVector object, chr2:[0,Inf)/., step>})]
>     >>> ga = HTSeq.GenomicArray(["chr1", "chr2"], stranded=True)
>     >>> sorted([(st[0], sorted(st[1].items())) for st in ga.chrom_vectors.items()])
>     [('chr1', [('+', <ChromVector object, chr1:[0,Inf)/+, step>),
>                ('-', <ChromVector object, chr1:[0,Inf)/-, step>)]),
>      ('chr2', [('+', <ChromVector object, chr2:[0,Inf)/+, step>),
>                ('-', <ChromVector object, chr2:[0,Inf)/-, step>)])]
>     ```
>
> GenomicArray.auto\_add\_chroms[](#HTSeq.GenomicArray.auto_add_chroms "Permalink to this definition")
> :   A boolean. This attribute is set to True if the GenomicArray was created with the `"auto"`
>     arguments for the `chroms` parameter. If it is true, an new chromosome
>     will be added whenever needed.

Data access
:   To access the data, use :class:GenomicInterval objects.

    To set an single position or an interval, use:

    ```
    >>> ga[HTSeq.GenomicPosition("chr1", 100, "+")] = 7
    >>> ga[HTSeq.GenomicInterval("chr1", 250, 400, "+")] = 20
    ```

    To read a single position:

    ```
    >>> ga[HTSeq.GenomicPosition("chr1", 300, "+")]
    20.0
    ```

    ChromVector.steps(*self*)[](#HTSeq.ChromVector.steps "Permalink to this definition")

    To read an interval, use a `GenomicInterval` object as index, and
    obtain a `ChromVector` with a sub-view:

    ```
    >>> iv = HTSeq.GenomicInterval("chr1", 250, 450, "+")
    >>> v = ga[iv]
    >>> v
    <ChromVector object, chr1:[250,450)/+, step>
    >>> list(v.steps())
    [(<GenomicInterval object 'chr1', [250,400), strand '+'>, 20.0),
     (<GenomicInterval object 'chr1', [400,450), strand '+'>, 0.0)]
    ```

    Note that you get (interval, value) pairs , i.e., you can conveniently cycle
    through them with:

    ```
    >>> for iv, value in ga[iv].steps():
    ...    print(iv, value)
    chr1:[250,400)/+ 20.0
    chr1:[400,450)/+ 0.0
    ```

    GenomicArray.steps(*self*)[](#HTSeq.GenomicArray.steps "Permalink to this definition")
    :   You can get all steps from all chromosomes by calling the arrays own `steps`
        method.

Modifying values

> ChromVector implements the `__iadd__` method. Hence you can use `+=`:
>
> ```
> >>> ga[HTSeq.GenomicInterval("chr1", 290, 310, "+")] += 1000
> >>> list(ga[HTSeq.GenomicInterval("chr1", 250, 450, "+")].steps())
> [(<GenomicInterval object 'chr1', [250,290), strand '+'>, 20.0),
>  (<GenomicInterval object 'chr1', [290,310), strand '+'>, 1020.0),
>  (<GenomicInterval object 'chr1', [310,400), strand '+'>, 20.0),
>  (<GenomicInterval object 'chr1', [400,450), strand '+'>, 0.0)]
> ```
>
> To do manipulations other than additions, use Chromvector’s `apply` method:
>
> ChromVector.apply(*func*)[](#HTSeq.ChromVector.apply "Permalink to this definition")
> :   ```
>     >>> ga[HTSeq.GenomicInterval("chr1", 290, 300, "+")].apply(lambda x: x * 2)
>     >>> list(ga[HTSeq.GenomicInterval("chr1", 250, 450, "+")].steps())
>     [(<GenomicInterval object 'chr1', [250,290), strand '+'>, 20.0),
>      (<GenomicInterval object 'chr1', [290,300), strand '+'>, 2040.0),
>      (<GenomicInterval object 'chr1', [300,310), strand '+'>, 1020.0),
>      (<GenomicInterval object 'chr1', [310,400), strand '+'>, 20.0),
>      (<GenomicInterval object 'chr1', [400,450), strand '+'>, 0.0)]
>     ```

Adding a chromosome
:   GenomicArray.add\_chrom(*chrom*, *length=sys.maxint*, *start\_index=0*)[](#HTSeq.GenomicArray.add_chrom "Permalink t