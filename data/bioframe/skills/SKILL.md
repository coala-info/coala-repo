---
name: bioframe
description: "Bioframe is a library that extends Pandas to perform spatial operations and arithmetic on genomic interval data. Use when user asks to find overlaps between genomic datasets, merge contiguous regions, calculate coverage, or find the closest intervals."
homepage: https://github.com/mirnylab/bioframe
---


# bioframe

## Overview
Bioframe is a specialized library that extends Pandas to handle genomic interval data. It treats genomic regions as rows in a DataFrame with specific columns for chromosome, start, and end positions. This skill enables efficient manipulation of these intervals, allowing for complex spatial operations like finding overlaps between datasets, merging contiguous regions, and calculating coverage without leaving the Pandas ecosystem.

## Core Operations

### Interval Manipulation
*   **Overlap**: Find intersections between two sets of intervals.
    ```python
    import bioframe as bf
    overlaps = bf.overlap(df1, df2, how='inner')
    ```
*   **Merge**: Combine overlapping or adjacent intervals into single contiguous blocks.
    ```python
    merged_df = bf.merge(df)
    ```
*   **Cluster**: Group overlapping intervals and assign a cluster ID without collapsing them.
    ```python
    clustered_df = bf.cluster(df)
    ```
*   **Closest**: Find the nearest interval in a target DataFrame for every interval in a query DataFrame.
    ```python
    closest_df = bf.closest(df1, df2)
    ```
*   **Subtract**: Remove regions from one set of intervals that overlap with another.
    ```python
    result = bf.subtract(df1, df2)
    ```

### File I/O and Schemas
Bioframe provides `read_table` to simplify loading genomic files with predefined column names.
*   **Common Schemas**: 'bed', 'bed3', 'bedGraph', 'narrowPeak', 'broadPeak', 'jaspar'.
    ```python
    df = bf.read_table("data.bed", schema='bed3')
    ```

### Genomic Arithmetic
*   **Coverage**: Calculate how much of one set of intervals is covered by another.
    ```python
    cov = bf.coverage(df1, df2)
    ```
*   **Expand**: Extend interval boundaries by a fixed amount or fraction.
    ```python
    expanded_df = bf.expand(df, pad=100)
    ```
*   **Complement**: Find the "gaps" or regions not covered by any interval in the DataFrame (requires chromosome lengths).
    ```python
    gaps = bf.complement(df, view_df=chromsizes_df)
    ```

## Best Practices
*   **Column Naming**: Ensure your DataFrames use standard names (`chrom`, `start`, `end`) or specify them using the `cols` argument in functions (e.g., `cols=['chr', 's', 'e']`).
*   **Coordinate System**: Bioframe assumes 0-indexed, half-open intervals (standard BED format).
*   **Performance**: For very large datasets, ensure the DataFrames are sorted by chromosome and start position before performing operations to improve efficiency.
*   **Assembly Information**: Use `bf.fetch_chromsizes` to quickly retrieve chromosome lengths for standard assemblies (e.g., 'hg38', 'mm10') to use as bounds for operations like `complement`.

## Reference documentation
- [Bioframe GitHub Repository](./references/github_com_open2c_bioframe.md)
- [Bioconda Bioframe Overview](./references/anaconda_org_channels_bioconda_packages_bioframe_overview.md)