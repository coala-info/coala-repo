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

# CHANGELOG

All notable changes to this project are documented in this file.

## v2.0.0

```
* Major release. Introduced speedups and accuracy improvements. Version used for the preprint. (https://doi.org/10.1101/2022.11.28.518213)
```

## v1.1.1

```
* Removed bug in haploid imputation
* Removed bug reading imputing regions with spanning indels (bug reported by @MySelvan)
* Removed bug in INFO score calculation
* Refactory model classes (cast)
* Added --inputGL option
* Added --ban-repeated-sample-names option
```

## v1.1.0

```
* Better reporting of missing genotype likelihoods and ploidy
* Added multi-threaded input for VCF/BCF files
* Added haploid/diploid/mixed ploidy imputation
* Added FPLOIDY parameter in output
* Small improvements in the PBWT selection
```

## v1.0.1

```
* Version used for the paper (https://doi.org/10.1038/s41588-020-00756-0)
* Change in the state  selection for phasing
* Bugfix for compatibility with bcftools 1.10.x regarding --main
```

## v1.0.0

```
* First release. Version used for the preprint (https://doi.org/10.1101/2020.04.14.040329)
```

---

[Back to top](#top)

Copyright © 2022-2023 Simone Rubinacci & Olivier Delaneau | All Rights Reserved | Distributed by an [MIT license.](https://github.com/odelaneau/GLIMPSE/blob/master/LICENSE)

[Edit this page on GitHub](https://github.com/srubinacci/ideal-barnacle/tree/main/docs/CHANGELOG.md)