whatshap

* [Installation](installation.html)
* [User guide](guide.html)
* [Questions and Answers](faq.html)
* [Contributing](develop.html)
* [Various notes](notes.html)
* [How to cite](howtocite.html)
* [Changes](changes.html)

whatshap

* WhatsHap
* [View page source](_sources/index.rst.txt)

---

[![https://img.shields.io/pypi/v/whatshap.svg?branch=main](https://img.shields.io/pypi/v/whatshap.svg?branch=main)](https://pypi.python.org/pypi/whatshap)
![https://github.com/whatshap/whatshap/workflows/CI/badge.svg](https://github.com/whatshap/whatshap/workflows/CI/badge.svg)
[![https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg)](http://bioconda.github.io/recipes/whatshap/README.html)![https://github.com/whatshap/whatshap/raw/main/logo/whatshap_logo.png](https://github.com/whatshap/whatshap/raw/main/logo/whatshap_logo.png)

# WhatsHap[](#whatshap "Link to this heading")

WhatsHap is a software for phasing genomic variants using DNA sequencing
reads, also called *read-based phasing* or *haplotype assembly*. It is
especially suitable for long reads, but works also well with short reads.

# Features[](#features "Link to this heading")

> * Very accurate results (Martin et al.,
>   [WhatsHap: fast and accurate read-based phasing](https://doi.org/10.1101/085050))
> * Works well with Illumina, PacBio, Oxford Nanopore and other types of reads
> * It phases SNVs, indels and even “complex” variants (such as `TCG` → `AGAA`)
> * Pedigree phasing mode uses reads from related individuals (such as trios)
>   to improve results and to reduce coverage requirements
>   (Garg et al., [Read-Based Phasing of Related Individuals](https://doi.org/10.1093/bioinformatics/btw276)).
> * WhatsHap is easy to install
> * It is easy to use: Pass in a VCF and one or more BAM files, get out a phased VCF.
>   Supports multi-sample VCFs.
> * It produces standard-compliant VCF output by default
> * If desired, get output that is compatible with ReadBackedPhasing
> * Open Source (MIT license)

## Documentation[](#documentation "Link to this heading")

* We recommend you start with this book chapter for a concise introduction:
  [Read-Based Phasing and Analysis of Phased Variants with WhatsHap](https://doi.org/10.1007/978-1-0716-2819-5_8)
* [WhatsHap documentation online](https://whatshap.readthedocs.io/)
* [GitHub repository](https://github.com/whatshap/whatshap/)

## Issue tracker[](#issue-tracker "Link to this heading")

Please do not hesitate to use our [issue tracker](https://github.com/whatshap/whatshap/issues) for bug reports and feature requests.

### Table of contents[](#table-of-contents "Link to this heading")

* [Installation](installation.html)
  + [Installation with Conda](installation.html#installation-with-conda)
  + [Installation with pip](installation.html#installation-with-pip)
  + [Installing an unreleased development version](installation.html#installing-an-unreleased-development-version)
* [User guide](guide.html)
  + [Features and limitations](guide.html#features-and-limitations)
  + [Subcommands](guide.html#subcommands)
  + [Recommended workflow](guide.html#recommended-workflow)
  + [Input data requirements](guide.html#input-data-requirements)
  + [Representation of phasing information in VCFs](guide.html#phasing-in-vcfs)
  + [Trusting the variant caller](guide.html#trusting-the-variant-caller)
  + [Phasing pedigrees](guide.html#phasing-pedigrees)
  + [Creating phased references in FASTA format](guide.html#creating-phased-references-in-fasta-format)
  + [whatshap stats: Computing phasing statistics](guide.html#whatshap-stats)
  + [Visualizing phasing results](guide.html#visualizing-phasing-results)
  + [whatshap haplotag: Tagging reads by haplotype](guide.html#whatshap-haplotag)
  + [whatshap split: Splitting reads according to haplotype](guide.html#whatshap-split)
  + [whatshap genotype: Genotyping Variants](guide.html#whatshap-genotype)
  + [whatshap polyphase: Polyploid Phasing](guide.html#whatshap-polyphase)
  + [whatshap polyphaseg: Polyploid Phasing with progeny information](guide.html#whatshap-polyphaseg)
  + [whatshap compare: Comparing variant files](guide.html#whatshap-compare)
  + [whatshap learn: Generate sequencing technology specific error profiles](guide.html#whatshap-learn)
  + [*k*-merald](guide.html#k-merald)
  + [whatshap haplotagphase: Phase VCF file using haplotagged BAM file](guide.html#whatshap-haplotagphase)
* [Questions and Answers](faq.html)
* [Contributing](develop.html)
  + [Code style](develop.html#code-style)
  + [Developing WhatsHap](develop.html#developing)
  + [Development installation](develop.html#development-installation)
  + [Development installation when using Conda](develop.html#development-installation-when-using-conda)
  + [Running tests](develop.html#running-tests)
  + [Code style](develop.html#id1)
  + [Installing other Python versions in Ubuntu](develop.html#installing-other-python-versions-in-ubuntu)
  + [Debugging](develop.html#debugging)
  + [Wrapping C++ classes](develop.html#wrapping-c-classes)
  + [Writing documentation](develop.html#writing-documentation)
  + [Making a release](develop.html#making-a-release)
  + [Adding a new subcommand](develop.html#adding-a-new-subcommand)
  + [Structure](develop.html#structure)
  + [Download count statistics](develop.html#download-count-statistics)
* [Various notes](notes.html)
  + [Allele detection with re-alignment](notes.html#allele-detection-with-re-alignment)
* [How to cite](howtocite.html)
* [Changes](changes.html)
  + [v2.8 (2025-06-08)](changes.html#v2-8-2025-06-08)
  + [v2.7 (2025-05-27)](changes.html#v2-7-2025-05-27)
  + [v2.6 (2025-04-11)](changes.html#v2-6-2025-04-11)
  + [v2.5 (2025-04-03)](changes.html#v2-5-2025-04-03)
  + [v2.4 (2025-01-22)](changes.html#v2-4-2025-01-22)
  + [v2.3 (2024-05-05)](changes.html#v2-3-2024-05-05)
  + [v2.2 (2024-01-26)](changes.html#v2-2-2024-01-26)
  + [v2.1 (2023-10-17)](changes.html#v2-1-2023-10-17)
  + [v2.0 (2023-06-30)](changes.html#v2-0-2023-06-30)
  + [v1.7 (2022-12-01)](changes.html#v1-7-2022-12-01)
  + [v1.6 (2022-09-06)](changes.html#v1-6-2022-09-06)
  + [v1.5 (2022-08-23)](changes.html#v1-5-2022-08-23)
  + [v1.4 (2022-04-07)](changes.html#v1-4-2022-04-07)
  + [v1.3 (2022-03-11)](changes.html#v1-3-2022-03-11)
  + [v1.2 (2021-12-08)](changes.html#v1-2-2021-12-08)
  + [v1.1 (2021-04-08)](changes.html#v1-1-2021-04-08)
  + [v1.0 (2020-06-24)](changes.html#v1-0-2020-06-24)
  + [v0.18 (2019-02-15)](changes.html#v0-18-2019-02-15)
  + [v0.17 (2018-07-20)](changes.html#v0-17-2018-07-20)
  + [v0.16 (2018-05-22)](changes.html#v0-16-2018-05-22)
  + [v0.15 (2018-04-07)](changes.html#v0-15-2018-04-07)
  + [v0.14.1 (2017-07-07)](changes.html#v0-14-1-2017-07-07)
  + [v0.14 (2017-07-06)](changes.html#v0-14-2017-07-06)
  + [v0.13 (2016-10-27)](changes.html#v0-13-2016-10-27)
  + [v0.12 (2016-07-01)](changes.html#v0-12-2016-07-01)
  + [v0.11 (2016-06-09)](changes.html#v0-11-2016-06-09)
  + [v0.10 (2016-04-27)](changes.html#v0-10-2016-04-27)
  + [v0.9 (2016-01-05)](changes.html#v0-9-2016-01-05)
  + [January 2016](changes.html#january-2016)
  + [September 2015](changes.html#september-2015)
  + [April 2015](changes.html#april-2015)
  + [February 2015](changes.html#february-2015)
  + [January 2015](changes.html#january-2015)
  + [December 2014](changes.html#december-2014)
  + [November 2014](changes.html#november-2014)
  + [June 2014](changes.html#june-2014)
  + [April 2014](changes.html#april-2014)

[Next](installation.html "Installation")

---

© Copyright 2014.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).