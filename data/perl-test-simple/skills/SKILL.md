---
name: perl-test-simple
description: This tool facilitates the creation and execution of Perl test suites using the Test::Simple and Test::More frameworks. Use when user asks to write Perl test scripts, compare data structures with is_deeply, manage test plans, or run tests using the prove harness.
homepage: http://metacpan.org/pod/Test-Simple
metadata:
  docker_image: "quay.io/biocontainers/perl-test-simple:1.302190--pl5321hdfd78af_0"
---

# perl-test-simple

## Overview
This skill facilitates the creation of robust Perl test suites. Test::Simple is the foundational utility for Perl testing, providing the basic `ok()` function, while Test::More (included in the same distribution) offers a comprehensive set of testing functions for comparing scalars, arrays, hashes, and regex patterns. Use this skill to structure test files (.t), manage test plans, and interpret TAP (Test Anything Protocol) output.

## Core Testing Patterns

### Basic Test Structure
Every test script should typically reside in the `t/` directory and end in `.t`.
```perl
use strict;
use warnings;
use Test::More; # Test::More is preferred over Test::Simple for most tasks

# Declare how many tests you plan to run
plan tests => 3;

# Or, if the number is unknown:
# use Test::More qw(no_plan); 
# done_testing(); # at the end

ok(1 + 1 == 2, 'Basic addition works');
is(2 + 2, 4, 'is() provides better failure diagnostics than ok()');
like('Perl testing', qr/Perl/, 'Regex matching with like()');

done_testing();
```

### Comparison Functions
*   `is($got, $expected, $name)`: Compares scalars using `eq`.
*   `isnt($got, $expected, $name)`: Opposite of `is`.
*   `is_deeply($got_ref, $expected_ref, $name)`: Recursively compares complex data structures (hashes/arrays).
*   `can_ok($module_or_obj, @methods)`: Verifies that an object or class can perform specific methods.
*   `isa_ok($object, $class)`: Verifies that an object is an instance of a specific class.

### Handling Failures and Skipping
*   **Diagnostics**: Use `diag("Message")` to print comments to the test output (stderr) without affecting test results. Use `note()` for stdout.
*   **Skipping Tests**: Use `SKIP: { ... }` blocks for tests that cannot run in certain environments (e.g., missing dependencies).
    ```perl
    SKIP: {
        skip "OS-specific test", 1 if $^O ne 'linux';
        ok(check_linux_feature(), "Feature works on Linux");
    }
    ```
*   **Todo Tests**: Use `TODO: { ... }` for known bugs you haven't fixed yet.
    ```perl
    TODO: {
        local $TODO = "Feature not implemented yet";
        ok(new_feature(), "New feature works");
    }
    ```

## Execution and Best Practices
*   **Running Tests**: Use `prove` (the standard TAP harness) to run tests.
    *   `prove t/test_file.t` (Run a single file)
    *   `prove -r t/` (Run all tests recursively)
    *   `prove -v t/` (Verbose output)
    *   `prove -l t/` (Include `lib/` in @INC)
*   **Plan Management**: Always prefer `done_testing()` at the end of the script over a hardcoded `plan tests => n` unless the number of tests is strictly deterministic and critical for detecting premature exits.
*   **Module Testing**: When testing a module, use `use_ok('Your::Module')` inside a `BEGIN` block or at the start of the script to ensure the module loads correctly.

## Reference documentation
- [Test::Simple Documentation](./references/metacpan_org_pod_Test-Simple.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-simple_overview.md)