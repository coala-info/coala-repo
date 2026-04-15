---
name: perl-variable-magic
description: This tool provides a lightweight mechanism to attach custom behaviors and callbacks to Perl variables by intercepting events like fetching, storing, or clearing. Use when user asks to attach magic to variables, intercept variable access or modification, create reactive data structures, or implement performant alternatives to the Perl tie mechanism.
homepage: http://search.cpan.org/dist/Variable-Magic/
metadata:
  docker_image: "quay.io/biocontainers/perl-variable-magic:0.63--pl5321hec16e2b_0"
---

# perl-variable-magic

## Overview
This skill provides guidance on using the `Variable::Magic` Perl module to attach "magic" behaviors to variables. Unlike standard Perl `tie` mechanisms, this module offers a more lightweight and performant way to intercept variable events such as fetching, storing, or clearing. It is particularly useful for debugging, creating reactive data structures, or enforcing strict constraints on variable manipulation without the overhead of full object orientation.

## Implementation Patterns

### Basic Magic Attachment
To use magic, you must first create a "wizard" that defines the callbacks, then apply that wizard to a variable.

```perl
use Variable::Magic qw(wizard cast);

# 1. Define the wizard (the blueprint)
my $wiz = wizard(
    set => sub {
        my ($ref, $data) = @_;
        print "Variable is being changed!\n";
    },
    get => sub {
        my ($ref, $data) = @_;
        print "Variable is being accessed!\n";
    }
);

# 2. Cast the magic onto a variable
my $target = 0;
cast $target, $wiz;
```

### Common Callback Hooks
- `get`: Triggered before the value is retrieved.
- `set`: Triggered after the value is assigned.
- `len`: Triggered when the length is requested (e.g., `scalar @array`).
- `clear`: Triggered when the variable is cleared or deleted.
- `free`: Triggered when the variable is garbage collected.

### Passing Private Data
Wizards can maintain state or context specific to the magic instance using the `data` parameter.

```perl
my $wiz = wizard(
    data => sub { $_[1] }, # Initialize data from cast() argument
    set  => sub {
        my ($ref, $storage) = @_;
        push @$storage, $$ref; # Log history in the private data array
    }
);

my @history;
my $val = 1;
cast $val, $wiz, \@history;
```

## Best Practices
- **Performance**: `Variable::Magic` is faster than `tie`, but excessive magic on frequently accessed variables in tight loops will still impact performance.
- **Scope**: Magic remains on the variable until it is explicitly removed or the variable goes out of scope. Use `dispell` to remove magic manually.
- **Read-only Variables**: Use the `set` hook to throw an exception if a modification is attempted, effectively creating a dynamic constant.
- **Validation**: Use `set` hooks to validate data types or ranges before the assignment is finalized.

## Reference documentation
- [Variable::Magic Documentation](./references/metacpan_org_release_Variable-Magic.md)