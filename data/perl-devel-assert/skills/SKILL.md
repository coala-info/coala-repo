---
name: perl-devel-assert
description: This tool provides a mechanism for embedding zero-cost assertions into Perl code that are optimized away during production. Use when user asks to embed assertions in Perl, enable development-time safety checks, or verify code assumptions without incurring a runtime penalty.
homepage: http://metacpan.org/pod/Devel::Assert
metadata:
  docker_image: "quay.io/biocontainers/perl-devel-assert:1.06--pl526h470a237_0"
---

# perl-devel-assert

## Overview
The `perl-devel-assert` skill provides a mechanism for embedding zero-cost assertions into Perl code. Unlike standard conditional checks, these assertions are optimized away by the Perl optree manipulator when disabled, ensuring that development-time safety checks do not incur a runtime penalty in production environments. This tool is particularly useful for verifying assumptions about variable states, reference types, and function arguments.

## Usage Patterns

### Basic Assertion
Import the `assert` function. By default, assertions are disabled (release mode).
```perl
use Devel::Assert;
assert($x > 0); # Does nothing in release mode
```

### Enabling Assertions
To activate checks during development or testing, pass the 'on' flag.
```perl
use Devel::Assert 'on';
assert(ref($callback) eq 'CODE'); # Dies with 'confess' if false
```

### Global Activation
To enable assertions across all modules in a project without modifying every file, use the 'global' mode or the command-line switch.
```perl
# In the main script
use Devel::Assert 'global';

# Or via command line
perl -MDevel::Assert::Global your_script.pl
```

### Explicit Deactivation
Force assertions to stay off even if a global 'on' state is requested elsewhere.
```perl
use Devel::Assert 'off';
```

## Best Practices
- **Contract Validation**: Use assertions at the beginning of subroutines to verify that arguments meet expected criteria (e.g., `assert scalar @_ == 2`).
- **Performance**: Since `Devel::Assert` manipulates the optree rather than using source filters, it is safe to use complex expressions inside `assert()`; they will be completely removed in production.
- **Debugging**: Failed assertions provide a full stack trace via `Carp::confess`, including the literal string of the failed code, making it easier to locate the logic error.
- **Compatibility**: Ensure the environment is running Perl 5.14 or higher, as the module relies on modern optree analysis.

## Reference documentation
- [Devel::Assert - assertions for Perl >= 5.14](./references/metacpan_org_pod_Devel__Assert.md)
- [bioconda perl-devel-assert overview](./references/anaconda_org_channels_bioconda_packages_perl-devel-assert_overview.md)