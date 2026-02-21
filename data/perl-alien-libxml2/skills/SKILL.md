---
name: perl-alien-libxml2
description: This skill provides guidance on using `Alien::Libxml2`, a Perl module designed to make the C-based `libxml2` library available to other Perl distributions.
homepage: https://metacpan.org/pod/Alien::Libxml2
---

# perl-alien-libxml2

## Overview
This skill provides guidance on using `Alien::Libxml2`, a Perl module designed to make the C-based `libxml2` library available to other Perl distributions. It handles the complexities of probing the system for an existing installation or downloading and building the library from source if it is missing. Use this tool to ensure that XML processing modules have the necessary native dependencies to compile and run correctly across different operating systems.

## Installation and Setup
The primary way to interact with this tool is through the Perl CPAN shell or via Conda if working in a bioinformatics/data science environment.

**Using CPAN:**
```bash
cpanm Alien::Libxml2
```

**Using Conda (Bioconda):**
```bash
conda install -c bioconda perl-alien-libxml2
```

## Common Usage Patterns
`Alien::Libxml2` is typically used within a `Makefile.PL` or `Build.PL` to provide compiler and linker flags for native extensions.

### Retrieving Configuration via CLI
You can query the installation details directly from the command line using Perl's one-liner syntax:

*   **Check if libxml2 is found:**
    ```bash
    perl -MAlien::Libxml2 -e 'print Alien::Libxml2->install_type'
    ```
    *Returns `system` if using a pre-installed library, or `share` if it built its own copy.*

*   **Get Compiler Flags (Cflags):**
    ```bash
    perl -MAlien::Libxml2 -e 'print Alien::Libxml2->cflags'
    ```

*   **Get Linker Flags (Libs):**
    ```bash
    perl -MAlien::Libxml2 -e 'print Alien::Libxml2->libs'
    ```

*   **Get Version:**
    ```bash
    perl -MAlien::Libxml2 -e 'print Alien::Libxml2->config("version")'
    ```

### Forcing a Build from Source
If the system version of libxml2 is broken or too old, you can force the module to download and build its own isolated version by setting the `ALIEN_INSTALL_TYPE` environment variable during installation:

```bash
export ALIEN_INSTALL_TYPE=share
cpanm Alien::Libxml2
```

## Troubleshooting
*   **Missing pkg-config:** `Alien::Libxml2` relies heavily on `pkg-config` to find system libraries. Ensure `pkg-config` is installed on your Linux/macOS system.
*   **Header Conflicts:** If you encounter compilation errors in dependent modules (like `XML::LibXML`), verify that `Alien::Libxml2->cflags` points to the correct directory and does not conflict with other XML library paths in your `CPATH`.
*   **Static vs Dynamic:** By default, the tool prefers dynamic linking. If you require static linking, check the output of `Alien::Libxml2->libs` to ensure it includes the necessary `.a` paths.

## Reference documentation
- [Alien::Libxml2 Documentation](./references/metacpan_org_pod_Alien__Libxml2.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-alien-libxml2_overview.md)