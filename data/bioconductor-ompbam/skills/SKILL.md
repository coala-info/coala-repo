---
name: bioconductor-ompbam
description: The ompBAM package provides C++ header files and templates for developing high-performance, multi-threaded R packages that process BAM files using OpenMP. Use when user asks to create a new ompBAM-based project, implement multi-threaded BAM processing in C++, or use the pbam_in and pbam1_t APIs for genomic data analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/ompBAM.html
---

# bioconductor-ompbam

name: bioconductor-ompbam
description: Specialized guidance for using the Bioconductor package ompBAM to develop R packages that process BAM files using C++ and OpenMP. Use this skill when a user needs to create high-performance BAM processing tools, set up a new ompBAM-based project, or understand the pbam_in and pbam1_t C++ APIs for multi-threaded genomic data analysis.

# bioconductor-ompbam

## Overview

`ompBAM` is a developer-focused Bioconductor package that provides C++ header files for high-performance, multi-threaded BAM file processing. It abstracts the complexities of BGZF decompression, file access, and memory management, allowing developers to focus on domain-specific logic. It is particularly suited for whole-transcriptome calculations where sequential reading of the entire BAM file is required.

## Core Workflow: Creating a New Package

To start a new R package that utilizes `ompBAM`, use the following workflow:

1.  **Initialize the Package**:
    ```r
    library(ompBAM)
    pkg_path <- file.path(tempdir(), "MyNewPkg")
    use_ompBAM(pkg_path)
    ```
    This function creates the directory structure, `DESCRIPTION` (with `Rcpp` and `ompBAM` dependencies), `Makevars` files for OpenMP/zlib linking, and an example C++ implementation.

2.  **Document and Export**:
    ```r
    devtools::document(pkg_path)
    ```
    This processes the roxygen2 tags and generates the `NAMESPACE`.

3.  **Compile and Load**:
    ```r
    devtools::load_all(pkg_path)
    ```

## C++ API Usage Patterns

### 1. Setting up Headers
In your `.cpp` files, ensure `Rcpp` is included before `ompBAM`, and define `cout` to use R's console:
```cpp
#include "Rcpp.h"
using namespace Rcpp;
#define cout Rcpp::Rcout

// [[Rcpp::depends(ompBAM)]]
#include <ompBAM.hpp>
```

### 2. The pbam_in Object (File Input)
The `pbam_in` class manages the BAM stream.
- **Open**: `inbam.openFile(bam_file, n_threads);`
- **Metadata**: `inbam.obtainChrs(names_vec, lens_vec);`
- **The Processing Loop**:
  ```cpp
  while(0 == inbam.fillReads()) {
      #pragma omp parallel for num_threads(n) schedule(static,1)
      for(int i = 0; i < n; i++) {
          pbam1_t read(inbam.supplyRead(i));
          while(read.validate()) {
              // Process read
              read = inbam.supplyRead(i);
          }
      }
  }
  ```

### 3. The pbam1_t Object (Read Access)
`pbam1_t` provides "getters" for BAM alignment data:
- **Core**: `refID()`, `pos()`, `mapq()`, `flag()`, `l_seq()`.
- **Cigar**: `cigar(string_dest)`, `cigar_op(pos)`, `cigar_val(pos)`.
- **Sequence/Qual**: `seq(string_dest)`, `qual(uint8_vec_dest)`.
- **Tags**: `tagVal_i("NM")`, `tagVal_Z("RG", string_dest)`.

## Key Performance Tips

- **Virtual vs. Real Reads**: By default, `pbam1_t` is a "virtual" read (a pointer to the `pbam_in` buffer). It becomes invalid after the next `fillReads()` call. To keep a read in memory (e.g., for paired-end matching), call `read.realize()`.
- **Thread Safety**: `supplyRead(i)` is thread-safe when `i` corresponds to the thread ID in an OpenMP loop.
- **Critical Sections**: Use `#pragma omp critical` when aggregating results from multiple threads into a shared Rcpp/STL container to avoid race conditions.
- **MacOS Compatibility**: MacOS does not support OpenMP natively. Users must install `libomp` (e.g., via brew) and the package must use the `configure` script provided by `use_ompBAM()`.

## Reference documentation

- [ompBAM API Documentation](./references/ompBAM-API-Docs.md)
- [ompBAM API Source (Rmd)](./references/ompBAM-API-Docs.Rmd)