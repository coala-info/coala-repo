---
name: perl-test2-plugin-nowarnings
description: This tool monitors Perl Test2 execution and treats any emitted warnings as test failures. Use when user asks to fail tests on warnings, enforce a zero-tolerance warning policy, or detect unexpected STDERR output during testing.
homepage: https://metacpan.org/release/Test2-Plugin-NoWarnings
---


# perl-test2-plugin-nowarnings

## Overview
This plugin integrates with the Perl `Test2` testing framework to automatically monitor for warnings during test execution. By default, Perl tests may pass even if the code under test emits warnings to STDERR. This tool changes that behavior by treating any warning as a test failure, ensuring a higher standard of code quality and preventing "noisy" test outputs from hiding real issues.

## Usage Patterns

### Basic Integration
To enable global warning detection in a test script, load the module at the start of your `.t` file:

```perl
use Test2::V0;
use Test2::Plugin::NoWarnings;

# Your tests here
ok(1, 'test passes');
warn "This will cause the test to fail";
done_testing;
```

### Scope Control
If you have specific blocks of code where warnings are expected or unavoidable, use `Test2::API::intercept` or standard Perl warning masking within a localized scope, though the plugin is generally designed to be a global "zero-tolerance" check.

### Best Practices
- **Load Order**: Always load `Test2::Plugin::NoWarnings` early in the test script to ensure it captures warnings emitted during the setup phase of other modules.
- **CI/CD Integration**: Use this plugin in continuous integration environments to enforce a "no-warning" policy across the codebase.
- **Debugging**: When a test fails due to a warning, the plugin provides the warning message and the line number where it originated, making it easier to trace the source of the issue.

## Expert Tips
- **Compatibility**: This plugin is specifically designed for the `Test2` ecosystem. If you are using the older `Test::More` (Test::Builder), ensure you are using the `Test2::V0` bundle or appropriate compatibility layers.
- **Selective Disabling**: If a specific test file must allow warnings, simply omit the `use Test2::Plugin::NoWarnings;` line for that file rather than trying to disable it globally.

## Reference documentation
- [Test2::Plugin::NoWarnings Documentation](./references/metacpan_org_release_Test2-Plugin-NoWarnings.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test2-plugin-nowarnings_overview.md)