[itero](index.html)

latest

Contents:

* [Purpose](purpose.html)
* [Installation](installation.html)
* [Running itero](running.html)

* [License](license.html)
* Changelog
  + [v1.0.x (April 2018)](#v1-0-x-april-2018)
  + [v1.1.0 (May 2018)](#v1-1-0-may-2018)
  + [v1.1.1 (June 2018)](#v1-1-1-june-2018)
* [Funding](funding.html)

[itero](index.html)

* [Docs](index.html) »
* Changelog
* [Edit on GitHub](https://github.com/faircloth-lab/itero/blob/master/docs/changelog.rst)

---

# Changelog[¶](#changelog "Permalink to this headline")

## v1.0.x (April 2018)[¶](#v1-0-x-april-2018 "Permalink to this headline")

* initial version with MPI and multiprocessing capability

## v1.1.0 (May 2018)[¶](#v1-1-0-may-2018 "Permalink to this headline")

* fix error in contig checking code that could cause MPI operations to hang
* refactor BAM splitting code for hopefully faster operation
* add RAM limits on spades
* add configuration parameters to iter.conf for spades
* create unique log file for each run

## v1.1.1 (June 2018)[¶](#v1-1-1-june-2018 "Permalink to this headline")

* fix an error where too many fastq files would cause MPI to hang

[Next](funding.html "Funding")
 [Previous](license.html "License")

---

© Copyright 2018, Brant C. Faircloth
Revision `25c7fb69`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).