---
name: perl-padwalker
description: The perl-padwalker skill enables deep introspection of Perl's lexical pads.
homepage: http://metacpan.org/pod/PadWalker
---

# perl-padwalker

## Overview

The perl-padwalker skill enables deep introspection of Perl's lexical pads. It allows an agent to "peek" into the private variables of calling subroutines or specific code references. This is primarily useful for advanced debugging scenarios where you need to verify the state of variables that are not explicitly passed as arguments, or for metaprogramming tasks that require identifying which variables a subroutine has closed over.

## Core Functions and Usage

### Inspecting Lexical Variables (peek_my)
Use `peek_my(LEVEL)` to obtain a hash reference where keys are variable names (including sigils) and values are references to the actual variables.

*   `peek_my(0)`: Variables in the current scope.
*   `peek_my(1)`: Variables in the scope of the caller.

```perl
use PadWalker qw(peek_my);

my $x = 10;
my $hash_ref = peek_my(0);
print ${$hash_ref->{'$x'}}; # Prints 10

# Modifying the variable through the pad
${$hash_ref->{'$x'}}++;
print $x; # Prints 11
```

### Inspecting Package Variables (peek_our)
Functions identically to `peek_my` but targets variables declared with `our`.

```perl
our $global_state = "active";
my $h = peek_our(0);
print ${$h->{'$global_state'}};
```

### Analyzing Closures (closed_over)
Use `closed_over($sub_ref)` to identify which lexical variables from outer scopes are captured by a subroutine.

```perl
use PadWalker qw(closed_over);

my $counter = 0;
my $sub = sub { $counter++ };

my $vars = closed_over($sub);
# $vars->{'$counter'} contains a reference to the captured $counter
```

### Identifying Variable Names (var_name)
If you have a reference to a variable and need to know its lexical name within a specific scope or subroutine:

```perl
use PadWalker qw(var_name);

my $target_var;
my $name = var_name(0, \$target_var); # Returns '$target_var'
```

## Expert Tips and Best Practices

1.  **Sigil Inclusion**: Always include the sigil (`$`, `@`, `%`) when accessing the hash keys returned by `peek_my` or `peek_our`.
2.  **Scope Depth**: When using `peek_my(LEVEL)`, ensure the level correctly corresponds to the `caller` stack. Level 0 is the immediate scope, Level 1 is the caller, and so on.
3.  **Production Warning**: Avoid using PadWalker in production logic. It is a high-overhead tool designed for debugging, testing, and development-time introspection.
4.  **Subroutine State**: `peek_sub($sub_ref)` returns variables used in a sub, but values are typically only defined if that subroutine is currently active in the call chain. For static analysis of captures, prefer `closed_over`.
5.  **Variable Shadowing**: If multiple variables with the same name exist in different scopes, `peek_my` returns the one currently in scope at the specified level.

## Reference documentation
- [PadWalker - play with other peoples' lexical variables](./references/metacpan_org_pod_PadWalker.md)