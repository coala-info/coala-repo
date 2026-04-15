---
name: perl-test-most
description: This tool provides a unified interface for common Perl testing modules to reduce boilerplate and manage test failure behavior. Use when user asks to streamline unit testing, perform deep data structure comparisons, handle exceptions in tests, or stop test execution upon the first failure.
homepage: http://metacpan.org/pod/Test-Most
metadata:
  docker_image: "quay.io/biocontainers/perl-test-most:0.38--pl5321hdfd78af_0"
---

# perl-test-most

## Overview
This skill facilitates the use of `Test::Most`, a "greatest hits" collection of Perl testing modules. It is designed to reduce boilerplate in test files by importing standard testing functions automatically and providing global control over test behavior, such as "die on fail" logic. Use this to streamline unit testing and ensure deep data structure validation or exception handling is available without multiple `use` statements.

## Core Usage Patterns

### Boilerplate Reduction
Instead of loading multiple modules, use a single line to initialize the environment:
```perl
use Test::Most tests => 42; # Includes Test::More, Test::Deep, Test::Exception, etc.
```
If the number of tests is unknown:
```perl
use Test::Most 'no_plan';
```

### Failure Control
`Test::Most` allows you to stop execution immediately upon the first failure, which is critical for long-running test suites where subsequent tests depend on earlier ones.

- **Bail on failure**: `use Test::Most 'die';` (Stops the current test file on failure).
- **Global Bail out**: `use Test::Most 'bail';` (Stops the entire test run via `BAIL_OUT` on failure).

### Integrated Testing Functions
The following functions are available by default:
- **Deep Comparisons**: `cmp_deeply($got, $expected, $name)` for nested arrays/hashes.
- **Exception Handling**: `throws_ok { code } qr/expected error/, $name` and `lives_ok { code } $name`.
- **Warning Testing**: `warnings_exist { code } [qr/warn1/, qr/warn2/]`.
- **Difference Highlighting**: `eq_or_diff($got, $expected)` (via `Test::Differences`).

## Expert Tips
- **Deferred Plans**: If you need to calculate the plan at runtime, use `use Test::Most;` and call `plan tests => $count;` later in the script.
- **Excluding Modules**: If a specific bundled module conflicts with your code, you can exclude it: `use Test::Most qw(!throw_ok);`.
- **Always use `explain`**: Use `explain $data_structure` to produce human-readable output of complex variables during test failures; `Test::Most` ensures this is available.

## Reference documentation
- [Test::Most Documentation](./references/metacpan_org_pod_Test-Most.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-most_overview.md)