---
name: perl-test-warnings
description: This module monitors and tests for Perl warnings during test execution to ensure no unexpected warnings are emitted. Use when user asks to test for unexpected warnings, capture specific warnings for inspection, or allow certain warning patterns in Perl test scripts.
homepage: https://github.com/karenetheridge/Test-Warnings
metadata:
  docker_image: "quay.io/biocontainers/perl-test-warnings:0.031--pl5321hdfd78af_0"
---

# perl-test-warnings

## Overview

The `Test::Warnings` module provides a streamlined way to monitor Perl warnings during test execution. Unlike older modules, it hooks into the end of the test process (via `done_testing` or an `END` block) to automatically verify that no unexpected warnings were emitted. This prevents the common TAP (Test Anything Protocol) errors where the test count is calculated before the final warning check. It also provides functional tools to capture and inspect specific warnings as part of your test logic.

## Core Usage Patterns

### Basic Integration
To automatically add a "no unexpected warnings" test to your script, simply include the module. It works seamlessly with or without a pre-declared test plan.

```perl
use Test::More;
use Test::Warnings;

pass('Primary logic works');
# An implicit 'ok - no (unexpected) warnings' test is run here
done_testing;
```

### Capturing Specific Warnings
If you expect a block of code to warn, use the `warning` or `warnings` functions. These capture warnings and prevent them from triggering the end-of-test failure.

*   **`warning { ... }`**: Returns the single warning produced (or an arrayref if multiple occurred).
*   **`warnings { ... }`**: Returns a list of all warnings produced.

```perl
use Test::More;
use Test::Warnings ':all';

# Testing for a single expected warning
like(
    warning { warn "system offline" },
    qr/system offline/,
    "Caught the expected system warning"
);

# Testing for multiple warnings
is_deeply(
    [ warnings { warn "first"; warn "second" } ],
    [ "first at my_test.t line 10.\n", "second at my_test.t line 10.\n" ],
    "Caught both warnings"
);
```

## Advanced Configuration

### Import Options
Control the behavior of the module during the `use` statement:

*   **`:all`**: Imports all available functions (`warning`, `warnings`, `allow_warnings`, etc.).
*   **`:fail_on_warning`**: Causes the test to fail immediately when a warning occurs, rather than waiting until the end of the script. This is highly recommended for debugging.
*   **`:no_end_test`**: Prevents the automatic "no warnings" test from being added at the end. Use this if you only want the capture functions.
*   **`:report_warnings`**: Ensures warning content is printed even if other capture modules (like `Capture::Tiny`) are active.

### Managing Allowed Warnings
You can whitelist specific warnings globally or within a lexical scope to prevent them from failing the test.

```perl
use Test::Warnings qw(allow_patterns);

# Globally allow a specific pattern
allow_patterns(qr/Deprecated function XYZ/);

{
    # Temporarily allow a pattern in this scope only
    my $scope = allow_patterns(qr/Temporary filesystem lag/);
    perform_unstable_io();
}
```

## Expert Tips

1.  **Debugging Surprise Warnings**: If a test is failing at the very end with an "unexpected warning" but you can't find where it's coming from, add `:fail_on_warning` to your `use` statement. This will make the test fail at the exact line where the warning is generated.
2.  **Manual Checks**: You can call `had_no_warnings("test name")` at any point in your script to verify the state of the warning accumulator mid-test.
3.  **Replacement Strategy**: If you are migrating from `Test::NoWarnings`, you can safely perform a global search and replace. `Test::Warnings` is more compatible with modern `Test2` and `Test::More` workflows.

## Reference documentation
- [Test::Warnings GitHub Repository](./references/github_com_karenetheridge_Test-Warnings.md)
- [Bioconda perl-test-warnings Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-warnings_overview.md)