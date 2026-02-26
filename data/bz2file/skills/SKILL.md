---
name: bz2file
description: bz2file is a Python library that provides a drop-in replacement for the standard bz2 module to handle bzip2 compression and multi-stream files. Use when user asks to read or write bzip2 compressed files, handle multi-stream bzip2 archives, or use a feature-rich interface for bzip2 data in older Python environments.
homepage: https://github.com/nvawda/bz2file
---


# bz2file

## Overview

The `bz2file` library is a Python-based drop-in replacement for the standard library's `bz2` module. It provides a more consistent and feature-rich interface for handling bzip2 compression, especially across different Python versions (2.6 through 3.4). It is particularly useful for handling complex bzip2 files that contain multiple compressed streams, which some older versions of the standard `bz2` module may not handle correctly.

## Installation

Install the library via pip:

```bash
pip install bz2file
```

## Core Usage Patterns

### Reading Compressed Files
Use the `open()` function for a high-level interface. It supports both binary and text modes.

```python
import bz2file

# Reading in binary mode
with bz2file.open("data.bz2", "rb") as f:
    data = f.read()

# Reading in text mode (with encoding)
with bz2file.open("data.bz2", "rt", encoding="utf-8") as f:
    for line in f:
        print(line)
```

### Writing Compressed Files
You can specify the compression level (1-9) using the `compresslevel` parameter.

```python
import bz2file

content = b"Data to compress"
with bz2file.open("output.bz2", "wb", compresslevel=9) as f:
    f.write(content)
```

### Working with File-like Objects
`bz2file` can wrap existing file-like objects, allowing you to compress data being sent over a network or stored in memory.

```python
import bz2file
import io

raw_buffer = io.BytesIO()
with bz2file.BZ2File(raw_buffer, mode="w") as bz_file:
    bz_file.write(b"Compressed content in memory")
```

## Expert Tips and Best Practices

- **Multi-stream Support**: `bz2file` natively supports multi-stream files. If you have a file created by concatenating multiple `.bz2` files, `bz2file` will read through all of them seamlessly, whereas some legacy tools might stop after the first stream.
- **Performance Optimization**: Use `read1(size)` when you want to read at most `size` bytes of uncompressed data without necessarily waiting for the full buffer to be filled, which is more efficient for certain streaming applications.
- **Peek for Headers**: Use `peek(size)` to look at the next bytes in the stream without advancing the file pointer. This is useful for identifying file types or headers within a compressed archive.
- **Mode 'x'**: In environments supporting it (Python 3.3+), you can use mode `'xb'` or `'xt'` to exclusively create a file, failing if the file already exists.
- **Maintenance Note**: Be aware that this project is considered legacy and is no longer actively maintained. It is best used for compatibility with older systems or specific multi-stream edge cases that the modern standard `bz2` module (in Python 3.5+) now handles.

## Reference documentation
- [bz2file README and Features](./references/github_com_nvawda_bz2file.md)
- [Project Maintenance Status](./references/github_com_nvawda_bz2file_commits_master.md)