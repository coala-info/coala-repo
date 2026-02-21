---
name: wheezy.template
description: The `wheezy.template` library provides a minimalist yet powerful templating system.
homepage: https://bitbucket.org/akorn/wheezy.template
---

# wheezy.template

## Overview
The `wheezy.template` library provides a minimalist yet powerful templating system. It is designed to be faster than many mainstream alternatives by compiling templates into Python bytecode. Use this skill to implement dynamic content generation where performance is critical and you prefer a syntax that stays close to Python's logic.

## Core Usage Patterns

### Basic Template Syntax
- **Expressions**: Use `@` to evaluate Python expressions.
  - `@name` or `@user.name`
- **Statements**: Use `@` at the start of a line for control flow.
  - `@if items:`
  - `@for item in items:`
  - `@end`
- **Escaping**: Use `@@` to output a literal `@` symbol.

### Template Compilation
To use templates within a Python script:
```python
from wheezy.template.engine import Engine
from wheezy.template.loader import DictLoader
from wheezy.template.ext.core import CoreExtension

# Define templates in a dictionary or use FileLoader for disk access
templates = {
    'hello.txt': 'Hello, @name! @if tasks: You have @len(tasks) tasks.@end'
}

engine = Engine(loader=DictLoader(templates), extensions=[CoreExtension()])
template = engine.get_template('hello.txt')

# Render with a data context
print(template.render({'name': 'User', 'tasks': [1, 2]}))
```

### Best Practices
- **Pre-compilation**: Always initialize the `Engine` once and reuse it. The engine caches compiled templates, making subsequent renders extremely fast.
- **Extensions**: Enable `CoreExtension` for standard logic (if/for) and `CodeExtension` if you need to embed arbitrary Python code blocks using `@bracket` syntax.
- **Loaders**: Use `FileLoader` for production environments to manage template files on disk, and `DictLoader` for small, dynamic, or unit-testing scenarios.
- **Context Management**: Keep the dictionary passed to `render()` flat and simple to maintain high performance.

## Expert Tips
- **Whitespace Control**: `wheezy.template` is sensitive to indentation if you use it for Python-like structures. Ensure your template logic aligns with the desired output formatting.
- **Performance**: If rendering speed is the primary bottleneck, ensure you are not re-initializing the `Engine` or reloading files on every request.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_wheezy.template_overview.md)