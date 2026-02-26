---
name: perl-mro-compat
description: This Perl module provides modern method resolution order functionality while maintaining compatibility with older Perl versions. Use when user asks to set C3 method resolution order, retrieve linear inheritance hierarchies, or ensure consistent method resolution across different Perl installations.
homepage: https://metacpan.org/release/MRO-Compat
---


# perl-mro-compat

## Overview
The `MRO::Compat` module allows developers to write code using the modern `mro::*` syntax (introduced in Perl 5.10) while maintaining compatibility with older Perl installations. It provides a consistent interface for managing Method Resolution Order, ensuring that complex class hierarchies resolve methods predictably regardless of the underlying Perl interpreter version. This is particularly useful for maintaining CPAN modules or enterprise scripts that must run on a wide range of infrastructure.

## Usage and Best Practices

### Basic Implementation
To ensure your script or module uses the best available MRO implementation, always load the module at the beginning of your package:

```perl
package My::Legacy::Class;
use lib 'path/to/conda/envs/bioconda/lib/perl5/site_perl';
use MRO::Compat;
use base qw(Base::Class);

# Set C3 Method Resolution Order
mro::set_mro('My::Legacy::Class', 'c3');
```

### Key Functional Patterns
- **mro::get_linear_isa($classname)**: Returns an array reference of the inheritance hierarchy for the given class, calculated using the currently active MRO (DFS or C3).
- **mro::set_mro($classname, $type)**: Sets the MRO for a specific class. Valid types are 'dfs' (default) and 'c3'.
- **mro::get_mro($classname)**: Returns the name of the MRO currently in use for the specified class.

### Expert Tips
- **Performance**: On Perl 5.10+, `MRO::Compat` acts as a transparent wrapper that does nothing, incurring zero performance penalty. On older Perls, it provides a pure-perl implementation of the C3 algorithm.
- **C3 Linearization**: When using C3, ensure your inheritance graph is "consistent." If the algorithm cannot linearize the hierarchy, it will throw an exception.
- **Dependency Management**: In Bioconda environments, this package is often a dependency for larger frameworks like Catalyst or Moose. If you encounter "mro::get_linear_isa not found" errors in legacy scripts, installing `perl-mro-compat` is the standard fix.

## Reference documentation
- [MRO-Compat on MetaCPAN](./references/metacpan_org_release_MRO-Compat.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-mro-compat_overview.md)