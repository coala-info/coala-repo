---
name: perl-role-tiny
description: This tool facilitates the implementation of minimalist roles and trait-based composition in Perl. Use when user asks to define roles, require specific method implementations in classes, or apply roles to objects and packages at runtime.
homepage: http://metacpan.org/pod/Role-Tiny
metadata:
  docker_image: "quay.io/biocontainers/perl-role-tiny:2.002004--pl5321hdfd78af_0"
---

# perl-role-tiny

## Overview
This skill facilitates the implementation of minimalist roles in Perl using the `Role::Tiny` module. Unlike full-blown object systems like Moose or Moo, `Role::Tiny` focuses exclusively on role composition. It allows you to define sets of methods that can be "consumed" by classes, ensuring that the consuming class implements the required interface. It is ideal for projects where memory footprint and startup time are critical, but the architectural benefits of roles (traits) are still desired.

## Core Usage Patterns

### Defining a Role
To create a role, use the `Role::Tiny` module. Define required methods that the consuming class must implement using `requires`.

```perl
package Local::Role::Equippable;
use Role::Tiny;

# Methods the consuming class MUST provide
requires 'item_name', 'weight';

# Methods provided by the role itself
sub describe_item {
    my ($self) = @_;
    return $self->item_name . " (Weight: " . $self->weight . ")";
}

1;
```

### Consuming a Role in a Class
To apply a role to a class, use `Role::Tiny::With`.

```perl
package Local::Weapon;
use Role::Tiny::With;

# Apply the role
with 'Local::Role::Equippable';

sub new { bless { name => $_[1], w => $_[2] }, $_[0] }
sub item_name { $_[0]->{name} }
sub weight    { $_[0]->{w} }

1;
```

### Runtime Role Application
You can apply roles to specific object instances or classes at runtime, which is useful for plugin architectures.

```perl
use Role::Tiny;

# Apply to an instance
Role::Tiny->apply_roles_to_object($my_instance, 'Local::Role::ExtraBehavior');

# Apply to a class
Role::Tiny->apply_roles_to_package('Some::Package', 'Local::Role::Plugin');
```

## Best Practices
- **Interface Validation**: Always use `requires` for methods the role depends on but does not implement. This ensures the consuming class fails at compile-time (or composition-time) if the interface is incomplete.
- **Avoid State**: `Role::Tiny` does not provide an attribute builder (like `has`). If you need attributes, use `Moo::Role` or define getter/setter requirements in your `requires` list.
- **Method Modifiers**: While `Role::Tiny` supports `before`, `around`, and `after` modifiers, use them sparingly to keep the logic flow predictable.
- **Type Checking**: Use `Role::Tiny::does($object, 'Role::Name')` to check if an object consumes a specific role. This is safer than `isa` for trait-based logic.

## Reference documentation
- [Role::Tiny Documentation](./references/metacpan_org_pod_Role-Tiny.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-role-tiny_overview.md)