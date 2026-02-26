---
name: perl-test-base
description: The perl-test-base tool provides a data-driven testing framework for Perl that separates test logic from data blocks. Use when user asks to implement data-driven tests in Perl, define test cases in the script's data section, apply custom filters to test inputs, or compare complex multi-line outputs.
homepage: https://github.com/ingydotnet/test-base-pm
---


# perl-test-base

## Overview
The `perl-test-base` skill facilitates the use of the `Test::Base` framework, a powerful extension of `Test::More` designed for data-driven testing in Perl. Instead of embedding test data directly within procedural code, this tool allows you to separate test logic from data by defining test blocks in the `__END__` section of a script. It is particularly effective for testing compilers, parsers, or any system where you need to verify that specific inputs produce specific outputs across many variations.

## Core Usage Patterns

### Basic Test Structure
A standard `Test::Base` file consists of the Perl test logic followed by a data section.

```perl
use Test::Base;

plan tests => 1 * blocks;

run_is 'input' => 'expected';

__END__

=== Test Case One
--- input
raw data here
--- expected
processed data here
```

### Defining Custom Filters
Filters allow you to process data sections before they are compared. You can define them in a separate filter class or locally.

```perl
# Define a local filter
sub local_filter {
    my $input = shift;
    $input =~ s/foo/bar/g;
    return $input;
}

# Use it in the data section
__END__
=== Filter Test
--- input local_filter
foo content
--- expected
bar content
```

### Creating a Reusable Test Base
To avoid repeating setup code, subclass `Test::Base` to create a project-specific testing module.

```perl
# lib/MyProject/Test.pm
package MyProject::Test;
use Test::Base -Base;

# Exported logic for all tests using this module
sub run_my_test {
    my $block = shift;
    is(MyProject->process($block->input), $block->expected, $block->name);
}
```

## Expert Tips and Best Practices

*   **Automated Comparison**: Use `run_compare()` without arguments to automatically detect and compare data sections if you don't want to write explicit `run_is` calls.
*   **Diffing Multi-line Output**: `Test::Base` automatically provides unified diffs for failed multi-line string comparisons if `Text::Diff` is installed. To disable this, set `$ENV{TEST_SHOW_NO_DIFFS} = 1`.
*   **Iterating Blocks**: For complex logic, use the `blocks()` function to get a list of block objects and iterate manually:
    ```perl
    for my $block (blocks()) {
        my $output = some_func($block->input);
        is($output, $block->expected, $block->name);
    }
    ```
*   **Filtering by Section**: Use `blocks('section_name')` to only retrieve test blocks that contain a specific data section.
*   **Custom Delimiters**: If your test data contains `===` or `---`, change the delimiters using `delimiters($block_sep, $data_sep)`.

## Common CLI Patterns

### Running Tests
Since `Test::Base` scripts are standard Perl test files, run them using `prove`:
```bash
prove -l t/my-test.t
```

### Installation
If the environment uses Conda/Bioconda:
```bash
conda install bioconda::perl-test-base
```

## Reference documentation
- [Test::Base - A Data Driven Testing Framework](./references/github_com_ingydotnet_test-base-pm.md)
- [perl-test-base Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-base_overview.md)