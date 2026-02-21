---
name: voluptuous
description: Voluptuous is a Python data validation library that prioritizes simplicity and support for complex, nested data structures.
homepage: https://github.com/alecthomas/voluptuous
---

# voluptuous

## Overview

Voluptuous is a Python data validation library that prioritizes simplicity and support for complex, nested data structures. Unlike other validation libraries that require complex class hierarchies, Voluptuous allows you to define schemas using native Python data structures like dictionaries, lists, and basic types. It is designed to provide clear, actionable error messages when data does not conform to the expected format.

## Usage Instructions

### Basic Schema Definition
Define a schema by passing a Python structure to the `Schema` constructor. Validation is performed by calling the schema object with the data to be checked.

```python
from voluptuous import Schema

# Simple type checking
schema = Schema({
    'name': str,
    'age': int,
})

# Validates and returns the data
data = schema({'name': 'John', 'age': 30})
```

### Markers and Constraints
Use markers like `Required` and `Optional` to define key presence, and validators like `All`, `Length`, and `Range` to enforce value constraints.

*   **Required(key, default=None)**: The key must be present in the data.
*   **Optional(key)**: The key may be omitted.
*   **All(validators)**: All provided validators must pass (useful for chaining).
*   **Length(min=None, max=None)**: Constraints for strings or collections.
*   **Range(min=None, max=None)**: Constraints for numeric values.

```python
from voluptuous import Required, All, Length, Range

schema = Schema({
    Required('username'): All(str, Length(min=3)),
    Required('limit', default=10): All(int, Range(min=1, max=100)),
    'tags': [str], # A list of strings
})
```

### Handling Validation Errors
When validation fails, Voluptuous raises `MultipleInvalid` or `Invalid` exceptions. Catch these to access specific error details.

```python
from voluptuous import MultipleInvalid

try:
    schema({'username': 'ab', 'limit': 150})
except MultipleInvalid as e:
    for error in e.errors:
        print(f"Error: {error.msg} at {error.path}")
```

### Best Practices
*   **Type Coercion**: Use `Coerce(type)` if you want Voluptuous to attempt to convert the input data (e.g., a string "1" to an integer 1) before validating.
*   **Nested Structures**: Define nested dictionaries or lists directly within the schema; Voluptuous handles recursion automatically.
*   **Custom Validators**: Any callable that raises `Invalid` or returns the value can be used as a validator.
*   **Literal Matching**: Use specific values (like `1` or `'active'`) in the schema to enforce exact matches.

## Reference documentation
- [Voluptuous README](./references/github_com_alecthomas_voluptuous.md)