---
name: perl-file-sharedir
description: This tool provides a standardized way to locate and access non-executable auxiliary data files associated with Perl modules and distributions. Use when user asks to find shared resource directories, locate specific data files within a Perl module, or ensure portable file path resolution across different installation prefixes.
homepage: https://metacpan.org/release/File-ShareDir
---


# perl-file-sharedir

## Overview
The `perl-file-sharedir` skill provides a standardized way to interact with "sharedir" resources in Perl. While Perl modules typically consist of `.pm` files, many applications require auxiliary data files that are not executable code. This tool allows for the reliable location of these files across different installation prefixes (like those found in Conda environments) without hardcoding absolute paths. It is essential for maintaining portability in Perl-based bioinformatics pipelines and CLI tools.

## Usage Guidance

### Core Functions
Accessing shared files is typically done within Perl scripts using the `File::ShareDir` module.

- **Module-specific data**: Use `module_dir('Module::Name')` to find the directory containing data files for a specific module.
- **Distribution-specific data**: Use `dist_dir('Dist-Name')` to find the directory for an entire distribution.
- **File-specific location**: Use `module_file('Module::Name', 'file.txt')` or `dist_file('Dist-Name', 'file.txt')` to get the exact path to a resource.

### Integration with Conda/Bioconda
When using this tool within a Bioconda environment:
- Ensure the `perl-file-sharedir` package is installed in the active environment to provide the necessary hooks for path resolution.
- The tool automatically handles the relocation of shared files within the Conda prefix (`$CONDA_PREFIX/lib/perl5/site_perl/auto/share`), ensuring that scripts remain functional even if the environment is moved.

### Best Practices
- **Validation**: Always check for the existence of a directory using `dist_dir` within an `eval` block or a `try/catch` equivalent, as the function will throw an exception if the directory is not found.
- **Naming**: When creating your own distributions, ensure the `share/` directory is correctly defined in your `Makefile.PL` or `Build.PL` to ensure `File::ShareDir` can index it during installation.
- **Portability**: Avoid using `__FILE__` or relative paths to find assets; `File::ShareDir` is the standard method for finding shared resources in a way that respects user-defined installation paths.

## Reference documentation
- [File::ShareDir Release Overview](./references/metacpan_org_release_File-ShareDir.md)
- [Bioconda Package Metadata](./references/anaconda_org_channels_bioconda_packages_perl-file-sharedir_overview.md)