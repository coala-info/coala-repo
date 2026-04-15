---
name: google-sparsehash
description: The google-sparsehash library provides memory-efficient and high-speed C++ hash-table implementations including sparse and dense maps and sets. Use when user asks to optimize memory usage with sparse hash tables, achieve high-speed lookups with dense hash tables, or serialize hash-table data to disk.
homepage: https://github.com/benvanik/sparsehash
metadata:
  docker_image: "quay.io/biocontainers/google-sparsehash:2.0.3--1"
---

# google-sparsehash

## Overview
The `google-sparsehash` library provides several C++ hash-table implementations with distinct performance profiles. The primary components are `sparse_hash_map` (and `set`), which prioritize memory efficiency by using only 1-2 bits of overhead per entry, and `dense_hash_map` (and `set`), which prioritize raw speed. These containers are drop-in replacements for SGI's `hash_map` but include specialized requirements for initialization and element deletion to maintain their performance characteristics.

## Implementation Guidelines

### Choosing the Right Container
- **Use `sparse_hash_map`**: When memory is the primary bottleneck. It is significantly more space-efficient than `std::unordered_map` but slower on lookups.
- **Use `dense_hash_map`**: When lookup speed is critical. It is typically faster than standard implementations but has a higher memory "high-water mark" (using 3x-4x the space of the data itself).

### Mandatory Initialization
Unlike standard STL containers, these implementations require explicit configuration of special key values:

1.  **Empty Key (Required for `dense_hash_map`)**: You must set a key value that will never be used in your actual data to represent an empty bucket.
    ```cpp
    google::dense_hash_map<int, int> map;
    map.set_empty_key(-1); // Must be called before any other operations
    ```
2.  **Deleted Key (Required for Deletions)**: If you plan to call `erase()`, you must set a deleted key for both sparse and dense variants.
    ```cpp
    map.set_deleted_key(-2);
    ```

### Memory Management and Compaction
- **Constructor Argument**: The constructor takes the expected number of elements, not the number of buckets.
- **Iterator Stability**: `erase()` does not immediately reclaim memory or invalidate iterators. This allows for safe deletion during loops:
    ```cpp
    for (it = ht.begin(); it != ht.end(); ++it) {
        if (should_delete(*it)) ht.erase(it);
    }
    ```
- **Manual Compaction**: To reclaim memory after many deletions, call `ht.resize(0)`. The table also automatically compacts during the next `insert()` call.

### Persistence (I/O)
`sparse_hash_map` supports direct serialization to disk. This is highly efficient for "nopointer" data (POD types).
- **Writing**:
    ```cpp
    ht.write_metadata(fp);
    ht.write_nopointer_data(fp);
    ```
- **Reading**:
    ```cpp
    ht.read_metadata(fp);
    ht.read_nopointer_data(fp);
    ```

## Expert Tips
- **Namespace**: By default, the library uses the `google` namespace.
- **Quadratic Probing**: The library uses internal quadratic probing. Ensure your hash function provides a good distribution to avoid performance degradation.
- **Sparsetable**: For simple arrays that need to be space-proportional to the number of elements rather than the max index, use `sparsetable.h`.

## Reference documentation
- [Main README and API Overview](./references/github_com_benvanik_sparsehash.md)