---
name: perl-test-lectrotest
description: This tool provides a property-based testing framework for Perl that automatically generates random test cases to verify logical assertions. Use when user asks to define properties for code behavior, generate random test data for stress-testing, or find edge cases using automated trial runs.
homepage: http://metacpan.org/pod/Test::LectroTest
---


# perl-test-lectrotest

## Overview
This skill enables the use of `Test::LectroTest`, a Perl framework inspired by Haskell's QuickCheck. Instead of writing individual unit tests with manual inputs, you define "Properties"—logical assertions about how your code should behave for all possible inputs. The tool then stress-tests these assertions by generating thousands of random trials to find edge cases that break your logic.

## Core Usage Patterns

### Basic Property Declaration
Define properties using the `Property` block. The block requires a generator-binding declaration followed by the test logic.

```perl
use Test::LectroTest;

Property {
    ##[ x <- Int, y <- Int ]##
    MyModule::add($x, $y) == MyModule::add($y, $x);
}, name => "addition_is_commutative";
```

### Common Generators
Generators define the "search space" for your tests. Common types include:
- `Int`: Integers
- `Float`: Floating-point numbers
- `String`: Random strings
- `Bool`: Boolean values
- `List(Generator)`: Lists of a specific type

### Integration with Test::More
To use LectroTest within a standard Perl `Test::Builder` environment (like `Test::More`), use the compatibility module:

```perl
use Test::More tests => 1;
use Test::LectroTest::Compat;

# Now you can use LectroTest properties alongside ok() and is()
hold_property(
    Property {
        ##[ s <- String ]##
        reverse(reverse($s)) eq $s;
    }, name => "double_reverse_is_identity"
);
```

### Adjusting Test Intensity
By default, LectroTest runs 1,000 trials per property. Increase this for critical logic or decrease it for slow functions:

```perl
# Set globally via import
use Test::LectroTest trials => 5000;

# Or configure the TestRunner for specific needs
```

## Regression Testing
When LectroTest finds a counterexample (input that fails the property), you should record it to prevent future regressions.

```perl
# Record failures to a file and play them back in future runs
use Test::LectroTest regressions => "t/lectrotest_regressions.txt";
```

## Expert Tips
- **Meaningful Names**: Always provide a `name` to your properties. When a test fails, LectroTest uses this name to identify which logical assertion was falsified.
- **Counterexample Debugging**: When a property fails, LectroTest prints the specific values of `$x`, `$y`, etc., that caused the failure. Use these values to create a dedicated unit test in `Test::More` for debugging.
- **Lexical Scoping**: Ensure your property blocks are at the first column (no indentation) if you are relying on the automatic test runner to pick them up in a standalone script.

## Reference documentation
- [Test::LectroTest Documentation](./references/metacpan_org_pod_Test__LectroTest.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-lectrotest_overview.md)