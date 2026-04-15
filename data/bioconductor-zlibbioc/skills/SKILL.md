---
name: bioconductor-zlibbioc
description: This package provides the zlib source code and compiled libraries as a system-level utility for Bioconductor package development. Use when user asks to include zlib headers in C or C++ code, configure compiler and linker flags for compression, or ensure cross-platform zlib availability in R packages.
homepage: https://bioconductor.org/packages/3.20/bioc/html/zlibbioc.html
---

# bioconductor-zlibbioc

## Overview

The `zlibbioc` package is a "system-level" utility package for Bioconductor developers. It provides the source code and compiled libraries for `zlib` (version 1.2.5), ensuring that compression functionality is available across all operating systems, including those where a system-level zlib might be missing or incompatible. It is primarily used to provide headers and compiled libraries for other R packages containing C or C++ code.

## Package Integration Workflow

To use `zlibbioc` in your own R package development, follow these steps:

### 1. Configure Package Metadata
Update your package's core files to declare the dependency:
*   **DESCRIPTION**: Add `Imports: zlibbioc`
*   **NAMESPACE**: Add `import(zlibbioc)`

### 2. C/C++ Source Code
In your C or C++ source files, include the standard zlib header:
```c
#include "zlib.h"
```

### 3. Platform-Specific Build Configuration

The package provides a `pkgconfig()` function to retrieve the necessary compiler and linker flags.

#### For Windows (src/Makevars.win)
Use the shared library (DLL) approach. Ensure the second line of each rule starts with a **tab**.

```make
ZLIB_CFLAGS+=$(shell echo 'zlibbioc::pkgconfig("PKG_CFLAGS")'|\
  "${R_HOME}/bin/R" --vanilla --slave)
PKG_LIBS+=$(shell echo 'zlibbioc::pkgconfig("PKG_LIBS_shared")' |\
  "${R_HOME}/bin/R" --vanilla --slave)

%.o: %.c
	$(CC) $(ZLIB_CFLAGS) $(ALL_CPPFLAGS) $(ALL_CFLAGS) -c $< -o $@

# If using C++
%.o: %.cpp
	$(CXX) $(ZLIB_CFLAGS) $(ALL_CPPFLAGS) $(ALL_CXXFLAGS) -c $< -o $@
```

#### For Linux/Unix/macOS (src/Makevars)
The most portable method is linking to the static libraries:

```make
PKG_CFLAGS+=$(shell echo 'zlibbioc::pkgconfig("PKG_CFLAGS")'|\
    "${R_HOME}/bin/R" --vanilla --slave)
PKG_LIBS+=$(shell echo 'zlibbioc::pkgconfig("PKG_LIBS_static")'|\
    "${R_HOME}/bin/R" --vanilla --slave)
```

## Usage Tips

*   **System zlib vs zlibbioc**: Most Linux and macOS systems have a native zlib. `zlibbioc` is a fallback to ensure your Bioconductor package builds consistently regardless of the user's system configuration.
*   **pkgconfig() Arguments**:
    *   `"PKG_CFLAGS"`: Returns the include path for `zlib.h`.
    *   `"PKG_LIBS_shared"`: Returns flags for linking against the shared library.
    *   `"PKG_LIBS_static"`: Returns flags for linking against the static library.
*   **Troubleshooting**: If headers are not found during compilation, verify that `zlibbioc::pkgconfig("PKG_CFLAGS")` returns a valid path in your R console.

## Reference documentation

- [Using zlibbioc](./references/UsingZlibbioc.md)