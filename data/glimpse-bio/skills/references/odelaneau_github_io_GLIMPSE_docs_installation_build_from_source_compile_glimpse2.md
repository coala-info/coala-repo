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

1. [Installation](/GLIMPSE/docs/installation)
2. [Build from source](/GLIMPSE/docs/installation/build_from_source)
3. Compile GLIMPSE2

# Compile GLIMPSE2

## Table of contents

1. [Compile GLIMPSE2](#compile-glimpse2-1)

---

## Compile GLIMPSE2

Download the last version of the GLIMPSE2 code using:

```
git clone https://github.com/odelaneau/glimpse.git
```

Navigate to the downloaded folder using `cd glimpse`.

You’ll find there a folder containing all the software packages are other utility folders:

* **chunk**: program to define chunks where to run phasing and imputation.
* **common**: basic source files used by different tools.
* **concordance**: program to verify the accuracy of low-coverage imputation against high-coverage genomes
* **docker**: all scripts needed to build a docker file comprising all binaries
* **docs**: documentation in html
* **ligate**: ligate multiple imputed BCF/VCF files into a single chromosome-length file
* **maps**: genetics maps in b37 and b38
* **phase**: program to impute and phase low-coverage data.
* **split\_reference**: prorgram to create GLIMPSE2’s reference file format, used by GLIMPSE2\_phase
* **tutorial**: test datasets and scripts
* **versions**: versioning

Each program in the suite contains the same folder structure:

* `bin`: folder for the compiled binary.
* `obj`: folder with all binary objects.
* `src`: folder with source code.
* `makefile`: Makefile to compile the program.

In order to compile a specific tool, for example *GLIMPSE2\_phase*, go in directory of the software (cd `phase`) and edit the specific makefile at lines so that the following variables are correctly set up (look at the paths already there for an example):

* `HTSSRC`: path to the root of the HTSlib library, the prefix for HTSLIB\_INC and HTSLIB\_LIB paths.
* `HTSLIB_INC`: path to the HTSlib header files.
* `HTSLIB_LIB`: path to the static HTSlib library (file `libhts.a`).
* `BOOST_INC`: path to the BOOST header files (usually `/usr/include`).
* `BOOST_LIB_IO`: path to the static BOOST iostreams library (file `libboost_iostreams.a`).
* `BOOST_LIB_PO`: path to the static BOOST `program_options` library (file `libboost_program_options.a`).
* `BOOST_LIB_SE`: path to the static BOOST serialization library (file `libboost_serialization.a`).

If installed at the system level, static libraries (\*.a files) can be located with this command:

```
locate libboost_program_options.a libboost_iostreams.a libhts.a
```

Once all paths correctly set up, proceed with the compilation using `make`. The binary can be found in the `bin/` folder of each tool and will have a name similar to `GLIMPSE2_phase`. You will need to copy the modified makefile in each tool (folder) of GLIMPSE2.

---

[Back to top](#top)

Copyright © 2022-2023 Simone Rubinacci & Olivier Delaneau | All Rights Reserved | Distributed by an [MIT license.](https://github.com/odelaneau/GLIMPSE/blob/master/LICENSE)

[Edit this page on GitHub](https://github.com/srubinacci/ideal-barnacle/tree/main/docs/docs/installation/compile_glimpse2.md)