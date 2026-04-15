---
name: perl-moosex-role-parameterized
description: This tool enables the creation of flexible Perl roles that act as templates by accepting arguments to customize attributes and methods during consumption. Use when user asks to create parameterized roles, define dynamic attributes or methods in Moose, or implement reusable role templates with custom configuration.
homepage: https://github.com/moose/MooseX-Role-Parameterized
metadata:
  docker_image: "quay.io/biocontainers/perl-moosex-role-parameterized:1.11--pl5321hdfd78af_0"
---

# perl-moosex-role-parameterized

## Overview

The `MooseX::Role::Parameterized` skill enables the creation of highly flexible Perl roles that go beyond static code sharing. While standard Moose roles are fixed, parameterized roles act as templates. When a class consumes a parameterized role, it passes specific arguments that the role uses to customize itself—such as naming attributes, setting default values, or generating specific method logic. This is particularly useful for repetitive patterns like "Counter" or "Plugin" architectures where the core logic remains the same but the target attributes or identifiers vary.

## Implementation Patterns

### Basic Role Definition
To create a parameterized role, use the `parameter` keyword to define the inputs and a `role` block to define the implementation.

```perl
package My::Parameterized::Role;
use MooseX::Role::Parameterized;

# 1. Define parameters (similar to Moose 'has')
parameter 'attribute_name' => (
    isa      => 'Str',
    required => 1,
);

# 2. Define the role implementation block
role {
    my $p = shift; # The parameter object
    my $attr = $p->attribute_name;

    # Define attributes dynamically
    has $attr => (
        is  => 'rw',
        isa => 'Int',
    );

    # Define methods using the required 'method' keyword
    method "clear_$attr" => sub {
        my $self = shift;
        $self->$attr(0);
    };
};
```

### Consuming the Role
Pass a hashref of values to the `with` statement in your Moose class.

```perl
package My::Class;
use Moose;

# The role is customized for 'score'
with 'My::Parameterized::Role' => {
    attribute_name => 'score',
};

# Resulting class has:
# - attribute: score
# - method: clear_score
```

## Expert Tips and Best Practices

### Method Declaration Syntax
**Critical Requirement**: Inside the `role { ... }` block, you must use the `method NAME => sub { ... };` syntax rather than the standard `sub NAME { ... }`. This is a Perl limitation; using the `method` keyword ensures that the method is correctly associated with the role being generated and allows you to use parameters within the method name or body.

### Parameter Object Benefits
The `$p` variable shifted off in the role block is a full Moose object. This allows you to:
*   Use `isa` for type constraint validation of parameters.
*   Set `default` or `lazy` values for parameters.
*   Use `required => 1` to ensure the consuming class provides necessary configuration.

### Dynamic Attribute Naming
Use parameterized roles to avoid naming collisions. If a class needs to consume the same role logic twice for different purposes, parameters allow you to prefix or suffix the generated attributes and methods to keep them distinct.

### Installation
If managing dependencies via Conda/Bioconda:
```bash
conda install bioconda::perl-moosex-role-parameterized
```

## Reference documentation
- [MooseX::Role::Parameterized GitHub Repository](./references/github_com_moose_MooseX-Role-Parameterized.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-moosex-role-parameterized_overview.md)