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

1. [Documentation](/GLIMPSE/docs/documentation)
2. ligate

# ligate

## Table of contents

1. [Description](#description)
2. [Usage](#usage)
3. [Command line options](#command-line-options)
   1. [Basic options](#basic-options)
   2. [Input files](#input-files)
   3. [Output files](#output-files)

---

### Description

Ligatation of multiple phased BCF/VCF files into a single whole chromosome file. GLIMPSE2 is run in chunks that are ligated into chromosome-wide files maintaining the phasing.

### Usage

Simple run

```
#ls -1v in order to keep the order within the chromosome
ls -1v chr20/*.imputed.bcf > list_imputed_files_chr20.txt

GLIMPSE2_ligate --input list_imputed_files_chr20.txt --output ligated_chr20.bcf --threads 2
```

---

### Command line options

#### Basic options

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| --help | NA | NA | Produces help message |
| --seed | INT | 15052011 | Seed of the random number generator |
| -T [ --thread ] | INT | 1 | Number of threads |

#### Input files

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| -I [--input ] | STRING | NA | Text file containing all VCF/BCF to ligate, one file per line |

#### Output files

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| -O [--output ] | STRING | NA | Output ligated (phased) file in VCF/BCF format |
| --no-index | STRING | NA | If specified, the ligated VCF/BCF is not indexed by GLIMPSE2 for random access to genomic regions |
| --log | STRING | NA | Log file |

---

[Back to top](#top)

Copyright © 2022-2023 Simone Rubinacci & Olivier Delaneau | All Rights Reserved | Distributed by an [MIT license.](https://github.com/odelaneau/GLIMPSE/blob/master/LICENSE)

[Edit this page on GitHub](https://github.com/srubinacci/ideal-barnacle/tree/main/docs/docs/documentation/ligate.md)