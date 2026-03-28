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
2. chunk

# chunk

## Table of contents

1. [Description](#description)
2. [Usage](#usage)
3. [Command line options](#command-line-options)
   1. [Basic options](#basic-options)
   2. [Input files](#input-files)
   3. [Window Parameters](#window-parameters)
   4. [Model Parameters](#model-parameters)
   5. [Output files](#output-files)

---

### Description

Tool to create imputation chunks.

### Usage

Simple run

```
GLIMPSE2_chunk --input file_chr20.bcf --map chr20.b38.gmap.gz --region chr20 --sequential --output chunks_chr20.txt
```

---

### Command line options

#### Basic options

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| --help | NA | NA | Produces help message |
| --seed | INT | 15052011 | Seed of the random number generator |
| -T [ --threads ] | INT | 1 | Number of threads |

#### Input files

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| -I [ --input ] | FILE | NA | Reference or target dataset at all variable positions in VCF/BCF format. The GT field is not required |
| --region | STRING | NA | Chromosome or region to be split |
| -M [ --map ] | FILE | NA | Genetic map |
| --sparse-maf | FLOAT | 0.001 | **Expert setting.** Rare variant threshold |

#### Window Parameters

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| --window-cm | FLOAT | 4.0 | Minimal window size in cM |
| --window-mb | FLOAT | 4.0 | Minimal window size in Mb |
| --window-count | INT | 30000 | Minimal window size in #variants |
| --buffer-cm | FLOAT | 0.5 | Minimal buffer size in cM |
| --buffer-mb | FLOAT | 0.5 | Minimal buffer size in Mb |
| --buffer-count | INT | 3000 | Minimal buffer size in #variants |

#### Model Parameters

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| --recursive | NA | NA | Recursive algorithm |
| --sequential | NA | NA | **Recommended.** Sequential algorithm |
| --uniform-number-variants | NA | NA | **Experimental.** Uniform the number of variants in the sequential algorithm |

#### Output files

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| -O [--output ] | STRING | NA | File containing the chunks for phasing and imputation |
| --log | STRING | NA | Log file |

---

[Back to top](#top)

Copyright © 2022-2023 Simone Rubinacci & Olivier Delaneau | All Rights Reserved | Distributed by an [MIT license.](https://github.com/odelaneau/GLIMPSE/blob/master/LICENSE)

[Edit this page on GitHub](https://github.com/srubinacci/ideal-barnacle/tree/main/docs/docs/documentation/chunk.md)