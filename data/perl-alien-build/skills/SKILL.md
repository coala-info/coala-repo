---
name: perl-alien-build
description: `Alien::Build` is the industry-standard Perl framework for finding or building external libraries and tools that Perl modules depend on.
homepage: https://metacpan.org/pod/Alien::Build
---

# perl-alien-build

## Overview
`Alien::Build` is the industry-standard Perl framework for finding or building external libraries and tools that Perl modules depend on. It utilizes a domain-specific language (DSL) defined in an `alienfile` to probe the host system for existing software (usually via `pkg-config`) or to download and compile the software from source if it is absent. This skill guides the implementation of these build recipes and the integration with Perl installers like `ExtUtils::MakeMaker`.

## Command Line and Environment Control

### Forcing Installation Types
The most critical CLI interaction with `Alien::Build` is controlling whether the tool uses a system-provided library or builds its own "share" copy.
*   **Force System Install**: `ALIEN_INSTALL_TYPE=system cpanm Alien::Libfoo`
    *   Use when you know the header files and libraries are already in the system path.
*   **Force Source Build**: `ALIEN_INSTALL_TYPE=share cpanm Alien::Libfoo`
    *   Use when the system version is too old, missing, or you need a specific configuration.

### Debugging and Logging
If a build fails, use the logging plugin capabilities to inspect the process:
*   **Enable Verbose Logging**: Set `ALIEN_BUILD_LOG=1` in your environment before running the installer.
*   **Log Implementation**: `Alien::Build::Log` manages how output is displayed. By default, it uses `Alien::Build::Log::Default`.

## Alienfile Best Practices
The `alienfile` is the core configuration. Follow these patterns for robust builds:

### Probing for System Libraries
Use the `PkgConfig` plugins to detect existing installations:
*   **Negotiate**: Use `plugin 'PkgConfig::Negotiate' => (pkgname => 'foo')` to automatically select the best `pkg-config` implementation available on the system.
*   **Command Line**: If the system has a non-standard `pkg-config`, `Alien::Build::Plugin::PkgConfig::CommandLine` can be used to interface with the binary directly.

### Downloading and Fetching
*   **Negotiate Downloads**: Use `plugin 'Download::Negotiate'` to allow the tool to decide between `curl`, `wget`, or Perl-based fetchers based on what is installed on the user's system.
*   **Digest Verification**: Always include `plugin 'Digest::Negotiate' => ( sha256 => '...' )` to ensure the integrity of downloaded source tarballs.

### Building
*   **Autoconf**: For standard C libraries, use `plugin 'Build::Autoconf'`. This handles the `./configure`, `make`, `make install` workflow automatically, including logic for cross-compilation.

## Installer Integration
To use `Alien::Build` in a Perl distribution, you must integrate it into the `Makefile.PL` or `Build.PL`:

### ExtUtils::MakeMaker (MM)
In your `Makefile.PL`, use `Alien::Build::MM` to wrap the configuration:
```perl
use Alien::Build::MM;
my $abmm = Alien::Build::MM->new;

WriteMakefile(
  $abmm->mm_args(
    NAME => 'Alien::LibFoo',
    DISTNAME => 'Alien-LibFoo',
    # ... standard MM args
  )
);
```

## Expert Tips
*   **Interpolation**: Use `Alien::Build::Interpolate` to handle platform-specific pathing and command differences (e.g., using `%{make}` instead of hardcoding `make`).
*   **Conda Environments**: When working within Bioconda, ensure `perl-alien-build` is installed via `conda install bioconda::perl-alien-build` to ensure the Perl environment correctly maps to Conda's library paths.
*   **Testing**: Use `Test::Alien` (not listed in references but standard companion) to verify that the resulting Alien module provides the expected compiler and linker flags.

## Reference documentation
- [Alien::Build](./references/metacpan_org_pod_Alien__Build.md)
- [Alien::Build::MM](./references/metacpan_org_pod_Alien__Build__MM.md)
- [Alien::Build::Plugin::Download::Negotiate](./references/metacpan_org_pod_Alien__Build__Plugin__Download__Negotiate.md)
- [Alien::Build::Plugin::PkgConfig::Negotiate](./references/metacpan_org_pod_Alien__Build__Plugin__PkgConfig__Negotiate.md)
- [Alien::Build::Plugin::Build::Autoconf](./references/metacpan_org_pod_Alien__Build__Plugin__Build__Autoconf.md)
- [Alien::Build::Log](./references/metacpan_org_pod_Alien__Build__Log.md)