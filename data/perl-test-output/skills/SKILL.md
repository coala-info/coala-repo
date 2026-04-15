---
name: perl-test-output
description: This tool validates data printed to standard output and error streams within Perl applications. Use when user asks to test STDOUT or STDERR, verify terminal output with regular expressions, or capture output from Perl subroutines and external commands.
homepage: https://github.com/briandfoy/test-output
metadata:
  docker_image: "quay.io/biocontainers/perl-test-output:1.031--pl526_0"
---

# perl-test-output

## Overview

The `perl-test-output` skill focuses on the `Test::Output` Perl module, a specialized utility for validating data printed to standard output streams. This tool is essential for unit testing CLI applications, logging functions, or any procedural code where the primary side effect is terminal output rather than a returned value. It allows developers to capture output from specific blocks of code and compare them against strings or regular expressions without manually redirecting filehandles.

## Installation

Install the package via Bioconda or standard Perl CPAN clients:

```bash
# Via Conda
conda install bioconda::perl-test-output

# Via CPAN
cpanm Test::Output
```

## Core Usage Patterns

The module provides several functions to test different output scenarios. All functions typically take a block of code (wrapped in braces) as their first argument.

### Testing STDOUT
Use `stdout_is` for exact string matches and `stdout_like` for regular expression validation.

```perl
use Test::More;
use Test::Output;

# Exact match
stdout_is { print "Hello World" } "Hello World", "Prints greeting to STDOUT";

# Regex match
stdout_like { print "User ID: 123" } qr/User ID: \d+/, "Output contains a numeric ID";
```

### Testing STDERR
Use `stderr_is` and `stderr_like` to verify error messages or warnings.

```perl
# Exact match on error
stderr_is { warn "Access Denied" } "Access Denied\n", "Warning matches exactly";

# Regex match on error
stderr_like { warn "Error at line 50" } qr/Error at line \d+/, "Error message format is correct";
```

### Combined and Split Output
For complex interactions, you can test both streams simultaneously.

```perl
# Test STDOUT and STDERR at once
output_is { print "out"; warn "err" } "out", "err\n", "Both streams match";

# Test combined output (STDOUT and STDERR merged)
combined_is { print "out"; warn "err" } "outerr\n", "Combined streams match";
```

## Expert Tips and Best Practices

- **Newline Sensitivity**: `Test::Output` is sensitive to trailing newlines. If your code uses `say` or appends `\n`, ensure your expected string includes it, or use `stdout_like` with a regex to avoid strict whitespace matching.
- **Capturing External Commands**: To test the output of a system command, wrap the `system` call or backticks in the block:
  ```perl
  stdout_is { system("echo 'test'") } "test\n", "External echo works";
  ```
- **Testing Subroutines**: Pass a subroutine reference or an anonymous sub to the test function to keep test files clean:
  ```perl
  stdout_is \&my_function, "expected output", "Function prints correctly";
  ```
- **Suppression**: If you want to verify that a function produces *no* output, use an empty string:
  ```perl
  stdout_is { silent_function() } "", "Function is truly silent";
  ```
- **Running Tests**: Always execute your test scripts using `prove` to ensure the environment is set up correctly:
  ```bash
  prove -l t/my_test.t
  ```

## Reference documentation

- [perl-test-output - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-test-output_overview.md)
- [GitHub - briandfoy/test-output: Utilities to test STDOUT and STDERR messages.](./references/github_com_briandfoy_test-output.md)