---
name: galaxy-ops
description: This tool performs genomic interval arithmetic and set operations on BED files. Use when user asks to subtract regions, find intersections, merge overlapping segments, cluster features, or calculate overlap density.
homepage: https://github.com/galaxyproject/gops
metadata:
  docker_image: "quay.io/biocontainers/galaxy-ops:1.1.0--py27_0"
---

# galaxy-ops

## Overview
The `galaxy-ops` tool (invoked via `galaxyOps.py`) provides a suite of operations for genomic interval arithmetic. It is designed to handle functional genomic data at scale, offering standard set operations like union and intersection alongside specialized bioinformatics workflows such as proximity searches and interval clustering. Use this tool to efficiently process BED files and extract specific genomic regions based on their relationship to other datasets.

## Common CLI Patterns

### Set Operations
*   **Subtract non-overlapping segments**: Use `-s` to return segments of the first file that do not overlap with the second.
    `galaxyOps.py input1.bed input2.bed -s > unique_segments.bed`
*   **Subtract whole regions**: Use `-w` to return entire regions from the first file that have no overlap with the second.
    `galaxyOps.py input1.bed input2.bed -w > non_overlapping_regions.bed`
*   **Find intersections**: Use `-i` to return only the overlapping segments, or `-a` to return the entire original region from the first file if it overlaps at all.
    `galaxyOps.py input1.bed input2.bed -i`
*   **Merge/Union**: Use `-o` to merge any overlapping regions between two files into a single contiguous block.

### Proximity and Clustering
*   **Find nearby regions**: Use `-p` to find regions in the first file within a specific distance of regions in the second.
    `galaxyOps.py file1.bed file2.bed -p -U 1000 -D 1000` (1kb upstream/downstream)
*   **Cluster features**: Use `-t` to find clusters within a single file based on a distance threshold (`-z`) and minimum number of regions (`-N`).
    `galaxyOps.py input.bed -t -z 100 -N 3`

### Coverage and Density
*   **Calculate overlap density**: Use `-d` to return regions from the first file with two additional fields: the number of overlapping base pairs and the percentage of overlap relative to the first file's region.

## Expert Tips and Best Practices

### Column Mapping
By default, `galaxy-ops` assumes standard BED format (Chrom: Col 0, Start: Col 1, Stop: Col 2). If your file uses different columns, you must specify them to avoid incorrect results:
*   `-1 N`: Chromosome column (1st file)
*   `-2 N`: Start column (1st file)
*   `-3 N`: Stop column (1st file)
*   `-5 N`, `-6 N`, `-7 N`: Corresponding columns for the 2nd file.

### Complement Operations
When using the complement operation (`-c`), you must provide the build/genome version (`-b`) or ensure the tool can access the relevant chromosome sizes to define the boundaries of the genomic space.

### Restricting Search Space
To improve performance or isolate specific data, use the `-C` flag to restrict operations to a single chromosome (e.g., `-C chr1`).

### Filtering by Size
Use the `-r` (restrict) flag in combination with `-m` (minSize) and `-x` (maxSize) to filter the output regions based on their length.

## Reference documentation
- [Galaxy Operations Overview](./references/anaconda_org_channels_bioconda_packages_galaxy-ops_overview.md)
- [Gops GitHub Repository and CLI Docs](./references/github_com_galaxyproject_gops.md)