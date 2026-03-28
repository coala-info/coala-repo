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

![GLIMPSE2_logo](assets/images/branding/glimpse_logo_400x171.png)

# GLIMPSE

A tool for low-coverage whole-genome sequencing imputation

## About

[GLIMPSE2](https://www.biorxiv.org/content/10.1101/2022.11.28.518213v1) is a set of tools for low-coverage whole genome sequencing imputation. GLIMPSE2 is based on the [GLIMPSE model](https://www.nature.com/articles/s41588-020-00756-0) and designed for reference panels containing hundreads of thousands of reference samples, with a special focus on rare variants.

## Citation

If you use GLIMPSE in your research work, please cite the following papers:

[Rubinacci et al., Imputation of low-coverage sequencing data from 150,119 UK Biobank genomes. BiorXiv (2022)](https://www.biorxiv.org/content/10.1101/2022.11.28.518213v1)

[Rubinacci et al., Efficient phasing and imputation of low-coverage sequencing data using large reference panels. Nature Genetics 53.1 (2021): 120-126.](https://www.nature.com/articles/s41588-020-00756-0)

[Get started now](#getting-started)
[View source code on GitHub](https://github.com/odelaneau/GLIMPSE)

## GLIMPSE1

At the moment, GLIMPSE2 performs imputation only from a reference panel of samples.
To use the joint-model, particularly useful for many samples at higher coverages (>0.5x) and small reference panels, please visit the [GLIMPSE1 website](https://odelaneau.github.io/GLIMPSE/glimpse1/index.html).

## News

> **Version `2.0.0` is now available!**
> See [the CHANGELOG](https://github.com/odelaneau/GLIMPSE/blob/master/docs/CHANGELOG.md) for details.

## Description

GLIMPSE2 is composed of the following tools:

* **chunk**. Tool to phase common sites, typically SNP array data, or the first step of WES/WGS data.
* **split\_reference**. Tool to phase common sites, typically SNP array data, or the first step of WES/WGS data.
* **phase**. Ligate multiple phased BCF/VCF files into a single whole chromosome file. Typically run to ligate multiple chunks of phased common variants.
* **ligate**. Tool to phase rare variants onto a scaffold of common variants (output of phase\_common / ligate).
* **concordance**. Program to compute switch error rate and genotyping error rate given simulated or trio data.

[chunk](/GLIMPSE/docs/documentation/chunk/)
[split\_reference](/GLIMPSE/docs/documentation/split_reference/)
[phase](/GLIMPSE/docs/documentation/phase/)
[ligate](/GLIMPSE/docs/documentation/ligate/)
[concordance](/GLIMPSE/docs/documentation/concordance/)

---

## Getting started

* [See documentation](/GLIMPSE/docs/documentation)

---

## About the project

GLIMPSE is developed by Simone Rubinacci & Olivier Delaneau.

### License

GLIMPSE is distributed with [MIT license](https://github.com/odelaneau/GLIMPSE/blob/master/LICENSE).

### Organisations

[![unil](assets/images/lausanne_logo.jpg)](https://www.unil.ch/index.html)

[![sib](assets/images/sib_logo.jpg)](https://www.sib.swiss/)

[![snf](assets/images/snf.gif)](https://www.snf.ch/en/Pages/default.aspx)

### Contributing

GLIMPSE is an open source project and we very much welcome new contributors. To make the contribution quickly accepted, please first discuss the change you wish to make via issue,
email, or any other method with the owners of this repository before making a change.

#### Thank you to the contributors of GLIMPSE!

* [![odelaneau](https://avatars.githubusercontent.com/u/16349601?v=4)](https://github.com/odelaneau)
* [![srubinacci](https://avatars.githubusercontent.com/u/17588501?v=4)](https://github.com/srubinacci)
* [![kachulis](https://avatars.githubusercontent.com/u/39926576?v=4)](https://github.com/kachulis)
* [![RJHFMSTR](https://avatars.githubusercontent.com/u/89519497?v=4)](https://github.com/RJHFMSTR)
* [![dependabot[bot]](https://avatars.githubusercontent.com/in/29110?v=4)](https://github.com/apps/dependabot)
* [![michaelgatzen](https://avatars.githubusercontent.com/u/52426291?v=4)](https://github.com/michaelgatzen)
* [![rwk-unil](https://avatars.githubusercontent.com/u/72375500?v=4)](https://github.com/rwk-unil)
* [![LouisLeNezet](https://avatars.githubusercontent.com/u/58640615?v=4)](https://github.com/LouisLeNezet)
* [![ejeanvoi](https://avatars.githubusercontent.com/u/696922?v=4)](https://github.com/ejeanvoi)
* [![lmtani](https://avatars.githubusercontent.com/u/12699242?v=4)](https://github.com/lmtani)
* [![koido](https://avatars.githubusercontent.com/u/16730135?v=4)](https://github.com/koido)
* [![saulpierotti](https://avatars.githubusercontent.com/u/91374534?v=4)](https://github.com/saulpierotti)
* [![stephenturner](https://avatars.githubusercontent.com/u/460076?v=4)](https://github.com/stephenturner)
* [![cqgd](https://avatars.githubusercontent.com/u/1307936?v=4)](https://github.com/cqgd)

We thank the [Just the Docs](https://github.com/just-the-docs/just-the-docs) developers, who made this awesome theme for Jekyll.

---

[Back to top](#top)

Copyright © 2022-2023 Simone Rubinacci & Olivier Delaneau | All Rights Reserved | Distributed by an [MIT license.](https://github.com/odelaneau/GLIMPSE/blob/master/LICENSE)

[Edit this page on GitHub](https://github.com/srubinacci/ideal-barnacle/tree/main/docs/index.md)