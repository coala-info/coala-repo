---
name: perl-test-object
description: This tool verifies Perl objects by automatically executing registered test handlers for every class in an object's inheritance hierarchy. Use when user asks to register test handlers for Perl classes, verify object behavior across inheritance trees, or run automated tests on Perl objects using object_ok.
homepage: https://github.com/karenetheridge/Test-Object
metadata:
  docker_image: "quay.io/biocontainers/perl-test-object:0.08--0"
---

# perl-test-object

## Overview
The `perl-test-object` skill facilitates the thorough testing of Perl objects by verifying their behavior against every class in their inheritance hierarchy. Instead of manually writing redundant tests for parent class behaviors in every subclass test script, you can register test handlers for specific classes. When an object is passed to the testing function, the tool automatically identifies which registered tests apply based on the object's inheritance and executes them. This ensures that a subclass implementation hasn't inadvertently broken expected behaviors defined at higher levels of the class tree.

## Usage Instructions

### Registering Test Handlers
Test handlers should typically be defined in a dedicated test module or at the beginning of your test suite. Use the `register` method to associate a class name with a block of test code.

```perl
use Test::Object;

# Register tests for a base class
Test::Object->register(
    class => 'My::BaseClass',
    tests => 3, # Optional: specify number of tests in the sub
    code  => sub {
        my $obj = shift;
        ok($obj->can('execute'), 'BaseClass: can execute');
        # ... more tests
    },
);

# Register tests for a subclass
Test::Object->register(
    class => 'My::SubClass',
    code  => sub {
        my $obj = shift;
        is($obj->status, 'active', 'SubClass: status is active');
    },
);
```

### Executing Tests against an Object
In your `.t` scripts, use the `object_ok` function. This single call will trigger all applicable registered tests.

```perl
use Test::More;
use Test::Object;
use My::SubClass;

my $object = My::SubClass->new;

# This will run tests registered for My::SubClass AND My::BaseClass
object_ok($object);

done_testing();
```

## Best Practices and Tips
- **Test Counting**: Be aware that `object_ok` can run a variable number of tests depending on the object's inheritance. If you are using a fixed test plan (e.g., `use Test::More tests => 10;`), ensure your math accounts for every registered handler that will fire.
- **Decoupled Testing**: Create a "Tester" module (e.g., `lib/Test/MyProject.pm`) that contains all your `Test::Object->register` calls. This allows you to maintain your testing logic in one place while keeping your `.t` files clean.
- **Adapter Support**: Because `Test::Object` relies on the `$object->isa($class)` method, it works correctly with adapter objects or mocked objects that override `isa` to advertise compatibility with specific interfaces.
- **Inheritance Safety**: Always register tests for your base classes. This provides a safety net that ensures any new subclass created in the future still adheres to the fundamental requirements of the parent class without writing new code.

## Reference documentation
- [Test::Object GitHub Repository](./references/github_com_karenetheridge_Test-Object.md)
- [Bioconda perl-test-object Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-object_overview.md)