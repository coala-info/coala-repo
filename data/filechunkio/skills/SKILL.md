---
name: filechunkio
description: `filechunkio` is a Python utility that creates a file-like object representing a specific "chunk" or slice of an existing file on disk.
homepage: https://github.com/fabiant7t/filechunkio
---

# filechunkio

## Overview

`filechunkio` is a Python utility that creates a file-like object representing a specific "chunk" or slice of an existing file on disk. Instead of physically splitting a large file into smaller pieces (which consumes extra disk space and time) or loading chunks into memory as `StringIO` objects (which consumes RAM), `filechunkio` uses OS-level file descriptors to provide a seekable, readable interface to a defined byte range. This makes it an essential tool for high-performance data engineering and cloud storage workflows involving massive datasets.

## Usage Instructions

### Basic Implementation
To create a chunk, specify the source file path, the starting offset, and the number of bytes to include in the chunk.

```python
from filechunkio import FileChunkIO

# Create a chunk starting at byte 1024, spanning 5MB
chunk = FileChunkIO('large_data.bin', offset=1024, bytes=5242880)

# The chunk behaves like a standard file object
data = chunk.read(1024)
current_pos = chunk.tell()
chunk.seek(0)
line = chunk.readline()
```

### Integration with Amazon S3 (Boto2/Boto3)
The primary use case for `filechunkio` is performing multipart uploads. Because it implements the standard file interface, it can be passed directly to upload methods.

**Pattern for Multipart Upload:**
1. Determine the total file size.
2. Define a fixed chunk size (e.g., 50MB).
3. Iterate through the file, creating a `FileChunkIO` instance for each part.
4. Pass the instance to the S3 `upload_part` method.

### Expert Tips and Best Practices
- **Memory Efficiency**: Always prefer `filechunkio` over `StringIO` or `BytesIO` when the source data already exists on disk. It keeps the memory footprint constant regardless of chunk size.
- **Read-Only Operations**: By default, `filechunkio` is intended for reading (`mode='r'`). Ensure your workflow does not attempt to write to the chunk, as it is a window into a static file.
- **Offset Management**: When calculating offsets for multipart uploads, ensure your math accounts for the 0-based index. The `offset` of part `N` is typically `N * chunk_size`.
- **File Handles**: `filechunkio` opens a file handle to the underlying file. If you are processing thousands of chunks simultaneously, be mindful of your OS's open file limit (`ulimit -n`).

## Reference documentation
- [FileChunkIO README](./references/github_com_fabiant7t_filechunkio.md)