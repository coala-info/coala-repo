---
name: perl-path-tiny
description: The `perl-path-tiny` skill provides guidance on using the `Path::Tiny` Perl module, a lightweight and fast utility for file path manipulation and file I/O.
homepage: https://github.com/dagolden/Path-Tiny
---

# perl-path-tiny

## Overview
The `perl-path-tiny` skill provides guidance on using the `Path::Tiny` Perl module, a lightweight and fast utility for file path manipulation and file I/O. This tool is designed to replace more complex modules like `File::Spec` or `File::Path` with a simpler, more intuitive API. It is particularly useful for bioinformatics workflows (via Bioconda) and general system scripting where you need to read, write, or traverse the file system with minimal boilerplate.

## Installation
To use this tool, ensure the environment has the module installed.
- **Conda (Bioconda):** `conda install bioconda::perl-path-tiny`
- **CPAN:** `cpanm Path::Tiny`

## Common Patterns and Best Practices

### Perl One-Liners
`Path::Tiny` is highly effective for quick command-line file manipulations using the `-MPath::Tiny` flag.

- **Slurping a file (Reading entire content):**
  ```bash
  perl -MPath::Tiny -e 'print path("file.txt")->slurp'
  ```
- **Spewing to a file (Writing content):**
  ```bash
  perl -MPath::Tiny -e 'path("output.txt")->spew("Hello World")'
  ```
- **Processing lines:**
  ```bash
  perl -MPath::Tiny -e 'path("file.txt")->lines'
  ```

### Core Functional Methods
Based on the tool's capabilities, prioritize these methods for file handling:
- **slurp / slurp_raw:** Use for reading entire files into a scalar. `slurp_raw` is preferred for binary data or files larger than 2GB to avoid encoding overhead.
- **lines / lines_raw:** Use for reading a file into a list of lines. This is more memory-efficient than slurping for large text files.
- **tempdir / tempfile:** Use for creating self-cleaning temporary resources.
- **chmod:** Use to modify file permissions (e.g., `path("script.pl")->chmod(0755)`).
- **move / remove:** Use for filesystem reorganization. Note that `move()` returns the path object of the new location.

### Expert Tips
- **Path Objects:** Always wrap strings in the `path()` constructor to access the library's methods.
- **Chaining:** Methods can often be chained for concise scripts (e.g., `path("dir")->child("file.txt")->touch`).
- **Error Handling:** While the library is "tiny," it throws exceptions for common failures (like spewing to a non-existent directory). Wrap critical operations in `eval {}` or use a try/catch block if using modern Perl.
- **Validation:** Use `is_file` or `is_dir` to validate paths before performing destructive operations.

## Reference documentation
- [anaconda_org_channels_bioconda_packages_perl-path-tiny_overview.md](./references/anaconda_org_channels_bioconda_packages_perl-path-tiny_overview.md)
- [github_com_dagolden_Path-Tiny.md](./references/github_com_dagolden_Path-Tiny.md)
- [github_com_dagolden_Path-Tiny_issues.md](./references/github_com_dagolden_Path-Tiny_issues.md)