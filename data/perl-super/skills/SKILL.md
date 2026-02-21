---
name: perl-super
description: The `perl-super` (SUPER) module provides a more robust and flexible way to call parent methods compared to Perl's built-in `SUPER::` mechanism.
homepage: http://metacpan.org/pod/SUPER
---

# perl-super

## Overview

The `perl-super` (SUPER) module provides a more robust and flexible way to call parent methods compared to Perl's built-in `SUPER::` mechanism. While native Perl determines the "super" class based on the package where the code was compiled, this skill allows for dynamic dispatch that respects the actual inheritance hierarchy at runtime. Use this when you need Ruby-style `super` calls, need to pass modified arguments to a parent method, or are working with complex class compositions like roles and mixins.

## Usage Patterns

### 1. Ruby-style Dispatch
To call the parent implementation of the current method with the exact same arguments, use the exported `super` function. This is the most concise way to redispatch.

```perl
use SUPER;

sub my_method {
    my $self = shift;
    # Custom logic here
    if ($should_handle_locally) {
        return "Handled";
    }
    # Automatically passes $self and original @_ to the parent
    super; 
}
```

### 2. Manual Dispatch with Custom Arguments
If you need to modify the arguments before passing them to the superclass, use the `SUPER()` method (note the uppercase). Unlike the lowercase function, this requires an explicit invocant and argument list.

```perl
sub save {
    my ($self, %args) = @_;
    $args{timestamp} = time;
    # Call parent 'save' with modified %args
    $self->SUPER(%args);
}
```

### 3. Dynamic Method Discovery
To find the code reference for a parent method without executing it immediately (useful for `goto &sub` patterns to save stack frames):

```perl
sub complex_dispatch {
    my $self = shift;
    my $parent_sub = $self->super('method_name');
    goto &$parent_sub;
}
```

## Best Practices

- **Package Declaration**: Ensure your `package` statement is correctly defined. The module relies on the package context to identify the starting point for inheritance lookups.
- **Avoid `Devel::Cover` Conflicts**: Be aware that `super` uses "Deep Magic" to inspect the caller's stack. If you encounter issues with coverage tools or debuggers, switch to the explicit `$self->SUPER(@_)` syntax.
- **Anonymous Subs**: If using `super` inside anonymous subroutines, you must name the sub (e.g., using `Sub::Identify` or similar techniques) for the dispatch logic to find the correct hierarchy.
- **Proxy Objects**: If your class uses delegation or proxying, define a `__get_parents()` method in your class. `SUPER` will call this method to determine the inheritance chain instead of looking at `@ISA`.

## Reference documentation

- [SUPER - control superclass method dispatch](./references/metacpan_org_pod_SUPER.md)