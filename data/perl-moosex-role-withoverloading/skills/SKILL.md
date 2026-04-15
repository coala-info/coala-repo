---
name: perl-moosex-role-withoverloading
description: This Perl module allows Moose roles to support operator overloading in legacy environments where this functionality is not natively available in the Moose core. Use when user asks to preserve overloaded operators in Moose roles, fix issues with role-based overloading in older Moose versions, or implement stringification and mathematical operations within a role.
homepage: https://github.com/moose/MooseX-Role-WithOverloading
metadata:
  docker_image: "quay.io/biocontainers/perl-moosex-role-withoverloading:0.17--pl5321h9948957_6"
---

# perl-moosex-role-withoverloading

## Overview

`MooseX::Role::WithOverloading` is a Perl module designed to fix a limitation in older versions of Moose where operator overloading defined within a `Moose::Role` would be lost when that role was applied to a class or another role. 

You should use this skill when:
1. Working with legacy Perl codebases (Moose versions earlier than 2.1300) that require roles to provide overloaded behavior (e.g., stringification, mathematical operations).
2. Troubleshooting issues where `use overload` in a Moose role is not behaving as expected in the consuming class.
3. Planning a migration from this extension to core Moose.

**Note on Deprecation**: This module is deprecated for modern Moose installations. Since Moose version 2.1300, this functionality is built into the core. If your environment supports it, you should upgrade Moose and use standard `Moose::Role` instead.

## Implementation Patterns

### Defining an Overloaded Role
To create a role that supports overloading, replace `use Moose::Role` with `use MooseX::Role::WithOverloading`.

```perl
package My::Overloaded::Role;
use MooseX::Role::WithOverloading;
use overload 
    q{""}    => 'serialize',
    fallback => 1;

has 'id' => ( is => 'ro', isa => 'Int' );

sub serialize {
    my $self = shift;
    return "Object ID: " . $self->id;
}

1;
```

### Consuming the Role
Classes consume the role using the standard `with` keyword. The overloading behavior will be preserved.

```perl
package My::Class;
use Moose;
use namespace::autoclean;

with 'My::Overloaded::Role';

1;

# Usage in main:
# my $obj = My::Class->new(id => 42);
# print $obj; # Outputs: Object ID: 42
```

## Best Practices and Tips

### 1. Check Moose Version First
Before implementing this module, check your Moose version. If you are on 2.1300 or higher, simply use `Moose::Role`.
```bash
perl -MMoose -e 'print $Moose::VERSION'
```

### 2. Use namespace::autoclean
Always use `namespace::autoclean` in your consuming classes to ensure that the role's methods are properly composed and that the namespace remains clean of imported functions, which can sometimes interfere with method resolution in complex overloading scenarios.

### 3. Fallback Parameter
When using `use overload`, it is generally recommended to set `fallback => 1`. This allows Perl to attempt to synthesize missing overloaded operators based on the ones you have defined (e.g., deriving `!=` from `==`).

### 4. Installation via Bioconda
If managing dependencies via Conda, the package is available in the Bioconda channel:
```bash
conda install bioconda::perl-moosex-role-withoverloading
```

## Reference documentation
- [MooseX::Role::WithOverloading Overview](./references/github_com_moose_MooseX-Role-WithOverloading.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_perl-moosex-role-withoverloading_overview.md)