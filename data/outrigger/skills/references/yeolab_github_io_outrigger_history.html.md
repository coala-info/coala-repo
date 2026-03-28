# History[¶](#history "Permalink to this headline")

## v1.0.0 (April 3rd, 2017)[¶](#v1-0-0-april-3rd-2017 "Permalink to this headline")

This is the first major release of `outrigger`!!!

### v1.0.0 New features[¶](#v1-0-0-new-features "Permalink to this headline")

* Parallelized event across chromosomes
* Added `--low-memory` flag for `index`, `validate`, and `psi` commands
  to use a smaller memory footprint when reading CSV files.
* Added `--splice-types` option to specify only one kind of splicing you’d
  like to find
* So the user can double-check the Psi calculation, create a `summary.csv`
  file indicating the number of reads found at each junction, for all samples
  - This also shows which “Case” corresponds to each event in each sample, so you can see whether there were sufficient or insufficient reads on the junctions of each event, and how `outrigger` judged it.
* Added functions to extract constitutive and alternative exons separately

### v1.0.0 Bug fixes[¶](#v1-0-0-bug-fixes "Permalink to this headline")

* Fixed a bug that stalled on `.bam` files while counting the junctions

### v1.0.0 Miscellaneous[¶](#v1-0-0-miscellaneous "Permalink to this headline")

* Added `GC/AG` to valid splice sites

## v0.2.9 (November 11th, 2016)[¶](#v0-2-9-november-11th-2016 "Permalink to this headline")

This is a non-breaking release with many speed improvements, and upgrade is
recommended.

### v0.2.9 New features[¶](#v0-2-9-new-features "Permalink to this headline")

* Add `bam` alignment files as input option

### Miscellaneous[¶](#miscellaneous "Permalink to this headline")

* Parallelized Psi calculation, the exact number of processors can be specified
  with `--n-jobs`, and by default, `--n-jobs` is `-1`, which means use as
  many processors as are available.

## v0.2.8 (October 23rd, 2016)[¶](#v0-2-8-october-23rd-2016 "Permalink to this headline")

Updated README/HISTORY files

## v0.2.7 (October 23rd, 2016)[¶](#v0-2-7-october-23rd-2016 "Permalink to this headline")

### v0.2.7 New features[¶](#v0-2-7-new-features "Permalink to this headline")

* Added `outrigger validate` command to check for canonical splice sites
  by default: `GT/AG` (U1, major spliceosome) and `AT/AC`
  (U12, minor spliceosome). Both of these are user-adjustable as they are only
  the standard for mammalian genomes.

### v0.2.7 API changes[¶](#v0-2-7-api-changes "Permalink to this headline")

* Added `--resume` and `--force` options to `outrigger index` to prevent
  the overwriting of interrupted indexing operations, or to force overwriting.
  By default, `outrigger` complains and cowardly exits.

### v0.2.7 Bug fixes[¶](#v0-2-7-bug-fixes "Permalink to this headline")

* Support ENSEMBL gtf files which specify chromsome names with a number, e.g.
  `4` instead of `chr4`. Thank you to [lcscs12345](https://github.com/lcscs12345) for pointing this out!

### v0.2.7 Miscellaneous[¶](#v0-2-7-miscellaneous "Permalink to this headline")

* Added version info with `outrigger --version`
* Sped up gffutils queries and event finding by running `ANALYZE` on SQLite
  databases.

## v0.2.6 (September 15th, 2016)[¶](#v0-2-6-september-15th-2016 "Permalink to this headline")

This is a non-breaking patch release

### v0.2.6 Bug fixes[¶](#v0-2-6-bug-fixes "Permalink to this headline")

* Wasn’t concatenating exons properly after parallelizing

### v0.2.6 Miscellaneous[¶](#v0-2-6-miscellaneous "Permalink to this headline")

* Clarified `.gtf` file example for directory output

## v0.2.5 (September 14th, 2016)[¶](#v0-2-5-september-14th-2016 "Permalink to this headline")

### v0.2.5 Bug fixes[¶](#v0-2-5-bug-fixes "Permalink to this headline")

* Added `joblib` to requirements

## v0.2.4 (September 14th, 2016)[¶](#v0-2-4-september-14th-2016 "Permalink to this headline")

This is a non-breaking patch release of `outrigger`.

### v0.2.4 New features[¶](#v0-2-4-new-features "Permalink to this headline")

* **Actually** parallelized exon finding for novel exons. Before had written the code and tested the non-parallelized version but now using actually parallelized version!

### v0.2.4 Bug fixes[¶](#v0-2-4-bug-fixes "Permalink to this headline")

* Don’t need to turn on `--debug` command for outrigger to even run

## v0.2.3 (September 13th, 2016)[¶](#v0-2-3-september-13th-2016 "Permalink to this headline")

This is a patch release of outrigger, with non-breaking changes from the
previous one.

### Bug fixes[¶](#bug-fixes "Permalink to this headline")

* Subfolders get copied when installing
* Add test for checking that `outrigger -h` command works

## v0.2.2 (September 12th, 2016)[¶](#v0-2-2-september-12th-2016 "Permalink to this headline")

This is a point release which includes the `index` submodule in the `__all__` statement.

## v0.2.1 (September 12th, 2016)[¶](#v0-2-1-september-12th-2016 "Permalink to this headline")

This is a point release which actually includes the `requirements.txt` file that specifies which packages `outrigger` depends on.

## v0.2.0 (September 9th, 2016)[¶](#v0-2-0-september-9th-2016 "Permalink to this headline")

This is the second release of `outrigger`!

### New features[¶](#new-features "Permalink to this headline")

* Parallelized exon finding for novel exons
* Added `outrigger validate` command to check that your new exons have proper splice sites (e.g. GT/AG and AT/AC)
* Added more test data for other event types (even though we don’t detect them yet)

## v0.1.0 (May 25, 2016)[¶](#v0-1-0-may-25-2016 "Permalink to this headline")

This is the initial release of `outrigger`

[![Logo](_static/logo-150px.png)](index.html)

### [Table Of Contents](index.html)

* [Home](index.html)
* [Contents](contents.html)
* [Install](installation.html)
* [Usage](Usage.html)
* [`index`: Detect exons](subcommands/outrigger_index.html)
* [`validate`: Remove non-canonical splice sites](subcommands/outrigger_validate.html)
* [`psi`: Quantify exon inclusion](subcommands/outrigger_psi.html)
* Changelog
* [License](license.html)

---

* History
  + [v1.0.0 (April 3rd, 2017)](#v1-0-0-april-3rd-2017)
    - [v1.0.0 New features](#v1-0-0-new-features)
    - [v1.0.0 Bug fixes](#v1-0-0-bug-fixes)
    - [v1.0.0 Miscellaneous](#v1-0-0-miscellaneous)
  + [v0.2.9 (November 11th, 2016)](#v0-2-9-november-11th-2016)
    - [v0.2.9 New features](#v0-2-9-new-features)
    - [Miscellaneous](#miscellaneous)
  + [v0.2.8 (October 23rd, 2016)](#v0-2-8-october-23rd-2016)
  + [v0.2.7 (October 23rd, 2016)](#v0-2-7-october-23rd-2016)
    - [v0.2.7 New features](#v0-2-7-new-features)
    - [v0.2.7 API changes](#v0-2-7-api-changes)
    - [v0.2.7 Bug fixes](#v0-2-7-bug-fixes)
    - [v0.2.7 Miscellaneous](#v0-2-7-miscellaneous)
  + [v0.2.6 (September 15th, 2016)](#v0-2-6-september-15th-2016)
    - [v0.2.6 Bug fixes](#v0-2-6-bug-fixes)
    - [v0.2.6 Miscellaneous](#v0-2-6-miscellaneous)
  + [v0.2.5 (September 14th, 2016)](#v0-2-5-september-14th-2016)
    - [v0.2.5 Bug fixes](#v0-2-5-bug-fixes)
  + [v0.2.4 (September 14th, 2016)](#v0-2-4-september-14th-2016)
    - [v0.2.4 New features](#v0-2-4-new-features)
    - [v0.2.4 Bug fixes](#v0-2-4-bug-fixes)
  + [v0.2.3 (September 13th, 2016)](#v0-2-3-september-13th-2016)
    - [Bug fixes](#bug-fixes)
  + [v0.2.2 (September 12th, 2016)](#v0-2-2-september-12th-2016)
  + [v0.2.1 (September 12th, 2016)](#v0-2-1-september-12th-2016)
  + [v0.2.0 (September 9th, 2016)](#v0-2-0-september-9th-2016)
    - [New features](#new-features)
  + [v0.1.0 (May 25, 2016)](#v0-1-0-may-25-2016)

### Quick search

©2015-2017, Olga Botvinnik.
|
Powered by [Sphinx 1.4.8](http://sphinx-doc.org/)
& [Alabaster 0.7.9](https://github.com/bitprophet/alabaster)
|
[Page source](_sources/history.txt)