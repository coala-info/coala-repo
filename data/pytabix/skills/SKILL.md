---
name: pytabix
description: The `pytabix` skill provides a Python interface for the `tabix` indexing system.
homepage: https://github.com/slowkow/pytabix
---

# pytabix

## Overview

The `pytabix` skill provides a Python interface for the `tabix` indexing system. It allows for efficient retrieval of specific genomic regions from massive datasets that have been compressed with `bgzip`. This is a lightweight alternative to `pysam` when only tabix-based querying is required. It is particularly useful for bioinformatics pipelines that need to fetch data from local files or remote URLs (FTP/HTTP) based on chromosome coordinates.

## Installation

Install the package via pip or conda:

```bash
pip install pytabix
# OR
conda install -c bioconda pytabix
```

## File Preparation

Before using `pytabix`, your data files must be properly formatted, compressed, and indexed using the command line.

1.  **Sort the file**: Files must be sorted by chromosome and position.
    ```bash
    sort -k1,1 -k2,2n input.bed > sorted.bed
    ```
2.  **Compress with bgzip**: Standard gzip is not compatible; you must use `bgzip`.
    ```bash
    bgzip sorted.bed
    ```
3.  **Index with tabix**: Create the `.tbi` index file.
    ```bash
    # Use presets for common formats: vcf, bed, gff, sam
    tabix -p bed sorted.bed.gz
    ```

## Python Usage Patterns

### Opening a Connection
You can open local files or remote URLs. The index file (`.tbi`) must be present in the same location.

```python
import tabix

# Local file
tb = tabix.open("data.bed.gz")

# Remote URL
url = "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20100804/ALL.chr1.vcf.gz"
tb_remote = tabix.open(url)
```

### Querying Intervals
`pytabix` provides three primary ways to query data. All return an iterator of lists, where each list represents a row in the file.

1.  **Standard Query (`query`)**: Uses chromosome name and start/end coordinates.
    ```python
    # Fetch records for Chromosome 1 from 1,000,000 to 1,250,000
    records = tb.query("1", 1000000, 1250000)
    for record in records:
        print(record[:3]) # Access columns by index
    ```

2.  **String Query (`querys`)**: Uses a region string (e.g., "chr:start-end").
    ```python
    records = tb.querys("1:1000000-1250000")
    ```

3.  **Integer Index Query (`queryi`)**: Uses the chromosome's numerical index.
    ```python
    # Useful if chromosome names are integers or if you are iterating by index
    records = tb.queryi(0, 1000000, 1250000)
    ```

## Expert Tips and Best Practices

-   **Memory Efficiency**: `pytabix` returns an iterator. Avoid converting the result to a list (`list(records)`) if the interval contains millions of rows, as this will consume significant memory.
-   **Remote Access**: When querying remote files, `pytabix` only downloads the specific compressed blocks needed for the requested interval, making it extremely efficient for large cloud-hosted datasets.
-   **Column Access**: Since `pytabix` returns rows as lists of strings, you must manually cast numerical columns (e.g., `int(record[1])`) if you need to perform calculations.
-   **Error Handling**: If a query is made for a chromosome not present in the index, it will typically raise a `tabix.TabixError`. Always wrap queries in try-except blocks when dealing with unpredictable user input.
-   **Multiprocessing**: While `pytabix` is fast, the underlying C extension may have limitations with Python's multiprocessing. If parallelizing, open the tabix handle *inside* the worker function rather than passing a shared handle.

## Reference documentation
- [github_com_slowkow_pytabix.md](./references/github_com_slowkow_pytabix.md)
- [anaconda_org_channels_bioconda_packages_pytabix_overview.md](./references/anaconda_org_channels_bioconda_packages_pytabix_overview.md)