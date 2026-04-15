---
name: perl-test-taint
description: perl-test-taint provides a framework for verifying Perl's taint-checking mechanism and data security state within unit tests. Use when user asks to verify if data is tainted, assert that variables have been properly sanitized, or simulate untrusted input in Perl scripts.
homepage: https://metacpan.org/pod/Test::Taint
metadata:
  docker_image: "quay.io/biocontainers/perl-test-taint:1.08--pl5321h7b50bb2_1"
---

# perl-test-taint

## Overview
The `perl-test-taint` skill provides a framework for verifying Perl's taint-checking mechanism within unit tests. It is used to ensure that data coming from potentially unsafe sources—such as command-line arguments, environment variables, or web inputs—is properly handled and sanitized before being used in "unsafe" operations. This skill is essential for developers building secure Perl applications who need to programmatically assert the security state of their data structures.

## Core Functions and Usage

### Enabling Taint Mode
For any of these tests to function, Perl must be running in taint mode. This is typically achieved by adding the `-T` flag to the shebang line or the command line execution.
```perl
# Run tests with taint mode enabled
perl -T t/security_tests.t
```

### Essential Test Assertions
Use these functions within your `.t` files to validate data state:

*   **`taint_checking_ok()`**: Verifies that the `-T` flag is actually active. This should be the first test in any taint-related test suite.
*   **`tainted_ok($var, $msg)`**: Asserts that a specific variable is currently tainted.
*   **`untainted_ok($var, $msg)`**: Asserts that a variable has been successfully untainted (usually after a regex match or validation routine).
*   **`tainted_ok_deeply($ref)`**: Recursively checks a hash or array reference to ensure every nested element is tainted.

### Simulating Untrusted Input
To test your validation logic, you often need to "poison" data manually:

*   **`taint(@list)`**: Marks the provided scalars as tainted. This allows you to simulate data coming from a web form or database without actually needing an external source.
*   **`taint_deeply(@list)`**: Recursively taints entire data structures.

## Expert Tips and Best Practices

*   **The Taint-Check First Rule**: Always call `taint_checking_ok()` at the start of your test script. If taint mode isn't on, all subsequent `tainted_ok` tests will fail, and `untainted_ok` will pass falsely.
*   **Testing Validation Logic**: To properly test a validation function, take a clean string, use `taint($string)`, pass it to your function, and then use `untainted_ok($result)` to verify the function actually cleaned the data.
*   **Environment Variables**: Remember that `%ENV` is a primary source of tainted data. Use `tainted_ok_deeply(\%ENV)` to verify your environment is correctly restricted.
*   **References vs. Values**: Note that while you can taint a reference, it is usually the underlying scalar value that carries the taint. Use the `_deeply` variants when working with complex objects or JSON-decoded data.

## Reference documentation
- [Test::Taint - Tools to test taintedness](./references/metacpan_org_pod_Test__Taint.md)
- [perl-test-taint Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-taint_overview.md)