[Sex Genomics Toolkit](../index.html)

RADSex

* Introduction
* [Getting started](getting_started.html)
* [Example walkthrough](example.html)
* [RADSex-workflow](workflow.html)
* [Usage](usage.html)
* [Input files](input_files.html)
* [Output files](output_files.html)

PSASS

* [Introduction](../psass/introduction.html)
* [Getting started](../psass/getting_started.html)
* [Example walkthrough](../psass/example.html)
* [PSASS-workflow](../psass/workflow.html)
* [Usage](../psass/usage.html)
* [Output files](../psass/output_files.html)

KPOOL

* [Introduction](../kpool/introduction.html)
* [Getting started](../kpool/getting_started.html)
* [Example walkthrough](../kpool/example.html)
* [Kpool-workflow](../kpool/workflow.html)
* [Usage](../kpool/usage.html)
* [Output files](../kpool/output_files.html)

sgtr

* [Introduction](../sgtr/introduction.html)

[Sex Genomics Toolkit](../index.html)

* [Docs](../index.html) »
* Introduction
* [View page source](../_sources/radsex/introduction.rst.txt)

---

# Introduction[¶](#introduction "Permalink to this headline")

RADSex is a computational workflow to analyze RAD-Sequencing data. It was primarily designed to compare male and female individuals looking for markers associated with sex, but it can be used to study any binary trait in two populations.

The core idea of RADSex is to compare presence / absence of non-polymorphic markers between individuals in two groups. RADSex does not allow mismatches when grouping reads into markers. This means that each allele in a polyallelic locus is represented as a separate marker, whereas other RAD-Sequencing analysis softwares would usually group these alleles in a single polymorphic marker. Splitting alleles from polymorphic markers enables RADSex to easily detect sex-specific alleles using only minimum depth of a marker as parameter.

The main input of RADSex is a dataset of demultiplexed RAD reads, *i.e.* one reads file per individual. From this dataset, RADSex generates a table containing the depth of each marker in each individual. This table is then used to infer information about the type of sex-determination system, identify sex-biased markers, or align the markers to a genome. Several functions are also implemented to assist with general analysis of the dataset, for instance computing the frequencies of markers in all individuals or estimating the median marker depth in each individual.

Results from RADSex can be visualized with the [sgtr](https://github.com/SexGenomicsToolkit/sgtr) R package, which provides easy-to-use functions to generate visual representations of your data.

[Next](getting_started.html "Getting started")
 [Previous](../index.html "Sex Genomics Toolkit")

---

© Copyright 2018-2020, Romain Feron

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).