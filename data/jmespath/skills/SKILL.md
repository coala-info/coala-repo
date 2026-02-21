---
name: jmespath
description: JMESPath is a declarative query language that allows you to precisely define how to extract and reshape data from JSON documents.
homepage: https://github.com/jmespath/jmespath.py
---

# jmespath

## Overview
JMESPath is a declarative query language that allows you to precisely define how to extract and reshape data from JSON documents. This skill provides the syntax patterns and Python API implementation details necessary to perform sophisticated data retrieval. Use this skill to replace imperative data parsing with concise, maintainable query expressions.

## Core Syntax Patterns

### Basic Navigation
- **Identifier**: Use `foo.bar` to access nested keys.
- **Index Expressions**: Use `foo[0]` for specific elements or `foo[-1]` for the last element.
- **Flattening**: Use `foo[*].bar` to extract the "bar" key from every object in the "foo" list.
- **Hash Projections**: Use `foo.*.name` to extract the "name" attribute from all values within an object.

### Filtering and Selection
- **Filter Expressions**: Use `list[?age > \`20\`]` to filter items based on a condition. Note that literals like numbers or strings in filters must be enclosed in backticks.
- **Multi-Select List**: Use `foo.[name, age]` to return a list containing only those specific fields.
- **Multi-Select Hash**: Use `foo.{Name: name, Age: age}` to create a new object with renamed keys.

### Advanced Operators
- **Pipe Expressions**: Use `foo.bar | [0]` to pass the result of the left-hand side to the right-hand side. This is useful for stopping projections and operating on the resulting list.
- **Current Node**: Use `@` to refer to the current element being processed, often used in filters or custom functions.

## Python API Implementation

### Basic Search
Use the `search` function for one-off queries:
```python
import jmespath
result = jmespath.search('foo.bar', {'foo': {'bar': 'baz'}})
```

### Performance Optimization
When applying the same expression to multiple documents, compile the expression first to avoid redundant parsing overhead:
```python
import jmespath
expression = jmespath.compile('foo[*].name')
for doc in large_dataset:
    name = expression.search(doc)
```

### Handling Ordered Output
To maintain dictionary key order in the output (e.g., using `collections.OrderedDict`), use the `Options` object:
```python
import jmespath
import collections
options = jmespath.Options(dict_cls=collections.OrderedDict)
jmespath.search('{a: a, b: b}', data, options=options)
```

## Custom Functions
Extend the language by subclassing `jmespath.functions.Functions`.
1. Define a method prefixed with `_func_`.
2. Use the `@signature` decorator to enforce argument types.
3. Pass an instance of the subclass to the `Options` object during search.

## Expert Tips
- **Literal Escaping**: Always use backticks (\`) for literal values like integers, booleans, or nulls within expressions (e.g., `length(@) > \`5\``).
- **Type Safety**: JMESPath is strictly typed. Ensure that functions like `sort()` or `sum()` are receiving arrays of the expected type (strings/numbers).
- **Orphaned Projections**: If a projection returns `null` for certain elements, those elements are typically omitted from the resulting list.

## Reference documentation
- [JMESPath Python README](./references/github_com_jmespath_jmespath.py.md)