---
name: varna
description: The varna tool allows Python functions to dynamically discover their assignment targets, argument sources, and chained attribute access at runtime. Use when user asks to get the name of a variable a function's return value is assigned to, retrieve argument names, detect chained attribute access, or create dictionaries from local variables.
homepage: https://github.com/pwwang/python-varname
metadata:
  docker_image: "biocontainers/varna:v3-93ds-2-deb_cv1"
---

# varna

## Overview
The varna skill (utilizing the `python-varname` library) enables Python developers to peek into the call stack and AST to extract variable names at runtime. Instead of manually passing strings that match variable names, this tool allows functions to "discover" their assignment targets and argument sources. This is particularly powerful for data science workflows, debugging utilities, and building intuitive frameworks where the relationship between a variable and its name is significant.

## Core API Usage

### Retrieving Assignment Names
Use `varname()` inside a function to get the name of the variable the function's return value is assigned to.

```python
from varname import varname

def my_func():
    return varname()

# The value of x will be "x"
x = my_func()
```

### Handling Wrappers and Frames
If `varname()` is called inside a helper or a wrapped function, use the `frame` or `ignore` parameters to reach the correct caller.

- **frame**: The number of frames to look back (default is 1).
- **ignore**: A function or module to skip when searching the stack.

```python
def wrapper():
    return target()

def target():
    return varname(frame=2)

# result is "x"
x = wrapper()
```

### Fetching Argument Names
Use `argname()` to get the names of variables passed as arguments to a function.

```python
from varname import argname

def debug_args(a, b):
    print(argname('a', 'b'))

x = 10
y = 20
debug_args(x, b=y) # Prints: ('x', 'y')
```

### Detecting Chained Attributes
The `will()` function detects the next attribute name being accessed on the object returned by the current method.

```python
from varname import will

class Query:
    def filter(self):
        next_attr = will()
        if next_attr == 'execute':
            print("Last step in chain")
        return self
    def execute(self):
        return "Done"

# Triggers the "Last step" print
Query().filter().execute()
```

## Best Practices and Tips

- **Strict Mode**: By default, `varname()` expects a direct assignment (e.g., `x = func()`). If the call is part of an expression (e.g., `x = [func()]`), it will raise an `ImproperUseError`. Set `strict=False` to allow use within expressions.
- **Multiple Assignments**: Use `multi_vars=True` when a function is assigned to multiple variables (e.g., `x, y = func()`).
- **Performance**: Retrieving names involves stack inspection. Avoid using these utilities in tight, performance-critical loops. Use them for initialization, logging, or high-level API logic.
- **Variable Name Persistence**: Use `varname.helpers.Wrapper` to create an object that carries its own variable name as an attribute (`.name`).
- **Quick Dictionaries**: Use `jsobj` to create dictionaries from local variables without repeating keys: `jsobj(a, b)` is equivalent to `{'a': a, 'b': b}`.

## Reference documentation
- [python-varname README](./references/github_com_pwwang_python-varname.md)