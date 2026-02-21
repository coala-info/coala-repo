# Linking to Rhdf5lib

Mike L. Smith1

1de.NBI & EMBL Heidelberg

#### 30 October 2025

#### Package

Rhdf5lib 1.32.0

# Contents

* [1 Motivation](#motivation)
* [2 Usage](#usage)
  + [2.1 Link to the library](#link-to-the-library)
  + [2.2 Locating the library headers](#locating-the-library-headers)
* [3 Configuration arguments for non-standard system setups](#configuration-arguments-for-non-standard-system-setups)
  + [3.1 Non-standard ZLIB location](#non-standard-zlib-location)
  + [3.2 Disabling link time optimisation (LTO)](#disabling-link-time-optimisation-lto)
  + [3.3 Disabling setting rpath](#disabling-setting-rpath)
* [4 Funding](#funding)
* [Session info](#session-info)

# 1 Motivation

*[Rhdf5lib](https://bioconductor.org/packages/3.22/Rhdf5lib)* provides versions of the C and C++ HDF5 libraries. It is primarily useful to developers of other R packages who want to make use of the capabilities of the HDF5 library directly in the C or C++ code of their own packages, rather than using a higher level interface such as the [**rhdf5**](http://bioconductor.org/packages/rhdf5/) package. Using **Rhdf5lib** makes life easier for users, as they do not have to worry about installing libraries at a system level, and for developers since they can work with a defined version of the library rather than developing strategies to cope with the potential for multiple versions.

**Rhdf5lib** is very much inspired by the [**zlibbioc**](http://bioconductor.org/packages/zlibbioc/) and [**Rhtslib**](http://bioconductor.org/packages/Rhtslib/) packages.

# 2 Usage

There is an example package,
[**usingRhdf5lib**](https://github.com/grimbough/usingRhdf5lib), that
demonstrates how packages should link to **Rhdf5lib**.

## 2.1 Link to the library

To link successfully to the HDF5 library included in **Rhdf5lib** a package must include *both* a `src/Makevars.win` *and* `src/Makevars` file.

Add the following lines to both `src/Makevars` and `src/Makevars.win`

```
RHDF5_LIBS=$(shell "${R_HOME}/bin${R_ARCH_BIN}/Rscript" -e \
    'Rhdf5lib::pkgconfig("PKG_C_LIBS")')
PKG_LIBS=$(RHDF5_LIBS)
```

Alternatively if using the C++ interface, please add the following lines instead:

```
RHDF5_LIBS=$(shell "${R_HOME}/bin${R_ARCH_BIN}/Rscript" -e \
    'Rhdf5lib::pkgconfig("PKG_CXX_LIBS")')
PKG_LIBS=$(RHDF5_LIBS)
```

The statement for each platform modifies the `$PKG_LIBS` variable. If your package needs to add additional information to the `$PKG_LIBS` variable, do so by adding to the `PKG_LIBS=$(RHDF5_LIBS)` line, e.g.,

```
PKG_LIBS=$(RHDF5_LIBS) -L/path/to/foolib -lfoo
```

*Note that the use of `$(shell ...)` necessitates using GNU Make, and you need to make this requirement explicit in your package’s DESCRIPTION file via the entry:*

```
SystemRequirements: GNU make
```

The default behaviour of `Rhdf5lib::pkgconfig` is to report the location of the shared library as the result of `system.file("lib", package="Rhdf5lib")`. If this is inappropriate for your system e.g. a cluster with a shared file system, use the environment variable `RHDF5LIB_RPATH` to override this and set an appropriate location for your infrastructure.

Valid options to provide to `pkgconfig()` are: `PKG_C_LIBS`, `PKG_CXX_LIBS`, `PKG_C_HL_LIBS` and `PKG_CXX_HL_LIBS`. Choose the most appropriate depending upon whether your linking code requires the C++ API (`C` vs `CXX`) and/or the HDF5 ‘high-level’ API (`HL`). Choosing options that you don’t require should not harm performance, but will result in a larger library and potentially greater memory usage for your application, so it is good practice to select only the features you need.

## 2.2 Locating the library headers

In order for the C/C++ compiler to find the HDF5 headers during package installation, add **Rhdf5lib** to the *LinkingTo* field of the DESCRIPTION file of your package, e.g.

```
LinkingTo: Rhdf5lib
```

In you C or C++ code files, you can then use the standard include techniques, e.g., `#include "hdf5.h"` or `#include "H5Cpp.h"`. You can inspect the header files manually to check their names and declared functions. To find their location on your system you can use the following code:

```
system.file(package="Rhdf5lib", "include")
```

```
## [1] "/tmp/RtmpCCfdAl/Rinst2a4aa426fba75/Rhdf5lib/include"
```

# 3 Configuration arguments for non-standard system setups

## 3.1 Non-standard ZLIB location

*Rhdf5lib* requires the ZLIB compression library to be installed on non-Windows platforms. If installation fails with a message reporting that **zlib.h** can not be found, it is possible to provide the appropriate path explicitly during installation via the `configure.args` argument e.g.

```
BiocManager::install('Rhdf5lib', configure.args = "--with-zlib='/path/to/zlib/'")
```

Here `/path/to/zlib` should be the directory that contains both `include/zlib.h` and `lib/libz.a`. For example, on a typical Ubuntu installation this may be `/usr/` while for libraries installed via **miniconda** this location could be `/home/<USER>/miniconda3/`.

## 3.2 Disabling link time optimisation (LTO)

If you have configured R with link-time optimisation enabled (see [here](https://cran.r-project.org/doc/manuals/r-devel/R-admin.html#Link_002dTime-Optimization)), but wish to turn it off for the installation of **Rhdf5lib**, you need to set both the `configure.args` and `INSTALL_opts` arguments e.g.

```
BiocManager::install('Rhdf5lib', INSTALL_opts="--no-use-LTO", configure.args = "--disable-lto")
```

This is because building **Rhdf5lib** involves first compiling the HDF5 library, and then compiling and linking the R interface against that. The `INSTALL_opts` argument affects the latter part, but we need to use `configure.args` to ensure the HDF5 library is built with the same settings. 111 Using `"--enable-lto"` here will have no effect. To enable link-time optimisation you must have already configured R with `--enable-lto` (see [here](https://cran.r-project.org/doc/manuals/r-devel/R-admin.html#Link_002dTime-Optimization)).

## 3.3 Disabling setting rpath

If you encounter problems checking whether to use `-Wl,-rpath` to “*link shared libs in nondefault directories*” you can disable the test by passing the option `"--disable-sharedlib-rath"` to the configuration script.

```
BiocManager::install('Rhdf5lib', configure.args = "--disable-sharedlib-rath")
```

# 4 Funding

MLS was supported by the BMBF-funded Heidelberg Center for Human Bioinformatics (HD-HuB) within the German Network for Bioinformatics Infrastructure ([de.NBI](https://www.denbi.de)), Grant Number #031A537B

![](data:image/png;base64...)

# Session info

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```