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
* [Quality Assessment with `htseq-qa`](qa.html)
* Version history
* [Contributing](contrib.html)

[HTSeq](index.html)

* Version history
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/history.rst)

---

# Version history[](#version-history "Permalink to this heading")

## Version 2.0.5[](#version-2-0-5 "Permalink to this heading")

2023-12-13

Fixes installation on some platforms, only upgrade if necessary if you already have 2.0.4 (though it does not hurt).

* Bugfix for poetry and other package managers courtesy of @cameronraysmith.

## Version 2.0.4[](#version-2-0-4 "Permalink to this heading")

All users are encouraged to upgrade.

* htseq-count now checks if any chromosome names match between the BAM and GFF/GTF file. If not, it shows a warning to stderr.
* Python 3.11 is covered on CI build and deploy (linux only - OSX is not supported by pysam yet).

## Version 2.0.3[](#version-2-0-3 "Permalink to this heading")

2023-05-16

Bugfix release. All users are encouraged to upgrade.

* GenomicInterval\_from\_directional had a typo (issue #62). Thanks @justinaruda for spotting it.

## Version 2.0.2[](#version-2-0-2 "Permalink to this heading")

2022-07-03

Bugfix release. All users are encouraged to upgrade.

Scripts:

* `htseq-count` had silently adopted a new logic to handle a corner case where read 1 was missing but read 2 was present. This has now been reverted
  to ensure exact compatibility with `HTSeq<=0.13.5`.

## Version 2.0.1[](#version-2-0-1 "Permalink to this heading")

2022-03-25

Maintenance version. Users are not required to upgrade.

CI:

* Updated docker CI requirements.

## Version 2.0.0[](#version-2-0-0 "Permalink to this heading")

2022-03-22

Major release. All users are encouraged to upgrade.

Publication:

* New paper describing HTSeq 2.0 in [Bioinformatics](<https://doi.org/10.1093/bioinformatics/btac166>). **Please cite the new paper** to help us maintain HTSeq!

API features:

* Support for StretchVector, a data structure for “island-of-data” sparsity
* Added BigWig\_Reader
* Added I/O functions for `GenomicArray` to/from bedGraph and BigWig files
* `make_feature_genomicarrayofsets` now supports multiple primary attributes
* `make_feature_genomicarrayofsets` can now add chromosome info as an additional attribute
* Improved context manager support (`with` statement) for parsers
* Support for `pathlib.Path` objects

Scripts:

* Refactoring of `htseq-count` for readability
* Added exon-level counting to `htseq-count`
* Added output formats to `htseq-count`: loom, h5ad, mtx files
* The above all apply to `htseq-count-barcodes` as well.
* Added `--with-header` option to `htseq-count`.

Documentation:

* Modernized template of docs
* Added tutorial on High C analysis
* Added step by step explanation of `htseq-count` logic
* Improved API documentation on a number of interfaces
* Improved docstrings throughout

Tests/Infrastructure:

* Better testing infra (e.g. `test.sh`)
* Many more unit tests

Bug fixes:

* Fixed a bug with templates SAM files
* Fixed a bug about `ChromVector` steps.
* Fixed a bug about file opening (thanks @mruffalo)
* Fixed a bug about ambiguous reads (thanks @Mashin6)
* Fixed a typo in the docs (thanks @Tejindersingh1)
* Improved style of code and documentation

## Version 0.13.5[](#version-0-13-5 "Permalink to this heading")

2020-12-29

Maintenance and small feature release

* Refactored CI to use Github actions.
* Improved docs and fixed docs building bugs
* Reader classes (e.g. FastaReader, BAM\_Reader) can be used with `with` (as context managers)
* Fixed a few bugs in `htseq-count`

## Version 0.12.4[](#version-0-12-4 "Permalink to this heading")

2020-04-20

Bugfix release:

* use correct stranded information (thanks gaffneyk)

## Version 0.12.3[](#version-0-12-3 "Permalink to this heading")

2020-04-18

New features:

* Negative indices for `StepVector` (thanks to shouldsee for the original PR).
* `htseq-count-barcodes` counts features in barcoded SAM/BAM files, e.g. 10X Genomics
  single cell outputs. It supports cell barcodes, which result in different columns of
  the output count table, and unique molecular identifiers.
* `htseq-count` has new option `-n` for multicore parallel processing
* `htseq-count` has new option `-d` for separating output columns by arbitrary character
  (defalt TAB, `,` is also common)
* `htseq-count` has new option `-c` for output into a file instead of stdout
* `htseq-count` has new option `--append-output` for output into a file by appending to
  any existing test (e.g. a header with the feature attribute names and sample names)
* `htseq-count` has two new values for option `--nonunique`, namely `fraction`, which
  will count an N-multimapper as 1/N for each feature, and `random`, which will assign
  the alignment to a random one of its N-multimapped features. This feature was added by
  ewallace (thank you!).
* `htseq-qa` got refactored and now accepts an options `--primary-only` which ignores
  non-primary alignments in SAM/BAM files. This means that the final number of alignments
  scored is equal to the number of reads even when multimapped reads are present.

Testing improvements:

* Extensive testing and installation changes for Mac OSX 10.14 and later versions
* Testing Python 2.7, 3.6, 3.7, and 3.8 on OSX
* Testing and deployment now uses conda environments

Numerous bugfixes and doc improvements.

This is the **last** version of `HTSEQ` supporting Python 2.7, as it is unmaintained since Jan 1st, 2020. `HTSeq` will support Python 3.5+ from the next version.

## Version 0.11.4[](#version-0-11-4 "Permalink to this heading")

2020-03-30

Fix a bug with Python3 and no-quality BAM/SAM files.

## Version 0.11.3[](#version-0-11-3 "Permalink to this heading")

2020-03-01

Updates in the documentation and new wheels to fix installation bugs.

## Version 0.11.2[](#version-0-11-2 "Permalink to this heading")

2019-01-07

Bugfix release for `htseq-count`:

* fixed bug and changed how to use output SAM files via `-o`: you now have
  to specify the option once per input/output file

## Version 0.11.1[](#version-0-11-1 "Permalink to this heading")

2019-01-03

Bugfix release for `htseq-count`:

* fixed bug and changed how to use of additional attributes via `--additional-attr`

## Version 0.11.0[](#version-0-11-0 "Permalink to this heading")

2018-08-01

* `htseq-count` ignores secondary and supplementary alignments by default
* bugfix in the SAM output of `htseq-count`
* optional argument name in reverse complement function
* better linting of Cython files

## Version 0.10.0[](#version-0-10-0 "Permalink to this heading")

2018-05-08

* flush output of `htseq-count` (thanks dcroote)
* pass memmap\_dir to ChromVector.create (thanks wkopp)
* `BAM_Reader` supports `check_sq` for PacBio reads (thanks jbloom)
* a number of Bugfixes

## Version 0.9.1[](#version-0-9-1 "Permalink to this heading")

2017-07-26

Bugfix release for `htseq-count`:

* `--secondary-alignments` and `supplementary-alignments` should now work for some corner cases of unmapped reads

## Version 0.9.0[](#version-0-9-0 "Permalink to this heading")

2017-07-11

This release adds a few options to `htseq-count`:

* `--secondary-alignments` handles secondary alignments coming from the same read
* `--supplementary-alignments` handles supplementary alignments (aka chimeric reads)

Raw but fast iterators for FASTA and FASTQ files have been added.

Support for the SAM CIGAR flags `=` and `X` (sequence match and mismatch) has been added.

`Sequence` objects can now be pickled/serialized.

Binaries for linux and OSX are now provided on PyPI.

Automation of the release process has been greatly extended, including OSX continuous integration builds.

Several bugs have been fixed, and some parts of the code have been linted or modernized.

## Version 0.8.0[](#version-0-8-0 "Permalink to this heading")

2017-06-07

This release adds a few options to `htseq-count`:

* `--nonunique` handles non-uniquely mapped reads
* `--additional-attr` adds an optional column to the output (typically for human-readable gene names)
* `--max-reads-in-buffer` allows increasing the buffer size when working with paired end, coordinate sorted files

Moreover, `htseq-count` can now take more than one input file and prints the output with one column per input file.

Finally, parts of the code have been streamlined or modernized, documentation has been moved to readthedocs,
and other minor changes.

## Version 0.7.2[](#version-0-7-2 "Permalink to this heading")

2017-03-24

This release effectively merges the Python2 and Python3 branches.

Enhancements:

* `pip install HTSeq` works for both Python 2.7 and 3.4+

## Version 0.7.1[](#version-0-7-1 "Permalink to this heading")

2017-03-16

Enhancements:

* installs from PyPI

## Version 0.7.0[](#version-0-7-0 "Permalink to this heading")

2017-02-07

Enhancements:

* understands SAMtools optional field B (used sometimes in STAR aligner)
* write fasta files in a single line
* better docstrings thanks to SWIG 3

Bugfixes:

* fixed tests and docs in .rst files

Support bumps:

* supports pysam >=0.9.0

New maintainer: Fabio Zanini.

## Version 0.6.1[](#version-0-6-1 "Permalink to this heading")

2014-02-27

* added parser classes for BED and Wiggle format

Patch versions:

* 0.6.1p1 (2014-04-13)

  + Fixed incorrect version tag
* 0.6.1p2 (2014-08-09)

  + some improvements to documentation

## Version 0.6.0[](#version-0-6-0 "Permalink to this heading")

2014-02-26

* Several changes and improvements to htseq-count:

  + BAM files can now be read natively. (New option `--format`)
  + Paired-end SAM files can be used also if sorted by position. No need any mroe to sort by name. (New option `--order`.)
  + Documentation extended by a FAQ section.
  + Default for `--minaqual` is now 10. (was: 0)
* New chapter in documentation, with more information on counting reads.
* New function `pair_SAM_alignments_with_buffer` to implement pairing for position-sorted SAM files.

## Version 0.5.4[](#version-0-5-4 "Permalink to this heading")

2013-02-20

Various bugs fixed, including

> * GFF\_Reader interpreted the constructor’s “end\_included” flag
>   in the wrong way, hence the end position of intervals of
>   GFF features was off by 1 base pair before
> * htseq-count no longer warns about missing chromosomes, as this
>   warning was often misleading. Also, these reads are no properly
>   included in the “no\_feature” count.
> * default for “max\_qual” in “htseq-qa” is now 41, to accommodate newer
>   Illumina FASTQ files
> * BAM\_Reader used to incorrectly label single-end reads as paired-end

Patch versions:

* v0.5.4p1 (2013-02-22):

  + changed default for GFF\_Reader to end\_included=True, which is actually the
    correct style for Ensemble GTF files. Now the behavious should be as it
    was before.
* v0.5.4p2 (2013-04-18):

  + fixed issue blocking proper built on Windows
* v0.5.4p3 (2013-04-29):

  + htseq-count now correctly skips over “M0” cigar operations
* v0.5.4p4 (2013-08-28):

  + added `.get_original_line()` function to `VariantCall`
  + firex a bug with reads not being read as paired if they were not
    flagged as proper pair
* v0.5.4p5 (2013-10-02/2013-10-10):

  + parsing of GFF attribute field no longer fails on quoted semicolons
  + fixed issue with get\_line\_number\_string

## Version 0.5.3[](#version-0-5-3 "Permalink to this heading")

2011-06-29

* added the ‘–stranded=reverse’ option to htseq-count

Patch versions:

* v0.5.3p1 (2011-07-15):

  + fix a bug in pair\_sam\_Alignment (many thanks for Justin Powell for
    finding the bug and suggesting a patch)
* v0.5.3p2 (2011-09-15)

  + fixed a bug (and a documentation bug) in trim\_left/right\_end\_with\_quals
* v0.5.3p3 (2011-09-15)

  + p2 was built improperly
* v0.5.3p5 (2012-05-29)

  + added ‘to\_line’ function to VariantCall objects and ‘meta\_info’ function to VCF\_Reader objects to print VCF-lines / -headers respectively
* v0.5.3p5b (2012-06-01)
  - added ‘flag’ field to SAM\_Alignment objects and fixed ‘get\_sam\_line’ function of those
* v0.5.3p6 (2012-06-11)
  - fixed mix-up between patches p3, p4 and p5
* v0.5.3p7 (2012-06-13)
  - switched global pysam import to on-demand version
* v0.5.3p9ur1 (2012-08-31)
  - corrected get\_sam\_line: tab isntead of space between optional fields

## Version 0.5.2[](#version-0-5-2 "Permalink to this heading")

2011-06-24

* added the ‘–maxqual’ option to htseq-qa

## Version 0.5.1[](#version-0-5-1 "Permalink to this heading")

2011-05-03

* added steps method to GenomicArray

Patch versions:

* v0.5.1p1 (2011-05-11):

  + fixed a bug in step\_vector.h causing linkage failure under GCC 4.2
* v0.5.1p2 (2011-05-12):

  + fixed pickling
* v0.5.1p3 (2011-05-22):

  + fixed quality plot in htseq-qa (top pixel row, for quality score 40, was cut off)

## Version 0.5.0[](#version-0-5-0 "Permalink to this heading")

2011-04-21

* refactoring of GenomicArray class:

  + field `step_vectors` replaced with `chrom_vector`. These now contain
    dicts of dicts of `ChromVector` objects rather than `StepVector` ones.
  + `chrom_vectors` is now always a dict of dict, even for unstranded GenomicArrays
    to make it easier to loop over them. (The inner dict has either keys `"+"`
    and `"-"`, or just one key, `"."`.)
  + The new `ChromVector` class wraps the actual vector and supports three different
    storage modes: `step`, `ndarray` and `memmap`, the latter two being numpy
    arrays, without and with memory mapping.
  + The `GenomicArray` constructor now take two new arguments, one for the storage
    class, one for the memmap directory (if needed).
  + The `add_value` methods had been replaced with an `__iadd__` method, to
    enable the `+=` semantics.
  + Similarily, `+=` for `GenomicArrayOfSets` adds an element to the sets.
  + Instead of `get_steps`, now use `steps`.
* new parser class `VCF_Reader` and record class `VariantCall`
* new parser class `BAM_Reader`, to add BAM support (including indexed random access)
  (requires PySam to be installed)
* new documentation page [Tutorial: Transcription start sites (TSS)](tutorials/tss.html#tss)
* `Fasta_Reader` now allows indexed access to Fasta files (requires Pysam to be
  installed)
* peek function removed

Patch Versions:

* v0.5.0p1 (2011-04-