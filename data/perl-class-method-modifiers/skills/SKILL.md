---
name: perl-class-method-modifiers
description: This tool provides a lightweight way to hook into existing Perl methods using before, after, around, or fresh modifiers. Use when user asks to add hooks to methods, modify method behavior without using Moose, or execute code before or after a specific subroutine.
homepage: https://github.com/moose/Class-Method-Modifiers
---


# perl-class-method-modifiers

## Overview
`Class::Method::Modifiers` provides a lightweight way to hook into existing methods in Perl classes. It allows you to execute code before, after, or around a method without needing to manually manage `SUPER::` calls or complex method redispatching. This is particularly useful for creating pluggable architectures, adding logging/validation, or safely extending classes that do not use the full Moose object system.

## Core Modifiers

### before
Executes code before the target method. The return value is ignored.
- **Use case**: Argument validation, logging, or setting up state.
- **Note**: You can modify the arguments the original method receives by altering `@_` directly.

```perl
before 'search' => sub {
    my ($self, $query) = @_;
    warn "Searching for $query...";
};
```

### after
Executes code after the target method. The return value is ignored.
- **Use case**: Cleanup, teardown, or post-execution notifications.
- **Note**: It sees the version of `@_` that the original method finished with.

```perl
after 'save' => sub {
    my $self = shift;
    $self->update_audit_log("Record saved");
};
```

### around
Wraps the target method, providing full control over execution.
- **Use case**: Conditional execution, munging return values, or catching exceptions.
- **Pattern**: The first argument is the original method coderef (`$orig`), followed by the object and arguments.

```perl
around 'get_data' => sub {
    my $orig = shift;
    my $self = shift;
    
    # Pre-processing
    my $results = $orig->($self, @_);
    
    # Post-processing / Munging
    return lc($results); 
};
```

### fresh
Installs a new method but throws an exception if a method with that name already exists in the class hierarchy.
- **Use case**: Safety when subclassing to prevent accidental shadowing of future parent class methods.

```perl
use Class::Method::Modifiers qw(fresh);
fresh 'unique_subclass_method' => sub { ... };
```

## Expert Tips and Best Practices

- **Multiple Modifiers**: You can define multiple modifiers for the same method in a single namespace. They operate independently, making top-down design easier.
- **Array References**: Modifiers can be applied to multiple methods at once by passing an array reference: `before [qw(start stop pause)] => sub { ... };`.
- **Namespace Cleanliness**: Use `use Class::Method::Modifiers ();` if you want to avoid exporting the modifiers into your namespace and prefer using `install_modifier` for dynamic application.
- **Performance**: This module is significantly faster than the full Moose implementation of method modifiers, making it suitable for performance-sensitive applications.
- **Context Awareness**: When using `around`, be mindful of the calling context (wantarray). If the original method is context-sensitive, ensure your wrapper handles `wantarray` correctly when calling `$orig`.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_moose_Class-Method-Modifiers.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_perl-class-method-modifiers_overview.md)