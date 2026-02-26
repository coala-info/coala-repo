---
name: ruamel.ordereddict
description: "ruamel.ordereddict provides a C-based implementation of ordered and sorted dictionaries with advanced positional manipulation and slicing capabilities. Use when user asks to maintain key insertion order, perform index-based dictionary operations, rename keys in place, or manage automatically sorted dictionaries."
homepage: https://github.com/ruamel/ordereddict
---


# ruamel.ordereddict

## Overview
`ruamel.ordereddict` provides a robust, C-based implementation of ordered and sorted dictionaries for Python. It extends the capabilities of the standard library by offering multiple insertion modes, automatic sorting, and list-like manipulation of dictionary entries. Use this tool when you need to maintain specific key sequences, perform efficient positional lookups, or handle dictionary slices.

## Core Dictionary Types
- **ordereddict (KIO)**: Key Insertion Order (default). Updates to existing keys do not change their position.
- **ordereddict (KVIO)**: Key Value Insertion Order. Updating a value moves the key to the end of the dictionary.
- **sorteddict**: Automatically maintains keys in sorted order.

## Implementation Patterns

### Initialization and "Relaxed" Mode
By default, `ordereddict` prevents initialization from unordered dictionaries to ensure order integrity. Use the `relax` parameter to bypass this.

```python
from ruamel.ordereddict import ordereddict, sorteddict

# Standard KIO
od = ordereddict([('a', 1), ('b', 2)])

# KVIO: Updates move keys to the back
kvio = ordereddict(kvio=True)

# Relaxed: Allows initialization from a standard dict
d = ordereddict({'a': 1, 'b': 2}, relax=True)

# Sorted: Always relaxed by default
sd = sorteddict({'b': 2, 'a': 1})
```

### Positional and List-like Operations
Unlike standard dicts, these objects support index-based access and manipulation.
- **Indexing**: `od.index('key')` returns the integer position of the key.
- **Insertion**: `od.insert(pos, 'key', value)` places a key at a specific index. If the key exists, it moves to the new position.
- **Popping**: `od.popitem(i)` removes and returns the item at index `i` (default is -1, the last item).
- **Renaming**: `od.rename('old_key', 'new_key')` changes a key name while preserving its original position and value.

### Advanced Key/Value Manipulation
- **.setkeys(iterable)**: Reorders keys based on a permutation of existing keys. The iterable must contain all existing keys.
- **.setvalues(iterable)**: Updates all values in order from an iterable of the same length as the dictionary.
- **.setitems(iterable)**: Clears the dictionary and adds new items in the provided order.
- **.reverse()**: Reverses the order of keys in-place.

### Slicing and Iteration
The library supports slice retrieval, deletion, and assignment.
- **Reversed Iteration**: Methods like `.keys()`, `.values()`, and `.items()` accept a `reverse=True` parameter for efficient backward traversal.
- **Slicing**: `od[0:2]` retrieves a slice; `del od[0:1]` deletes a range. Assignment to a slice is supported from other `OrderedDict` objects of the same length.

## Expert Tips
- **Performance**: This is a C implementation. For large datasets requiring frequent reordering, positional lookups, or slicing, it is significantly more performant than pure-Python ordered dictionary implementations.
- **Sorted Transforms**: When using `sorteddict`, you can provide a `key` argument (e.g., `key=str.lower`) to transform keys before comparison, allowing for case-insensitive sorting.
- **Pickling**: Both `ordereddict` and `sorteddict` instances are fully picklable, making them suitable for applications requiring data serialization.
- **Avoid Direct Imports**: Always import from `ruamel.ordereddict`. Do not attempt to import from the underlying `_ordereddict` C module directly.

## Reference documentation
- [The ordereddict module in short](./references/github_com_ruamel_ordereddict.md)