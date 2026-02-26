---
name: piranha
description: Piranha is a high-performance refactoring engine that automates code transformations through structural search and replace using Abstract Syntax Trees. Use when user asks to prune code associated with expired feature flags, perform large-scale code refactoring, or automate the cleanup of redundant logic and expressions.
homepage: https://github.com/uber/piranha
---


# piranha

## Overview
Piranha is a high-performance, multilingual toolset designed to automate code transformations through structural search and replace. While originally developed by Uber to prune code associated with expired feature flags, it serves as a general-purpose refactoring engine. It leverages tree-sitter to parse code into Abstract Syntax Trees (ASTs) and allows you to define "Rule Graphs"—chains of interdependent rules that ensure when a flag is removed, the surrounding logic (like empty if-statements or redundant boolean expressions) is cleaned up deterministically.

## Installation
Piranha can be used as a Python library or a standalone binary.

- **Python API**: `pip install polyglot-piranha`
- **CLI (from source)**:
  1. Clone the repository: `git clone https://github.com/uber/piranha.git`
  2. Build: `cargo build --release`
  3. The binary is located at `target/release/polyglot_piranha`.

## Core Concepts
To use Piranha effectively, you must define three main components:
1. **Rules**: These contain a `query` (to find code), a `replace_node` (the target AST node), and the `replace` string (the new code).
2. **Edges**: These define the flow of transformations. For example, after a "replace_method" rule runs, an edge can trigger a "cleanup" rule on the parent scope.
3. **RuleGraph**: A collection of rules and their connecting edges.

## Expert Usage Patterns

### Using Concrete Syntax (cs:)
Instead of writing complex tree-sitter S-expressions, use the `cs:` prefix to write queries using the actual programming language syntax.
- **Example Query**: `cs:[x].isLocEnabled()` matches any method call to `isLocEnabled()` on an object `x`.
- **Replacement**: Setting `replace = "true"` will turn that method call into a boolean literal.

### Chaining Cleanup Rules
Piranha is most powerful when primary transformations trigger secondary cleanups.
- **Seed Rules**: Mark the initial transformation rule as `is_seed_rule = True`.
- **Scope**: Use `scope = "parent"` in `OutgoingEdges` to ensure that after a variable or method is removed, Piranha looks at the containing block to remove now-empty `if` statements or unused imports.

### Python API Implementation
For complex workflows, use the Python interface to programmatically execute transformations:

```python
from polyglot_piranha import execute_piranha, PiranhaArguments, Rule, RuleGraph, OutgoingEdges

# 1. Define the primary transformation
r1 = Rule(
    name = "remove_flag",
    query = "cs:if (Flags.isFeatureEnabled()) { :[body] }",
    replace_node = "*",
    replace = ":[body]",
    is_seed_rule = True
)

# 2. Define cleanup edges (e.g., cleaning up boolean literals)
edge = OutgoingEdges("remove_flag", to = ["boolean_literal_cleanup"], scope = "parent")

# 3. Execute
args = PiranhaArguments(
    path_to_codebase = "/path/to/src",
    language = "java",
    rule_graph = RuleGraph(rules = [r1], edges = [edge])
)
output = execute_piranha(args)
```

## Best Practices
- **Test in the Playground**: Use the [Piranha Tree-sitter Playground](https://uber.github.io/piranha/tree-sitter-playground/) to validate your queries and see how the AST is structured before running on a codebase.
- **Incremental Rules**: Start with a single seed rule and verify the output. Add cleanup rules (edges) one by one to handle edge cases like trailing semicolons or empty blocks.
- **Language Specifics**: Note that Piranha uses custom patches for certain grammars. If a query fails, check the `src/cleanup_rules` directory in the repository for pre-defined language-specific cleanup patterns.

## Reference documentation
- [PolyglotPiranha Main Repository](./references/github_com_uber_piranha.md)
- [Piranha Wiki and Core Framework](./references/github_com_uber_piranha_wiki.md)