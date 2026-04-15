---
name: bioconductor-rseqan
description: This tool provides the SeqAn C++ library as a header-only Bioconductor package for high-performance biological sequence analysis in R. Use when user asks to integrate C++ sequence processing into R packages, perform fast pattern searching, or handle SAM/BAM I/O using Rcpp.
homepage: https://bioconductor.org/packages/release/bioc/html/RSeqAn.html
---

# bioconductor-rseqan

name: bioconductor-rseqan
description: Use this skill when working with the RSeqAn Bioconductor package to integrate the SeqAn C++ library for high-performance biological sequence analysis. This skill is applicable for developing R packages that require fast sequence processing, pattern searching, or SAM/BAM I/O by bridging R and C++ via Rcpp.

# bioconductor-rseqan

## Overview

RSeqAn is a header-only Bioconductor package that provides the SeqAn C++ library for use within the R ecosystem. It is designed to overcome R's performance limitations when handling large-scale next-generation sequencing (NGS) data. By using RSeqAn with Rcpp, developers can implement highly efficient sequence analysis algorithms in C++ while maintaining an R-accessible interface.

## Typical Workflow

### 1. Project Configuration
To use RSeqAn in an R package, you must configure the build system to support C++14 and link the necessary libraries.

**In the DESCRIPTION file:**
```
SystemRequirements: C++14
Imports: Rcpp
LinkingTo: Rcpp, RSeqAn
```

**In src/Makevars:**
```
CXX_STD = CXX14
```

### 2. Implementing C++ Functions with RSeqAn
Use the `// [[Rcpp::depends(RSeqAn)]]` attribute to expose SeqAn headers to your Rcpp code.

```cpp
// [[Rcpp::depends(RSeqAn)]]
#include <seqan/sequence.h>
#include <Rcpp.h>

using namespace Rcpp;
using namespace seqan;

// [[Rcpp::export]]
IntegerVector pattern_search(std::string t, std::string p) {
    seqan::String<char> text = t;
    seqan::String<char> pattern = p;
    
    // SeqAn logic here...
    
    // Convert SeqAn results back to Rcpp types for return
    IntegerVector res; 
    return res;
}
```

### 3. Data Type Conversion
SeqAn uses specialized template classes (like `seqan::String<T>`) that do not automatically map to R types.
- **R to SeqAn**: Assign Rcpp/standard C++ types to SeqAn types (e.g., `seqan::String<char> text = t;`).
- **SeqAn to R**: Manually iterate through SeqAn containers and copy values into Rcpp types (e.g., `IntegerVector` or `CharacterVector`) before returning to R.

### 4. Enabling External Libraries (zlib/bzip2)
To handle compressed files (like BAM), you must enable preprocessor flags before compiling.

**In R session:**
```r
Sys.setenv("PKG_CXXFLAGS"="-DSEQAN_HAS_ZLIB -std=c++14")
```

**In src/Makevars:**
```
PKG_CXXFLAGS=-DSEQAN_HAS_ZLIB
```

## SAM/BAM I/O Example
RSeqAn allows for efficient reading and writing of alignment files using the `bam_io.h` module.

```cpp
#include <seqan/bam_io.h>

// Inside an exported Rcpp function:
seqan::BamFileIn bamFileIn("input.bam");
seqan::BamHeader header;
seqan::readHeader(header, bamFileIn);

// Use Rcout for R-compatible console output
seqan::BamFileOut bamFileOut(context(bamFileIn), Rcout, seqan::Sam());
seqan::writeHeader(bamFileOut, header);
```

## Tips for Success
- **Namespace Management**: Be careful when using `using namespace seqan;` and `using namespace Rcpp;` simultaneously, as name collisions can occur.
- **Memory**: SeqAn manages its own memory; ensure you copy data into Rcpp objects if you need the data to persist in the R environment after the C++ function exits.
- **Documentation**: For advanced algorithmic implementation, refer to the official SeqAn C++ documentation, as RSeqAn is primarily a distribution wrapper for that library.

## Reference documentation
- [Introduction to Using RSeqAn](./references/first_example.md)
- [Linking to and configuring RSeqAn](./references/linking.Rmd)