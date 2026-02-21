---
name: fis-gtm
description: FIS GT.M is a high-performance, hierarchical database engine optimized for transaction processing.
homepage: https://github.com/luisibanez/fis-gtm
---

# fis-gtm

## Overview
FIS GT.M is a high-performance, hierarchical database engine optimized for transaction processing. This skill provides the procedural knowledge required to compile the engine from source code. It covers the prerequisite environment configuration, the specific use of tcsh for build scripts, and the management of build types (production, debug, and beta) using the project's custom makefile system.

## Environment Setup
GT.M requires a specific environment configuration before compilation. You must use `tcsh` to execute the build scripts.

1.  **Required Variables**: Define the following in your shell:
    *   `gtm_curpro`: Path to an existing GT.M binary installation (required for bootstrapping).
    *   `gtm_exe`: Set to `$gtm_curpro`.
    *   `gtm_tools` & `gtm_inc`: Set to `$PWD/sr_linux`.
    *   `HOSTOS`: Set to `uname -s`.
    *   `gtm_icu_version`: The major.minor version of ICU (e.g., 3.8). Obtain via `icu-config --version`.

2.  **Platform Specifics**:
    *   **Ubuntu**: You must set `setenv distro ubuntu` to avoid "missing separator" errors caused by the builtin echo command.
    *   **32-bit on 64-bit**: Set `setenv OBJECT_MODE 32` if targeting 32-bit architecture on an x86_64 machine.

3.  **Initialization**:
    ```tcsh
    setenv gtm_version_change 1
    source sr_unix/gtm_env.csh
    ```

## Build Patterns
The build system uses `gmake` with specific include paths and parameters.

### Standard Production Build
To build the production version:
```bash
gmake -f sr_unix/comlist.mk -I./sr_unix -I./sr_linux gtm_ver=$PWD
```

### Targeted Build Types
Use the `buildtypes` parameter to specify `pro` (production), `dbg` (debug), or `bta` (beta).
```bash
# Build only the debug version
gmake -f sr_unix/comlist.mk -I./sr_unix -I./sr_linux buildtypes=dbg gtm_ver=$PWD
```

### Cleaning the Build
Append `clean` to the make command to remove previous build artifacts:
```bash
gmake -f sr_unix/comlist.mk -I./sr_unix -I./sr_linux buildtypes=pro gtm_ver=$PWD clean
```

## Packaging
Once the binaries are built, create a distributable tarball using the `package` target:
```bash
gmake -f sr_unix/comlist.mk -I./sr_unix -I./sr_linux buildtypes=pro gtm_ver=$PWD package
```

## Troubleshooting
*   **Obsolete Option Warnings**: The warning `cc1: note: obsolete option -I- used` can be safely ignored.
*   **Missing Separator Error**: If you encounter `chk2lev.mdep:2: *** missing separator. Stop.`, ensure `distro` is set to `ubuntu` and run a `clean` build.
*   **ICU Versioning**: Ensure `gtm_icu_version` only contains two parts (e.g., 4.2, not 4.2.1).

## Reference documentation
- [GT.M Source README](./references/github_com_luis_ibanez_fis-gtm.md)