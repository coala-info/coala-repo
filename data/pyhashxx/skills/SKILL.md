---
name: pyhashxx
description: pyhashxx is a Python wrapper for the xxHash algorithm, designed to be faster than traditional algorithms like MD5 or SHA-1 while maintaining high collision resistance.
homepage: https://github.com/ewencp/pyhashxx
---

# pyhashxx

## Overview
pyhashxx is a Python wrapper for the xxHash algorithm, designed to be faster than traditional algorithms like MD5 or SHA-1 while maintaining high collision resistance. This specific implementation is optimized for Pythonic workflows, offering a thread-safe environment that avoids global state. It supports both one-shot hashing of bytes and complex nested tuples, as well as incremental hashing for large data streams.

## Usage Patterns

### One-Shot Hashing
The `hashxx` function is the most efficient way to hash data that is already in memory. It can process multiple arguments or nested tuples directly.

```python
from pyhashxx import hashxx

# Basic usage with bytes
result = hashxx(b'Hello World!')

# Hashing multiple segments (concatenates logically)
result = hashxx(b'Hello', b' ', b'World!')

# Hashing nested structures
# The function recursively traverses tuples
data = (b'Hello', (b' ', b'World!'))
result = hashxx(data)

# Using a custom seed for consistent hashing across different runs
seeded_result = hashxx(b'Hello World!', seed=42)
```

### Incremental Hashing
For large files or data arriving in chunks, use the `Hashxx` class to maintain state and compute the digest incrementally.

```python
from pyhashxx import Hashxx

# Initialize the hasher (seed is optional)
hasher = Hashxx(seed=0)

# Update with chunks of data
hasher.update(b'Part 1 of the data')
hasher.update(b'Part 2 of the data')

# Get the intermediate or final digest
current_hash = hasher.digest()
```

## Best Practices and Tips

- **Input Types**: Always provide `bytes` objects. While the tool is robust, passing non-bytes objects without explicit encoding may lead to unexpected results or errors.
- **Concurrency**: Unlike older xxHash wrappers, pyhashxx does not use a static global context. You can safely use `Hashxx` instances in different threads to process data in parallel.
- **Seed Consistency**: When using hashes for persistent storage or distributed systems, always specify a fixed `seed` value to ensure the hash remains consistent across different environments or application restarts.
- **Performance**: For single, large buffers, the one-shot `hashxx()` function is generally faster than creating a `Hashxx` object and calling `update()`.

## Reference documentation
- [pyhashxx README](./references/github_com_ewencp_pyhashxx.md)