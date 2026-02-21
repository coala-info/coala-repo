---
name: perl-parse-recdescent
description: This skill facilitates the creation of powerful, readable, and maintainable parsers using the `Parse::RecDescent` module.
homepage: http://metacpan.org/pod/Parse-RecDescent
---

# perl-parse-recdescent

## Overview

This skill facilitates the creation of powerful, readable, and maintainable parsers using the `Parse::RecDescent` module. Unlike standard regular expression-based parsing, this tool allows for the definition of grammar rules in a natural, top-down hierarchy. It is particularly effective for tasks involving nested structures, mathematical expressions, or custom configuration languages where context-free grammar is required.

## Implementation Patterns

### Basic Grammar Structure
Define your grammar as a single string containing rules and actions. Each rule consists of a name followed by a colon and one or more productions.

```perl
use Parse::RecDescent;

my $grammar = q{
    Equation: Variable '=' Number
            { print "Assigning $item{Number} to $item{Variable}\n"; }
    Variable: /[a-zA-Z_]\w*/
    Number:   /\d+/
};

my $parser = Parse::RecDescent->new($grammar) or die "Bad grammar!";
$parser->Equation("x = 42");
```

### Key Directives and Variables
*   **`<skip: 'pattern'>`**: Change the default whitespace skipping behavior (default is `\s*`).
*   **`$item[n]`**: Access the n-th element of a production (1-indexed).
*   **`%item`**: Access named elements of a production (e.g., `$item{Number}`).
*   **`<return: value>`**: Explicitly set the value returned by a rule.
*   **`<rescore: expression>`**: Manually adjust the "fitness" of a match during ambiguous parsing.

### Handling Left-Recursion
`Parse::RecDescent` is a top-down parser and cannot handle direct left-recursion (e.g., `A: A 'x'`). Rewrite these rules using repetition operators:
*   **`item(s)`**: One or more.
*   **`item(s?)`**: Zero or more.
*   **`item(?)`**: Optional.

### Incremental Development Tips
1.  **Enable Debugging**: Set `$::RD_TRACE = 1;` to see a detailed trace of the parsing process, including where the parser backtracks or fails.
2.  **Precompilation**: For large grammars, precompile the parser into a standalone Perl module to improve startup time:
    ```perl
    Parse::RecDescent->Precompile($grammar, "MyParser");
    ```
3.  **Error Reporting**: Use the `<error>` directive to provide meaningful feedback when a mandatory part of a production fails to match.

## Reference documentation
- [Parse::RecDescent Documentation](./references/metacpan_org_pod_Parse-RecDescent.md)