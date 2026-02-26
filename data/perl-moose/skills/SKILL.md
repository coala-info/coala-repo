---
name: perl-moose
description: Perl-moose provides a modern, declarative object-oriented framework for Perl that replaces traditional manual class construction. Use when user asks to define classes with attributes, enforce type constraints, implement roles for code reuse, or apply method modifiers.
homepage: http://moose.perl.org/
---


# perl-moose

## Overview
This skill facilitates the use of Moose, the standard for modern Object-Oriented programming in Perl. It replaces traditional, error-prone "blessed hash" mechanics with a declarative syntax. Use this to define robust data structures, enforce type safety, and implement reusable behaviors through Roles.

## Core Implementation Patterns

### Basic Class Definition
Always include `use Moose;` to enable the object system and `no Moose;` with `__PACKAGE__->meta->make_immutable;` at the end to optimize performance.

```perl
package User;
use Moose;

has 'username' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'login_count' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

__PACKAGE__->meta->make_immutable;
1;
```

### Attributes and Type Constraints
*   **is**: Use `ro` (read-only) by default to promote immutability. Use `rw` (read-write) only when state must change.
*   **isa**: Leverage built-in types (`Str`, `Int`, `Bool`, `ArrayRef`, `HashRef`, `Object`).
*   **lazy**: Use `lazy => 1` with a `builder` or `default` for attributes that are expensive to compute or depend on other attributes.
*   **coerce**: Enable `coerce => 1` to automatically transform input data into the required type (requires defined coercions).

### Roles (Composition over Inheritance)
Use Roles to share behavior across unrelated classes.

```perl
package Identifiable;
use Moose::Role;

has 'id' => ( is => 'ro', isa => 'Int', required => 1 );

sub display_id {
    my $self = shift;
    print "ID: " . $self->id;
}
1;

# In another class:
with 'Identifiable';
```

### Method Modifiers
Use these to hook into inherited logic without overriding the entire method:
*   **before**: Validate state or log data before a method runs.
*   **after**: Log results or trigger side effects after a method completes.
*   **around**: Wrap a method to modify arguments or conditionally skip execution.

## Expert Tips
*   **Namespace Cleanup**: Use `namespace::autoclean` in your modules to prevent Moose keywords (like `has`, `with`, `extends`) from being exported as class methods.
*   **Types**: For complex validation, use `MooseX::Types` instead of string-based type names to catch typos at compile time.
*   **Constructor Injection**: Prefer passing dependencies through the constructor (`BUILDARGS`) rather than setting them post-instantiation.

## Reference documentation
- [perl-moose Overview](./references/anaconda_org_channels_bioconda_packages_perl-moose_overview.md)