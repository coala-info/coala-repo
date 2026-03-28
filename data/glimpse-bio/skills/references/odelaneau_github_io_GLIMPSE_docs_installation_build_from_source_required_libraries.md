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
3. Required libraries

# Required libraries

## Table of contents

1. [Required libraries](#required-libraries-1)
   1. [HTSlib](#htslib)
   2. [Boost](#boost)
   3. [Additional libraries](#additional-libraries)

---

## Required libraries

GLIMPSE2 requires several libraries installed on the system. Here we assume most of the libraries are available, and we focus on two main libraries:

* HTSlib version >= 1.7: A C library for reading/writing high-throughput sequencing data.
* BOOST version >= 1.65: A set of peer-reviewed portable C++ source libraries. GLIMPSE2 uses three specific BOOST libraries: `iostreams`, `program_options` and `serialization`.

### HTSlib

Building HTSlib is straightforward and does not require root privileges. Please refer to the [HTSlib](http://www.htslib.org/) documentation for complete details. Here we provide a basic script to install HTSlib v1.16:

```
wget https://github.com/samtools/htslib/releases/download/1.16/htslib-1.16.tar.bz2
tar -xf htslib-1.16.tar.bz2
mv htslib-1.16 htslib
cd htslib
autoheader; autoconf; ./configure; #optional
make
```

After this, you’ll find the libhts.a inside your current directory and the include files inside subdirectory: `./include/`

### Boost

As GLIMPSE2 only requires few of the boost libraries, we’ll build the smallest possible boost build, without requiring root privileges. Please refer to the [Boost installation instructions](https://www.boost.org/doc/libs/1_73_0/more/getting_started/unix-variants.html#easy-build-and-install) for complete details. Here we provide a basic script to the minimal build of Boost v1.73.0 required to run GLIMPSE2:

```
wget https://boostorg.jfrog.io/artifactory/main/release/1.73.0/source/boost_1_73_0.tar.bz2
tar --bzip2 -xf boost_1_73_0.tar.bz2
cd boost_1_73_0
./bootstrap.sh --with-libraries=iostreams,program_options,serialization --prefix=../boost #where ../boost is your custom boost installation prefix
./b2 install
cd ../boost #change this to the folder you used as --prefix for the bootstrap script
```

After this, you will also find a copy of the Boost headers in the include/ subdirectory of the installation prefix (our current directory). The Boost static libraries (`libboost_iostreams.a`, `libboost_program_options.a` and `libboost_serialization.a`) are found in the subfolder `./lib/` of your installation prefix.

### Additional libraries

Make sure that the following standard library flags can be used by g++ on your system:

* `-lz`,`-lbz2` and `-llzma` for reading/writing compressed files.
* `-lm` for basic math operations.
* `-lpthread` for multi-threading

You can do so by checking the outcome of the following commands:

```
locate -b '\libz.so'
locate -b '\libbz2.so'
locate -b '\liblzma.so'
locate -b '\libm.so'
locate -b '\libpthread.so'
locate -b '\libcurl.so'
```

---

[Back to top](#top)

Copyright © 2022-2023 Simone Rubinacci & Olivier Delaneau | All Rights Reserved | Distributed by an [MIT license.](https://github.com/odelaneau/GLIMPSE/blob/master/LICENSE)

[Edit this page on GitHub](https://github.com/srubinacci/ideal-barnacle/tree/main/docs/docs/installation/required_libraries.md)