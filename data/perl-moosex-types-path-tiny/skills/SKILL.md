---
name: perl-moosex-types-path-tiny
description: This tool integrates Path::Tiny types into the Moose type system to provide automatic path coercion and validation for class attributes. Use when user asks to define Moose attributes as Path::Tiny objects, automatically convert strings to absolute paths, or validate that filesystem paths exist as files or directories.
homepage: https://github.com/moose/MooseX-Types-Path-Tiny
---


# perl-moosex-types-path-tiny

## Overview
MooseX::Types::Path::Tiny integrates the lightweight and powerful Path::Tiny library into the Moose type system. It allows developers to define class attributes that automatically convert string input into Path::Tiny objects. This skill should be used to simplify filesystem interactions within Moose classes, ensuring that paths are automatically validated for existence or converted to absolute paths during object instantiation.

## Core Type Constraints
Import these types from `MooseX::Types::Path::Tiny` to use in attribute definitions:

- **Path**: Ensures the attribute is a `Path::Tiny` object. Coerces from strings or objects with overloaded stringification.
- **AbsPath**: Like `Path`, but automatically coerces the path to its absolute form.
- **File / AbsFile**: Validates that the path exists and is a file (`-f`).
- **Dir / AbsDir**: Validates that the path exists and is a directory (`-d`).
- **Paths / AbsPaths**: Handles an `ArrayRef` of paths, coercing each element.

## Implementation Patterns

### Basic Attribute Definition
Always enable `coerce => 1` to allow string inputs to be converted to Path::Tiny objects.

```perl
package My::App::Config;
use Moose;
use MooseX::Types::Path::Tiny qw(Path AbsDir);

# Accepts a string, stores a Path::Tiny object
has 'log_file' => (
    is     => 'ro',
    isa    => Path,
    coerce => 1,
);

# Accepts a relative path string, stores an absolute Path::Tiny object
has 'data_dir' => (
    is     => 'ro',
    isa    => AbsDir,
    coerce => 1,
);
```

### Handling Multiple Paths
Use `Paths` or `AbsPaths` for attributes that require a list of filesystem locations.

```perl
has 'include_dirs' => (
    is     => 'ro',
    isa    => AbsPaths,
    coerce => 1,
);

# Usage:
# My::App::Config->new( include_dirs => [ './lib', '/usr/local/lib' ] );
```

## Expert Tips and Caveats

### Path vs. File/Dir Validation
- Use `Path` when you need to store a path that might not exist yet (e.g., an output file).
- Use `File` or `Dir` only when the existence of the target is a hard requirement for the object to be valid. These types perform a filesystem check (`-f` or `-d`) during coercion/validation.

### File::Temp Integration
Be cautious when passing `File::Temp` objects directly to attributes using these types. Because the coercion stringifies the object to create a new `Path::Tiny` instance, the original `File::Temp` object may go out of scope and trigger an immediate cleanup (deletion) of the temporary file.
**Best Practice**: Use `Path::Tiny->tempfile` or `Path::Tiny->tempdir` instead, as they are designed to work seamlessly with these types.

### Coercion from Objects
These types will coerce any object that has overloaded stringification. This makes the module highly compatible with other URI or Path-related objects, provided they stringify to a valid filesystem path.

## Reference documentation
- [MooseX::Types::Path::Tiny Main Documentation](./references/github_com_moose_MooseX-Types-Path-Tiny.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-moosex-types-path-tiny_overview.md)