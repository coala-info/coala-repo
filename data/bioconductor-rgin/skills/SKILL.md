---
name: bioconductor-rgin
description: The Rgin package provides a Bioconductor resource for integrating the gin, cephes, and maxflow C++ libraries into R packages. Use when user asks to link to static libraries, include C++ headers, or configure Makevars for cross-platform compatibility.
homepage: https://bioconductor.org/packages/3.8/bioc/html/Rgin.html
---

# bioconductor-rgin

name: bioconductor-rgin
description: Guidance for using the Rgin Bioconductor package to integrate C++ libraries (gin, cephes, maxflow) into R packages. Use when a developer needs to link to Rgin's static libraries, include its headers in C++ code, or configure Makevars for cross-platform compatibility.

# bioconductor-rgin

## Overview

The `Rgin` package provides a set of C++ libraries (including `gin`, `cephes`, and `maxflow`) as a Bioconductor resource. It is primarily used by R package developers who wish to leverage these specific C++ functionalities within their own packages without bundling the source code manually. It handles the distribution of static libraries and headers for use in `src/` code.

## Package Integration Workflow

To use `Rgin` in a third-party R package, follow these steps to ensure headers are discovered and libraries are linked correctly across different operating systems.

### 1. Update DESCRIPTION File
Add `Rgin` to the `LinkingTo` field so the compiler can find the header files.

```
LinkingTo: Rgin
```

### 2. Include Headers in C++ Source
Reference the relevant include files in your C++ code located in `src/`.

```cpp
#include "gin/bam.h"
```

### 3. Configure Compilation (Makevars)
You must provide both `src/Makevars` and `src/Makevars.win` to ensure the static libraries link correctly.

#### For Windows (src/Makevars.win)
Use the internal `pkgMk()` function to resolve paths:

```make
GINVARS=$(shell echo 'cat(Rgin:::.pkgMk())' |\
"${R_HOME}/bin/R" --vanilla --slave)
include $(GINVARS)
PKG_LIBS=$(GIN_LIBS)
PKG_CPPFLAGS=$(GIN_CPPFLAGS)
```

#### For Unix/macOS (src/Makevars)
Use `pkgLd()` to locate the library path and manually specify the static archives:

```make
GIN_PATH=`${R_HOME}/bin/Rscript -e "cat(Rgin:::.pkgLd())"`
GIN_LIBS="$(GIN_PATH)/libgin.a" "$(GIN_PATH)/libcephes.a"\
    "$(GIN_PATH)/libmaxflow.a" -lz -pthread
GIN_CPPFLAGS=-D_USE_KNETFILE -DBGZF_CACHE -D_FILE_OFFSET_BITS=64 \
    -D_LARGEFILE64_SOURCE

PKG_LIBS=$(GIN_LIBS)
PKG_CPPFLAGS=$(GIN_CPPFLAGS)
```

## Tips for Developers
- **Appending Flags**: If your package requires additional libraries or flags, append them to the variables:
  - `PKG_LIBS=$(GIN_LIBS) -ladditional_lib`
  - `PKG_CPPFLAGS=$(GIN_CPPFLAGS) -I/extra/includes`
- **Header Location**: The headers are stored under `src/include/gin` within the `Rgin` source.
- **Dependencies**: Note that `Rgin` links against `zlib` (`-lz`) and requires `pthread` support.

## Reference documentation
- [Using Rgin C++ libraries](./references/Rgin-UsingCppLibraries.md)