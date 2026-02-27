---
name: bioconductor-rhtslib
description: This package provides R wrappers for the HTSlib C library to facilitate high-throughput sequencing data manipulation in R package development. Use when user asks to integrate HTSlib into an R package, link C or C++ code to HTSlib headers, or manage SAM, BAM, CRAM, and VCF files within a Bioconductor developer workflow.
homepage: https://bioconductor.org/packages/release/bioc/html/Rhtslib.html
---


# bioconductor-rhtslib

## Overview

Rhtslib is a developer-focused Bioconductor package that wraps the HTSlib C library (version 1.18). It allows R package developers to use HTSlib's powerful APIs for manipulating high-throughput sequencing data formats (SAM, BAM, CRAM, VCF, BCF2) without requiring end-users to manually install system-level dependencies. It provides a consistent version of HTSlib across platforms, ensuring reproducible behavior in C/C++ extensions.

## Developer Workflow

### 1. Configure DESCRIPTION
To use Rhtslib in your package, you must specify it in the `LinkingTo` field so the compiler can find the headers. Since it uses GNU make syntax in the build process, add it to `SystemRequirements`.

```
LinkingTo: Rhtslib
SystemRequirements: GNU make
```

### 2. Configure src/Makevars
You must create or update `src/Makevars` (and `src/Makevars.win` for Windows) to correctly link the compiled HTSlib library. Use `Rhtslib::pkgconfig` to retrieve the necessary flags.

**Recommended src/Makevars content:**
```make
RHTSLIB_LIBS=$(shell "${R_HOME}/bin${R_ARCH_BIN}/Rscript" -e \
    'Rhtslib::pkgconfig("PKG_LIBS")')
RHTSLIB_CPPFLAGS=$(shell "${R_HOME}/bin${R_ARCH_BIN}/Rscript" -e \
    'Rhtslib::pkgconfig("PKG_CPPFLAGS")')

PKG_LIBS=$(RHTSLIB_LIBS)
PKG_CPPFLAGS=$(RHTSLIB_CPPFLAGS)
```

*Note: If you have other libraries to link, append them to `PKG_LIBS`, e.g., `PKG_LIBS=$(RHTSLIB_LIBS) -lz`.*

### 3. Include Headers in C/C++ Code
Once `LinkingTo` is set, you can include HTSlib headers directly in your source files:

```c
#include "htslib/hts.h"
#include "htslib/sam.h"
#include "htslib/vcf.h"
```

### 4. Utility Functions
While primarily for C-level integration, you can check the versioning and file locations from within R:

*   **Check HTSlib Version:**
    ```r
    Rhtslib:::htsVersion()
    ```
*   **Locate Header Directory:**
    ```r
    system.file(package="Rhtslib", "include")
    ```

## Implementation Notes
*   **Static vs Dynamic:** Rhtslib provides both static and dynamic libraries on Linux and macOS, but only static on Windows. The `pkgconfig` approach defaults to static linking for maximum portability.
*   **Whitespace Handling:** The `$(shell ...)` syntax in Makevars is preferred over back-ticks to prevent path resolution errors when R is installed in directories containing spaces.
*   **Reference Implementation:** For a robust example of a package using Rhtslib, refer to the source code of the `Rsamtools` Bioconductor package.

## Reference documentation
- [Motivation and use of Rhtslib](./references/Rhtslib.md)