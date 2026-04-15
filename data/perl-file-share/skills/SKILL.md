---
name: perl-file-share
description: This tool provides a development-aware way to locate and access non-code data files associated with Perl distributions. Use when user asks to locate shared distribution directories, access data files in a Perl project, or manage file paths during Perl module development.
homepage: https://github.com/ingydotnet/file-share-pm
metadata:
  docker_image: "quay.io/biocontainers/perl-file-share:0.25--pl526_1"
---

# perl-file-share

## Overview

The `perl-file-share` tool (provided by the `File::Share` module) is an enhanced version of the standard `File::ShareDir` module. Its primary purpose is to provide a reliable way to access non-code files associated with a Perl distribution. Unlike the standard library, `File::Share` is "development-aware"—it can automatically detect if a module is being loaded from a local development path and will prioritize looking for a `./share/` directory in the current working environment. This makes it an essential tool for developers who want their tests and local execution to behave identically to the final installed version without hardcoding paths.

## Usage and Best Practices

### Basic Implementation
To use the module in a Perl script, import the functions using the `:all` tag. This provides a drop-in replacement for `File::ShareDir` logic.

```perl
use File::Share ':all';

# Locate the shared directory for a specific distribution
my $dir = dist_dir('Package-Name');

# Locate a specific file within the shared directory
my $file = dist_file('Package-Name', 'data_template.txt');
```

### Development Workflow
The main advantage of `perl-file-share` is its ability to resolve paths during the development cycle:
1. **Local Testing**: If you are running code from a repository root, the module looks for a directory named `share/` in that root.
2. **Installed State**: Once the module is installed via CPAN or Conda, it reverts to standard `File::ShareDir` behavior to find the files in the system's site-library.
3. **Integration with Devel::Local**: This module works seamlessly with `Devel::Local` to manage include paths (`@INC`) for multiple source repositories.

### Installation
For environments managed by Conda (specifically Bioconda), install the package using:
```bash
conda install bioconda::perl-file-share
```

### Expert Tips
- **Naming Conventions**: Always ensure your distribution name passed to `dist_dir` matches the name defined in your `Makefile.PL` or `Build.PL`.
- **Directory Structure**: By convention, always place your shared assets in a top-level directory named `share/` within your Perl project.
- **Module Limitations**: Note that `module_dist` and `module_file` functions are currently not supported by this specific extension; it focuses on distribution-level sharing.

## Reference documentation
- [File::Share - Extend File::ShareDir to Local Libraries](./references/github_com_ingydotnet_file-share-pm.md)
- [perl-file-share - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-file-share_overview.md)