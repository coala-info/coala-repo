---
name: npstructures
description: The npstructures library provides efficient NumPy-like data structures for handling ragged arrays, hash tables, and counters with vectorized performance. Use when user asks to perform operations on non-uniform datasets, map keys to values using arrays, or count occurrences of specific elements.
homepage: https://github.com/bionumpy/npstructures
metadata:
  docker_image: "quay.io/biocontainers/npstructures:0.2.19--pyh05cac1d_1"
---

# npstructures

## Overview
The `npstructures` library extends NumPy's capabilities by introducing data structures designed for "ragged" data—datasets where rows have varying lengths. While standard NumPy arrays require uniform dimensions, `npstructures.RaggedArray` allows for vectorized operations, slicing, and indexing on non-uniform data without falling back to slow Python object arrays. Additionally, the library provides `HashTable` and `Counter` implementations optimized for use with NumPy arrays, enabling efficient key-value mapping and frequency counting of array elements.

## Core Data Structures

### RaggedArray
Use `RaggedArray` as a drop-in replacement for NumPy arrays when row lengths differ.

*   **Construction**: Create from a list of lists or sequences.
    ```python
    from npstructures import RaggedArray
    ra = RaggedArray([[1, 2], [4, 1, 3, 7], [9], [8, 7, 3, 4]])
    ```
*   **Indexing and Slicing**: Supports standard NumPy-style indexing.
    *   `ra[1]` returns the second row as a standard NumPy array.
    *   `ra[1, 3]` returns a specific scalar.
    *   `ra[1:3]` returns a new `RaggedArray` containing the specified rows.
    *   `ra[[0, 3]]` performs fancy indexing to return specific rows.
*   **Assignments**: You can assign values to rows or slices using lists or other `RaggedArray` objects, provided the lengths match or are broadcastable.

### HashTable
The `HashTable` provides dictionary-like functionality where keys and values are stored as NumPy arrays. Note that the set of keys is fixed at initialization.

*   **Initialization**: `table = HashTable(keys_array, values_array)`
*   **Lookup**: `table[query_keys]` returns an array of values.
*   **Modification**: Values for existing keys can be updated: `table[existing_keys] = new_values`.

### Counter
Use `Counter` to count occurrences of a predefined set of keys within a sample array.

*   **Usage**:
    ```python
    from npstructures import Counter
    counter = Counter([key1, key2, key3])
    counter.count(sample_data_array)
    ```

## Best Practices and Tips

*   **Vectorization**: Always prefer applying NumPy `ufuncs` (e.g., `ra + 1`, `np.abs(ra)`) directly to the `RaggedArray`. The library handles the underlying data buffer to ensure performance.
*   **Broadcasting**: `RaggedArray` supports broadcasting with column vectors. For example, `ra + [[10], [20], [30], [40]]` will add 10 to every element in the first row, 20 to the second, etc.
*   **NumPy Integration**: Many standard NumPy functions like `np.concatenate`, `np.nonzero`, and `np.ones_like` are compatible with `RaggedArray` objects.
*   **Memory Efficiency**: Use `RaggedArray` instead of `np.array(list_of_lists, dtype=object)` to significantly reduce memory overhead and enable SIMD optimizations.
*   **Fixed Keys**: Remember that `HashTable` keys cannot be added after initialization. If you need a dynamic set of keys, you must rebuild the table or use a different structure.

## Reference documentation
- [npstructures Overview](./references/anaconda_org_channels_bioconda_packages_npstructures_overview.md)
- [npstructures GitHub Repository](./references/github_com_bionumpy_npstructures.md)