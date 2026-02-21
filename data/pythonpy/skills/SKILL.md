---
name: pythonpy
description: pythonpy acts as a bridge between the shell and Python, allowing you to execute Python expressions and apply them to streams of data.
homepage: https://github.com/Russell91/pythonpy
---

# pythonpy

## Overview
pythonpy acts as a bridge between the shell and Python, allowing you to execute Python expressions and apply them to streams of data. It eliminates the boilerplate of `import` statements and loop structures, making it the "Swiss Army Knife" for command-line data munging. Use it to transform stdout from other commands using Python's rich library of string and list methods.

## Core Usage Patterns

### Expression Evaluation (`py`)
Use `py` to evaluate a single Python expression and print the result.
- **Math**: `py '3 * 1.5'`
- **Library access**: `py 'math.sqrt(16)'` (Common modules like `math`, `re`, `datetime` are often pre-imported).

### Piped Input Processing (`py -x`)
Use `-x` to apply an expression to each line of input. The variable `x` represents the current line (as a string).
- **String manipulation**: `ls | py -x 'x.upper()'`
- **Filtering**: `cat numbers.txt | py -x 'x if int(x) > 10 else None'` (None values are not printed).

### List Processing (`py -l`)
Use `-l` to treat the entire input as a list of strings named `l`.
- **Sorting/Reversing**: `cat names.txt | py -l 'l[::-1]'`
- **Summation**: `cat prices.txt | py -l 'sum(float(x) for x in l)'`

### List Comprehensions (`py -fx`)
Use `-fx` as a shorthand for filtering. It evaluates the expression for each line `x` and only prints `x` if the expression is true.
- **Regex filtering**: `ls | py -fx 're.match(".*\.py", x)'`

## Expert Tips
- **Automatic Imports**: pythonpy attempts to import modules on demand. You rarely need to write `import`.
- **Formatting**: Use `py -j` to output results as JSON, which is useful for passing data to other tools like `jq`.
- **List Flattening**: If an expression returns a list, pythonpy prints each element on a new line by default.

## Reference documentation
- [pythonpy Overview](./references/anaconda_org_channels_bioconda_packages_pythonpy_overview.md)