---
name: perl-error
description: The perl-error tool enables structured, object-oriented exception handling in Perl using the Error module. Use when user asks to implement try-catch blocks, throw custom error objects, or manage error cleanup with finally blocks.
homepage: http://metacpan.org/pod/Error
metadata:
  docker_image: "quay.io/biocontainers/perl-error:0.17030--pl5321hdfd78af_0"
---

# perl-error

## Overview
The `perl-error` skill enables the implementation of structured, object-oriented exception handling in Perl. While modern Perl often uses `Try::Tiny` or `Syntax::Keyword::Try`, the `Error` module is a legacy standard found in many bioinformatics and long-standing CPAN distributions. This skill provides the specific "syntactic sugar" patterns required to catch specific error classes, handle cleanup via `finally` blocks, and manage error propagation.

## Procedural Interface (Try/Catch)
To use the procedural "sugar" syntax, you must import the `:try` tag.

```perl
use Error qw(:try);

try {
    # Code that might fail
    if ($problem) {
        throw Error::Simple("A specific error occurred");
    }
}
catch Error::IO with {
    my $E = shift;
    warn "IO Error at " . $E->file . " line " . $E->line;
}
otherwise {
    my $E = shift;
    warn "Catch-all for other errors: $E";
}
finally {
    # Cleanup code always runs
    $obj->close() if defined $obj;
}; # Note: The trailing semicolon is mandatory
```

## Class Interface and Throwing
Errors should generally be thrown as objects. `Error::Simple` is the default provided class for basic string-based errors.

- **Throwing**: `throw Error::Simple("message", $error_code);`
- **Recording**: `record Error::Simple("message") and return;` (Sets the internal "last error" without jumping out of execution).
- **Custom Classes**: Inherit from `Error` to create specific exception types for `catch` blocks to filter.

## Best Practices and Constraints
- **The Semicolon**: Always place a semicolon `;` after the closing brace of the `finally` or `otherwise` block. Failure to do so causes difficult-to-debug parsing errors.
- **Moose Conflict**: If using `Moose`, the `with` keyword will conflict. Use the fully qualified name or handle the import carefully.
- **Variable Access**: The error object is passed as the first argument to `catch` and `otherwise` blocks, and is also available in `$@`.
- **Nested Try**: `try` blocks can be nested. To re-throw an error from a catch block, call `$E->throw()`.

## Pre-defined Error Classes
- `Error::Simple`: Basic error taking a string and an optional value.
- `Error`: The base class. Do not throw this directly; use a subclass.

## Reference documentation
- [Error - Error/exception handling in an OO-ish way](./references/metacpan_org_pod_Error.md)
- [perl-error Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-error_overview.md)