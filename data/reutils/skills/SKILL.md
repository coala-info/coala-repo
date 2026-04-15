---
name: reutils
description: reutils is a Python-based suite of utilities for inspecting and modifying ELF and PE binaries during reverse engineering and exploit development. Use when user asks to audit binary security protections, patch ELF interpreters to use specific libc versions, or extract System Service Numbers from Windows ntdll.dll files.
homepage: https://github.com/Ayrx/reutils
metadata:
  docker_image: "quay.io/biocontainers/bioconductor-metabocoreutils:1.14.0--r44hdfd78af_0"
---

# reutils

## Overview

reutils is a Python-based suite of utilities designed to automate repetitive tasks in the reverse engineering workflow. It leverages the LIEF (Library to Instrument Executable Formats) project to provide deep inspection and modification capabilities for ELF and PE binaries. Use this skill to quickly audit binary protections or prepare binaries for debugging in specific environments (e.g., matching a remote server's libc version).

## Installation and Dependencies

Before using the scripts, ensure the environment has the necessary dependencies:

- **Python 3**: Required for all scripts.
- **Click**: Used for the command-line interface.
- **LIEF**: Required for binary parsing and modification.

```bash
pip install click
pip install https://github.com/lief-project/LIEF/releases/download/0.9.0/pylief-0.9.0.zip
```

## Core Utilities and Usage

### Security Auditing with `checksec`
Use this utility to verify the security properties of a binary. It supports both ELF (Linux) and PE (Windows) formats.

- **Purpose**: Identify if mitigations like NX (No-Execute), Stack Canaries, ASLR/PIE, and RELRO are enabled.
- **Typical Workflow**: Run this as the first step when analyzing a new challenge or target to determine the exploit primitives available.

### Modifying ELF Binaries with `change_libc`
This is a critical tool for exploit development when you need a local binary to load a specific version of `libc.so.6` (e.g., from a provided Docker container or a specific GLIBC version).

- **Purpose**: Patches the ELF interpreter and the RPATH/RUNPATH to point to a custom libc.
- **Usage Tip**: Ensure the target libc and the corresponding linker (ld-linux.so) are in the same directory before running the script to ensure the binary remains executable.

### Windows Analysis with `parse_ntdll_ssn`
A specialized tool for Windows researchers and malware analysts.

- **Purpose**: Extracts System Service Numbers (SSNs) from `ntdll.dll`.
- **Context**: Useful when building direct syscall stubs for EDR evasion or analyzing changes in syscall numbering between Windows versions.

## Expert Tips

- **Binary Patching**: When using `change_libc`, always keep a backup of the original binary. LIEF modifies the binary structure, and while generally stable, it is best practice to work on a copy.
- **Section Management**: The toolkit includes scripts for handling binary sections. Use these when you need to identify non-standard sections added by packers or protectors.
- **Environment Matching**: For CTF players, use `change_libc` in conjunction with tools like `patchelf` if you need more granular control over symbol versions, though `reutils` provides a more streamlined interface for the common "libc swap" task.

## Reference documentation
- [README.md](./references/github_com_Ayrx_reutils_blob_master_README.md)
- [Commit History](./references/github_com_Ayrx_reutils_commits_master.md)