---
name: cyordereddict
description: The `cyordereddict` library is a Cython implementation of the Python standard library's `OrderedDict`.
homepage: https://github.com/shoyer/cyordereddict
---

# cyordereddict

## Overview

The `cyordereddict` library is a Cython implementation of the Python standard library's `OrderedDict`. It is designed as a high-performance, drop-in replacement for `collections.OrderedDict`. While it provides significant speed advantages for older Python versions, it is important to note that this library is considered obsolete for Python 3.5 and later, as the standard library's native `OrderedDict` was rewritten in C and generally outperforms `cyordereddict` in modern environments.

## Installation and Basic Usage

To install the library, use pip:

```bash
pip install cyordereddict
```

To use it in your code, replace the standard library import:

```python
# Replace this:
# from collections import OrderedDict

# With this:
from cyordereddict import OrderedDict
```

## Performance Benchmarking

You can verify the performance gains in your specific environment by running the built-in benchmark utility:

```python
import cyordereddict
cyordereddict.benchmark()
```

Expected performance ratios (Standard Library vs. Cython) on compatible legacy systems:
- `__setitem__`: ~8.4x faster
- `update()`: ~6.5x faster
- `__init__` (from list): ~4.0x faster
- `__getitem__`: ~3.0x faster

## Technical Constraints and Caveats

Because `cyordereddict.OrderedDict` is implemented as a Cython extension type rather than a pure Python class, there are specific behavioral differences to manage:

1.  **Attribute Restrictions**: Extension types use `__slots__` instead of a `__dict__`. You cannot add custom attributes to an instance (e.g., `d.metadata = 'info'`) unless you create a subclass.
2.  **Introspection**: The `inspect` module does not work on `cyordereddict.OrderedDict` methods.
3.  **Pickling**: While generally compatible, ensure you are using the latest version (0.2.2+) to avoid known pickling issues related to the internal structure.

## Expert Tips

-   **Version Check**: Always verify the Python runtime before enforcing `cyordereddict`. If the environment is Python 3.5+, default back to `collections.OrderedDict` for better performance and maintenance.
-   **Subclassing**: If you need to attach metadata to your ordered dictionaries, subclass the `cyordereddict.OrderedDict` to define the necessary slots or a dictionary.
-   **Memory Efficiency**: In addition to speed, the extension type nature of this tool often results in a smaller memory footprint compared to the pure-Python `OrderedDict` found in Python 2.7.

## Reference documentation

- [shoyer/cyordereddict: Cython implementation of OrderedDict](./references/github_com_shoyer_cyordereddict.md)