[plastid](index.html)

latest

Getting started

* [Getting started](quickstart.html)
* [Tour](tour.html)
* [Installation](installation.html)
* [Demo dataset](test_dataset.html)
* [List of command-line scripts](scriptlist.html)

User manual

* [Tutorials](examples.html)
* [Module documentation](generated/plastid.html)
* [Frequently asked questions](FAQ.html)
* [Glossary of terms](glossary.html)
* [References](zreferences.html)

Developer info

* [Contributing](devinfo/contributing.html)
* [Entrypoints](devinfo/entrypoints.html)

Other information

* [Citing `plastid`](citing.html)
* [License](license.html)
* Change log
  + [plastid [0.6.1] = [2022-05-05]](#plastid-0-6-1-2022-05-05)
    - [Added](#added)
    - [Changed](#changed)
    - [Removed](#removed)
  + [plastid [0.5.1] = [2020-05-20]](#plastid-0-5-1-2020-05-20)
  + [plastid [0.5.0] = [2020-05-20]](#plastid-0-5-0-2020-05-20)
    - [Changed](#id1)
    - [Added](#id2)
    - [Fixed](#fixed)
    - [Removed](#id3)
  + [plastid [0.4.8] = [2017-04-09]](#plastid-0-4-8-2017-04-09)
  + [plastid [0.4.7] = [2017-03-06]](#plastid-0-4-7-2017-03-06)
    - [Added](#id4)
    - [Fixed](#id5)
  + [plastid [0.4.6] = [2016-05-20]](#plastid-0-4-6-2016-05-20)
    - [Added/Changed](#added-changed)
      * [File formats](#file-formats)
      * [Infrastructure](#infrastructure)
      * [Command-line scripts](#command-line-scripts)
    - [Fixed](#id6)
    - [Deprecated](#deprecated)
  + [plastid [0.4.5] = [2016-03-09]](#plastid-0-4-5-2016-03-09)
    - [Added](#id7)
    - [Fixed](#id8)
    - [Changed](#id9)
    - [Deprecated](#id10)
  + [plastid [0.4.4] = [2105-11-16]](#plastid-0-4-4-2105-11-16)
    - [Added](#id11)
    - [Changed](#id12)
    - [Fixed](#id13)
  + [plastid [0.4.3] = [2015-10-28]](#plastid-0-4-3-2015-10-28)
    - [Fixed](#id14)
  + [plastid [0.4.2] = [2015-10-22]](#plastid-0-4-2-2015-10-22)
  + [plastid [0.4.0] = [2015-10-21]](#plastid-0-4-0-2015-10-21)
    - [Added](#id15)
    - [Changed](#id16)
    - [Fixed](#id17)
    - [Removed](#id18)
  + [plastid [0.3.2] = [2015-10-01]](#plastid-0-3-2-2015-10-01)
    - [Changed](#id19)
  + [plastid [0.3.0] = [2015-10-01]](#plastid-0-3-0-2015-10-01)
    - [Changed](#id20)
    - [Deprecated](#id21)
    - [Removed](#id22)
  + [plastid [0.2.3] = [2015-09-23]](#plastid-0-2-3-2015-09-23)
    - [Changed](#id23)
  + [plastid [0.2.2] = [2015-09-15]](#plastid-0-2-2-2015-09-15)
    - [Added](#id24)
    - [Changed](#id25)
  + [yeti [0.2.1] = [2015-09-06]](#yeti-0-2-1-2015-09-06)
    - [Added](#id26)
    - [Changed](#id27)
  + [yeti [0.2.0] = [2015-08-26]](#yeti-0-2-0-2015-08-26)
    - [Added](#id28)
    - [Changed](#id29)
    - [Removed](#id30)
  + [yeti [0.1.1] = [2015-07-23]](#yeti-0-1-1-2015-07-23)
    - [Added](#id31)
    - [Changed](#id32)
    - [Fixed](#id33)
    - [Removed](#id34)
  + [yeti [0.1.0] = [2015-06-06]](#yeti-0-1-0-2015-06-06)
    - [Changed](#id35)
  + [genometools [0.9.1] - 2015-05-21](#genometools-0-9-1-2015-05-21)
    - [Changed](#id36)
    - [Added](#id37)
  + [genometools [0.9.0] - 2015-05-20](#genometools-0-9-0-2015-05-20)
    - [Changed](#id38)
    - [Removed](#id39)
    - [Deprecated](#id40)
  + [genometools [0.8.3] - 2015-05-19](#genometools-0-8-3-2015-05-19)
    - [Added](#id41)
  + [genometools [0.8.2] - 2015-05-19](#genometools-0-8-2-2015-05-19)
    - [Changed](#id42)
    - [Fixed](#id43)
  + [genometools [0.8.1] - 2015-05-18](#genometools-0-8-1-2015-05-18)
    - [Added](#id44)
    - [Changed](#id45)
  + [genometools [0.8.2015-05-08] - 2015-05-08](#genometools-0-8-2015-05-08-2015-05-08)
    - [Changed](#id46)
    - [Added](#id47)
    - [Fixed](#id48)
    - [Deprecated](#id49)
* [Related resources](related.html)
* [Contact](contact.html)

[plastid](index.html)

* »
* Change log
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/CHANGES.rst)

---

# Change log[¶](#change-log "Permalink to this headline")

Major changes to `plastid` are documented here. Version numbers for the
project follow the conventions described in [**PEP 440**](https://peps.python.org/pep-0440/) and
[Semantic versioning 2.0.0](http://semver.org/).

## plastid [0.6.1] = [2022-05-05][¶](#plastid-0-6-1-2022-05-05 "Permalink to this headline")

This is a maintenance release meant to leave this package in a reasonable state,
as it is only sporadically maintained.

### Added[¶](#added "Permalink to this headline")

* Dockerization, to further control test environments, and make this release
  release more future-proof. Test environments now include Python 3.6 and 3.9.

### Changed[¶](#changed "Permalink to this headline")

* Bumped minimum requirements to reasonable 2022 standards.
* Upgraded embedded Kent & HTSlib source code
* Clarified licenses

### Removed[¶](#removed "Permalink to this headline")

* Dropped support for Python versions 2.7–3.5. These *might* still run, but
  are no longer tested.
* Deprecated classes: `BPlusTree`, `RTree`
* Deprecated methods: of `SegmentChain.get_length()` and
  `SegmentChain.get_masked_length()`

## plastid [0.5.1] = [2020-05-20][¶](#plastid-0-5-1-2020-05-20 "Permalink to this headline")

* Updates to package metadata and docs

## plastid [0.5.0] = [2020-05-20][¶](#plastid-0-5-0-2020-05-20 "Permalink to this headline")

Changes are predominantly for maintenance, bugfixes, and streamlining.

### Changed[¶](#id1 "Permalink to this headline")

* Iterators rewritten for compatibility with Python 3.7 and Python 3.8 (per
  instructions in [**PEP 479**](https://peps.python.org/pep-0479/) )
* As a result, **while readers in** [`plastid.readers`](generated/plastid.readers.html#module-plastid.readers "plastid.readers") **are still
  generators, they are no longer their own iterators**. This is a bit of an
  obscure point, but implications are:

  > + they can still be cast to lists:
  >
  >   ```
  >   >>> my_list = list(GTF2_TranscriptAssembler("/path/to/foo.gtf"))
  >   ```
  > + they can still be used in `for` loops:
  >
  >   ```
  >   >>> for my_transcript in GTF2_TranscriptAssembler("/path/to/foo.gtf"):
  >   >>>     # pass
  >   ```
  > + they *cannot* be used like this:
  >
  >   ```
  >   >>> transcripts = GTF2_TranscriptAssembler("/path/to/foo.gtf")
  >   >>> a = next(transcripts)
  >   ```
  >
  >   # a will be None!!
  > > instead, wrap the reader in iter if you want to use them this way:
  > >
  > > ```
  > > >>> transcripts = iter(GTF2_TranscriptAssembler("/path/to/foo.gtf"))
  > > >>> a = next(transcripts)
  > > # a is now a Transcript
  > > ```

### Added[¶](#id2 "Permalink to this headline")

* BioConda support (special thanks to `@lparsons`)
* Testing streamlined via `tox`, and additional test environments added

### Fixed[¶](#fixed "Permalink to this headline")

* Moved calls to `open()` into `with` context managers to avoid creation of
  stale filehandles
* Rewrote `setup.py` to remove requirement for pre-installation of
  `cython`, `numpy`, and `pysam`, as this is now handled by `pip`
* Removed references to deprecated `pandas.DataFrame.sort()`, enabling
  compatibility with `pandas` versions above 0.2.0
* Improved compatibility with `numpy` versions above 1.31.1
* `VariableFivePrimeMapFactory.from_file()` and
  `StratifiedVariableFivePrimeMapFactory.from_file()` now work on filenames
  as well as file handles, as they were supposed to
* `StratifiedVariableFivePrimeMapFactory` now imported by typing
  `from plastid import *`
* And others as well

### Removed[¶](#id3 "Permalink to this headline")

* `BigBedReader.custom_fields` was removed in favor of its non-deprecated
  alias, `BigBedReader.extension_fields`

## plastid [0.4.8] = [2017-04-09][¶](#plastid-0-4-8-2017-04-09 "Permalink to this headline")

* Fixed a change in setup.py that caused Plastid compilation to fail in
  Macintosh environments. Sorry Mac users!

## plastid [0.4.7] = [2017-03-06][¶](#plastid-0-4-7-2017-03-06 "Permalink to this headline")

This update is minor compared to the release 0.4.6, and was mainly motivated by
updates, bugfixes, and changes required for compatibility with new versions of
`Pysam`

### Added[¶](#id4 "Permalink to this headline")

* Support for `Pysam` >= 0.10.0
* `write_pl_table()` added as a convenience function
* `--use_mean` flag added to `metagene`
* Warnings / better help text

### Fixed[¶](#id5 "Permalink to this headline")

* rounding error in `get_str_from_rgb()`
* `PSL_Reader()` now capable of parsing strands from translated blat output
* Fixed bug in header parsing in `PSL_reader`

## plastid [0.4.6] = [2016-05-20][¶](#plastid-0-4-6-2016-05-20 "Permalink to this headline")

Highlights

* Support for [BigWig](http://genome.ucsc.edu/goldenPath/help/bigWig.html) files
* Reimplementation of [BigBed](http://genome.ucsc.edu/goldenPath/help/bigBed.html) file support
* Simplification of syntax / removal of annoyances in both command-line
  scripts and in infrastructure

### Added/Changed[¶](#added-changed "Permalink to this headline")

#### File formats[¶](#file-formats "Permalink to this headline")

* Support for [BigWig](http://genome.ucsc.edu/goldenPath/help/bigWig.html) files. `BigWigReader` reads [BigWig](http://genome.ucsc.edu/goldenPath/help/bigWig.html) files, and
  `BigWigGenomeArray` handles them conveniently.
* `BigBedReader` has been reimplemented using Jim Kent’s C library, making
  it far faster and more memory efficient.
* `BigBedReader.search()` created to search indexed fields included in BigBed
  files, e.g. to find transcripts with a given gene\_id (if gene\_id is included
  as an extension column and indexed). To see which fields are searchable,
  use `BigBedReader.indexed_fields`

#### Infrastructure[¶](#infrastructure "Permalink to this headline")

* Simplified file opening. All readers can now take filenames in addition
  to open filehandles. No need to wrap filenames in lists any more.
  For example:

  > ```
  > # old way to open GTF2 file
  > >>> data = GTF2_TranscriptAssembler(open("some_file.gtf"))
  >
  > # new way. Also works with BED_Reader, GTF2_Reader, GFF3_TranscriptAssembler, and others
  > >>> data = GTF2_TranscriptAssembler("some_file.gtf")
  >
  > # old way to get read alignments from BAM files
  > >>> alignments = BAMGenomeArray(["some_file.bam","some_other_file.bam"])
  >
  > # new way
  > >>> alignemnts = BAMGenomeArray("some_file.bam","some_other_file.bam")
  >
  > # old way to open a tabix-indexed file
  > >>> data = BED_Reader(pysam.tabix_iterator(open("some_file.bed.gz"),pysam.asTuple()),tabix=True)
  >
  > # new way
  > >>> data = BED_Reader("some_file.bed.gz",tabix=True)
  > ```

  To maintain backward compatibility, the old syntax still works
* `BAMGenomeArray` can now use mapping functions that return multidimensional
  arrays. As an example we added `StratifiedVariableFivePrimeMapFactory`,
  which produces a 2D array of counts at each position in a region (columns),
  stratified by read length (rows).
* Reformatted & colorized warning output to improve legibility
* `read_pl_table()` convenience function for reading tables written
  by command-line scripts into DataFrames, preserving headers, formatting,
  et c

#### Command-line scripts[¶](#command-line-scripts "Permalink to this headline")

* All script output metadata now includes command as executed, for easier
  re-running and record keeping
* Scripts using count files get `--sum` flag, enabling users to
  set effective sum of counts/reads used in normalization and RPKM
  calculations
* `psite`

  > + `--constrain` option added to `psite` to improve performance on
  >   noisy or low count data.
  > + No longer saves intermediate count files. `--keep` option added
  >   to take care of this.
* `metagene`

  > + Fixed/improved color scaling in heatmap output. Color values are now
  >   capped at the 95th percentile of nonzero values, improving contrast
  > + Added warnings for files that appear not to contain UTRs
  > + Like `psite`, no longer saves intermediate count files. `--keep`
  >   option added to take care of this.
* `phase_by_size` can now optionally use an ROI file from the
  `metagene generate` subprogram. This improves accuracy in higher
  eukaryotes by preventing double-counting of codons when more than
  one transcript is annotated per gene.
* `cs chart` file containing list of genes is now optional. If not given,
  all genes are included in comparisons
* `reformat_transcripts` is now able to export extended BED columns
  (e.g. gene\_id) if the input data has useful attributes. This particularly
  useful when working with large transcript annotations in GTF2/GFF3 format-
  they can now be exported to BED format, and converted to BigBed foramt,
  allowing random access and low memory usage, while preserving gene-transcript
  relationships.

### Fixed[¶](#id6 "Permalink to this headline")

* Version parsing bug in setup script.
* `@deprecated` function decorator now gives `FutureWarning` instead
  of `DeprecationWarning`

### Deprecated[¶](#deprecated "Permalink to this headline")

* `--norm_region` option of `psite` and `metagene` has been deprecated
  and will be removed in `plastid` v0.5. Instead, use `--normalize_over`,
  which performs the same role, except coordinates are specified relative to the
  landmark of interest, rather than entire window. This change is more
  intuitive to many users, and saves them mental math. If both `--norm_region`
  and `--normalize_over` are specified, `--normalize_over` will be used.
* `BigBedReader.custom_fields` has been replaced with `BigBedReader.extension_fields`
* `BigBedReader.chrom_sizes` has been replaced with `BigBedReader.chroms`
  for consistency with other data structures
* `BPlusTree` and `RTree` classes, which will be removed in `plastid` v0.5

## plastid [0.4.5] = [2016-03-09][¶](#plastid-0-4-5-2016-03-09 "Permalink to this headline")

Changes here are mostly under the hood, involving improvements in usability,
speed, stability, compatibility, and error reporting. We also fixed up tools
for developers and added entrypoints for custom mapping rules.

### Added[¶](#id7 "Permalink to this headline")

* Users can now control verbosity/frequency of warnings via ‘-v’ or ‘-q’
  options! By default there should no long screens of DataWarnings
  when processing Ensembl (or other) GTFs.
* `--aggregate` option added to `psite` script to improve sensitivity
  for low-count data.
* Created entrypoints for allowing users to use custom mapping rules
  in the command line scripts:

  > + `plastid.mapping_rules` for specifying new mapping functions
  > + `plastid.mapping_options` for specifying any other command-line
  >   arguments they consume

  Detailed instructions for use in the *developer info* section
  of <plastid.readthedocs.org>.
* Argument parsing classes that replace methods deprecated below:

  > + [`AlignmentParser`](generated/plastid.util.scriptlib.argparsers.html#plastid.util.scriptlib.argparsers.AlignmentParser "plastid.util.scriptlib.argparsers.AlignmentParser")
  > + [`AnnotationParser`](generated/plas