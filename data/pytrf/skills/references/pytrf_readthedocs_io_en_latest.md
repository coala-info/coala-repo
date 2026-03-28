pytrf

Contents:

* [Installation](installation.html)
* [Usage](usage.html)
* [Changelog](changelog.html)
* [API Reference](api_reference.html)

pytrf

* Welcome to pytrf’s documentation!
* [View page source](_sources/index.rst.txt)

---

# Welcome to pytrf’s documentation![](#welcome-to-pytrf-s-documentation "Link to this heading")

A Tandem repeat (TR) in genomic sequence is a set of adjacent short DNA
sequence repeated consecutively. The core sequence or repeat unit is generally
called motif. According to the motif length, tandem repeats can be classified
as microsatellites and minisatellites. Microsatellites are also known as simple
sequence repeats (SSRs) or short tandem repeats (STRs) with motif length of 1-6 bp.
Minisatellites are also sometimes referred to as variable number of tandem repeats
(VNTRs) has longer motif length than micorsatellites.

The pytrf is a lightweight Python C extension for identification of tandem repeats.
The pytrf enables to fastly identify both exact or perfect SSRs. It also can find generic
tandem repeats with any size of motif, such as with maximum motif length of 100 bp.
Additionally, it has capability of finding approximate or imperfect tandem repeats.
Furthermore, the pytrf not only can be used as Python package but also provides command
line interface for users to facilitate the identification of tandem repeats.

Note: pytrf is not a Python binding to common used tool [TRF](https://tandem.bu.edu/trf/trf.html).

Contents:

* [Installation](installation.html)
  + [Install from PyPI](installation.html#install-from-pypi)
  + [Install from source](installation.html#install-from-source)
* [Usage](usage.html)
  + [STR identification](usage.html#str-identification)
  + [GTR identification](usage.html#gtr-identification)
  + [Exact tandem repeat](usage.html#exact-tandem-repeat)
  + [ATR identification](usage.html#atr-identification)
  + [Approximate tandem repeat](usage.html#approximate-tandem-repeat)
  + [Commandline interface](usage.html#commandline-interface)
* [Changelog](changelog.html)
  + [Version 1.4.2 (2025-03-19)](changelog.html#version-1-4-2-2025-03-19)
  + [Version 1.4.1 (2024-12-05)](changelog.html#version-1-4-1-2024-12-05)
  + [Version 1.3.3 (2024-07-20)](changelog.html#version-1-3-3-2024-07-20)
  + [Version 1.3.1 (2024-07-15)](changelog.html#version-1-3-1-2024-07-15)
  + [Version 1.3.0 (2024-02-21)](changelog.html#version-1-3-0-2024-02-21)
  + [Version 1.2.1 (2023-10-17)](changelog.html#version-1-2-1-2023-10-17)
  + [Version 1.2.0 (2023-10-15)](changelog.html#version-1-2-0-2023-10-15)
  + [Version 1.1.0 (2023-09-16)](changelog.html#version-1-1-0-2023-09-16)
  + [Version 1.0.1 (2023-06-24)](changelog.html#version-1-0-1-2023-06-24)
  + [Version 1.0.0 (2023-06-05)](changelog.html#version-1-0-0-2023-06-05)
  + [Version 0.1.5 (2023-05-05)](changelog.html#version-0-1-5-2023-05-05)
  + [Version 0.1.4 (2023-05-04)](changelog.html#version-0-1-4-2023-05-04)
  + [Version 0.1.3 (2021-05-31)](changelog.html#version-0-1-3-2021-05-31)
  + [Version 0.1.2 (2021-05-21)](changelog.html#version-0-1-2-2021-05-21)
  + [Version 0.1.1 (2021-05-17)](changelog.html#version-0-1-1-2021-05-17)
  + [Version 0.1.0 (2021-04-27)](changelog.html#version-0-1-0-2021-04-27)
* [API Reference](api_reference.html)
  + [pytrf.version](api_reference.html#pytrf-version)
  + [pytrf.STRFinder](api_reference.html#pytrf-strfinder)
  + [pytrf.GTRFinder](api_reference.html#pytrf-gtrfinder)
  + [pytrf.ATRFinder](api_reference.html#pytrf-atrfinder)
  + [pytrf.ETR](api_reference.html#pytrf-etr)
  + [pytrf.ATR](api_reference.html#pytrf-atr)

# Indices and tables[](#indices-and-tables "Link to this heading")

* [Index](genindex.html)
* [Module Index](py-modindex.html)
* [Search Page](search.html)

[Next](installation.html "Installation")

---

© Copyright 2023, Lianming Du.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).