---
name: sharedmem
description: sharedmem is a multiprocessing library that enables efficient memory sharing between Python processes using fork and shared NumPy arrays. Use when user asks to perform parallel processing with shared memory, create writable shared NumPy arrays, or execute MapReduce workflows without serialization overhead.
homepage: http://github.com/rainwoodman/sharedmem
metadata:
  docker_image: "quay.io/biocontainers/sharedmem:0.3.6--py_0"
---

# sharedmem

## Overview
sharedmem is a specialized multiprocessing library designed for "trivially parallelizable" tasks in Python. It differs from the standard multiprocessing module by utilizing the `fork` system call and copy-on-write mechanisms to allow child processes to share memory efficiently. Its primary strength lies in its ability to create shared NumPy arrays that are writable from both the master and worker processes, and its support for worker functions defined in nested scopes.

## Installation
Install the package via Conda from the Bioconda channel:
```bash
conda install bioconda::sharedmem
```

## Core Usage Patterns

### Shared NumPy Arrays
To allow multiple processes to write to the same memory space, use `sharedmem.empty` instead of `numpy.empty`.
- **Pattern**: `data = sharedmem.empty(shape, dtype='f8')`
- **Benefit**: This creates an array in a shared memory segment, avoiding the serialization/deserialization overhead typical of standard Python multiprocessing.

### MapReduce Workflows
The `MapReduce` class is the primary interface for dispatching jobs. It is best used as a context manager to ensure proper cleanup of worker processes.

```python
import sharedmem
import numpy

with sharedmem.MapReduce() as pool:
    def work(index):
        # Perform calculation
        return result
    
    results = pool.map(work, range(100))
```

### Synchronization Primitives
sharedmem provides OpenMP-like synchronization within the `MapReduce` context:
- **Critical Sections**: Use `with pool.critical:` to wrap code that must only be executed by one worker at a time (e.g., accumulating a global sum).
- **Ordered Execution**: Use `pool.ordered` to ensure certain operations happen in the sequence of the input data.

## Expert Tips and Best Practices

### Avoiding Segfaults with Raw Pointers
A common pitfall occurs when a worker function returns an object containing a raw pointer (common in some C-extension libraries). Because sharedmem uses `pickle` to return values to the master process, the pointer becomes invalid in the master's memory space, leading to a segfault.
- **Solution**: Unpack high-level objects into simple, pickle-friendly Python types (dicts, lists, or NumPy scalars) before returning them from the `work` function.

### Debugging
If you encounter mysterious hangs or synchronization issues, you can enable debug mode to get more verbose output regarding process management:
```python
sharedmem.set_debug(True)
# ... run your pool ...
sharedmem.set_debug(False)
```

### Platform Limitations
- **OS Support**: sharedmem relies heavily on the `fork` syscall. It is fully supported on Linux and macOS but does **not** support Windows.
- **Memory Management**: While global variables are inherited via copy-on-write, only arrays explicitly created via `sharedmem.empty` are writable across process boundaries with persistence in the master process.

## Reference documentation
- [sharedmem Overview](./references/anaconda_org_channels_bioconda_packages_sharedmem_overview.md)
- [sharedmem GitHub Repository](./references/github_com_rainwoodman_sharedmem.md)