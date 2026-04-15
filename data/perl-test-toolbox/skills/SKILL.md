---
name: perl-test-toolbox
description: This tool provides a collection of streamlined utilities for performing unit tests and data validation in Perl scripts. Use when user asks to run unit tests, perform deep comparisons of data structures, check for strings within lists, or validate regex matches in Perl.
homepage: http://metacpan.org/pod/Test::Toolbox
metadata:
  docker_image: "quay.io/biocontainers/perl-test-toolbox:0.4--pl526_1"
---

# perl-test-toolbox

## Overview
The `perl-test-toolbox` provides a streamlined set of utilities for Perl developers to conduct unit testing. Unlike standard testing modules that can be verbose, this tool focuses on "toolbox" functions that handle common edge cases—like checking if a string exists within any element of a list or performing deep comparisons—with minimal boilerplate. It is ideal for legacy Perl projects or scripts where quick, reliable validation of data structures and output is required.

## Usage Patterns

### Core Testing Functions
Use these functions within your `.t` Perl scripts to validate logic:

- **rt($success, $name)**: The primary "run test" function. Pass a boolean and a description.
- **is_deeply_toolbox($got, $expected, $name)**: Use for comparing nested hashes or arrays. It provides cleaner failure output than some standard library equivalents.
- **has_string($list_ref, $search_string, $name)**: Efficiently checks if `$search_string` exists within any element of the array referenced by `$list_ref`.
- **matches($string, $regex, $name)**: A wrapper for regex validation that integrates directly with the test counter.

### Managing Test State
- **collapse_whitespace($string)**: Use this to normalize strings before comparison, especially when testing HTML or multi-line log output.
- **Test Verbosity**: Control output by setting the `TEST_VERBOSE` environment variable or using the module's internal configuration to suppress non-failure messages.

### Best Practices
- **Initialization**: Always start your test script with `use Test::Toolbox;` and end with `done_testing();` (if using modern Test::More integration) or ensure your plan is explicitly stated.
- **Data Cleaning**: Use the toolbox's string manipulation utilities to clean "dirty" data from files or APIs before running assertions to prevent false negatives caused by hidden characters.
- **Logical Grouping**: Group related `rt()` calls to test specific sub-routines, using the `$name` parameter to provide a clear audit trail in the TAP (Test Anything Protocol) output.

## Reference documentation
- [Test::Toolbox Documentation](./references/metacpan_org_pod_Test__Toolbox.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-toolbox_overview.md)