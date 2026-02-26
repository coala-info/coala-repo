---
name: kseqpp
description: "kseqpp is a high-performance C++ library for reading and writing FASTA and FASTQ sequence files. Use when user asks to parse genomic sequences, handle compressed sequence I/O, or integrate fast sequence processing into C++ bioinformatics applications."
homepage: https://github.com/cartoonist/kseqpp
---


# kseqpp

## Overview

kseqpp is a high-performance C++11 re-implementation of the popular kseq library by Heng Li. It is designed to provide a modern, type-safe API for sequence I/O while maintaining the extreme speed and flexibility of the original C macro-based implementation. It is particularly useful for bioinformatics developers who need to handle large-scale genomic data in FASTA or FASTQ formats, including compressed files, without the manual memory management overhead of C.

## Installation and Setup

The library is available via Bioconda and can be integrated into C++ projects using CMake.

```bash
# Install via conda
conda install bioconda::kseqpp
```

To use kseqpp in a C++ project, ensure you link against `zlib` and include the library headers.

## High-Level API Usage

The high-level API is defined in `kseq++/seqio.hpp` and provides the most user-friendly interface for reading and writing.

### Reading Sequences
Use `SeqStreamIn` for simple, iterative reading. It automatically detects file formats (FASTA/FASTQ) and handles gzip compression if zlib is available.

```cpp
#include <kseq++/seqio.hpp>
using namespace klibpp;

KSeq record;
SeqStreamIn iss("input.fastq.gz");
while (iss >> record) {
    // Access record.name, record.seq, record.qual, record.comment
}
```

### Writing Sequences
Use `SeqStreamOut` for writing. The writer is multi-threaded by default to hide I/O latency.

```cpp
#include <kseq++/seqio.hpp>
using namespace klibpp;

SeqStreamOut oss("output.fasta.gz", true, format::fasta);
for (const auto& r : records) {
    oss << r;
}
// Buffer flushes automatically on destruction
```

## Expert Tips and Best Practices

### Chunk-Based Reading
For applications where processing speed is critical, reading records in chunks can be more efficient than record-by-record iteration.
```cpp
auto records = iss.read(1000); // Reads a chunk of 1000 records into a std::vector<KSeq>
```

### Explicit Flushing
When using the writer, if the `SeqStreamOut` object does not go out of scope before the program logic ends or the underlying file descriptor is closed, you must manually flush the buffer to prevent data loss.
```cpp
oss << kend; 
```

### Low-Level Stream Control
If you need to use custom stream types or specific buffer sizes, use the `KStream` class from `kseq++/kseq++.hpp`. This allows you to wrap any file descriptor or custom stream object by providing a corresponding read/write function.

### Performance Optimization
*   **C++ Standard**: While compatible with C++11, using C++17 allows the compiler to infer template parameters for `KStream` constructors, leading to cleaner code.
*   **Memory Management**: `KSeq` objects use RAII. Reusing a single `KSeq` object in a loop (as shown in the reading example) is more memory-efficient than creating new objects for every record.

## Reference documentation
- [kseqpp GitHub Repository](./references/github_com_cartoonist_kseqpp.md)
- [kseqpp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kseqpp_overview.md)