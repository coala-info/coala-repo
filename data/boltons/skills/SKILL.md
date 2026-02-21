---
name: boltons
description: Boltons is a comprehensive collection of over 250 pure-Python utilities designed to supplement the standard library.
homepage: https://github.com/mahmoud/boltons
---

# boltons

## Overview
Boltons is a comprehensive collection of over 250 pure-Python utilities designed to supplement the standard library. It provides "missing" constructs like specialized dictionaries, advanced iterators, and robust file helpers. Because it has no external dependencies, it is particularly useful for library authors and developers who need to maintain a slim dependency tree while gaining access to sophisticated data manipulation tools.

## Integration and Installation
Boltons offers flexible integration paths depending on project requirements:

*   **Standard Installation**: Use `pip install boltons` for general application development.
*   **Vendorization**: Since every module in boltons is independent and pure-Python, you can copy individual `.py` files (e.g., `iterutils.py`) directly into your project's subpackage to avoid a formal dependency.
*   **Compatibility**: Supports Python 3.7 through 3.13 and PyPy3.

## High-Utility Patterns

### Advanced Iteration (iterutils)
Use `iterutils` when `itertools` falls short:
*   **Chunking**: Use `chunked()` to break iterables into fixed-size lists.
*   **Windowing**: Use `windowed()` for sliding window iteration (overlapping tuples).
*   **Recursive Mapping**: Use `remap()` to transform nested dictionary/list structures. This is the "Swiss Army Knife" for cleaning or modifying complex JSON-like data.
*   **Backoff**: Use `backoff()` for exponential backoff generators, useful for retry logic in network requests.

### Robust File Operations (fileutils)
*   **Atomic Saving**: Use `atomic_save()` to ensure a file is either fully written or not written at all, preventing data corruption during crashes or power failures.
*   **File Discovery**: Use `iter_find_files()` for recursive file searching with pattern matching.

### Specialized Data Structures (dictutils & cacheutils)
*   **OrderedMultiDict**: Use when you need to store multiple values per key while preserving insertion order (common in web form processing).
*   **LRU Cache**: Use `cacheutils.LRU` for a standalone Least Recently Used cache when you need more control than `functools.lru_cache` provides (e.g., manual expiration or size management).

### Traceback Management (tbutils)
*   **TracebackInfo**: Use to represent and manipulate stack traces as objects, making it easier to serialize errors or format them for custom logging systems.

## Expert Tips
*   **"Good Enough" Philosophy**: Boltons modules are designed to be "good enough" for 80% of use cases. If you hit performance bottlenecks or need highly specialized features (e.g., massive scale statistics), transition to dedicated libraries like `numpy` or `pandas`.
*   **Zero-Dependency Maintenance**: When vendorizing, include the boltons version and license in your internal documentation to simplify future updates.
*   **Functional Wrappers**: Check `funcutils` for tools like `wraps` that preserve function signatures better than the standard library version in certain edge cases.

## Reference documentation
- [Boltons Main Repository](./references/github_com_mahmoud_boltons.md)
- [Boltons Module Structure](./references/github_com_mahmoud_boltons_tree_master_boltons.md)