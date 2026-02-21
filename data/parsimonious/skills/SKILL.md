---
name: parsimonious
description: Parsimonious is a lightweight, pure-Python PEG parser designed for speed and usability.
homepage: https://github.com/erikrose/parsimonious
---

# parsimonious

## Overview
Parsimonious is a lightweight, pure-Python PEG parser designed for speed and usability. It simplifies the parsing process by combining lexing and parsing into a single step, using a syntax based on a simplified version of EBNF. This skill provides guidance on defining grammars, generating syntax trees, and using the `NodeVisitor` pattern to transform those trees into useful data structures.

## Core Workflow

### 1. Define the Grammar
Grammars are defined as strings where the first rule is the default entry point.

```python
from parsimonious.grammar import Grammar

# Define rules using EBNF-like syntax
grammar = Grammar(r"""
    entry       = (record / emptyline)*
    record      = identifier ":" value
    identifier  = ~"[a-z]+"
    value       = ~"\d+"
    emptyline   = ~"\s+"
""")
```

### 2. Parse Input
The `parse()` method returns a `Node` object representing the root of the Abstract Syntax Tree (AST).

```python
tree = grammar.parse("age:25")
```

### 3. Transform with NodeVisitor
To process the AST, subclass `NodeVisitor`. Each method should match a rule name (prefixed with `visit_`).

```python
from parsimonious.nodes import NodeVisitor

class MyVisitor(NodeVisitor):
    def visit_record(self, node, visited_children):
        identifier, _, value = visited_children
        return {identifier: value}

    def visit_identifier(self, node, visited_children):
        return node.text

    def visit_value(self, node, visited_children):
        return int(node.text)

    def generic_visit(self, node, visited_children):
        return visited_children or node

visitor = MyVisitor()
output = visitor.visit(tree)
```

## Syntax Reference

| Operator | Description | Example |
| :--- | :--- | :--- |
| `"literal"` | Matches a string literal | `open_bracket = "["` |
| `~"regex"` | Matches a regular expression | `word = ~"[A-Z]+"i` |
| `rule1 rule2` | Sequence: matches 1 then 2 | `pair = key value` |
| `r1 / r2` | Ordered Choice: tries r1, then r2 | `expr = term / factor` |
| `*` | Zero or more | `items = item*` |
| `+` | One or more | `words = word+` |
| `?` | Zero or one (optional) | `opt = sign?` |
| `( )` | Grouping | `group = (a / b) c` |

## Expert Tips & Best Practices

- **Prioritized Choice**: The `/` operator is not commutative. It tries matches in order. Put the most specific or longest match first to avoid "shadowing" (e.g., ` ">= " / ">" `).
- **Regex Flags**: Use the `i` suffix on regex strings for case-insensitivity: `~"apple"i`.
- **Whitespace Management**: PEG parsers do not ignore whitespace automatically. You must define a `ws` rule (e.g., `ws = ~"\s*"`) and include it in your sequences where appropriate.
- **Greedy Matching**: Quantifiers are greedy. If a rule consumes too much, use more specific regex or lookahead assertions.
- **File Extensions**: While grammars can be strings, it is a best practice to save complex grammars in separate files with the `.ppeg` extension.
- **Generic Visit**: Always implement `generic_visit(self, node, visited_children)` to handle nodes that don't have specific `visit_` methods, typically returning `visited_children or node`.

## Reference documentation
- [Parsimonious README](./references/github_com_erikrose_parsimonious.md)