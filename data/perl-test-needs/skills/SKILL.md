---
name: perl-test-needs
description: The `perl-test-needs` skill facilitates the implementation of conditional testing in Perl.
homepage: http://metacpan.org/pod/Test::Needs
---

# perl-test-needs

## Overview
The `perl-test-needs` skill facilitates the implementation of conditional testing in Perl. It allows test scripts to automatically skip individual tests, subtests, or entire files when required CPAN modules or specific Perl interpreter versions are unavailable. This is particularly useful for maintaining robust CI/CD pipelines and ensuring that software can be packaged (e.g., via Bioconda) even when non-essential dependencies are missing.

## Usage Patterns

### Compile-Time Requirements
To skip an entire test script if a module is missing, use the module at the top of your `.t` file.

```perl
# Require a single module
use Test::Needs 'JSON::MaybeXS';

# Require multiple modules
use Test::Needs 'LWP::UserAgent', 'HTTP::Request';

# Require a specific version
use Test::Needs { 'Moose' => '2.000' };

# Require a minimum Perl version
use Test::Needs { perl => 5.020 };
```

### Runtime/Conditional Requirements
Use the exported `test_needs` function to check for dependencies dynamically within the flow of a test, such as inside a subtest.

```perl
use Test::More;
use Test::Needs;

subtest 'Optional Feature' => sub {
    test_needs 'DBD::SQLite';
    # If DBD::SQLite is missing, the rest of this subtest is skipped
    my $dbh = DBI->connect("dbi:SQLite:dbname=:memory:", "", "");
    ok($dbh, 'Connected to database');
};
```

## Expert Tips & Best Practices

- **Broken vs. Missing Modules**: `Test::Needs` distinguishes between a module that is simply not installed (which triggers a skip) and a module that is installed but fails to compile due to syntax errors (which triggers a hard failure). This helps catch legitimate bugs in your code.
- **Enforcing Tests in CI**: Set the environment variable `RELEASE_TESTING=1` in your continuous integration environment. When this variable is active, `Test::Needs` will cause tests to **fail** instead of skip if a dependency is missing, ensuring your release environment is fully provisioned.
- **Version Formatting**: When checking versions, provide them exactly as the module's `VERSION` method expects (e.g., `1.005` or `v5.20.0`). `Test::Needs` does not perform internal normalization on version strings.
- **Subtest Behavior**: If `test_needs` fails inside a subtest, only that specific subtest is aborted. The main test script will continue to the next block of code.

## Reference documentation
- [Test::Needs - Skip tests when modules not available](./references/metacpan_org_pod_Test__Needs.md)