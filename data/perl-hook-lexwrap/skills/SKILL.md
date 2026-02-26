---
name: perl-hook-lexwrap
description: This tool provides a mechanism to wrap Perl subroutines with custom pre- and post-execution code while maintaining the original caller and context information. Use when user asks to wrap Perl subroutines with hooks, add temporary or lexical subroutine wrappers, or modify subroutine arguments and return values transparently.
homepage: https://github.com/karenetheridge/Hook-LexWrap
---


# perl-hook-lexwrap

## Overview

The `perl-hook-lexwrap` skill provides a mechanism to "wrap" existing Perl subroutines with custom code that runs immediately before (`pre`) or after (`post`) the original routine. Unlike simpler wrapping techniques, this tool ensures that the wrapped subroutine still sees the correct `caller` and `wantarray` information, making it transparent to the rest of the application. It supports both global wrapping and lexical wrapping, where the hook is automatically removed when a control object goes out of scope.

## Installation

To install the package via Bioconda:
```bash
conda install bioconda::perl-hook-lexwrap
```

## Core Usage Patterns

### 1. Basic Subroutine Wrapping
Wrap a subroutine by name or typeglob to add logging or side effects.

```perl
use Hook::LexWrap;

# Wrap by name
wrap 'MyPackage::do_work', 
    pre  => sub { print "Starting work with args: @_\n" },
    post => sub { print "Finished work\n" };
```

### 2. Lexical (Temporary) Scoping
If you call `wrap` in a non-void context, it returns an object. The wrapper remains active only as long as that object exists.

```perl
{
    my $temporary_hook = wrap 'calculate_sum',
        pre => sub { print "Calculating...\n" };
    
    calculate_sum(1, 2); # Wrapper is active
} 
# $temporary_hook is destroyed here; calculate_sum is now unwrapped.
```

### 3. Modifying Arguments and Return Values
The wrappers receive an extra argument at the end of `@_` (accessible as `$_[-1]`) which acts as a placeholder for the return value.

*   **In `pre` hooks:** `$_[-1]` is `undef`. Assigning a value to it short-circuits the call; the original subroutine and the `post` hook will not run.
*   **In `post` hooks:** `$_[-1]` contains the return value. In list context, it is an array reference. Assigning to it modifies what the caller receives.

```perl
# Example: Memoization
my %cache;
wrap 'expensive_func',
    pre => sub {
        if (exists $cache{$_[0]}) {
            $_[-1] = $cache{$_[0]}; # Short-circuits original call
        }
    },
    post => sub {
        $cache{$_[0]} = $_[-1]; # Caches the result
    };
```

### 4. Anonymous Wrapping
If you pass a subroutine reference instead of a name, `wrap` returns a new subroutine reference containing the hooks, leaving the original untouched.

```perl
my $original_sub = sub { print "Action" };
my $wrapped_sub = wrap $original_sub, pre => sub { print "Ready... " };

$wrapped_sub->(); # Prints "Ready... Action"
$original_sub->(); # Prints "Action"
```

## Expert Tips and Best Practices

*   **Context Awareness:** Always remember that `$_[-1]` in a `post` hook is an array reference if the subroutine was called in list context. Check `wantarray` if your wrapper needs to handle different return types.
*   **Avoid Recursion:** Be careful when wrapping subroutines that the wrapper itself might call, as this can lead to infinite loops.
*   **Typeglobs vs. Strings:** Use typeglobs (`*sub_name`) for slightly faster lookups if the subroutine is in the current package, but strings (`'Package::sub'`) are generally safer for fully qualified names.
*   **Diagnostics:** If you receive the error `"Can't wrap non-existent subroutine"`, ensure the module containing the target sub is fully loaded (`use` or `require`) before calling `wrap`.

## Reference documentation
- [Hook::LexWrap GitHub Repository](./references/github_com_karenetheridge_Hook-LexWrap.md)
- [Bioconda perl-hook-lexwrap Overview](./references/anaconda_org_channels_bioconda_packages_perl-hook-lexwrap_overview.md)