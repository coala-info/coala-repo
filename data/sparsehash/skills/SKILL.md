---
name: sparsehash
description: The sparsehash library provides C++ template classes for hash maps and hash sets optimized for either minimal memory usage or maximum lookup speed. Use when user asks to store millions of items with low RAM overhead, implement high-performance hash tables, or serialize hash maps directly to disk.
homepage: https://github.com/sparsehash/sparsehash
---


# sparsehash

## Overview
The `sparsehash` library provides C++ template classes for hash maps and hash sets with specialized performance profiles. Unlike standard library containers, these are optimized for either extreme memory parsimony or maximum lookup speed. Use `sparse_hash_map` when you need to store millions of items with minimal RAM overhead (1-2 bits per entry), and use `dense_hash_map` when raw speed is the priority and you can afford a higher memory footprint.

## Implementation Patterns

### Container Selection
*   **sparse_hash_map / sparse_hash_set**: Best for memory-constrained environments. It uses quadratic probing and has very low overhead.
*   **dense_hash_map / dense_hash_set**: Best for speed. It is significantly faster than `std::unordered_map` for lookups but requires a "high water mark" of memory (up to 6x the size of entries during resizing).

### Mandatory Configuration
Unlike standard C++ containers, `sparsehash` containers require explicit key configuration for internal state management:

1.  **Empty Key (Required for Dense)**: You must set a key value that represents an empty bucket before any insertions.
    ```cpp
    google::dense_hash_map<int, int> map;
    map.set_empty_key(-1); // -1 is now reserved and cannot be used as a real key
    ```
2.  **Deleted Key (Required for Erase)**: If you plan to call `erase()`, you must set a deleted key.
    ```cpp
    map.set_deleted_key(-2); // Required before calling erase()
    ```

### Memory Management
*   **Compaction**: `erase()` does not immediately reclaim memory. To manually compact a table after many deletions, call `ht.resize(0)`.
*   **Pre-allocation**: The constructor takes an expected element count rather than a bucket count.
    ```cpp
    google::sparse_hash_map<int, int> map(1000000); // Expecting 1M elements
    ```

### Disk I/O
`sparse_hash_map` supports direct serialization to disk. This is most efficient for "Plain Old Data" (POD) types that do not contain pointers.

*   **Writing**:
    ```cpp
    FILE* fp = fopen("data.map", "wb");
    map.write_metadata(fp);
    map.write_nopointer_data(fp);
    fclose(fp);
    ```
*   **Reading**:
    ```cpp
    google::sparse_hash_map<int, int> map;
    FILE* fp = fopen("data.map", "rb");
    map.read_metadata(fp);
    map.read_nopointer_data(fp);
    fclose(fp);
    ```

## Expert Tips
*   **Iterator Stability**: `erase()` does not invalidate iterators, allowing for safe deletion during loops:
    ```cpp
    for (it = ht.begin(); it != ht.end(); ++it) {
        if (should_delete(*it)) ht.erase(it);
    }
    ```
*   **Namespace**: By default, the library uses the `google` namespace.
*   **Custom Probing**: The library uses internal quadratic probing; ensure your hash function provides a good distribution to avoid performance degradation.

## Reference documentation
- [Main README and API Overview](./references/github_com_sparsehash_sparsehash.md)
- [Documentation Index](./references/github_com_sparsehash_sparsehash_tree_master_doc.md)