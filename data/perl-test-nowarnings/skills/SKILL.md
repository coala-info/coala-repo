---
name: perl-test-nowarnings
description: This Perl testing utility captures warnings emitted during test execution and adds a final test case to ensure no unexpected warnings occurred. Use when user asks to validate that a test suite runs without warnings, integrate warning checks into fixed or dynamic test plans, or debug the source of unexpected warnings using stack traces.
homepage: https://metacpan.org/pod/Test::NoWarnings
---


# perl-test-nowarnings

## Overview
`Test::NoWarnings` is a Perl testing utility that captures all warnings emitted during the execution of a test script. Instead of allowing warnings to clutter STDERR, it stores them and automatically adds a final test case to your suite. If any warnings occurred, this final test fails and provides a detailed stack trace to help locate the source of the noise. This skill helps you integrate warning validation into various test plan configurations (fixed plans, no_plan, or `done_testing`).

## Integration Patterns

### 1. Scripts with a Fixed Test Plan
When you have a specific number of tests defined, you must increment your test count by 1 to account for the check performed by `Test::NoWarnings`.
```perl
use Test::More tests => 4; # Original count was 3
use Test::NoWarnings;

ok(1, "test one");
ok(1, "test two");
ok(1, "test three");
# Test::NoWarnings automatically runs the 4th test here
```

### 2. Scripts using done_testing
If you do not use a plan and rely on `done_testing`, you must manually call `had_no_warnings` before the end of the script.
```perl
use Test::More;
use Test::NoWarnings 'had_no_warnings';

# ... your tests ...

had_no_warnings;
done_testing;
```

### 3. Scripts with no_plan
For simple scripts using `no_plan`, no manual adjustment is needed.
```perl
use Test::More 'no_plan';
use Test::NoWarnings;
```

## Expert Tips & Debugging

### Immediate Feedback with :early
By default, warnings are only reported at the very end of the test script. If you are debugging a complex test and need to know exactly when a warning occurs, use the `:early` pragma:
```perl
use Test::NoWarnings ':early';
```
*Note: This is recommended for debugging only, as it attributes the warning to the previous successful test.*

### Handling Expected Warnings
If a specific piece of code is *expected* to warn, do not let `Test::NoWarnings` catch it. Use `Test::Warn` to trap and verify the expected warning so that `Test::NoWarnings` remains "clean":
```perl
use Test::More;
use Test::NoWarnings;
use Test::Warn;

warning_like { some_legacy_code() } qr/deprecated/, "Caught expected warning";
```

### Clearing Warnings
In complex setup/teardown scenarios, you can clear the internal warning accumulator to ignore warnings generated during specific phases:
```perl
clear_warnings(); # Resets the warning counter to zero
```

## Pitfalls
- **$SIG{__WARN__} Conflicts**: This module works by localized overriding of the warning signal. If other modules (like `Carp::Always`) also manipulate `%SIG`, `Test::NoWarnings` may fail to report issues.
- **Forking**: The automatic END block check does not trigger in forked child processes.

## Reference documentation
- [Test::NoWarnings - MetaCPAN](./references/metacpan_org_pod_Test__NoWarnings.md)