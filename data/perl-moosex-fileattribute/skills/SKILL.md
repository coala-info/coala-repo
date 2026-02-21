---
name: perl-moosex-fileattribute
description: MooseX::FileAttribute is a Moose extension designed to reduce boilerplate when defining attributes that represent filesystem paths.
homepage: https://github.com/moose/MooseX-FileAttribute
---

# perl-moosex-fileattribute

## Overview

MooseX::FileAttribute is a Moose extension designed to reduce boilerplate when defining attributes that represent filesystem paths. It simplifies the process of handling file and directory inputs by automatically applying type constraints and coercions from Path::Class. Instead of manually setting up MooseX::Types::Path::Class with coercion and specific types, developers can use the provided "sugar" functions to define robust file-handling attributes in a single line.

## Implementation Guidance

### Basic Attribute Definition
Replace the standard Moose `has` keyword with `has_file` or `has_directory` to automatically handle path objects.

```perl
package My::App::Config;
use Moose;
use MooseX::FileAttribute;

# Automatically coerces strings to Path::Class::File objects
has_file 'config_file' => (
    is       => 'ro',
    required => 1,
);

# Automatically coerces strings to Path::Class::Dir objects
has_directory 'output_dir' => (
    is      => 'rw',
    default => './output',
);
```

### Enforcing Path Existence
Use the `must_exist` parameter to add a type constraint that ensures the file or directory is present on the disk at the time of attribute initialization.

```perl
has_file 'input_data' => (
    must_exist => 1,
    required   => 1,
);
```

### Working with Path Objects
Because these attributes are promoted to Path::Class objects, you can call Path::Class methods directly on the attribute reader.

```perl
my $app = My::App::Config->new(config_file => '/etc/app.conf');

# Open a filehandle directly from the attribute
my $fh = $app->config_file->openr;

# For directories, use Path::Class::Dir methods
my $subdir = $app->output_dir->subdir('logs');
```

## Expert Tips

*   **Boilerplate Reduction**: Using `has_file` is exactly equivalent to defining an attribute with `isa => 'Path::Class::File'`, `coerce => 1`, and `is => 'ro'` (though you can override `is`).
*   **Constraint Specificity**: Note that the `ExistingFile` constraint (triggered by `must_exist => 1`) is broad and may accept named pipes or ttys if they exist on disk. The `ExistingDir` constraint is strictly limited to directories.
*   **Initialization Order**: If your class needs to create a directory before it is validated, handle the creation in a `BUILD` block or use a default/builder that ensures the path exists before the constraint check triggers.

## Reference documentation
- [MooseX::FileAttribute GitHub Repository](./references/github_com_moose_MooseX-FileAttribute.md)
- [Bioconda perl-moosex-fileattribute Overview](./references/anaconda_org_channels_bioconda_packages_perl-moosex-fileattribute_overview.md)