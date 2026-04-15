---
name: perl-moosex-strictconstructor
description: This tool makes Moose constructors throw an error when passed unknown attributes to help catch typos and bugs. Use when user asks to enforce strict constructor arguments, catch invalid attributes during object instantiation, or implement MooseX::StrictConstructor in Perl classes.
homepage: http://metacpan.org/release/MooseX::StrictConstructor
metadata:
  docker_image: "quay.io/biocontainers/perl-moosex-strictconstructor:0.21--pl5321hdfd78af_1"
---

# perl-moosex-strictconstructor

## Overview
This skill provides guidance on implementing `MooseX::StrictConstructor` within Perl object-oriented programming. By default, Moose constructors ignore any arguments that do not correspond to defined attributes. This module changes that behavior to "fail fast," which is essential for catching typos in attribute names and preventing subtle bugs during object instantiation.

## Implementation Patterns

### Basic Usage
To enable strict constructors in a Moose class, simply use the module after `use Moose`:

```perl
package My::App::User;
use Moose;
use MooseX::StrictConstructor;

has 'username' => (is => 'ro', isa => 'Str', required => 1);
has 'email'    => (is => 'rw', isa => 'Str');

__PACKAGE__->meta->make_immutable;
1;
```

### Handling Inheritance
When using inheritance, `MooseX::StrictConstructor` should be used in the base class. It will automatically apply to all subclasses. If a subclass needs to disable this behavior (which is rarely recommended), it must be done explicitly.

### Interaction with BUILD
The strict check happens during the `new()` method call. It validates the hash or hash reference passed to the constructor against the attributes defined in the class and its roles. It does not interfere with `BUILD` or `BUILDARGS` methods, but `BUILDARGS` should be used carefully to ensure it returns a hash reference that only contains valid attributes if you are transforming input.

## Best Practices
- **Always use with make_immutable**: For performance and to ensure the constructor is properly "inlined" with the strict checks, always call `__PACKAGE__->meta->make_immutable` at the end of your class.
- **Role Integration**: If you apply a Role to a class that uses `MooseX::StrictConstructor`, the attributes provided by the Role are automatically recognized as valid.
- **Debugging Typos**: Use this module during development to catch cases where a developer might pass `user_name` instead of `username`. Without this module, `username` would be undef (or trigger a "required" error), but the developer wouldn't know why `user_name` was ignored.

## Reference documentation
- [MooseX::StrictConstructor on MetaCPAN](./references/metacpan_org_release_MooseX__StrictConstructor.md)