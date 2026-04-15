---
name: xxhash
description: xxhash provides high-performance, non-cryptographic hashing for data. Use when user asks to verify large file transfers, generate unique identifiers for data blocks, optimize cache lookups, perform high-speed hashing, hash streaming data, get integer digests, reuse hash objects, or branch hash calculations.
homepage: https://github.com/ifduyue/python-xxhash
metadata:
  docker_image: "quay.io/biocontainers/xxhash:1.0.1--py27_0"
---

# xxhash

## Overview
xxhash provides Python bindings for the xxHash library, a high-performance hashing algorithm that operates at RAM speed limits. This skill enables the implementation of `hashlib`-compliant hashing workflows, supporting both streaming data processing and high-speed oneshot hashing. It is particularly useful for verifying large file transfers, generating unique identifiers for data blocks, and optimizing cache lookups.

## Implementation Patterns

### Algorithm Selection
*   **xxh32**: Use for 32-bit systems or when memory footprint is the primary constraint.
*   **xxh64**: The standard choice for 64-bit systems, offering a good balance of speed and collision resistance.
*   **xxh3_64 / xxh3_128**: The latest generation (XXH3), highly optimized for modern CPUs with SIMD instructions. Use these for maximum performance on large datasets.

### Oneshot vs. Streaming
For small data or single-block strings, use oneshot functions to avoid the overhead of object allocation:
```python
import xxhash
# Fast oneshot hashing
digest = xxhash.xxh3_64_hexdigest(b'data to hash', seed=0)
```

For large files or data streams, use the streaming interface:
```python
import xxhash
x = xxhash.xxh3_64()
with open('large_file.dat', 'rb') as f:
    for chunk in iter(lambda: f.read(65536), b''):
        x.update(chunk)
print(x.hexdigest())
```

### Working with Seeds
Seeds allow you to produce different hash results for the same input, which is useful for hash-table randomization or sharding:
*   `xxh32` accepts an unsigned 32-bit integer.
*   `xxh64` and `xxh3` accept an unsigned 64-bit integer.
*   Passing a seed larger than the bit-width will result in defined overflow behavior, but it is best practice to stay within the native range.

### Integer Digests
Unlike `hashlib`, xxhash provides `intdigest()`. This is significantly faster than generating a hex string and converting it back to an integer when you need a numeric key:
```python
# Direct integer for indexing or database keys
numeric_id = xxhash.xxh64(b'user_123').intdigest()
```

## Expert Tips
*   **Endianness**: As of version 0.3.0, `digest()` returns bytes in big-endian representation. If you are migrating from very old versions, verify your byte-order logic.
*   **Non-Cryptographic**: Never use xxhash for password hashing, digital signatures, or any security-sensitive application. It is designed for speed, not resistance to malicious collisions.
*   **Memory Efficiency**: Use `reset()` on an existing hash object to reuse it for a new calculation without reallocating the state on the heap.
*   **Copying State**: Use `copy()` to branch a hash calculation (e.g., hashing a common prefix and then different suffixes).

## Reference documentation
- [Python Binding for xxHash](./references/github_com_ifduyue_python-xxhash.md)
- [xxhash - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_xxhash_overview.md)