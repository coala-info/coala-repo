---
name: cityhash
description: The cityhash skill provides Python bindings for CityHash and FarmHash, a family of fast hash functions.
homepage: https://github.com/escherba/python-cityhash
---

# cityhash

## Overview
The cityhash skill provides Python bindings for CityHash and FarmHash, a family of fast hash functions. It supports 32-, 64-, 128-, and 256-bit implementations. This skill is optimized for speed, particularly when working with objects that support the Buffer Protocol (like NumPy arrays), and includes specialized CRC functions that leverage SSE4.2 instructions for maximum throughput.

## Installation
The package can be installed via pip or conda:
- `pip install cityhash`
- `conda install -c conda-forge python-cityhash`

## Core Usage Patterns

### Stateless Hashing
Both `cityhash` and `farmhash` namespaces provide 32, 64, and 128-bit variants. FarmHash is generally recommended as the successor to CityHash.

```python
from farmhash import FarmHash32, FarmHash64, FarmHash128
from cityhash import CityHash64

# Basic string hashing
hash_32 = FarmHash32("example_string")
hash_64 = FarmHash64("example_string")
hash_128 = FarmHash128("example_string")
```

### Hardware-Independent Fingerprints
Use Fingerprints when hashed values need to be persisted or shared across different hardware/platforms. These are guaranteed to be seedless and consistent.

```python
from farmhash import Fingerprint64, Fingerprint128

# Consistent across different CPU architectures
fp = Fingerprint128("persistent_data_key")
```

### Fast Hashing of NumPy Arrays
The library uses the Buffer Protocol to hash raw byte arrays without memory copying. Arrays must be contiguous.

```python
import numpy as np
from farmhash import FarmHash64

arr = np.random.rand(100, 100)
# Ensure array is contiguous for the buffer protocol
if not arr.flags['C_CONTIGUOUS']:
    arr = np.ascontiguousarray(arr)

hash_val = FarmHash64(arr)
```

### SSE4.2 Optimized CRC
For x86-64 platforms, the `cityhashcrc` module provides 128- and 256-bit functions that utilize SSE4.2 instructions, often outperforming standard FarmHash128.

```python
from cityhashcrc import CityHashCrc128, CityHashCrc256

crc_128 = CityHashCrc128("data")
crc_256 = CityHashCrc256("data")
```

## Expert Tips and Best Practices
- **Prefer FarmHash**: FarmHash is the newer generation of these algorithms and typically offers better performance and collision resistance than the original CityHash.
- **Avoid Incremental Hashing**: Neither CityHash nor FarmHash support incremental (streaming) hashing. If you need to hash a long stream of data piece-by-piece, use `xxHash` or `MetroHash` instead.
- **Check SSE4.2 Availability**: Before relying on `cityhashcrc` for production, verify the target environment supports SSE4.2 to ensure the performance benefits are realized.
- **Memory Efficiency**: When working with large datasets in NumPy, always use `np.ascontiguousarray()` before hashing to prevent errors and ensure the library can read the raw buffer directly.

## Reference documentation
- [Python bindings for FarmHash and CityHash](./references/github_com_escherba_python-cityhash.md)
- [CityHash Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cityhash_overview.md)