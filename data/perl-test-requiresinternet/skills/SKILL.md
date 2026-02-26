---
name: perl-test-requiresinternet
description: This tool verifies network connectivity in Perl test suites to skip tests when internet access is unavailable. Use when user asks to check for internet access in Perl scripts, skip tests if the network is down, or verify connectivity to specific hosts and ports during testing.
homepage: https://metacpan.org/dist/Test-RequiresInternet
---


# perl-test-requiresinternet

## Overview

The `perl-test-requiresinternet` skill focuses on the `Test::RequiresInternet` Perl module, a utility used to verify network connectivity before executing test suites. In many build environments—such as Bioconda, Debian buildds, or restricted CI runners—internet access is intentionally disabled. This tool allows developers to declare that a specific test file requires a working connection; if the connection is missing, the tests are skipped rather than failed. This ensures that software can be packaged and tested reliably across diverse infrastructure.

## Installation

To use this tool during development or within a build recipe, install it via one of the following methods:

- **Conda (Bioconda):** `conda install bioconda::perl-test-requiresinternet`
- **CPAN:** `cpanm Test::RequiresInternet`
- **Standard Perl:** `perl -MCPAN -e shell install Test::RequiresInternet`

## Usage Patterns

The module is typically invoked at the beginning of a Perl test script (`.t` file).

### Basic Connectivity Check
To skip all tests in a file if no general internet connection is detected:
```perl
use Test::RequiresInternet;
```

### Testing Specific Services
If your test relies on a specific host or port, you can specify them to ensure the required service is reachable:
```perl
use Test::RequiresInternet ( 'google.com' => 80 );
```

### Multiple Host Verification
You can verify multiple endpoints simultaneously:
```perl
use Test::RequiresInternet ( 
    'google.com' => 80, 
    'github.com' => 443 
);
```

## Expert Tips and Best Practices

### Respecting Build Environment Flags
The module respects the `NO_NETWORK_TESTING` environment variable. If this variable is set to a true value, `Test::RequiresInternet` will skip tests immediately without even attempting a network connection. This is the preferred way to handle "hermetic" builds where network calls are strictly forbidden.

### Placement in Test Scripts
Always place the `use Test::RequiresInternet` statement as early as possible in your test script, ideally before `use Test::More` or any network-heavy module loads. This prevents the script from hanging during the compilation phase if the network is down.

### Socket Dependencies
Note that this module relies on the core `Socket` module. If you are working in a highly stripped-down Perl environment, ensure `Socket` is available, as `Test::RequiresInternet` uses it to attempt low-level connections to the specified hosts.

### Debugging Failures
If tests are skipping unexpectedly, verify that your environment is not accidentally setting `NO_NETWORK_TESTING` or that your local firewall is not blocking the specific ports (usually 80 or 443) used by the module's default connectivity check.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-requiresinternet_overview.md)
- [MetaCPAN Test::RequiresInternet Documentation](./references/metacpan_org_dist_Test-RequiresInternet.md)
- [Changelog and RT Fixes](./references/metacpan_org_dist_Test-RequiresInternet_changes.md)