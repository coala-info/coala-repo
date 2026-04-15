---
name: semidbm
description: semidbm is a high-performance, pure-Python DBM implementation that provides a persistent, disk-backed dictionary for storing string-based key-value pairs. Use when user asks to create a persistent database, store data in a single-file DBM format, or perform disk-backed dictionary operations without external C dependencies.
homepage: https://github.com/jamesls/semidbm
metadata:
  docker_image: "quay.io/biocontainers/semidbm:0.5.1--py36_1"
---

# semidbm

## Overview

semidbm is a high-performance, pure-Python implementation of a DBM (Database Manager). It serves as a robust alternative to the standard library's `dumbdbm`, offering better performance and a simplified single-file storage format. It is designed for scenarios where you need a persistent, disk-backed dictionary that works consistently across Windows, Linux, and macOS without requiring external C dependencies.

## Core Usage Patterns

### Basic Operations
The library uses a standard Python dictionary interface. All keys and values must be strings (or bytes in Python 3).

```python
import semidbm

# Open a database (flag 'c' creates it if it doesn't exist)
db = semidbm.open('my_database', 'c')

# Setting and getting values
db['username'] = 'admin'
db['session_id'] = '12345'

print(db['username'])

# Close to ensure data is flushed to disk
db.close()
```

### Opening Flags
Choose the appropriate flag based on your access requirements:
- `r`: Open existing database for reading only (default).
- `w`: Open existing database for reading and writing.
- `c`: Open for reading and writing, creating it if it doesn't exist.
- `n`: Always create a new, empty database, open for reading and writing.

## Expert Tips and Best Practices

### Managing File Size with Compaction
semidbm uses an **append-only** file format. Every update or deletion adds data to the end of the file rather than overwriting existing bytes. Over time, the data file will grow even if the number of keys remains constant.

**Best Practice**: Periodically call the `compact()` method to rewrite the database into its most minimal representation and reclaim disk space.

```python
db = semidbm.open('my_database', 'w')
# ... perform many updates ...
db.compact()
db.close()
```

### Memory Considerations
While the values are stored on disk, semidbm loads the **entire index (all keys)** into memory. 
- **Constraint**: Ensure your system has enough RAM to hold all keys simultaneously.
- **Use Case**: Ideal for millions of small keys or fewer large keys, but not for datasets where the key-set exceeds available memory.

### Handling Concurrency
semidbm is **not thread-safe** and does not support concurrent access by multiple processes.
- **Warning**: Accessing the same database file from multiple threads or processes simultaneously can lead to data corruption.
- **Solution**: Implement your own locking mechanism (e.g., `multiprocessing.Lock` or `threading.Lock`) if your application requires concurrent access.

### Data Integrity
To ensure data is physically written to the disk without closing the database, use the `sync()` method. This is useful for long-running processes to prevent data loss in the event of a crash.

```python
db['important_key'] = 'critical_value'
db.sync() 
```

## Reference documentation
- [semidbm README](./references/github_com_jamesls_semidbm.md)