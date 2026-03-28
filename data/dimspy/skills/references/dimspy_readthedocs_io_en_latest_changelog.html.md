[DIMSPy](index.html)

latest

* [Installation](installation.html)
* [API reference](api-reference.html)
* [Command Line Interface](cli.html)
* [Credits](credits.html)
* [Bugs and Issues](bugs-and-issues.html)
* Changelog
  + [DIMSpy v2.0.0](#id1)
  + [DIMSpy v1.4.0](#id2)
  + [DIMSpy v1.3.0](#id3)
  + [DIMSpy v1.2.0](#id4)
  + [DIMSpy v1.1.0](#id5)
  + [DIMSpy v1.0.0](#id6)
  + [DIMSpy v0.1.0 (pre-release)](#id7)
* [Citation](citation.html)
* [License](license.html)

[DIMSPy](index.html)

* [Docs](index.html) »
* Changelog
* [Edit on GitHub](https://github.com/computational-metabolomics/dimspy/blob/master/docs/source/changelog.rst)

---

# Changelog[¶](#changelog "Permalink to this headline")

All notable changes to this project will be documented here. For more details changes please refer to [github](https://github.com/computational-metabolomics/dimspy) commit history

## [DIMSpy v2.0.0](https://github.com/computational-metabolomics/dimspy/releases/tag/v2.0.0)[¶](#id1 "Permalink to this headline")

**Release date: 26 April 2020**

* First stable Python 3 only release
* Refactor and improve HDF5 portal to save peaklists and/or peak matrices
* Add compatibility for previous HDF5 files (python 2 version of DIMSpy)
* Improve filelist handling
* mzML or raw files are ordered by timestamp if no filelist is provided (i.e. process\_scans)
* Fix warnings (NaturalNameWarning, ResourceWarning, DeprecationWarning)
* Fix ‘blank filter’ bug (missing and/or zero values are excluded)
* Improve sub setting / filtering of scan events
* Optimise imports
* Increase [coverage tests](https://codecov.io/gh/computational-metabolomics/dimspy)
* Improve documentation ([Read the Docs](https://dimspy.readthedocs.io/en/latest/)), including docstrings

## [DIMSpy v1.4.0](https://github.com/computational-metabolomics/dimspy/releases/tag/v1.4.0)[¶](#id2 "Permalink to this headline")

**Release date: 2 October 2019**

* Final Python 2 release

## [DIMSpy v1.3.0](https://github.com/computational-metabolomics/dimspy/releases/tag/v1.3.0)[¶](#id3 "Permalink to this headline")

**Release date: 26 November 2018**

## [DIMSpy v1.2.0](https://github.com/computational-metabolomics/dimspy/releases/tag/v1.2.0)[¶](#id4 "Permalink to this headline")

**Release date: 29 May 2018**

## [DIMSpy v1.1.0](https://github.com/computational-metabolomics/dimspy/releases/tag/v1.1.0)[¶](#id5 "Permalink to this headline")

**Release date: 19 February 2018**

## [DIMSpy v1.0.0](https://github.com/computational-metabolomics/dimspy/releases/tag/v1.0.0)[¶](#id6 "Permalink to this headline")

**Release date: 10 December 2017**

## [DIMSpy v0.1.0 (pre-release)](https://github.com/computational-metabolomics/dimspy/releases/tag/v0.1.0)[¶](#id7 "Permalink to this headline")

**Release date: 11 July 2017**

[Next](citation.html "Citation")
 [Previous](bugs-and-issues.html "Bugs and Issues")

---

© Copyright 2019, Ralf Weber, Jiarui (Albert) Zhou
Revision `4a0b8982`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).