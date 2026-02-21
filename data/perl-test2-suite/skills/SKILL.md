---
name: perl-test2-suite
description: The `Test2::Suite` package is the modern standard for Perl testing, providing a modular and extensible alternative to the legacy `Test::More` ecosystem.
homepage: http://metacpan.org/pod/Test2-Suite
---

# perl-test2-suite

## Overview
The `Test2::Suite` package is the modern standard for Perl testing, providing a modular and extensible alternative to the legacy `Test::More` ecosystem. It allows developers to create robust test suites with better error reporting, event-driven architecture, and built-in support for complex data structure validation and object mocking.

## Core Testing Patterns

### Basic Test Structure
Always start tests with the `Test2::V0` bundle, which includes the most commonly used tools (equivalent to `Test::More` but with stricter, cleaner defaults).

```perl
use Test2::V0;

ok(1, "Basic truth test");
is($value, $expected, "Simple comparison");
like($text, qr/pattern/, "Regex match");

done_testing;
```

### Advanced Comparisons
Use `is()` with specialized check functions for deep data structures:
- `hash { ... }`: Validate specific keys in a hash.
- `array { ... }`: Validate elements in an array.
- `field 'name' => 'value'`: Check a specific hash key.
- `item 0 => 'value'`: Check a specific array index.
- `etc()`: Allow extra keys/items not explicitly defined in the check.

```perl
is(
    $data_structure,
    hash {
        field id => 123;
        field tags => array {
            item 'perl';
            item 'testing';
            etc(); # Ignore additional tags
        };
        etc(); # Ignore additional hash keys
    },
    "Deep structure validation"
);
```

### Mocking
The `mock` tool allows for scoped overriding of subroutines without manual symbol table manipulation.

```perl
use Test2::V0;
use My::Module;

my $mock = mock 'My::Module' => (
    override => [
        fetch_data => sub { return { status => 'mocked' } },
    ],
);

is(My::Module->fetch_data->{status}, 'mocked', "Subroutine was overridden");
$mock = undef; # Original behavior restored when mock goes out of scope
```

### Intercepting Events
To test the testing code itself or to verify that specific warnings/errors are issued, use `intercept`.

```perl
my $events = intercept {
    warn "Something went wrong";
    ok(0, "This should fail");
};

# $events contains an array of event objects to inspect
```

## Best Practices
- **Prefer Test2::V0**: It bundles `Test2::Bundle::Extended`, `Test2::Plugin::DieOnFail`, and other essential tools into a single import.
- **Avoid Manual Plan**: Use `done_testing` at the end of the script instead of `plan tests => n` to make tests more maintainable.
- **Scoped Mocking**: Always keep mock objects in the smallest scope possible to prevent side effects in other tests.
- **Strict Comparisons**: Use `is()` for almost everything; it handles scalars, regexes, and deep structures intelligently based on the second argument.

## Reference documentation
- [Test2::Suite Documentation](./references/metacpan_org_pod_Test2-Suite.md)