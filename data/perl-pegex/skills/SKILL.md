---
name: perl-pegex
description: Pegex is a parsing framework that combines Parsing Expression Grammars with a receiver architecture to process structured data into abstract syntax trees. Use when user asks to define a grammar in a .pgx file, parse strings into data structures, create custom receivers for data transformation, or precompile grammars for performance.
homepage: https://metacpan.org/dist/Pegex/view/lib/Pegex.pod
---


# perl-pegex

## Overview
Pegex is a powerful parsing framework that combines the clean syntax of Parsing Expression Grammars (PEG) with the flexibility of a "Receiver" architecture. Unlike traditional regex-heavy parsing, Pegex allows you to define a language in a human-readable `.pgx` file and then process the resulting AST (Abstract Syntax Tree) through custom Perl classes. This skill provides the necessary patterns for grammar construction and parser invocation.

## Core Usage Patterns

### 1. Defining a Grammar (.pgx)
Create a grammar file using Pegex syntax. Rules are defined as `name: definition`.
- **Leaf rules**: Match text (e.g., `word: /\w+/`)
- **Branch rules**: Combine other rules (e.g., `sentence: word+ punctuation`)
- **Whitespace**: Use `~` to represent optional whitespace defined by the `%whitespace` directive.

### 2. Basic Parser Invocation
To parse a string using a grammar file and a default receiver (which returns a nested array/hash structure):
```perl
use Pegex::Parser;
use Pegex::Grammar;

my $grammar = Pegex::Grammar->new(text => $grammar_text);
my $parser = Pegex::Parser->new(grammar => $grammar);
my $data = $parser->parse($input_string);
```

### 3. Using Custom Receivers
To transform the data during the parsing process, create a subclass of `Pegex::Receiver`.
```perl
package MyReceiver;
use Role::Tiny::With;
with 'Pegex::Receiver';

# Method name matches the grammar rule name
# 'got_rule' is called after 'rule' matches
sub got_word {
    my ($self, $got) = @_;
    return uc($got); # Transform data on the fly
}
```

### 4. Precompiling Grammars
For performance in production, compile the grammar to a Perl module:
```bash
# Command line utility to compile .pgx to a Perl module
perl -MPegex::Compiler -e 'print Pegex::Compiler->new->compile(shift)->to_perl' mygrammar.pgx > MyGrammar.pm
```

## Best Practices
- **Rule Naming**: Use lowercase for rules that return data and uppercase (e.g., `SEP: / \s* , \s* /`) for "skip" rules or separators.
- **Testing**: Use the `pegex-check` utility (if available in the environment) to validate grammar files against sample inputs before writing Perl code.
- **Regex Constraints**: Keep regexes within rules simple. If a regex becomes too complex, break it into multiple Pegex rules to improve maintainability and error reporting.
- **Error Handling**: Pegex provides detailed error messages including the line and column of the failure. Wrap `parse()` calls in `eval` or `Try::Tiny` to catch parsing exceptions.

## Reference documentation
- [Pegex Library Documentation](./references/metacpan_org_dist_Pegex_view_lib_Pegex.pod.md)