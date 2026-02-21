---
name: validictory
description: validictory is a Python-based data validation library that allows you to verify that a data object (typically a dictionary or list) conforms to a predefined schema.
homepage: https://github.com/jpmckinney/validictory
---

# validictory

## Overview
validictory is a Python-based data validation library that allows you to verify that a data object (typically a dictionary or list) conforms to a predefined schema. It implements a version of the JSON Schema specification, making it useful for ensuring data integrity in applications that process structured data. While the library is no longer actively maintained, it remains a lightweight option for basic validation tasks in existing Python 2 or early Python 3 codebases.

## Usage Instructions

### Basic Validation
To validate data, both the data and the schema must be Python objects (e.g., dictionaries, lists, strings).

```python
import validictory

# Simple string validation
validictory.validate("example_text", {"type": "string"})

# Validating a dictionary
data = {"name": "John", "age": 30}
schema = {
    "type": "object",
    "properties": {
        "name": {"type": "string"},
        "age": {"type": "integer"}
    }
}
validictory.validate(data, schema)
```

### Handling Validation Errors
When validation fails, the library raises a `ValueError`. You should wrap validation calls in a try-except block to handle these failures gracefully.

```python
try:
    validictory.validate("short", {"type": "string", "minLength": 10})
except ValueError as error:
    print(f"Validation failed: {error}")
```

### Complex Schema Patterns
validictory supports nested structures and multiple types.

*   **Arrays**: Use the `items` keyword to define the schema for elements within a list.
*   **Any Type**: Use `{"type": "any"}` to allow any data type for a specific field.
*   **Numbers vs Integers**: Distinguish between `number` (floats/decimals) and `integer` for stricter numeric validation.

```python
schema = {
    "type": "array",
    "items": [
        {"type": "string"},
        {"type": "object", "properties": {"id": {"type": "integer"}}}
    ]
}
```

## Best Practices and Tips
*   **Pre-parsing**: Always ensure JSON strings are converted to Python dictionaries using `json.loads()` before passing them to `validictory.validate()`.
*   **Field Naming**: When validation fails on a top-level object, the error message often refers to the field as `_data`.
*   **Deprecation Awareness**: If you are starting a new project, prefer the `jsonschema` library. Use `validictory` only when maintaining legacy systems or when specifically required by existing dependencies.
*   **Schema Portability**: Since the schema format is based on the JSON Schema Proposal, schemas used here are generally portable to other JSON Schema validators with minor adjustments.

## Reference documentation
- [validictory GitHub Repository](./references/github_com_jpmckinney_validictory.md)