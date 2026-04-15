---
name: perl-extutils-installpaths
description: This tool resolves installation paths for Perl distributions by mapping file types to their target system directories. Use when user asks to determine Perl module installation locations, configure custom install prefixes, or generate path maps for ExtUtils::Install.
homepage: http://metacpan.org/pod/ExtUtils::InstallPaths
metadata:
  docker_image: "quay.io/biocontainers/perl-extutils-installpaths:0.012--pl526_0"
---

# perl-extutils-installpaths

## Overview
This skill facilitates the resolution of installation paths for Perl distributions. While primarily used as a library within `Build.PL` or custom installation scripts, it is essential for determining where different components of a Perl package (pure-Perl modules, architecture-dependent binaries, scripts, and documentation) should be placed on a target system. It abstracts the complexity of `ExtUtils::Config` and provides a unified interface for handling `destdir`, `prefix`, and `install_base` logic.

## Core Installation Types
The tool categorizes files into specific types. When configuring paths, target these keys:
- `lib`: Pure-Perl modules (.pm, .pod).
- `arch`: Architecture-dependent files (compiled XS/Inline code).
- `script`: Pure-Perl programs.
- `bin`: Compiled binaries (C code).
- `bindoc` / `libdoc`: Manpages for scripts and modules.
- `binhtml` / `libhtml`: HTML documentation.

## Common Implementation Patterns

### Basic Path Resolution
To generate a path map compatible with `ExtUtils::Install`, use the following pattern in a Perl script:

```perl
use ExtUtils::InstallPaths;
use ExtUtils::Install 'install';

# Initialize with options (typically from @ARGV)
my $paths = ExtUtils::InstallPaths->new(
    installdirs  => 'site',
    install_base => '/home/user/perl5',
    dist_name    => 'My-Module'
);

# Get the mapping of source types to destination directories
my $install_map = $paths->install_map;

# Execute the installation
install($install_map, $verbose, 0, $uninst);
```

### Handling Different Installation Targets
Adjust the `installdirs` attribute to switch between system-level and user-level installs:
- `site`: (Default) Installs to the local site-specific directories.
- `vendor`: Installs to directories managed by a distribution packager.
- `core`: Installs to the Perl core directories (rarely used for third-party modules).

### Using Destdir for Packaging
When building packages (RPM, deb), use `destdir` to stage the installation into a temporary directory tree without affecting the live system:

```perl
my $paths = ExtUtils::InstallPaths->new(
    destdir => '/tmp/package-stage',
    prefix  => '/usr'
);
# Files will be mapped to /tmp/package-stage/usr/lib/...
```

## Expert Tips
- **Prefix vs. Install_Base**: Avoid using both simultaneously. `install_base` is generally preferred for modern local-lib style setups as it follows a simpler directory structure (`lib/perl5`), whereas `prefix` attempts to mimic the system's original configuration which can be complex and platform-dependent.
- **Custom Path Overrides**: You can override specific types while leaving others to defaults by passing an `install_path` hashref to the constructor:
  ```perl
  install_path => { script => '/usr/local/bin/custom' }
  ```
- **Validation**: Use `$paths->is_default_installable($type)` to check if a specific component (like manpages) is supported by the current system configuration before attempting to process it.

## Reference documentation
- [ExtUtils::InstallPaths - Metacpan](./references/metacpan_org_pod_ExtUtils__InstallPaths.md)