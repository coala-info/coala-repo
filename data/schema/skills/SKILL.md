---
name: schema
description: The schema library validates and transforms data structures using Pythonic objects and logic wrappers. Use when user asks to validate data, check data types, transform input values, or define dictionary and list schemas.
homepage: https://github.com/keleshev/schema
---


# schema

## Overview

The `schema` library offers a Pythonic approach to data validation, allowing you to describe the expected structure of your data using familiar Python objects. It goes beyond simple type checking by supporting data transformation (via `Use`), conditional logic (via `And`/`Or`), and custom validation functions. This skill helps you implement robust data contracts that fail fast with descriptive errors when data does not meet your specifications.

## Core Validation Patterns

### Type and Value Validation
The most basic usage involves checking if data matches a specific type or satisfies a predicate function.
- **Type Check**: `Schema(int).validate(123)` ensures the input is an integer.
- **Callable/Lambda**: `Schema(lambda n: n > 0).validate(5)` ensures the input satisfies a condition.
- **Regex**: Use `Regex(r'pattern')` to validate string formats like emails or IDs.

### Logic Wrappers
- **And**: Use `And(type, condition)` to require multiple constraints. Example: `And(int, lambda n: 0 <= n <= 100)`.
- **Or**: Use `Or(type1, type2)` to allow multiple valid types or values. Example: `Or(int, float)`.
- **Optional**: Wrap dictionary keys in `Optional('key')` to signify they are not required.

### Data Transformation
- **Use**: Wraps a callable to convert data during the validation process. Example: `Use(int)` will convert the string `"123"` to the integer `123`.
- **Const**: Validates data against a schema but returns the original input, even if a `Use` directive was nested inside it.

## Expert Tips and Best Practices

### Handling Validation Errors
Always wrap `.validate()` calls in a try-except block to catch `SchemaError`.
- Use `schema.is_valid(data)` for a simple boolean check if you do not need the transformed data or error details.
- `SchemaError` provides a descriptive message explaining exactly which part of the data structure failed validation.

### Dictionary Validation
- **Key Validation**: You can validate keys as well as values. For example, `{str: int}` validates a dictionary where all keys are strings and all values are integers.
- **Default Values**: While the core library focuses on validation, combining `Optional` with `Use` can be used to handle missing keys by providing a fallback in your application logic after validation.

### List Validation
- When validating a list, `Schema([int])` ensures every element in the list is an integer.
- You can provide multiple allowed types in a list schema, such as `Schema([int, str])`, which acts as an implicit `Or` for the list elements.

## Installation
Install the library via pip or conda:
- **Pip**: `pip install schema`
- **Conda**: `conda install bioconda::schema`

## Reference documentation
- [Schema GitHub README](./references/github_com_keleshev_schema.md)
- [Bioconda Schema Overview](./references/anaconda_org_channels_bioconda_packages_schema_overview.md)