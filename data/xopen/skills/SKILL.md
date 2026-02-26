---
name: xopen
description: xopen provides a unified interface for reading and writing compressed and uncompressed files, automatically detecting compression formats and optimizing performance. Use when user asks to read compressed files, write compressed files, read from or write to standard streams, or optimize file I/O performance.
homepage: https://github.com/marcelm/xopen
---


# xopen

## Overview

The `xopen` skill provides a streamlined way to handle file I/O in Python without manually managing different compression libraries. It acts as a drop-in replacement for the built-in `open()` function, automatically detecting compression formats based on file extensions or magic numbers. It is particularly useful in bioinformatics and data science workflows where large, compressed datasets are common, as it offloads compression tasks to external processes or optimized libraries to prevent the main Python thread from becoming a bottleneck.

## Usage Patterns

### Basic Reading and Writing
Use `xopen` exactly like the native `open()` function. It defaults to text mode with UTF-8 encoding.

```python
from xopen import xopen

# Reading a compressed file (auto-detects .gz, .bz2, .xz, .zst)
with xopen("data.fastq.gz", mode="rt") as f:
    for line in f:
        process(line)

# Writing to a compressed file
with xopen("output.txt.xz", mode="wt") as f:
    f.write("Sample output data")
```

### Performance Optimization
`xopen` is designed for speed. By default, it uses up to 4 threads. You can tune this behavior based on your hardware:

- **Multi-threading**: Set `threads` to a specific integer to control concurrency.
- **Single-threaded**: Set `threads=0` to force execution within the main Python thread (useful for debugging or resource-constrained environments).
- **Compression Levels**: Use `compresslevel` to balance speed vs. file size (e.g., `1` for fastest, `9` for smallest).

```python
# High-performance writing with specific threading
with xopen("large_archive.zst", mode="wb", threads=8, compresslevel=3) as f:
    f.write(binary_data)
```

### Handling Standard Streams
Use `"-"` as the filename to interact with `stdin` or `stdout` while maintaining the same API.

```python
# Read from stdin (can handle piped compressed data)
with xopen("-", mode="rb") as f:
    data = f.read()
```

## Best Practices

- **Binary vs. Text**: Always specify `mode="rb"` or `mode="wb"` when handling raw bytes to avoid encoding overhead.
- **Format Overrides**: If a file lacks a standard extension but you know the format, use the `format` parameter (e.g., `format="gz"`).
- **Backend Awareness**: `xopen` prefers optimized backends like `python-isal` or `pigz` if installed. Ensure these are available in your environment for maximum throughput.
- **Reproducibility**: `xopen` automatically strips timestamps from gzip headers (equivalent to `gzip -n`), ensuring that identical input data results in identical compressed output across different runs.

## Reference documentation

- [GitHub Repository Documentation](./references/github_com_pycompression_xopen.md)