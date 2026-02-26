---
name: perl-test-class-moose
description: Perl-test-class-moose provides an xUnit-style testing framework for Perl that utilizes the Moose object system to organize tests into classes and roles. Use when user asks to create object-oriented test suites, manage test lifecycles with startup or teardown methods, share testing logic via roles, or filter and run tests using a class-based runner.
homepage: https://metacpan.org/release/Test-Class-Moose
---


# perl-test-class-moose

## Overview
Test::Class::Moose is a powerful xUnit-style testing framework for Perl that leverages the Moose object system. It is designed for "serious" testing where test suites benefit from object-oriented features like inheritance, roles, and attribute-based configuration. It allows developers to group related tests into classes, making large test suites more maintainable and scalable than traditional procedural test scripts.

## Core Implementation Patterns

### Test Class Structure
Every test class must inherit from `Test::Class::Moose`. Test methods are identified by the `test_` prefix.

```perl
package Tests::For::MyModule;
use Test::Class::Moose;
use MyModule;

sub test_initialization {
    my $test = shift;
    my $obj = MyModule->new();
    ok($obj, 'Object created successfully');
}

1;
```

### Lifecycle Management
Use the built-in lifecycle methods to manage state. These are more robust than standard `BEGIN` or `END` blocks.
- `test_startup`: Runs once before any test methods in the class.
- `test_setup`: Runs before every individual test method.
- `test_teardown`: Runs after every individual test method.
- `test_shutdown`: Runs once after all test methods in the class have finished.

### Using Roles for Shared Logic
Instead of deep inheritance, use `Test::Class::Moose::Role` to share common testing behavior (e.g., database connection helpers) across multiple test classes.

```perl
package TestRole::Database;
use Test::Class::Moose::Role;

has 'db_handle' => ( is => 'rw' );

sub test_setup {
    my $test = shift;
    # Initialize DB handle here
}
```

## Execution and CLI Usage

### The Test Runner
Tests are typically executed via a small `.t` wrapper script (usually `t/run_tests.t`) that invokes the runner.

```perl
use Test::Class::Moose::Runner;
use Tests::For::MyModule;

Test::Class::Moose::Runner->new(
    test_classes => ['Tests::For::MyModule'],
)->runtests;
```

### Filtering and Parallelization
When running tests from the command line via `prove`, you can pass arguments to the runner:
- **Filter by Class**: Use the `test_classes` attribute in the runner to limit scope.
- **Parallel Execution**: Set the `jobs` attribute in the runner or use `prove -j` if the runner is configured to support it.
- **Tagging**: Use Moose attributes to tag tests (e.g., `Tags('api')`) and filter them using the `include_tags` or `exclude_tags` parameters in the runner.

## Best Practices
- **Abstract Base Classes**: Use `is_abstract => 1` for base classes that contain shared logic but should not be executed directly.
- **Independence**: Ensure test methods do not depend on the execution order of other methods. Use `test_setup` to reset state.
- **Reporting**: Use the `statistics` feature of the runner to identify slow-running test classes in large suites.
- **Avoid `Test::More` in Classes**: While `Test::More` functions work, prefer using the methods provided by the `$test` object or standard Moose-based assertions for better integration.

## Reference documentation
- [Test::Class::Moose on MetaCPAN](./references/metacpan_org_release_Test-Class-Moose.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-class-moose_overview.md)