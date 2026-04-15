---
name: perl-moo
description: Perl-moo provides a minimalist, efficient framework for object-oriented programming in Perl that offers essential features like attributes, inheritance, and roles with a small footprint. Use when user asks to define Perl classes, implement object attributes, use roles for code reuse, or create lightweight object-oriented systems compatible with Moose.
homepage: http://metacpan.org/pod/Moo
metadata:
  docker_image: "quay.io/biocontainers/perl-moo:2.005004--pl5321hdfd78af_0"
---

# perl-moo

## Overview
Moo (Minimalist Object Orientation) is a highly efficient, "Moose-lite" framework for Perl. It provides the most essential features of the Moose object system—such as declarative attribute definition, inheritance, and roles—while maintaining a significantly smaller footprint and faster startup time. Use this skill to implement clean, modern Perl objects that remain compatible with the broader Moose ecosystem without the heavy dependency chain.

## Core Implementation Patterns

### Class Definition
To turn a package into a Moo class, simply include `use Moo;`. This automatically enables `strict` and `warnings`.

```perl
package MyProject::User;
use Moo;

# Define attributes
has username => (
    is       => 'ro',
    required => 1,
);

has login_count => (
    is      => 'rw',
    default => 0,
);

1;
```

### Attributes (`has`)
Moo attributes support the following core options:
- `is`: Set to `ro` (read-only), `rw` (read-write), or `rwp` (read-write protected/private setter).
- `required`: Boolean to enforce value provision during instantiation.
- `default`: A constant or a coderef `sub { ... }` to provide a default value.
- `lazy`: Boolean; if true, the attribute is only initialized when first accessed.
- `builder`: The name of a method to call to populate the attribute.
- `trigger`: A coderef executed when the attribute is set.

### Roles and Inheritance
Moo uses `extends` for class inheritance and `with` for consuming roles (via `Role::Tiny`).

```perl
package MyProject::Admin;
use Moo;
extends 'MyProject::User'; # Inheritance
with 'MyProject::Role::Authenticatable'; # Roles

1;
```

### Method Modifiers
Use modifiers to hook into the execution of inherited methods:
- `before`: Run code before the method.
- `after`: Run code after the method.
- `around`: Wrap the method, allowing control over arguments and return values.

```perl
around 'save' => sub {
    my ($orig, $self, @args) = @_;
    print "Starting save...\n";
    my $result = $self->$orig(@args);
    print "Save complete.\n";
    return $result;
};
```

## Expert Tips and Best Practices

### Performance with Sub::Quote
For maximum performance, especially in constructors and accessors, use `Sub::Quote`. Moo can inline these for speed.
```perl
use Sub::Quote;
has id => (
    is      => 'ro',
    default => quote_sub q{ int(rand(1000)) },
);
```

### Namespace Hygiene
Always use `namespace::clean` at the end of your module to prevent Moo's imported keywords (`has`, `extends`, `with`) from leaking as class methods.
```perl
package MyClass;
use Moo;
use namespace::clean;
# ... code ...
1;
```

### Handling Types
Moo does not include a built-in type system. To enforce types, use `isa` with a coderef or integrate `Type::Tiny`.
```perl
use Types::Standard qw(Int);
has age => (
    is  => 'ro',
    isa => Int,
);
```

### Constructor Customization
Use `BUILDARGS` to manipulate arguments before they reach the constructor, and `BUILD` to perform validation or initialization after the object is created.

## Reference documentation
- [Moo - Minimalist Object Orientation](./references/metacpan_org_pod_Moo.md)
- [perl-moo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-moo_overview.md)