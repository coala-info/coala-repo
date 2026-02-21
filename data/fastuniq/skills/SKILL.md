---
name: fastuniq
description: FastUniq is a C++ header-only library designed for rapid string deduplication using a parallelized hash table.
homepage: https://github.com/matsuoka-601/FastUniq
---

# fastuniq

## Overview
FastUniq is a C++ header-only library designed for rapid string deduplication using a parallelized hash table. It achieves high throughput (exceeding 1 GB/s) by leveraging SIMD instructions (AVX2/AES), batching hash calculations, and utilizing prefetching for hash table accesses. It is an ideal replacement for traditional Unix deduplication workflows when processing massive newline-separated string files where speed is the primary concern.

## Usage and Best Practices

### Compilation Requirements
Because FastUniq relies on hardware-specific optimizations and multi-threading, you must use the following compiler flags:
- `-mavx2`: Enables AVX2 support for fast hashing.
- `-maes`: Enables AES-NI instructions.
- `-fopenmp`: Enables OpenMP for parallel processing.
- `-O3` or `-Ofast`: Required for the compiler to apply necessary optimizations.

**Example Command:**
`g++ your_program.cpp -mavx2 -maes -O3 -fopenmp -o deduplicator`

### Recommended API Patterns
FastUniq provides two main functions. Choose based on your workflow:

1.  **Maximum Performance (Stdout)**
    Use `void UniquifyToStdout(const char* inputFile)`. This is the fastest method because it avoids the overhead of merging thread-local results into a single memory structure. It is perfect for CLI tools that pipe output to other processes.
2.  **In-Memory Processing**
    Use `std::vector<std::string> Uniquify(const char* inputFile)` if your application needs to perform further operations on the unique strings. Note that this is slower than the stdout version due to the merging phase.

### Expert Tips for Performance
- **Thread Scaling**: Performance scales well with thread count, but gains may diminish beyond 16 threads due to bucket contention in the hash table.
- **Unique String Density**: FastUniq is most efficient when the input contains a high ratio of duplicates. As the number of unique strings increases, the number of hash table insertions increases, which can slow down processing.
- **Hardware Check**: Ensure your target environment supports AVX2. Without it, the library will not function as intended.

### Critical Considerations
- **Hash Collisions**: FastUniq uses 64-bit hashing. While the collision probability is extremely low (roughly 1-2 collisions per 10 million unique strings), it is non-zero. Use this tool only when it is acceptable to potentially miss a very small number of unique strings.
- **Unsorted Output**: The output is produced in a non-deterministic order. If you require sorted results, you must pipe the output to `sort` after deduplication, though this will negate much of the speed advantage.

## Reference documentation
- [FastUniq README](./references/github_com_matsuoka-601_FastUniq.md)