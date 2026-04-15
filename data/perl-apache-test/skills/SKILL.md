---
name: perl-apache-test
description: perl-apache-test provides a framework for writing and running unit tests that interact with a live Apache web server. Use when user asks to run Apache-specific Perl tests, automate server configuration for testing, or conditionally skip tests based on available Apache modules and versions.
homepage: http://metacpan.org/pod/Apache::Test
metadata:
  docker_image: "quay.io/biocontainers/perl-apache-test:1.43--pl5321hdfd78af_0"
---

# perl-apache-test

## Overview
`perl-apache-test` (centered around the `Apache::Test` module) is a robust testing framework that wraps the standard Perl `Test.pm` module to provide Apache-specific functionality. It allows developers to write unit tests that interact with a running Apache instance. The tool handles the complexities of starting and stopping the server, generating configuration files, and skipping tests based on the presence or absence of specific Apache modules or versions.

## Installation
To install the package via Conda:
```bash
conda install bioconda::perl-apache-test
```

## Common CLI Patterns
The primary entry point for running tests is usually a script named `TEST` located in the `t/` directory of a distribution.

- **Run all tests**:
  ```bash
  ./t/TEST
  ```
- **Run tests with verbose output**:
  ```bash
  ./t/TEST -v
  ```
- **Run specific sub-tests**:
  If the tests use the `sok()` function, you can run specific numbered sub-tests:
  ```bash
  ./t/TEST -v skip_subtest 1 3
  ```
  *This runs only the first and third sub-tests.*

## Expert Testing Patterns

### Conditional Planning
Use the extended `plan` function to automatically skip tests if the environment does not meet specific requirements.

```perl
use Apache::Test;
# Require Apache 2.0.40 or higher and mod_ssl
plan tests => 5, need_min_apache_version("2.0.40"), need_module('mod_ssl.c');
```

### Requirement Checking: `need_*` vs `have_*`
- **`need_*` functions**: Use these inside `plan()` to skip the entire test file with a descriptive message if the requirement is not met.
- **`have_*` functions**: Use these inside your test logic (if/else) to adjust expectations or behavior without skipping the whole test.

### Common Requirement Helpers
- `need_http11`: Requires HTTP/1.1 support.
- `need_ssl`: Requires SSL support.
- `need_cgi`: Requires `mod_cgi` or `mod_cgid`.
- `need_apache_mpm('prefork')`: Requires a specific Multi-Processing Module.
- `need_perl 'ithreads'`: Requires Perl compiled with thread support.

### Using `sok` for Granular Control
Instead of standard `ok()`, use `sok()` to allow users to select specific sub-tests from the command line:
```perl
sok { 
    my $result = perform_check();
    $result == 1;
};
```

## Best Practices
1. **Module Naming**: When using `need_module()`, use the `.c` extension (e.g., `mod_env.c`) to be explicit about the C module requirement and avoid confusion with Perl modules of the same name.
2. **Request Objects**: If you pass an `Apache::RequestRec` object as the first argument to `plan`, STDOUT is automatically tied to it, which is useful for testing handlers directly.
3. **Refreshing State**: If you must call `plan` multiple times in a single process, use `Apache::Test::test_pm_refresh()` to reset the global state of `Test.pm`.

## Reference documentation
- [Apache::Test - Test.pm wrapper with helpers for testing Apache](./references/metacpan_org_pod_Apache__Test.md)
- [perl-apache-test - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-apache-test_overview.md)