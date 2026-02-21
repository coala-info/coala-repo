---
name: perl-namespace-autoclean
description: The `namespace::autoclean` pragma is a tool for Perl developers to maintain clean package interfaces.
homepage: https://github.com/moose/namespace-autoclean
---

# perl-namespace-autoclean

## Overview
The `namespace::autoclean` pragma is a tool for Perl developers to maintain clean package interfaces. In Perl, any function imported into a package via `use` or `import` normally becomes available as a method on that package's objects. This skill provides the procedural knowledge to use `namespace::autoclean` to automatically remove these imported symbols at the end of the compilation cycle. This ensures that while the functions remain available for internal use within the package code, they are not reachable as external methods, thereby preserving the integrity of the class's public API.

## Usage Patterns and Best Practices

### Basic Implementation
Place the pragma at the top of your package definition. It will clean all functions imported both before and after its declaration.

```perl
package My::Class;
use Moose;
use namespace::autoclean;
use List::Util qw(first);

sub find_item {
    my ($self, $list) = @_;
    return first { $_->is_valid } @$list; # 'first' works here
}

# External call $obj->first will fail as expected.
```

### Cleaning Internal Helpers
If you define local helper functions that are not intended to be methods, use the `-also` parameter. This accepts a string, an array reference of names, a regex, or a coderef.

```perl
# Clean specific helpers
use namespace::autoclean -also => ['_private_helper', '_internal_util'];

# Clean all functions starting with an underscore using regex
use namespace::autoclean -also => qr/^_/;

# Clean using a predicate
use namespace::autoclean -also => sub { $_ =~ m/^tmp_/ };
```

### Preserving Specific Imports
If an imported function must remain available as a method, use the `-except` parameter.

```perl
use namespace::autoclean -except => 'required_method';
```

### Integration with Moo Roles
When using `Moo`, the order of operations is critical. If you consume roles at compile time (inside a `BEGIN` block), `namespace::autoclean` might inadvertently clean the methods provided by those roles.

**Correct Pattern for Moo:**
```perl
package My::MooClass;
use Moo;
use namespace::autoclean;

# Declare 'with' AFTER autoclean to ensure role methods are maintained
with 'My::Role'; 
```

### Creating Custom Cleaners (Exporters)
If you are writing a wrapper module or an exporter that should clean the calling package, use the `-cleanee` switch.

```perl
package My::Custom::Exporter;
use namespace::autoclean (); # Load without cleaning current package

sub import {
    my $target = caller;
    namespace::autoclean->import(
        -cleanee => $target,
    );
}
```

## Expert Tips
- **Method Detection:** `namespace::autoclean` is "Moose-aware." It uses `Class::MOP` to distinguish between actual methods and imported functions. In non-Moose classes, it identifies anything defined within the package as a method.
- **Overload Support:** The pragma automatically detects and ignores magic subs installed by the `overload` module, so operator overloading will not be broken by cleanup.
- **Performance:** Because the cleaning happens at the end of the compilation cycle (via `B::Hooks::EndOfScope`), there is zero runtime performance penalty for the method resolution of remaining methods.

## Reference documentation
- [perl-namespace-autoclean Overview](./references/anaconda_org_channels_bioconda_packages_perl-namespace-autoclean_overview.md)
- [namespace::autoclean Documentation](./references/github_com_moose_namespace-autoclean.md)