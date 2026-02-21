---
name: perl-carp
description: The perl-carp skill (specifically for the Raku implementation of Perl's Carp) allows developers to report errors from the caller's perspective.
homepage: https://github.com/alabamenhu/Carp
---

# perl-carp

## Overview
The perl-carp skill (specifically for the Raku implementation of Perl's Carp) allows developers to report errors from the caller's perspective. This is a critical practice when writing modules; it ensures that when a user provides invalid input to a library function, the resulting error message points to the line in the user's code where the function was called, rather than a line deep within the library's internal implementation.

## Usage Patterns

### Importing Routines
By default, only the `carp` routine is imported. Use named arguments to import additional functionality:

```raku
use Carp;                   # Imports only carp
use Carp :cluck;            # Imports carp and cluck
use Carp :croak, :confess;  # Imports carp, croak, and confess
use Carp :all;              # Imports all four routines
use Carp :X;                # Imports exceptions for CATCH blocks
```

### Routine Selection Matrix
Choose the routine based on whether the program should continue and how much detail is required:

| Routine | Action | Trace Level |
| :--- | :--- | :--- |
| **carp** | Warns | Single line (caller site) |
| **cluck** | Warns | Full backtrace |
| **croak** | Dies | Single line (caller site) |
| **confess** | Dies | Full backtrace |

### Configuration Options
Pass positional parameters during import to modify behavior:

*   **'block'**: Identifies the specific sub or method where the error occurred rather than reporting an unnamed block.
*   **'ofun'**: Enables "O(fun)" mode, which replaces standard text prefixes with Unicode emojis (e.g., 🐟 for carp, 🐔 for cluck, 🐸 for croak).

```raku
use Carp :all, <block ofun>; # Enable all routines and options
```

## Expert Tips and Best Practices

*   **Module Development**: Always prefer `croak` over `die` and `carp` over `warn` inside library modules to provide a better developer experience for your module's users.
*   **Resuming from Errors**: Since `croak` and `confess` throw exceptions, they can be handled in a `CATCH` block. Use `.resume` if recovery is possible after a `croak`.
*   **Contextual Clarity**: Use the `block` option when your code involves many nested blocks or anonymous routines to ensure the error report points to a meaningful named container (sub or method).
*   **Debugging Complex State**: Use `cluck` or `confess` when the error is likely the result of a complex call chain where the immediate caller site isn't enough to diagnose the root cause.

## Reference documentation
- [Carp README](./references/github_com_alabamenhu_Carp.md)