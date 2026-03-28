[pytrf](index.html)

Contents:

* [Installation](installation.html)
* [Usage](usage.html)
* Changelog
  + [Version 1.4.2 (2025-03-19)](#version-1-4-2-2025-03-19)
  + [Version 1.4.1 (2024-12-05)](#version-1-4-1-2024-12-05)
  + [Version 1.3.3 (2024-07-20)](#version-1-3-3-2024-07-20)
  + [Version 1.3.1 (2024-07-15)](#version-1-3-1-2024-07-15)
  + [Version 1.3.0 (2024-02-21)](#version-1-3-0-2024-02-21)
  + [Version 1.2.1 (2023-10-17)](#version-1-2-1-2023-10-17)
  + [Version 1.2.0 (2023-10-15)](#version-1-2-0-2023-10-15)
  + [Version 1.1.0 (2023-09-16)](#version-1-1-0-2023-09-16)
  + [Version 1.0.1 (2023-06-24)](#version-1-0-1-2023-06-24)
  + [Version 1.0.0 (2023-06-05)](#version-1-0-0-2023-06-05)
  + [Version 0.1.5 (2023-05-05)](#version-0-1-5-2023-05-05)
  + [Version 0.1.4 (2023-05-04)](#version-0-1-4-2023-05-04)
  + [Version 0.1.3 (2021-05-31)](#version-0-1-3-2021-05-31)
  + [Version 0.1.2 (2021-05-21)](#version-0-1-2-2021-05-21)
  + [Version 0.1.1 (2021-05-17)](#version-0-1-1-2021-05-17)
  + [Version 0.1.0 (2021-04-27)](#version-0-1-0-2021-04-27)
* [API Reference](api_reference.html)

[pytrf](index.html)

* Changelog
* [View page source](_sources/changelog.rst.txt)

---

# Changelog[](#changelog "Link to this heading")

## Version 1.4.2 (2025-03-19)[](#version-1-4-2-2025-03-19 "Link to this heading")

* Fixed atr and gtr redundant motif

## Version 1.4.1 (2024-12-05)[](#version-1-4-1-2024-12-05 "Link to this heading")

* Added seed length to ATR object
* Added support for Python 3.13
* Changed the output column order of findatr
* Fixed tandem repeat overlap
* Fixed wraparound backtrace error

## Version 1.3.3 (2024-07-20)[](#version-1-3-3-2024-07-20 "Link to this heading")

* Fixed dna sequence uppercase
* Updated command line parameters

## Version 1.3.1 (2024-07-15)[](#version-1-3-1-2024-07-15 "Link to this heading")

* Fixed minimum motif setting error
* Fixed caluclation error of alignment

## Version 1.3.0 (2024-02-21)[](#version-1-3-0-2024-02-21 "Link to this heading")

* Optimized ATR finder extending identity
* Added support for Python 3.12

## Version 1.2.1 (2023-10-17)[](#version-1-2-1-2023-10-17 "Link to this heading")

* Fixed STRFinder GC collection error

## Version 1.2.0 (2023-10-15)[](#version-1-2-0-2023-10-15 "Link to this heading")

* Fixed repeat search start position
* Optimized atr finder algorithm

## Version 1.1.0 (2023-09-16)[](#version-1-1-0-2023-09-16 "Link to this heading")

* Added seq attribute to ATR and ETR object

## Version 1.0.1 (2023-06-24)[](#version-1-0-1-2023-06-24 "Link to this heading")

* Fixed command line interface errors

## Version 1.0.0 (2023-06-05)[](#version-1-0-0-2023-06-05 "Link to this heading")

* Changed the name from stria to pytrf
* Optimized the command line interface
* Used wraparound dynamic programming to identify approximate repeats

## Version 0.1.5 (2023-05-05)[](#version-0-1-5-2023-05-05 "Link to this heading")

* Fixed ci wheel build

## Version 0.1.4 (2023-05-04)[](#version-0-1-4-2023-05-04 "Link to this heading")

* Added support for Python 3.9-3.11
* Updated the structure of objects

## Version 0.1.3 (2021-05-31)[](#version-0-1-3-2021-05-31 "Link to this heading")

* Fixed memory leak when iterating over ITRs

## Version 0.1.2 (2021-05-21)[](#version-0-1-2-2021-05-21 "Link to this heading")

* Fixed error caused by no boundary limit

## Version 0.1.1 (2021-05-17)[](#version-0-1-1-2021-05-17 "Link to this heading")

* Fixed ITRMiner parameter parser

## Version 0.1.0 (2021-04-27)[](#version-0-1-0-2021-04-27 "Link to this heading")

* released the first version

[Previous](usage.html "Usage")
[Next](api_reference.html "API Reference")

---

© Copyright 2023, Lianming Du.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).