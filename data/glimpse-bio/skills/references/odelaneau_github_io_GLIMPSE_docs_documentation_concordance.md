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
2. concordance

# concordance

## Table of contents

1. [Description](#description)
2. [Usage](#usage)
3. [Command line options](#command-line-options)
   1. [Basic options](#basic-options)
   2. [Input parameters](#input-parameters)
   3. [Other parameters](#other-parameters)
   4. [Output files](#output-files)

---

### Description

Program to compute the genotyping error rate at the sample or marker level.

### Usage

Simple run

```
echo "chr20 ukb_white_british_sites.bcf validation_c20_snps.bcf imputed_ligated_c20_rp140k_1.0x.bcf" > concordance.txt

GLIMPSE2_concordance --gt-val --ac-bins 1 5 10 20 50 100 200 500 1000 2000 5000 10000  20000 50000 100000 140119 --threads 2 --input concordance.txt --output concordance_c20_rp140
```

---

### Command line options

#### Basic options

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| --help | NA | NA | Produces help message |
| --seed | INT | 15052011 | Seed of the random number generator |
| -T [ --threads ] | INT | 1 | Number of threads |

#### Input parameters

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| --input | FILE | NA | File with four columns listing in order: regions frequencies validation and imputed dataset. For genome-wide concordance, add more lines specifying different chromosomes. |
| --samples | NA | NA | List of samples to process, one sample ID per line. |
| --gt-val | NA | NA | Uses hard called genotypes rather than phread-scaled likelihoods for the validation dataset, reading them from FORMAT/GT field. |
| --gt-tar | NA | NA | Uses FORMAT/GT field to determine the best-guess genotype rather than the FORMAT/GP (default). FORMAT/DS are FORMAT/GP fields are still required for calibration and rsquared calculations. |

#### Other parameters

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| --af-tag | STRING | AF | Allele frequency INFO tag to use for binning. By default the allele frequency is estimated from the INFO/AF tag. |
| --use-alt-af | NA | NA | If specified, the metrics work on the ALT allele frequency (range [0,1]), rather than minor allele frequency (range [0,0.5]). |
| --bins | VECTOR | NA | Allele frequency bins used for rsquared computations. By default they should as MAF bins [0-0.5], while they should take the full range [0-1] if –use-ref-alt is used. |
| --ac-bins | VECTOR | NA | User-defined allele count bins used for rsquared computations. |
| --allele-counts | VECTOR | NA | Default allele count bins used for rsquared computations. AN field must be defined in the frequency file. |
| --min-val-gl | FLOAT | NA | Minimum genotype likelihood probability P(G|R) in validation data [set to zero to have no filter of if using –gt-validation] |
| --min-val-dp | INT | NA | Minimum coverage in validation data. If FORMAT/DP is missing and –minDP > 0, the program exits with an error. [set to zero to have no filter of if using –gt-validation] |
| --min-tar-gp | VECTOR | NA | Minimum GP probabilities to be used as a filter. By default it looks at the GP field to specify the filter, but will try to use FORMAT/PL if gt-tar option is specified. Leave empty if no filter is used. |
| --out-r2-per-site | NA | NA | Output r2 at each site. |
| --out-rej-sites | NA | NA | Output sites where that cannot be used for the concordance. |
| --out-conc-sites | NA | NA | Output sites where all target genotypes are concordant with the truth. |
| --out-disc-sites | NA | NA | Output sites where at least one target genotype is diconcordant with the truth. |
| --groups | FILE | NA | Alternative to frequency bins: group bins are user defined, provided in a file. |

#### Output files

| Option name | Argument | Default | Description |
| --- | --- | --- | --- |
| -O [--output ] | STRING | NA | Prefix of the output files (extensions are automatically added) |
| --log | STRING | NA | Log file |

---

[Back to top](#top)

Copyright © 2022-2023 Simone Rubinacci & Olivier Delaneau | All Rights Reserved | Distributed by an [MIT license.](https://github.com/odelaneau/GLIMPSE/blob/master/LICENSE)

[Edit this page on GitHub](https://github.com/srubinacci/ideal-barnacle/tree/main/docs/docs/documentation/concordance.md)