---
name: perl-try-tiny
description: Try::Tiny provides a minimal, dependency-free syntax for exception handling in Perl.
homepage: https://github.com/karenetheridge/Try-Tiny
---

# perl-try-tiny

## Overview
Try::Tiny provides a minimal, dependency-free syntax for exception handling in Perl. While Perl's native `eval` is often used for this purpose, it is prone to "clobbering" the global error variable `$@` if inner blocks or destructors run during the error-handling phase. This skill helps you implement `try`, `catch`, and `finally` blocks that correctly localize errors and maintain a clean call stack.

## Usage Patterns

### Basic Try/Catch
Use this pattern to handle exceptions without manually checking `$@`. The error is automatically passed into the `catch` block via `$_`.

```perl
use Try::Tiny;

try {
    # Code that might die
    die "Critical failure";
} catch {
    warn "Caught error: $_"; # $_ contains the error message/object
};
```

### Using Finally for Cleanup
The `finally` block always executes, regardless of whether an error occurred. It is ideal for closing filehandles or database connections. Note that `finally` receives the error in `@_` rather than `$_`.

```perl
try {
    open my $fh, '<', $file or die $!;
    # Process file
} catch {
    warn "Error processing file: $_";
} finally {
    my $error = shift;
    if ($error) {
        print "Cleaned up after error: $error";
    }
    # Cleanup logic here
};
```

### Returning Values
`try` blocks return the value of the last statement executed. If an error occurs, the value of the last statement in the `catch` block is returned.

```perl
my $result = try {
    return_something_risky();
} catch {
    "default_value";
};
```

## Best Practices
- **Semicolons**: Always end the `try` / `catch` / `finally` chain with a semicolon (`;`). Since these are functions, not native keywords, the semicolon is syntactically required.
- **Localization**: Inside a `catch` block, the previous value of `$@` is preserved. If you are using an exception class that inspects `$@` (like `Class::Throwable`), you may need to manually assign `local $@ = $_;` inside the catch block.
- **Avoid 'return' for Flow Control**: Do not use `return` to exit the parent subroutine from inside a `try` block. Because `try` uses anonymous subroutines, `return` will only exit the `try` block itself.
- **Implicit Catch**: If you use `finally` without a `catch` block, exceptions will be suppressed (similar to a standalone `eval`). Always include a `catch` block if you need to log or handle the failure.

## Reference documentation
- [Try::Tiny GitHub Repository](./references/github_com_p5sagit_Try-Tiny.md)
- [Bioconda Perl-Try-Tiny Package](./references/anaconda_org_channels_bioconda_packages_perl-try-tiny_overview.md)