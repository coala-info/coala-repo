---
name: perl-extutils-depends
description: ExtUtils::Depends automates the discovery and sharing of compiler flags, linker flags, and typemaps between C-based Perl extensions. Use when user asks to manage dependencies between XS modules, share C headers across Perl distributions, or configure build variables for modular Perl libraries.
homepage: http://gtk2-perl.sourceforge.net
---


# perl-extutils-depends

## Overview
`ExtUtils::Depends` is a specialized build utility for the Perl ecosystem, primarily used when one C-based Perl extension (XS) needs to link against or use the API of another. It automates the discovery of compiler flags (`INC`), linker flags (`LIBS`), and typemaps required to build "child" modules that depend on "parent" XS modules. This is essential for modularizing C-based Perl libraries, such as the Gtk2/Gtk3 suites, where multiple distributions must share a common C/GObject core.

## Usage Patterns

### In Makefile.PL (The Parent Module)
When creating a module that others will depend on, use `ExtUtils::Depends` to export its configuration.

```perl
use ExtUtils::Depends;

# Define the package and its dependencies (if any)
my $pkg = ExtUtils::Depends->new('My::Parent::Module', 'Other::Required::Module');

# Add files that child modules will need
$pkg->add_typemaps('typemap');
$pkg->install('my_header.h');

# Generate the Makefile data
$pkg->save_config('build/IFiles.pm');

WriteMakefile(
    $pkg->get_makefile_vars,
    # ... other standard metadata
);
```

### In Makefile.PL (The Child Module)
When building a module that depends on an existing XS module, use `ExtUtils::Depends` to retrieve the parent's build settings.

```perl
use ExtUtils::Depends;

# Initialize with the parent module name
my $pkg = ExtUtils::Depends->new('My::Child::Module', 'My::Parent::Module');

WriteMakefile(
    $pkg->get_makefile_vars(
        NAME          => 'My::Child::Module',
        VERSION_FROM  => 'lib/My/Child/Module.pm',
        # Add child-specific XS files or libs here
    )
);
```

## Best Practices
- **Configuration Persistence**: Always use `save_config` in the parent module. This creates an `Inline::Files` (IFiles.pm) module that `ExtUtils::Depends` searches for when a child module calls `new`.
- **Header Installation**: Use the `install` method to ensure C header files are moved to the site-wide architecture-dependent library directory so they are accessible to other compilers.
- **Dependency Chaining**: You can pass multiple parent modules to the constructor. `ExtUtils::Depends` will aggregate all `INC` and `LIBS` flags from the entire dependency tree.
- **Integration with PkgConfig**: For modules wrapping C libraries, combine this with `ExtUtils::PkgConfig` to resolve external system dependencies alongside Perl-level XS dependencies.

## Troubleshooting
- **Missing IFiles.pm**: If a child module fails to find a parent's configuration, verify that the parent module was installed correctly and that its `Inline` files are in the `@INC` path.
- **Symbol Errors**: Ensure that the parent module's shared objects are correctly linked. On some platforms, you may need to explicitly add the parent's library path to `LIBS`.

## Reference documentation
- [ExtUtils::Depends Overview](./references/anaconda_org_channels_bioconda_packages_perl-extutils-depends_overview.md)
- [Gtk2-Perl Project Context](./references/gtk2-perl_sourceforge_net_index.md)