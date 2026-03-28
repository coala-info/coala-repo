[Intervene](index.html)

latest

Table of contents

* [Introduction](introduction.html)
* [Installation](install.html)
* [How to use Intervene](how_to_use.html)
* [Intervene modules](modules.html)
* [Example gallery](examples.html)
* [Interactive Shiny App](shinyapp.html)
* [Support](support.html)
* [Citation](cite.html)
* Changelog
  + [Version 0.6.1](#version-0-6-1)
  + [Version 0.6.0](#version-0-6-0)
  + [Version 0.5.9](#version-0-5-9)

[Intervene](index.html)

* [Docs](index.html) »
* Changelog
* [Edit on GitHub](https://github.com/asntech/intervene/blob/master/docs/changelog.rst)

---

# Changelog[¶](#changelog "Permalink to this headline")

## Version 0.6.1[¶](#version-0-6-1 "Permalink to this headline")

Released date: December 16, 2017

In this release, we have fixed various bugs and introduced new features:

* Users now can provide all the BedTools options by setting –bedtools-options argument in venn, upset and pairwise module. Thanks to Issue #3
* Now users can save all the overlapping genomic regions as BED and name lists as text file as by setting –save-overlaps. Thanks to those who suggested this feature.
* We added –bordercolors to change the Venn border colors.

## Version 0.6.0[¶](#version-0-6-0 "Permalink to this headline")

Released date: December 11, 2017

* Fixed the pairwise module’s –names argument. Thanks to @adomingues for reporting the bug.

## Version 0.5.9[¶](#version-0-5-9 "Permalink to this headline")

Released date: December 08, 2017

* Fixed the bug with two lists, issue #1 reported by @dayanne-castro
* Fixed upset module memory issue for large number of sets

[Previous](cite.html "Citation")

---

© Copyright 2017, Aziz Khan.
Revision `d7c77661`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/snide/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).