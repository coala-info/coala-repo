---
name: pyarrow
description: PyArrow provides Python bindings for Apache Arrow, enabling efficient in-memory data processing and seamless interoperability between different data tools.
homepage: https://github.com/lance-format/lance
---

# pyarrow

## Overview
PyArrow provides Python bindings for Apache Arrow, enabling efficient in-memory data processing and seamless interoperability between different data tools. This skill focuses on using PyArrow to bridge the gap between standard Python data analysis libraries (like Pandas) and high-performance storage formats. It is particularly useful for handling large-scale datasets where memory efficiency and fast I/O are critical, such as preparing data for vector search or multimodal AI workflows.

## High-Utility Patterns

### Table Creation and Conversion
The most common entry point for PyArrow is converting existing data structures into Arrow Tables to leverage columnar memory benefits.

*   **From Pandas**: Use `pa.Table.from_pandas(df)` to convert a DataFrame. This is a prerequisite for many high-performance writing operations.
*   **To Pandas**: Use `table.to_pandas()` to bring Arrow data back into the Pandas ecosystem for traditional analysis.

### Dataset Management
PyArrow's `dataset` module is the standard for interacting with multi-file data storage (like Parquet) on disk.

*   **Writing Parquet**: Use `pa.dataset.write_dataset(table, uri, format='parquet')` to write data. This handles partitioning and file management more effectively than simple file-based writers.
*   **Reading Datasets**: Use `pa.dataset.dataset(uri, format='parquet')` to create a dataset object. This allows for lazy loading and predicate pushdown, which saves memory by only reading necessary columns or rows.

### Integration with Lance
PyArrow is the foundational layer for the Lance format. Lance datasets are often treated as PyArrow Dataset objects, allowing you to use standard Arrow tools on Lance data.

*   **Type Checking**: Ensure compatibility by verifying that Lance datasets inherit from `pa.dataset.Dataset`.
*   **Data Conversion**: To move from Parquet to Lance, first load the Parquet file as a PyArrow dataset before passing it to the Lance writer.

## Expert Tips
*   **Schema Enforcement**: When creating tables, explicitly define your schema using `pa.schema()` to ensure data consistency across different versions of a dataset.
*   **Zero-Copy Reads**: PyArrow excels at zero-copy reads. When converting to Pandas, use the `zero_copy_only=True` parameter in `to_pandas()` to ensure you aren't doubling your memory usage, though this requires the data to be in a compatible format.
*   **Memory Mapping**: For very large files, use memory-mapped files (`pa.memory_map`) to allow the OS to handle paging, which can significantly improve performance for random access patterns.

## Reference documentation
- [The Open Lakehouse Format for Multimodal AI](./references/github_com_lance-format_lance.md)