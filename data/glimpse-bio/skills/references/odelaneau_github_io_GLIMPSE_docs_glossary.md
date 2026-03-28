[Skip to main content](#main-content)

Link

Search

Menu

Expand

Document

(external link)

* [Home](/GLIMPSE/)
* [Installation](/GLIMPSE/docs/installation)
  + [Build from source](/GLIMPSE/docs/installation/build_from_source)
    - [System requirements](/GLIMPSE/docs/installation/build_from_source/system_requirements)
    - [Required libraries](/GLIMPSE/docs/installation/build_from_source/required_libraries)
    - [Compile GLIMPSE2](/GLIMPSE/docs/installation/build_from_source/compile_glimpse2)
  + [Static binaries](/GLIMPSE/docs/installation/static_binaries)
  + [Docker](/GLIMPSE/docs/installation/docker)
* [Documentation](/GLIMPSE/docs/documentation)
  + [chunk](/GLIMPSE/docs/documentation/chunk/)
  + [split\_reference](/GLIMPSE/docs/documentation/split_reference/)
  + [phase](/GLIMPSE/docs/documentation/phase/)
  + [ligate](/GLIMPSE/docs/documentation/ligate/)
  + [concordance](/GLIMPSE/docs/documentation/concordance/)
* [Tutorials](/GLIMPSE/docs/tutorials)
  + [Getting started](/GLIMPSE/docs/tutorials/getting_started/)
  + [UK Biobank WGS data](/GLIMPSE/docs/tutorials/ukb_wgs/)
  + [Phasing](/GLIMPSE/docs/tutorials/ukb_phasing/)
* [Expert quick start](/GLIMPSE/docs/quickstart/)
* [Glossary](/GLIMPSE/docs/glossary/)
* [CHANGELOG](/GLIMPSE/CHANGELOG/)
* [GLIMPSE2 on GitHub](https://github.com/odelaneau/GLIMPSE)
* [GLIMPSE1 website](https://odelaneau.github.io/GLIMPSE/glimpse1)

* [GLIMPSE2 on GitHub](//github.com/odelaneau/GLIMPSE)

# Glossary of Terms

Below are some important concepts, software, standards, and other things you might encounter in these Docs and working with SHAPEIT5.

* [GLIMPSE](#glimpse)
* [Genotype imputation](#genotype-imputation)
* [Haplotype phasing](#haplotype-phasing)
* [Haplotype scaffold](#haplotype-scaffold)
* [IMPUTE](#impute)
* [Low-coverage whole genome sequencing](#low-coverage-whole-genome-sequencing)
* [Reference panel](#reference-panel)
* [SHAPEIT](#shapeit)
* [SNP array](#snp-array)
* [Singleton](#singleton)
* [Switch error rate](#switch-error-rate)
* [UK Biobank Research Analysis Platform](#uk-biobank-research-analysis-platform)
* [Whole exome sequencing (WES)](#whole-exome-sequencing-wes)
* [Whole genome sequencing (WGS)](#whole-genome-sequencing-wgs)

---

## GLIMPSE

GLIMPSE (Genotype Likelihoods IMputation and PhaSing mEthod) is a method for haplotype phasing and genotype imputation of low-coverage WGS data, developed by Simone Rubinacci and Olivier Delaneau. The latest version of the tool is GLIMPSE2, which offers the best accuracy and computational performance for large reference panels at rare variants.

Resources:

* GLIMPSE2 [[Website]](https://odelaneau.github.io/GLIMPSE/) [[Paper]](https://www.biorxiv.org/content/10.1101/2022.11.28.518213v1)
* GLIMPSE1 [[Website]](https://odelaneau.github.io/GLIMPSE/glimpse1/) [[Paper]](https://www.nature.com/articles/s41588-020-00756-0)

---

## Genotype imputation

Genotype imputation is a probabilistic inference of the genotypes, typically used for SNP array data or low-coverage WGS. Imputation uses a large reference panel of phased haplotypes to determine large shared identity-by-descent segments that can be used for the statistical inference. Two widely used tools for genotype imputation are [IMPUTE5 for SNP array data](https://www.dropbox.com/sh/mwnceyhir8yze2j/AADbzP6QuAFPrj0Z9_I1RSmla?dl=0) and [GLIMPSE tool for low-coverage imputation](https://odelaneau.github.io/GLIMPSE/).

Resources:

* GLIMPSE for low-coverage imputation [[Website]](https://odelaneau.github.io/GLIMPSE/) [[Paper]](https://www.nature.com/articles/s41588-020-00756-0)
* IMPUTE5 for SNP array data [[Website]](https://www.dropbox.com/sh/mwnceyhir8yze2j/AADbzP6QuAFPrj0Z9_I1RSmla?dl=0) [[Paper]](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1009049)

---

## Haplotype phasing

Haplotype phasing involves distinguishing the two parentally inherited copies of each chromosome into haplotypes. [SHAPEIT5](https://odelaneau.github.io/shapeit5/) is a tool for statistical population-based haplotype phasing which focuses specifically at extremely rare variants.

Resources:

* SHAPEIT5 [[Website]](https://odelaneau.github.io/shapeit5/) [[Paper]](https://www.biorxiv.org/content/10.1101/2022.10.19.512867v1)

---

## Haplotype scaffold

A haplotype scaffold is a set of highly confident haplotypes, typically on a subset of the data. SHAPEIT5 uses the haplotypes derived at common variants as haplotype scaffolds onto which heterozygous genotypes are phased one rare variant at a time.

---

## IMPUTE

IMPUTE is a method for genotype imputation of SNP array data, developed by Jonathan Marchini, Bryan Howie and Simone Rubinacci. The latest version of the tool is IMPUTE5, which offers efficient computational performances for large reference panels.

Resources:

* IMPUTE5 [[Website]](https://jmarchini.org/software/) [[Paper]](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1009049)
* IMPUTE4 [[Website]](https://jmarchini.org/software/) [[Paper]](https://www.nature.com/articles/s41586-018-0579-z)
* IMPUTE2 [[Paper 1]](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1000529) [[Paper 2]](https://www.nature.com/articles/ng.2354)
* IMPUTE1 [[Paper]](https://www.nature.com/articles/ng2088)

---

## Low-coverage whole genome sequencing

Low-coverage whole genome sequencing is whole genome sequencing data sequenced at low-depth usually data with a coverage between 0.1x-8x. Conversely to high-coverage WGS, genotype calling in this case is uncertain and very often this data needs to be imputed with specialised methods (e.g. [GLIMPSE](https://odelaneau.github.io/GLIMPSE/)) in order to be used and processed.

Resources:

* GLIMPSE for low-coverage WGS imputation [[Website]](https://odelaneau.github.io/GLIMPSE/) [[Paper]](https://www.biorxiv.org/content/10.1101/2022.10.19.512867v1)

---

## Reference panel

A reference panel is a large set of deeply-sequenced haplotypes used for genotype imputation and haplotype phasing typically for cohorts genotyped using SNP array or low-coverage WGS.

---

## SHAPEIT

SHAPEIT (Segmented HAPlotype Estimation and Imputation Tools) is a commonly used method for haplotype phasing, mainly developed by Olivier Delaneau. The latest version of the tool is SHAPEIT5, which offers the best accuracy for large cohorts at rare variants.

Resources:

* SHAPEIT5 [[Paper]](https://odelaneau.github.io/SHAPEIT5/)
* SHAPEIT4 [[Paper]](https://www.nature.com/articles/s41467-019-13225-y)
* SHAPEIT3 [[Paper]](https://www.nature.com/articles/ng.3583)
* SHAPEIT2 [[Paper]](https://www.nature.com/articles/nmeth.2307)
* SHAPEIT [[Paper]](https://www.nature.com/articles/nmeth.1785)

---

## SNP array

SNP array is a DNA microarray which is used to detect common SNPs within a population. In the context of GWAS, SNP array data is often imputed using a reference panel of haplotypes (e.g. using [IMPUTE5](https://www.dropbox.com/sh/mwnceyhir8yze2j/AADbzP6QuAFPrj0Z9_I1RSmla?dl=0)

Resources:

* IMPUTE5 for SNP array data [[Website]](https://www.dropbox.com/sh/mwnceyhir8yze2j/AADbzP6QuAFPrj0Z9_I1RSmla?dl=0) [[Paper]](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1009049)

---

## Singleton

A singleton is a rare variant for which genetic variation is carried by a unique chromosome in the dataset (minor allele count of 1). As these variants are unique in the datasets, there is no information to phase the variant, therefore statistical population-based phasing has always reported a switch error rate of 50% at these sites. The typical way to phase these variants is to use family information. However, [SHAPEIT5](https://odelaneau.github.io/shapeit5/) is able to provide for the first time non-random phasing at these sites without the need of family information, by using a simple coalescent-inspired model.

Resources

* SHAPEIT5 [[Website]](https://odelaneau.github.io/shapeit5/) [[Paper]](https://www.biorxiv.org/content/10.1101/2022.10.19.512867v1)

---

## Switch error rate

Switch error rate (SER) is a popular metric to measure the quality of phased data. SER is used when known maternal and paternal haplotypes are available and is defined as the number of switch errors divided by the number of opportunities for switch errors.

---

## UK Biobank Research Analysis Platform

The UK Biobank Research Analysis Platform (RAP), enabled by DNAnexus and Amazon Web Services (AWS), is a cloud-based platform that enables researchers to work with the UK Biobank WGS and WES data.

Resources:

* [UK Biobank website](https://www.ukbiobank.ac.uk/enable-your-research/research-analysis-platform)

---

## Whole exome sequencing (WES)

Whole exome sequencing (WES) is a technique for sequencing all of the protein-coding regions of genes in a genome. In the UK Biobank dataset, we combined WES with SNP array data and performed phasing with SHAPEIT5.

---

## Whole genome sequencing (WGS)

Whole-genome sequencing (WGS) is the process of determining the DNA sequence of an organism at a single time. WGS is intended at high coverage, from 30x of coverage or more, therefore the quality of genotype calling is high. [SHAPEIT5](https://odelaneau.github.io/shapeit5) is designed for large WGS cohorts (e.g. in the UK Biobank), to distinguish the two inherited copies of each chromosome into haplotypes (see haplotype phasing).

---

[Back to top](#top)

Copyright © 2022-2023 Simone Rubinacci & Olivier Delaneau | All Rights Reserved | Distributed by an [MIT license.](https://github.com/odelaneau/GLIMPSE/blob/master/LICENSE)

[Edit this page on GitHub](https://github.com/srubinacci/ideal-barnacle/tree/main/docs/docs/glossary.md)