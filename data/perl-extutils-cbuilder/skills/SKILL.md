---
name: perl-extutils-cbuilder
description: This skill provides guidance on using `ExtUtils::CBuilder`, a Perl module that provides a platform-independent interface for compiling and linking C code.
homepage: http://search.cpan.org/dist/ExtUtils-CBuilder
---

# perl-extutils-cbuilder

## Overview
This skill provides guidance on using `ExtUtils::CBuilder`, a Perl module that provides a platform-independent interface for compiling and linking C code. It is primarily used by build systems (like Module::Build) or scripts that need to generate Perl XS extensions or compiled C utilities on the fly without relying on the presence of a `make` utility.

## Usage Patterns

### Basic Compilation
To compile a C source file into an object file, use the `compile` method. This handles platform-specific compiler flags automatically.

```perl
use ExtUtils::CBuilder;
my $builder = ExtUtils::CBuilder->new();

my $obj_file = $builder->compile(
    source => 'src/my_extension.c',
    include_dirs => ['include'],
    defines => { DEBUG => 1, VERSION => '0.01' }
);
```

### Linking Objects
To create a dynamic library (e.g., a `.so` or `.dll` file) from object files, use the `link` method.

```perl
my $lib_file = $builder->link(
    objects => [$obj_file],
    module_name => 'My::Native::Module',
    extra_linker_flags => '-lm'
);
```

### Handling XS Files
When working with Perl XS (External Subroutine) files, you must first use `ExtUtils::ParseXS` to convert `.xs` to `.c`, then use `CBuilder` to compile the resulting C code.

```perl
# 1. Parse XS to C (using ExtUtils::ParseXS)
# 2. Compile the generated C file
my $obj = $builder->compile(source => 'Module.c');

# 3. Link into a shared object
my $lib = $builder->link(objects => $obj, module_name => 'Module');
```

## Best Practices
- **Object Persistence**: Always capture the return value of `compile()`. The filename of the object file varies by platform (e.g., `.o` vs `.obj`).
- **Clean Up**: Use the `have_compiler()` method to check for a working C compiler before attempting operations to provide graceful failures.
- **Environment Consistency**: `ExtUtils::CBuilder` relies on the configuration used to build Perl itself (`Config.pm`). Ensure your environment variables (like `CC` or `LD`) do not conflict with Perl's internal configuration unless intentional.
- **Include Paths**: Always provide absolute paths or paths relative to the project root for `include_dirs` to avoid issues during multi-stage builds.

## Reference documentation
- [ExtUtils::CBuilder Documentation](./references/metacpan_org_release_ExtUtils-CBuilder.md)