---
name: perl-extutils-pkgconfig
description: This tool provides a Perl interface to the pkg-config utility for querying library metadata and configuration flags. Use when user asks to find C library paths for Perl extensions, check library version constraints, or integrate pkg-config functionality into a Makefile.PL.
homepage: http://gtk2-perl.sourceforge.net
metadata:
  docker_image: "quay.io/biocontainers/perl-extutils-pkgconfig:1.16--pl526_1"
---

# perl-extutils-pkgconfig

## Overview

`ExtUtils::PkgConfig` is a Perl-based wrapper for the `pkg-config` utility. Its primary purpose is to simplify the configuration of Perl extensions that interface with C libraries (Gtk+, Glib, Cairo, etc.). Instead of hardcoding paths or manually parsing `pkg-config` output, this tool allows Perl developers to query library metadata programmatically, ensuring that the correct include paths and library locations are used during the compilation and linking phases of a Perl module.

## Usage Patterns

### Integration in Makefile.PL

The most common use case is within a `Makefile.PL` to dynamically set `INC` and `LIBS` parameters for `WriteMakefile`.

```perl
use ExtUtils::PkgConfig;

# Basic check and retrieval
my %pkg_info = ExtUtils::PkgConfig->find('glib-2.0');

WriteMakefile(
    NAME         => 'My::Module',
    VERSION_FROM => 'lib/My/Module.pm',
    LIBS         => $pkg_info{libs},
    INC          => $pkg_info{cflags},
);
```

### Version Constraints

You can enforce specific version requirements for dependencies directly through the Perl interface:

```perl
# Will die if version requirements are not met
my %pkg_info = ExtUtils::PkgConfig->find('gtk+-2.0 >= 2.10.0');
```

### Handling Multiple Packages

To query multiple libraries simultaneously (concatenating flags):

```perl
my %pkg_info = ExtUtils::PkgConfig->find('glib-2.0', 'gthread-2.0');
# $pkg_info{libs} now contains flags for both libraries
```

### Error Handling

If a package is not found or the version is incorrect, `find()` will `die` with a descriptive message. If you need to handle the failure gracefully, use an `eval` block:

```perl
my %pkg_info;
eval { %pkg_info = ExtUtils::PkgConfig->find('libsecret-1'); };
if ($@) {
    warn "Optional dependency libsecret-1 not found: $@";
}
```

## Best Practices

- **Prefer find() over manual backticks**: Using `ExtUtils::PkgConfig->find('lib')` is more portable and provides better error reporting than manually executing `` `pkg-config --cflags --libs lib` ``.
- **Use in XS Development**: This tool is essential when working with the `Gtk2-Perl` stack or any module requiring `ExtUtils::Depends`.
- **Check for existence**: Use `ExtUtils::PkgConfig->exists('package-name')` if you only need to verify a library's presence without retrieving flags.

## Reference documentation

- [gtk2-perl_sourceforge_net_index.md](./references/gtk2-perl_sourceforge_net_index.md)