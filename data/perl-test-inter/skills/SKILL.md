---
name: perl-test-inter
description: perl-test-inter (implemented via the `Test::Inter` module) provides a streamlined framework for Perl testing that prioritizes readability and maintainability.
homepage: https://metacpan.org/pod/Test::Inter
---

# perl-test-inter

## Overview
perl-test-inter (implemented via the `Test::Inter` module) provides a streamlined framework for Perl testing that prioritizes readability and maintainability. Instead of writing individual test assertions for every scenario, it allows you to define test cases as data structures. This approach is particularly effective for functions that take specific inputs and produce predictable outputs, as it handles the boilerplate of comparison and reporting automatically.

## Implementation Patterns

### Basic Test Structure
Initialize the testing object and define tests in a concise format:

```perl
use Test::Inter;
my $ti = new Test::Inter;

# Define a function to test
sub my_func {
    my ($input) = @_;
    return $input * 2;
}

# Run tests: [ [input1, input2], expected_output, "Test Name" ]
$ti->tests(
    func  => \&my_func,
    tests => [
        [ [2], 4, "Double two" ],
        [ [5], 10, "Double five" ],
    ]
);
```

### Handling Multiple Arguments
When a function takes multiple arguments, wrap them in an anonymous array:

```perl
sub add { $_[0] + $_[1] }

$ti->tests(
    func  => \&add,
    tests => [
        [ [1, 2], 3, "Add 1 and 2" ],
        [ [10, -5], 5, "Add 10 and -5" ],
    ]
);
```

### Interactive Testing and Filtering
`Test::Inter` supports interactive features that can be triggered via command-line arguments when running the test script:

- **Run specific tests**: Pass test numbers as arguments to skip others.
  `perl test.t 1 3-5`
- **Quiet mode**: Use the `-q` flag to suppress non-error output.
- **Verbose mode**: Use the `-v` flag for detailed diagnostic information.

## Best Practices
- **Use for Table-Driven Tests**: Reserve this tool for scenarios where you have many similar test cases that would otherwise result in "copy-paste" code using `Test::More`.
- **Leverage Smart Comparisons**: The framework automatically handles scalar, list, and hash comparisons. Use the `mode` parameter in the `tests` method if you need to force a specific comparison type (e.g., `mode => 'list'`).
- **Clean Up with done_testing**: Always ensure the script ends correctly by calling `$ti->done_testing()` if not using a predefined test count.
- **Group Related Tests**: Use multiple `$ti->tests()` calls within a single script to group different functions or logical sections, providing a clear description for each block.

## Reference documentation
- [Test::Inter Documentation](./references/metacpan_org_pod_Test__Inter.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-inter_overview.md)