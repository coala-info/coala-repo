---
name: perl-carp-clan
description: This Perl module reports errors from the perspective of the caller of a group of related modules rather than the immediate internal caller. Use when user asks to improve error reporting in multi-module systems, hide internal module complexity in stack traces, or treat a namespace of modules as a single entity for debugging.
homepage: http://metacpan.org/pod/Carp::Clan
metadata:
  docker_image: "quay.io/biocontainers/perl-carp-clan:6.08--pl5321hdfd78af_0"
---

# perl-carp-clan

## Overview

`Carp::Clan` is a specialized Perl module designed to improve error reporting in complex, multi-module systems. While the standard `Carp` module reports errors from the perspective of the immediate caller, `Carp::Clan` allows a group of related modules to be treated as a single entity. When an error occurs deep within the "clan," the message points back to the user's script that initiated the call, hiding the internal complexity of the module suite.

## Usage Patterns

### Basic Implementation
To make a module report errors from the perspective of its caller (standard `Carp` behavior but using the Clan engine):

```perl
use Carp::Clan;

sub my_function {
    my $arg = shift;
    croak "Invalid argument" unless defined $arg;
}
```

### Defining a Clan
To treat a group of modules (e.g., `MyProject::API`, `MyProject::Internal`, `MyProject::Utils`) as a single block, use a regex pattern in the import statement. This tells the module to skip any stack frames matching the pattern.

```perl
# In all modules within the MyProject::* namespace
use Carp::Clan qw(^MyProject::);

sub internal_task {
    # If this dies, the error is reported at the line in the user's 
    # script that called into the MyProject suite.
    croak "Internal consistency error"; 
}
```

### Available Functions
The module exports the same functional interface as `Carp`:

- `carp`: Non-fatal warning from the perspective of the caller.
- `cluck`: Non-fatal warning with a full stack backtrace.
- `croak`: Fatal error (die) from the perspective of the caller.
- `confess`: Fatal error (die) with a full stack backtrace.

### Debugging and Verbosity
You can force a full stack trace (transforming `croak` to `confess` and `carp` to `cluck`) for debugging purposes without changing the code logic.

**Via Import:**
```perl
use Carp::Clan qw(^MyClan:: verbose);
```

**Via Global Variable:**
```perl
$Carp::Clan::Verbose = 1;
```

## Best Practices

- **Consistency**: Ensure every module in your distribution uses the same regex pattern to maintain the "monolithic" error reporting illusion.
- **Regex Precision**: Use anchors in your regex (e.g., `^MyClan::`) to avoid accidentally skipping unrelated modules that might contain your clan name in their string.
- **Exception Objects**: Note that `Carp::Clan` does not currently handle exception objects. If passed a reference, it will revert to standard `die()` or `warn()` behavior.
- **Performance**: While slightly heavier than standard `Carp`, the overhead is negligible for error paths. Use it freely in API-facing modules.

## Reference documentation
- [Carp::Clan - Report errors from perspective of caller of a "clan" of modules](./references/metacpan_org_pod_Carp__Clan.md)