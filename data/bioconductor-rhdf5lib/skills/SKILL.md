---
name: bioconductor-rhdf5lib
description: This package provides compiled C and C++ HDF5 libraries for R package development. Use when user asks to link an R package to HDF5, configure Makevars for HDF5 support, or locate HDF5 headers and library paths within the Bioconductor ecosystem.
homepage: https://bioconductor.org/packages/release/bioc/html/Rhdf5lib.html
---

# bioconductor-rhdf5lib

name: bioconductor-rhdf5lib
description: Provides C and C++ HDF5 libraries for R package development. Use this skill when you need to link an R package to HDF5, configure Makevars for HDF5 support, or locate HDF5 headers and library paths within the Bioconductor ecosystem.

# bioconductor-rhdf5lib

## Overview
Rhdf5lib is a Bioconductor package that provides a compiled version of the HDF5 C and C++ libraries. Its primary purpose is to serve as a dependency for other R packages (like `rhdf5`) that require HDF5 functionality at the compiled code level. By using Rhdf5lib, developers ensure a consistent HDF5 version across platforms without requiring users to install HDF5 system-wide.

## Developer Workflow

### 1. Update DESCRIPTION
To use Rhdf5lib in your package, you must specify it in the `LinkingTo` field and require GNU Make:

```
LinkingTo: Rhdf5lib
SystemRequirements: GNU make
```

### 2. Configure Makevars
You must include both `src/Makevars` and `src/Makevars.win` to link the libraries correctly.

**For C projects:**
```make
RHDF5_LIBS=$(shell "${R_HOME}/bin${R_ARCH_BIN}/Rscript" -e 'Rhdf5lib::pkgconfig("PKG_C_LIBS")')
PKG_LIBS=$(RHDF5_LIBS)
```

**For C++ projects:**
```make
RHDF5_LIBS=$(shell "${R_HOME}/bin${R_ARCH_BIN}/Rscript" -e 'Rhdf5lib::pkgconfig("PKG_CXX_LIBS")')
PKG_LIBS=$(RHDF5_LIBS)
```

**Available pkgconfig options:**
- `PKG_C_LIBS`: Standard C library.
- `PKG_CXX_LIBS`: Standard C++ library.
- `PKG_C_HL_LIBS`: High-level C API.
- `PKG_CXX_HL_LIBS`: High-level C++ API.

### 3. Include Headers
In your C/C++ source files, include the HDF5 headers directly:

```cpp
#include "hdf5.h"
#include "H5Cpp.h"
```

## Troubleshooting and Configuration

### Locating Paths Manually
If you need to find the include or library directories programmatically in R:
- **Headers:** `system.file(package="Rhdf5lib", "include")`
- **Libraries:** `system.file(package="Rhdf5lib", "lib")`

### Installation Arguments
If installing on a system with non-standard setups, use `configure.args`:

- **Custom ZLIB:** `BiocManager::install('Rhdf5lib', configure.args = "--with-zlib='/path/to/zlib/'")`
- **Disable LTO:** `BiocManager::install('Rhdf5lib', INSTALL_opts="--no-use-LTO", configure.args = "--disable-lto")`
- **Disable RPATH:** `BiocManager::install('Rhdf5lib', configure.args = "--disable-sharedlib-rath")`

### Environment Variables
- `RHDF5LIB_RPATH`: Set this environment variable to override the default shared library location (useful for clusters with shared file systems).

## Reference documentation
- [Linking to Rhdf5lib](./references/Rhdf5lib.md)
- [Creating this HDF5 distribution](./references/downloadHDF5.md)