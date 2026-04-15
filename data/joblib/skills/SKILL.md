---
name: joblib
description: Joblib provides tools for lightweight pipelining in Python through transparent disk-based caching and parallel computing. Use when user asks to parallelize loops, cache function results to disk, or efficiently save and load large NumPy arrays.
homepage: https://github.com/joblib/joblib
metadata:
  docker_image: "quay.io/biocontainers/joblib:0.9.3--py36_0"
---

# joblib

## Overview
Joblib is a specialized Python library designed to enhance the performance of computational tasks. It provides a simple API for memoization (disk-based caching) and parallel computing. By intelligently managing data persistence and process distribution, it allows developers to avoid redundant calculations and fully utilize multi-core processors. It is particularly optimized for handling large data structures like NumPy arrays without significant memory overhead, making it a core component of the Scikit-Learn ecosystem.

## Core Functionality

### Parallel Computing
Use the `Parallel` and `delayed` helpers to distribute tasks across multiple cores. Joblib uses the `loky` backend by default, which is robust against crashes and memory leaks.

- **Basic Pattern**:
  ```python
  from joblib import Parallel, delayed
  results = Parallel(n_jobs=-1)(delayed(your_function)(i) for i in range(10))
  ```
- **n_jobs**: Set to `-1` to use all available CPUs; `-2` to use all but one.
- **Backends**:
  - `loky`: Default, process-based, best for general tasks.
  - `threading`: Low overhead, best for I/O-bound tasks or code that releases the Global Interpreter Lock (GIL).
  - `multiprocessing`: Legacy process-based backend.

### Transparent Disk Caching
The `Memory` object provides a decorator to cache function outputs to disk, ensuring that long-running functions only run once for a given set of inputs.

- **Setup**:
  ```python
  from joblib import Memory
  cachedir = './joblib_cache'
  mem = Memory(cachedir, verbose=0)

  @mem.cache
  def expensive_function(data):
      # Long computation here
      return result
  ```
- **Persistence**: Results are stored on disk and persist across different Python sessions.
- **Automatic Invalidation**: The cache is automatically invalidated if the function's source code changes.

### Efficient Data Persistence
Joblib's `dump` and `load` are optimized replacements for Python's `pickle`, specifically designed to handle large NumPy arrays by storing them in separate files or using memory mapping.

- **Usage**:
  ```python
  import joblib
  joblib.dump(large_object, 'model_data.jbl')
  data = joblib.load('model_data.jbl')
  ```
- **Compression**: Supports `zlib`, `gzip`, `bz2`, `lzma`, and `xz`. Use the `compress` parameter (e.g., `compress=3`).

## Expert Tips

- **Memory Mapping**: When using process-based backends, Joblib automatically uses memory mapping for large NumPy arrays to share data between the parent and child processes without copying memory.
- **Avoid Over-subscription**: In nested loops, avoid calling `Parallel` at every level. Use the `prefer="threads"` argument if the inner loop is I/O bound or the `require="sharedmem"` constraint if you must share memory.
- **Temporary Storage**: If you encounter disk space issues during parallel execution, set the `JOBLIB_TEMP_FOLDER` environment variable to a directory with sufficient space (e.g., `/mnt/fast_ssd`).
- **Manual Cache Management**: You can clear a specific function's cache using `expensive_function.clear()` or the entire cache directory using `mem.clear()`.
- **Generator Support**: For memory efficiency with large result sets, use `return_as="generator"` in the `Parallel` call to process results as they complete.

## Reference documentation
- [Joblib Main Repository](./references/github_com_joblib_joblib.md)
- [Security Policy](./references/github_com_joblib_joblib_security.md)