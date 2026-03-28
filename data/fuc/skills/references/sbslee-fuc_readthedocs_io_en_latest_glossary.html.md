[fuc](index.html)

latest

Contents:

* [README](readme.html)
* Glossary
  + [SNV classes](#snv-classes)
  + [Transitions (Ti) and transversions (Tv)](#transitions-ti-and-transversions-tv)
  + [Tumor mutational burden (TMB)](#tumor-mutational-burden-tmb)
  + [Variant allele frequency (VAF)](#variant-allele-frequency-vaf)
* [CLI](cli.html)
* [API](api.html)
* [Tutorials](tutorials.html)
* [Changelog](changelog.html)

[fuc](index.html)

* Glossary
* [Edit on GitHub](https://github.com/sbslee/fuc/blob/main/docs/glossary.rst)

---

# Glossary[](#glossary "Permalink to this heading")

## SNV classes[](#snv-classes "Permalink to this heading")

Considering the pyrimidines of the Watson-Crick base pairs, there are only six different possible substitutions: C>A, C>G, C>T, T>A, T>C, T>G.

References:

* [Single Base Substitution (SBS) Signatures](https://cancer.sanger.ac.uk/signatures/sbs/)

## Transitions (Ti) and transversions (Tv)[](#transitions-ti-and-transversions-tv "Permalink to this heading")

DNA substitution mutations are of two types. Transitions are interchanges of two-ring purines (A↔G) or of one-ring pyrimidines (C↔T): they therefore involve bases of similar shape. Transversions are interchanges of purine for pyrimidine bases, which therefore involve exchange of one-ring and two-ring structures.

| Type | SNV classes |
| --- | --- |
| Ti | C>T, T>C |
| Tv | C>A, C>G, T>A, T>G |

References:

* [Transitions vs. Transversions](https://www.mun.ca/biology/scarr/Transitions_vs_Transversions.html)

## Tumor mutational burden (TMB)[](#tumor-mutational-burden-tmb "Permalink to this heading")

Number of genetic alternations detected within an individual.

## Variant allele frequency (VAF)[](#variant-allele-frequency-vaf "Permalink to this heading")

VAF is used to infer whether a variant comes from somatic cells or inherited from parents when a matched normal sample is not provided. A variant is potentially a germline mutation if the VAF is approximately 50% or 100%.

References:

* [Variant Interpretation for Cancer (VIC): a computational tool for assessing clinical impacts of somatic variants](https://genomemedicine.biomedcentral.com/articles/10.1186/s13073-019-0664-4)

[Previous](readme.html "README")
[Next](cli.html "CLI")

---

© Copyright 2021, Seung-been "Steven" Lee.
Revision `7b0fbfbd`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).