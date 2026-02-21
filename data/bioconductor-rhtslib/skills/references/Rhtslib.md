# Motivation and use of *Rhtslib*

Nathaniel Hayden, Martin Morgan

#### Compiled 30 October 2025; Modified 31 October 2023

#### Abstract

This package provides version 1.18 of the ‘HTSlib’ C library for high-throughput sequence analysis. The package is primarily useful to developers of other R packages who wish to make use of HTSlib. Motivation and instructions for use of this package are in this vignette.

#### Package

Rhtslib 3.6.0

# Contents

* [1 Motivation](#motivation)
  + [1.1 HTSlib version](#htslib-version)
  + [1.2 Motivation](#motivation-1)
* [2 Use](#use)
  + [2.1 Find headers](#find-headers)
  + [2.2 Compile and link against the library](#compile-and-link-against-the-library)
* [3 Implementation notes](#implementation-notes)

# 1 Motivation

*[Rhtslib](https://bioconductor.org/packages/3.22/Rhtslib)* is an R package that provides the C `HTSlib`
library for high-throughput sequence data analysis. The library
provides APIs for creating, indexing, manipulating, and analyzing data
in SAM/BAM/CRAM sequence files and VCF/BCF2 variant files. See the
[HTSlib website](http://www.htslib.org/) for complete details and
documentation.

The *[Rhtslib](https://bioconductor.org/packages/3.22/Rhtslib)* package is primarily useful to developers
of other R packages who want to use the HTSlib facilities in the C
code of their own packages.

## 1.1 HTSlib version

The version of the included HTSlib is displayed at package load time,
but a user can also query the HTSlib version directly by calling
`Rhtslib:::htsVersion()` in an R session. The current version of the
package is 1.18.

Effort is made to update the included version of HTSlib with minor
version releases from the HTSlib authors. If you notice the included
HTSlib is older than the current minor release of HTSlib, please
contact the *[Rhtslib](https://bioconductor.org/packages/3.22/Rhtslib)* maintainer.

## 1.2 Motivation

There are several advantages to using `Rhtslib`, rather than requiring
an explicit user system dependency on `htslib` directly.

* Using `Rhtslib` means that your users (who are not always
  sophisticated system administrators) do not need to manually install
  their own library.
* Your application uses a defined version of `htslib`, so that you as
  a developer can rely on presence of specific features (and bugs!)
  rather than writing code to manage different library versions.

# 2 Use

See the [`Rsamtools`](https://github.com/Bioconductor/Rsamtools) package
for an example of a package that compiles and links against `Rhtslib`.

## 2.1 Find headers

In order for the C/C++ compiler to find HTSlib headers during installation
of your package, you must add `Rhtslib` to the `LinkingTo` field of its
`DESCRIPTION` file, e.g.,

```
LinkingTo: Rhtslib
```

Note that as of R 3.0.2 `LinkingTo` values can include version
specifications, e.g., `LinkingTo: Rhtslib (>= 0.99.10)`.

In C or C++ code files, use standard techniques, e.g., `#include "htslib/hts.h"`. Header files are available for perusal at (enter
in an R session)

```
system.file(package="Rhtslib", "include")
```

```
## [1] "/tmp/RtmpkZEHfj/Rinst2aefdb202ac91a/Rhtslib/include"
```

## 2.2 Compile and link against the library

To compile and link your package successfully against the HTSlib included
in *[Rhtslib](https://bioconductor.org/packages/3.22/Rhtslib)*, you must include a `src/Makevars` file.

Create a `src/Makevars` file with the following lines

```
RHTSLIB_LIBS=$(shell "${R_HOME}/bin${R_ARCH_BIN}/Rscript" -e \
    'Rhtslib::pkgconfig("PKG_LIBS")')
RHTSLIB_CPPFLAGS=$(shell "${R_HOME}/bin${R_ARCH_BIN}/Rscript" -e \
    'Rhtslib::pkgconfig("PKG_CPPFLAGS")')

PKG_LIBS=$(RHTSLIB_LIBS)
PKG_CPPFLAGS=$(RHTSLIB_CPPFLAGS)
```

Note that `$(shell ...)` is GNU make syntax so you should add `GNU make`
to the `SystemRequirements` field of the `DESCRIPTION` file of your package,
e.g.,

```
SystemRequirements: GNU make
```

The reason we use `$(shell echo ...)` rather than back-ticks (e.g.
`` `echo ...` ``) is because the latter causes problems when, after
evaluation, `PKG_LIBS` and/or `PKG_CPPFLAGS` contain paths with
whitespaces in them.

If your package needs to add to the `$PKG_LIBS` variable, do so by adding
to the `PKG_LIBS=$(RHTSLIB_LIBS)` line, e.g.,

```
PKG_LIBS=$(RHTSLIB_LIBS) -L/path/to/foolib -lfoo
```

[comment](#%20and%20has%20resolved%20symbolic%20links%20to%20their%20actual%20path.): # This can cause problems, e.g., when the ‘head’ node of
[comment](#%20and%20has%20resolved%20symbolic%20links%20to%20their%20actual%20path.): # a cluster mimicks the cluster node via a symbolic link to
[comment](#%20and%20has%20resolved%20symbolic%20links%20to%20their%20actual%20path.): # the directory in which Rhtslib is installed. Use the
[comment](#%20and%20has%20resolved%20symbolic%20links%20to%20their%20actual%20path.): # environment variable `RHTSLIB_RPATH` to resolve this by
[comment](#%20and%20has%20resolved%20symbolic%20links%20to%20their%20actual%20path.): # setting it to the cluster-node accessible path.

# 3 Implementation notes

`Rhtslib` provides both static and dynamic library versions of HTSlib
on Linux and Mac OS X platforms, but only the static version on
Windows. The procedure above will link against the static library
version of HTSlib on all platforms.