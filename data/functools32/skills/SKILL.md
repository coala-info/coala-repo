---
name: functools32
description: functools32 is a backport of the Python 3.2 `functools` module for use in Python 2.7 and PyPy environments.
homepage: https://github.com/michilu/python-functools32
---

# functools32

## Overview
functools32 is a backport of the Python 3.2 `functools` module for use in Python 2.7 and PyPy environments. It provides higher-order functions and operations on callable objects that were not natively available in older Python versions. Its most significant feature is the `lru_cache` decorator, which allows for easy memoization of function results to reduce redundant computations.

## Implementation Patterns

### Using lru_cache for Memoization
The primary use case for functools32 is caching expensive function calls.

```python
import functools32

@functools32.lru_cache(maxsize=128, typed=False)
def get_expensive_data(user_id):
    # Logic for expensive database or API call
    return data
```

- **maxsize**: Set to a power of two for best performance. If set to `None`, the cache grows without bound.
- **typed**: If set to `True`, arguments of different types will be cached separately (e.g., `f(3)` and `f(3.0)` will be distinct entries).

### Cache Management
You can inspect and clear the cache at runtime:

- `get_expensive_data.cache_info()`: Returns a named tuple showing `hits`, `misses`, `maxsize`, and `currsize`.
- `get_expensive_data.cache_clear()`: Clears the cache entirely.

### Class Decorators with total_ordering
Use `total_ordering` to reduce the boilerplate required for rich comparison methods. You only need to define `__eq__` and one other comparison method (`__lt__`, `__le__`, `__gt__`, or `__ge__`).

```python
@functools32.total_ordering
class Student:
    def __eq__(self, other):
        return self.lastname.lower() == other.lastname.lower()
    def __lt__(self, other):
        return self.lastname.lower() < other.lastname.lower()
```

## Expert Tips
- **Thread Safety**: The `lru_cache` implementation in functools32 is thread-safe, making it suitable for multi-threaded Python 2.7 applications.
- **Argument Requirements**: Functions decorated with `lru_cache` must have hashable arguments. Passing a list or dictionary directly will raise a `TypeError`.
- **Memory Management**: Always specify a `maxsize` in production environments to prevent memory leaks in long-running processes.
- **Wraps Decorator**: When writing custom decorators, use `functools32.wraps(f)` to preserve the original function's metadata (name, docstring, etc.), which is critical for debugging and introspection in legacy codebases.

## Reference documentation
- [Python functools32 README](./references/github_com_michilu_python-functools32.md)