---
name: perl-test-warn
description: This Perl module provides functions to test whether specific code blocks emit, or do not emit, warnings during execution. Use when user asks to validate warning messages, check for API deprecations, or ensure code blocks are warning-free.
homepage: http://metacpan.org/pod/Test-Warn
metadata:
  docker_image: "quay.io/biocontainers/perl-test-warn:0.36--pl526_0"
---

# perl-test-warn

## Overview
The `Test::Warn` Perl module extends the standard `Test::More` framework, allowing developers to treat warnings as testable events. This skill facilitates the validation of API deprecations, error handling paths, and data validation logic that triggers `warn()` calls. It is essential for maintaining code quality in Perl projects where silent failures or unexpected noise in STDERR must be prevented.

## Core Testing Functions
Use these functions within your `.t` files to intercept and validate warnings:

- `warning_is { code } "expected warning", "test name";`
  Tests if the code emits exactly one warning that matches the string exactly.
- `warning_like { code } qr/pattern/, "test name";`
  Tests if the code emits exactly one warning that matches the provided regular expression.
- `warnings_exist { code } [ qr/warn1/, qr/warn2/ ], "test name";`
  Tests if the code emits the specific list of warnings provided in the array reference.
- `warnings_are { code } ["warn1", "warn2"], "test name";`
  Tests if the code emits exactly the warnings listed, in the correct order.
- `warning_free { code } "test name";`
  Asserts that the block of code produces no warnings at all.

## Advanced Matching and Categories
For complex scenarios, use category-based testing:

- **Category Testing**: You can check for specific Perl warning categories (e.g., 'void', 'io', 'deprecated').
  `warnings_exist { code } ["void"], "Check for void context warning";`
- **Carps and Croaks**: To test warnings generated via `Carp`, use the specific `carp` or `cluck` targets if the module version supports it, though standard string/regex matching on the output is the most robust cross-version approach.

## Best Practices
- **Scope**: Always wrap the specific line of code likely to warn in the `{}` block to avoid catching unrelated warnings from setup or teardown logic.
- **Regex Precision**: When using `warning_like`, use anchors (`^` and `$`) if you want to ensure no extra text is present in the warning string.
- **Integration**: Combine with `Test::More`. Ensure `use Test::More;` and `use Test::Warn;` are at the top of your test script.
- **Diagnostics**: If a test fails, `Test::Warn` provides the actual warning received versus the expected one in the TAP output, making it easier to debug unexpected stack traces.

## Reference documentation
- [Test::Warn - Perl extension to test methods for warnings](./references/metacpan_org_pod_Test-Warn.md)
- [Bioconda perl-test-warn Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-warn_overview.md)