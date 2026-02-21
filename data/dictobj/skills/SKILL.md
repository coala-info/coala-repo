---
name: dictobj
description: The `dictobj` library provides specialized Python dictionary objects that allow for attribute-style lookup (`obj.key`) in addition to standard index-style lookup (`obj['key']`).
homepage: https://github.com/grimwm/py-dictobj
---

# dictobj

## Overview
The `dictobj` library provides specialized Python dictionary objects that allow for attribute-style lookup (`obj.key`) in addition to standard index-style lookup (`obj['key']`). It is designed to facilitate "Separation of Concerns" by offering an immutable-by-default class, `DictionaryObject`, which prevents accidental data modification across different parts of an application. For cases where updates are necessary, it provides a `MutableDictionaryObject`.

## Usage Guidelines

### Core Classes
- **DictionaryObject**: The base immutable class. Once initialized, keys cannot be added or modified.
- **MutableDictionaryObject**: A subclass that allows for attribute and item assignment (e.g., `d.x = 10` or `d['x'] = 10`).

### Initialization Patterns
You can initialize these objects using dictionaries, sequences of pairs, or keyword arguments:

```python
from dictobj import DictionaryObject, MutableDictionaryObject

# From a dictionary
d1 = DictionaryObject({'a': 1, 'b': 2})

# From keyword arguments
d2 = DictionaryObject(name="Claude", role="Assistant")

# With a default value for missing keys
d3 = DictionaryObject({'a': 1}, None)
print(d3.missing_key)  # Returns None instead of raising AttributeError
```

### Handling Attribute Access Limitations
Attribute access (`obj.key`) fails in two specific scenarios. In these cases, you must fall back to standard dictionary indexing (`obj['key']`):
1. **Invalid Identifiers**: Keys that are not valid Python variable names (e.g., keys containing spaces, special characters, or starting with numbers).
2. **Shadowed Names**: Keys that conflict with built-in dictionary methods (e.g., `keys`, `values`, `items`, `asdict`). Accessing `d.keys` will return the method, not the value stored at the 'keys' key.

### Best Practices
- **Prefer Immutability**: Use `DictionaryObject` by default to ensure data remains static across threads or processes.
- **Serialization**: Use these objects in multiprocessing environments; they are fully picklable.
- **Conversion**: Use the `.asdict()` method when you need to pass the data back to a library that expects a standard Python `dict`.
- **Comparison**: `DictionaryObject` and `MutableDictionaryObject` instances can be compared to each other and will return `True` if their underlying data is identical.

## Expert Tips
- **Eval-friendly Repr**: The `__repr__` of a `dictobj` is designed so that it can be passed to `eval()` to reconstruct the object, which is useful for quick debugging or logging.
- **Deep Mutability Caveat**: While `DictionaryObject` is immutable, if it contains mutable objects (like a list), those underlying objects can still be modified. Use with caution if strict immutability is required.

## Reference documentation
- [py-dictobj Main Documentation](./references/github_com_grimwm_py-dictobj.md)