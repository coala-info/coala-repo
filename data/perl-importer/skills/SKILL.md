---
name: perl-importer
description: The perl-importer module provides an alternative interface for importing symbols that gives the consumer control over how functions are brought into their scope. Use when user asks to import symbols lexically, rename imported functions to avoid naming conflicts, or get function references without installing them into a symbol table.
homepage: http://metacpan.org/pod/Importer
---


# perl-importer

## Overview
The `Importer` module provides a robust alternative to the default Perl `import` mechanism. It is designed to work with any module that uses `Exporter`, but it gives the *consumer* of the module control over how symbols are imported. This is particularly useful for avoiding naming conflicts, importing symbols into lexical scopes, or renaming imported functions on the fly to improve code clarity.

## Usage Patterns

### Basic Lexical Imports
To import symbols into the current scope without affecting the package namespace:
```perl
use Importer 'Module::Name' => qw(func1 func2);
```

### Renaming Symbols
To avoid collisions with existing subroutines, use the hash reference syntax to rename imports:
```perl
use Importer 'Long::Module::Name' => (
    'original_func' => { -as => 'short_func' },
    'other_func'    => { -as => 'my_alias' },
);
```

### Importing Tags
If a module defines export tags (like `:all` or `:helpers`), you can import them through the Importer interface:
```perl
use Importer 'Data::Dumper' => qw(:all);
```

### Version Requirements
Specify a minimum version of the source module before importing:
```perl
use Importer 'Module::Name' => '1.25', qw(symbol);
```

### Anonymous Imports
You can use Importer to get references to functions without installing them into any symbol table:
```perl
my $imports = Importer->get('Module::Name', qw(func1 func2));
# $imports is a hashref: { func1 => \&Module::Name::func1, ... }
$imports->{func1}->(@args);
```

## Best Practices
- **Prefer Lexical Scope**: Use `Importer` within the smallest scope possible (e.g., inside a subroutine) to keep the global namespace clean.
- **Avoid 'use' in Loops**: While `Importer` is efficient, avoid placing `use Importer` inside tight loops; keep it at the top of the scope.
- **Explicit Naming**: When importing from multiple modules that might share common function names (like `log` or `config`), always use the `-as` renaming feature to provide unique, descriptive names.

## Reference documentation
- [Importer - Alternative interface to modules that export symbols](./references/metacpan_org_pod_Importer.md)