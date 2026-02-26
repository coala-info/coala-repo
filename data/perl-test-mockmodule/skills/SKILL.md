---
name: perl-test-mockmodule
description: This tool allows developers to mock or override subroutines within Perl packages to create isolated unit tests. Use when user asks to mock subroutines, override package methods for testing, or simulate external module behavior in Perl.
homepage: https://github.com/geofffranks/test-mockmodule
---


# perl-test-mockmodule

## Overview
The `perl-test-mockmodule` skill facilitates the creation of isolated Perl unit tests by providing a mechanism to "mock" or override subroutines within specific packages. This tool is particularly useful when the code under test depends on external modules that perform side effects (like database operations or network calls) or have complex logic that is difficult to replicate in a test environment. By using `Test::MockModule`, you can redefine these subroutines to return deterministic values. The overrides remain in effect only as long as the mock object exists, preventing side effects from leaking into other test scripts.

## Installation
Install the module using CPAN or Conda:

```bash
# Via CPAN
cpanm Test::MockModule

# Via Bioconda
conda install bioconda::perl-test-mockmodule
```

## Basic Usage Patterns

### Creating a Mock Object
To begin mocking, create an instance of `Test::MockModule` targeting the package you wish to override.

```perl
use Test::MockModule;

# Target the package to be mocked
my $mock = Test::MockModule->new('My::External::Module');
```

### Mocking Subroutines
Use the `mock` method to provide a new implementation for a subroutine.

```perl
# Replace 'get_data' with a mock that returns a fixed value
$mock->mock('get_data', sub {
    my ($self, $id) = @_;
    return { id => $id, status => 'mocked' };
});
```

### Accessing the Original Subroutine
If you need to call the original implementation within your mock (e.g., for logging or conditional mocking), use the `original` method.

```perl
$mock->mock('calculate', sub {
    my @args = @_;
    print "Intercepted call to calculate\n";
    # Call the original function
    return $mock->original('calculate')->(@args);
});
```

### Unmocking and Scope
Overrides are active as long as the `$mock` object is in scope. To manually revert a specific subroutine before the object is destroyed, use `unmock`.

```perl
$mock->unmock('get_data');
```

## Expert Tips and Best Practices

### Lexical Scoping for Safety
Always declare your mock objects using `my` within the smallest possible scope (e.g., inside a `subtest` or a block). This ensures that if a test fails or exits early, the original subroutines are restored for subsequent tests.

```perl
{
    my $mock = Test::MockModule->new('Net::FTP');
    $mock->mock('new', sub { bless {}, 'MockFTP' });
    # ... run tests ...
} # Overrides are automatically cleared here
```

### Mocking Non-Existent Subs
Use the `define` method if you need to add a subroutine to a package that does not currently exist. Note that `mock` will fail if the subroutine is not already defined in the target package.

### Introspection
In newer versions (v0.180.0+), you can use `mocked_subs()` to see which subroutines are currently being overridden by a specific mock object.

### Handling Persistence Issues
Be cautious with "object persistence" in tests. If the module you are mocking caches data or state internally, mocking the subroutines might not be enough to reset the module's state between tests. You may need to mock the clear/reset methods of that module as well.

## Reference documentation
- [anaconda_org_channels_bioconda_packages_perl-test-mockmodule_overview.md](./references/anaconda_org_channels_bioconda_packages_perl-test-mockmodule_overview.md)
- [github_com_geofffranks_test-mockmodule.md](./references/github_com_geofffranks_test-mockmodule.md)
- [github_com_geofffranks_test-mockmodule_issues.md](./references/github_com_geofffranks_test-mockmodule_issues.md)