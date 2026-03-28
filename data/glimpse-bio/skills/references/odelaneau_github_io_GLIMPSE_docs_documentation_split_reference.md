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
2. split\_reference

# split\_reference

## Table of contents

1. [Description](#description)
2. [Usage](#usage)
3. [Command line options](#command-line-options)
   1. [Basic options](#basic-options)
   2. [Input parameters](#input-parameters)
   3. [Output files](#output-files)

---

### Description

Tool to create a binary reference panel for quick reading time.

### Usage

Simple run

```
GLIMPSE2_split_reference --input-region chr20:7702567-12266861 --output-region chr20:7952603-12016861 --output binary_reference_panel --reference reference_panel_full_chr20.bcf --map chr20.b38.gmap.gz --threads 4
```

---

### Command line options

#### Basic options

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| --help | NA | NA | Produces help message |
| --seed | INT | 15052011 | Seed of the random number generator |
| -T [ --threads] | INT | 1 | Number of threads |

#### Input parameters

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| -R [--reference] | FILE | NA | Haplotype reference panel in VCF/BCF format |
| -M [ --map ] | FILE | NA | Genetic map |
| --input-region | STRING | NA | Imputation region with buffers |
| --output-region | STRING | NA | Imputation region without buffers |
| --sparse-maf | FLOAT | 0.001 | **Expert setting.** Rare variant threshold |
| --keep-monomorphic-ref-sites | NA | NA | **Expert setting.** Keeps monomorphic markers in the reference panel (removed by default) |

#### Output files

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| -O [--output ] | STRING | NA | Prefix of the output file (region and extension are automatically added) |
| --log | STRING | NA | Log file |

---

[Back to top](#top)

Copyright © 2022-2023 Simone Rubinacci & Olivier Delaneau | All Rights Reserved | Distributed by an [MIT license.](https://github.com/odelaneau/GLIMPSE/blob/master/LICENSE)

[Edit this page on GitHub](https://github.com/srubinacci/ideal-barnacle/tree/main/docs/docs/documentation/split_reference.md)