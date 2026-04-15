---
name: perl-extutils-manifest
description: This tool manages MANIFEST and MANIFEST.SKIP files to ensure Perl project distributions contain the correct source files while excluding unnecessary artifacts. Use when user asks to create or update a manifest, verify manifest integrity, check for skipped files, or manage file exclusions in a Perl package.
homepage: https://metacpan.org/release/ExtUtils-Manifest
metadata:
  docker_image: "quay.io/biocontainers/perl-extutils-manifest:1.75--pl5321hdfd78af_0"
---

# perl-extutils-manifest

## Overview
This skill provides procedural knowledge for managing the `MANIFEST` and `MANIFEST.SKIP` files within Perl projects. It ensures that distributions contain all necessary source files while excluding build artifacts, version control directories, and temporary files. Use these utilities to maintain distribution integrity and prevent the inclusion of sensitive or redundant data in CPAN-style packages.

## Core Functions
The `ExtUtils::Manifest` module is typically used via one-liners or within a `Makefile.PL`/`Build.PL` script.

### Generating and Updating Manifests
*   **Create a new MANIFEST**: Scans the current directory and writes all found files to `MANIFEST`.
    ```bash
    perl -MExtUtils::Manifest=mkmanifest -e mkmanifest
    ```
*   **Verify Manifest**: Checks if all files listed in `MANIFEST` actually exist and if any files in the directory are missing from the `MANIFEST`.
    ```bash
    perl -MExtUtils::Manifest=fullcheck -e fullcheck
    ```

### Managing Exclusions (MANIFEST.SKIP)
The `MANIFEST.SKIP` file uses regular expressions to determine which files `mkmanifest` should ignore.

*   **Standard Skip Patterns**: Always include patterns for common metadata and VCS directories.
    ```text
    \bCVS\b
    \b\.git\b
    ^MANIFEST\.bak
    ^Makefile$
    ^blib/
    ^pm_to_blib$
    \.old$
    \.tmp$
    ```
*   **Skip Check**: To see which files are currently being skipped based on your skip file:
    ```bash
    perl -MExtUtils::Manifest=skipcheck -e skipcheck
    ```

## Best Practices
*   **Clean before checking**: Always run `make clean` or `realclean` before running `fullcheck` to avoid false positives from build artifacts.
*   **Manifest Fixedness**: Once a distribution is ready for release, ensure `MANIFEST` is sorted alphabetically (the default behavior of `mkmanifest`).
*   **Handling Symlinks**: Be aware that `ExtUtils::Manifest` follows symbolic links; ensure linked targets are intended for distribution.
*   **Automated Cleanup**: Use `manicopy` if you need to move files listed in the manifest to a new directory structure for bundling.

## Reference documentation
- [ExtUtils::Manifest on MetaCPAN](./references/metacpan_org_release_ExtUtils-Manifest.md)