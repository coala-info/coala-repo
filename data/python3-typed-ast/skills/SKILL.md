---
name: python3-typed-ast
description: python3-typed-ast parses Python 2 and 3 source code into an abstract syntax tree that includes PEP 484 type comments. Use when user asks to parse legacy Python code, extract type comments from source files, or convert Python 2.7 ASTs to Python 3.
homepage: https://github.com/pexip/os-python3-typed-ast
metadata:
  docker_image: "biocontainers/python3-typed-ast:v0.6.3-1-deb_cv1"
---

# python3-typed-ast

## Overview

`python3-typed-ast` is a specialized backport and enhancement of the CPython AST module. It provides parsers for both Python 2.7 and Python 3 that are capable of capturing PEP 484 type comments as part of the AST nodes. Unlike the standard `ast` library in older Python versions, `typed_ast` is version-independent, allowing a script running on Python 3.7 to accurately parse Python 2.7 syntax. While Python 3.8+ has integrated similar functionality into the standard library, this package remains the standard for tools supporting older runtimes or requiring specific legacy compatibility.

## Usage Guidelines

### Selecting the Parser
The package provides two distinct modules based on the target source code version:
- **`typed_ast.ast3`**: Use for parsing Python 3 code (matches Python 3.6/3.7 AST).
- **`typed_ast.ast27`**: Use for parsing legacy Python 2.7 code.

### Basic Parsing
To parse code and include type comments, use the `parse` function. Note that in `typed_ast`, type comments are considered part of the grammar; if they are syntactically misplaced, the parser will raise a `SyntaxError`.

```python
from typed_ast import ast3

code = """
def hello(name):
    # type: (str) -> None
    print("Hello " + name)
"""

tree = ast3.parse(code)
```

### Accessing Type Comments
Once parsed, specific nodes will contain a `type_comment` attribute (a string or `None`):
- **Function Definitions**: Found on the `FunctionDef` node.
- **Assignments**: Found on `Assign` and `AnnAssign` nodes.
- **For/With Loops**: Found on `For` and `With` nodes.
- **Arguments**: Found on the `arg` nodes within `arguments`.

### Version-Specific Constraints
When using `ast3`, you can restrict the parser to a specific Python 3 minor version to catch syntax that is "too new" for a target environment:

```python
# Raise SyntaxError if code uses features newer than Python 3.5
tree = ast3.parse(source_code, feature_version=5)
```

### Converting Python 2 to Python 3 AST
If you are performing cross-version analysis, the `conversions` module can attempt to transform a Python 2.7 AST into a Python 3 AST:

```python
from typed_ast import ast27, conversions

py2_tree = ast27.parse(py2_code)
py3_tree = conversions.py2to3(py2_tree)
```

## Best Practices and Tips

- **Archival Status**: Be aware that `typed_ast` is archived and does not support parsing syntax introduced in Python 3.8 or newer (e.g., walrus operators). For Python 3.8+ source code, use the standard library `ast.parse(source, type_comments=True)`.
- **Drop-in Compatibility**: Treat `typed_ast` as a drop-in replacement for the standard `ast` module for consumption purposes. However, if you are *constructing* ASTs manually, you must provide the additional `type_comment` fields required by the `typed_ast` constructors.
- **Error Handling**: Always wrap parsing logic in `try...except SyntaxError` blocks, as `typed_ast` is stricter than the standard library regarding the placement of comments starting with `# type:`.
- **Environment**: This library relies on C extensions and is compatible with CPython 3.5-3.8. It is not supported on PyPy.

## Reference documentation
- [Typed AST README](./references/github_com_pexip_os-python3-typed-ast.md)