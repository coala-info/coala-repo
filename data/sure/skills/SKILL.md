---
name: sure
description: Sure is a Python testing utility that provides a fluent, English-like syntax for assertions and a dedicated test runner. Use when user asks to implement BDD-style assertions, write readable test cases using the expects or should patterns, or execute tests via the CLI.
homepage: http://github.com/gabrielfalcao/sure
metadata:
  docker_image: "quay.io/biocontainers/sure:2.0.1--pyh7cba7a3_0"
---

# sure

## Overview
sure is a sophisticated testing utility for Python that provides a fluent, English-like syntax for assertions and a dedicated test runner. It transforms standard Python assertions into readable sentences, making test suites easier to maintain and understand. Use this skill to implement BDD-style assertions using the `expects` or `.should` patterns and to execute tests via the `sure` CLI.

## Installation
Install sure via pip or conda:
- **pip**: `pip install sure`
- **conda**: `conda install bioconda::sure`

## CLI Usage
The `sure` command-line tool acts as a test runner.
- **Run tests**: Execute `sure <directory>` (e.g., `sure tests`) to run all tests within a specific folder.
- **Help**: Use `sure --help` to view available runner options.

## Assertion Patterns
sure provides two primary ways to write assertions: the `expects` function and the `.should` property (which is dynamically added to objects).

### Basic Comparisons
```python
from sure import expects

# Using expects()
expects(4).to.be.equal(2 + 2)
expects(7.5).to.be.eql(3.5 + 4)

# Using .should
(2 + 2).should.equal(4)
"Awesome ASSERTIONS".lower().split().should.equal(['awesome', 'assertions'])
```

### Negative Assertions
```python
# Using not_be or to_not
expects(3).to.not_be.equal(5)
expects(9).to_not.be.equal(11)
```

### Dictionary and Collection Assertions
sure is particularly powerful for inspecting complex data structures.
```python
# Equality check for dicts
expects({'foo': 'bar'}).to.equal({'foo': 'bar'})

# Key and value inspection
expects({'foo': 'bar'}).to.have.key('foo').being.equal('bar')
```

## Expert Tips
- **Fluent Chaining**: You can chain assertions to drill down into objects (e.g., `.to.have.key().being.equal()`).
- **Readability**: Prefer `.should` for simple object comparisons to keep the code concise, and `expects()` when the expression being tested is complex or spans multiple lines.
- **Compatibility**: sure is designed to work alongside other testing frameworks like pytest or nose, providing a more expressive assertion layer.

## Reference documentation
- [sure GitHub Repository](./references/github_com_gabrielfalcao_sure.md)
- [sure Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sure_overview.md)