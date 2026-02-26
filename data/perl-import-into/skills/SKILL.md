---
name: perl-import-into
description: This tool allows Perl modules to import pragmas or other modules directly into a caller's namespace. Use when user asks to re-export dependencies, inject pragmas like strict or Moo into a calling package, or handle imports at specific stack levels.
homepage: http://metacpan.org/pod/Import::Into
---


# perl-import-into

## Overview
The `Import::Into` module solves the "double-export" problem in Perl. Normally, if you create a wrapper module that tries to load `strict` or `Moo` for its users, those pragmas only affect your wrapper, not the end-user's code. This skill provides the syntax and methods to inject these dependencies directly into the caller's namespace, ensuring that pragmas and exporters function correctly across different API styles.

## Core Usage Patterns

### Simple Re-exporting
To load a module into the package that just used your module, use `scalar caller` to identify the target.

```perl
package My::Toolkit;
use Import::Into;

sub import {
    my $target = scalar caller;
    
    # Inject pragmas into the caller
    strict->import::into($target);
    warnings->import::into($target);
    
    # Inject an exporter into the caller
    Moo->import::into($target);
}
```

### Exporting to a Specific Level
If your import logic is nested inside another subroutine, use an integer to represent the stack level. `1` refers to the immediate caller.

```perl
sub import {
    # Imports Thing1 into the package that called 'use My::Module'
    Thing1->import::into(1);
}
```

### Passing Arguments
You can pass import arguments (tags, version numbers, or specific subroutines) just as you would with a standard `use` statement.

```perl
sub import {
    my $target = caller;
    # Equivalent to: use Data::Dumper qw(Dumper);
    Data::Dumper->import::into($target, qw(Dumper));
}
```

### Handling Unimport
To clean up or disable features when the user calls `no My::Module`, use `unimport::out_of`.

```perl
sub unimport {
    my $target = scalar caller;
    warnings->unimport::out_of($target);
}
```

## Expert Tips
- **No Changes Required**: You do not need to modify the module you are importing (e.g., `Thing1`). `import::into` is a global method available to all packages once `Import::Into` is loaded.
- **Pragma Support**: This is the preferred method for re-exporting pragmas like `strictures`, `autodie`, or `feature`, as it correctly handles the lexical hints that standard `eval "package $target; use $pragma;"` often misses.
- **Complex Targets**: The `$target` can be a hashref containing `package`, `filename`, and `line` if you need to spoof the location of the import for error reporting or modules that check `caller` details.

## Reference documentation
- [Import::Into - Import packages into other packages](./references/metacpan_org_pod_Import__Into.md)