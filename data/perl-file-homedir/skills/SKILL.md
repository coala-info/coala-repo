---
name: perl-file-homedir
description: perl-file-homedir is a Perl module that provides a platform-agnostic way to locate home directories and standard system folders. Use when user asks to find the current user's home directory, retrieve paths for special folders like desktop or documents, or locate application data directories across different operating systems.
homepage: https://metacpan.org/release/File-HomeDir
metadata:
  docker_image: "quay.io/biocontainers/perl-file-homedir:1.004--pl526_2"
---

# perl-file-homedir

## Overview
`File::HomeDir` is a Perl module designed to solve the "where is my home directory" problem across different operating systems. While simple in theory, different platforms use different logic (e.g., `HOME` environment variable on Unix vs. Registry/User Profile on Windows). This skill provides the syntax and best practices for using the module to retrieve both the current user's paths and paths for other users on the system.

## Core Usage Patterns

### Basic Home Directory Retrieval
The most common use case is finding the current user's home directory.
```perl
use File::HomeDir;

# The most robust way to get the current user's home
$home = File::HomeDir->my_home;

# Get the home directory for a specific user (Unix-centric)
$other_home = File::HomeDir->users_home('username');
```

### Platform-Agnostic Special Folders
Use these methods to avoid hardcoding "Desktop" or "Documents" which vary by language and OS.
```perl
# Common user directories
$desktop   = File::HomeDir->my_desktop;
$documents = File::HomeDir->my_documents;
$music     = File::HomeDir->my_music;
$pictures  = File::HomeDir->my_pictures;
$videos    = File::HomeDir->my_videos;

# Application data locations (Best for config files)
$data = File::HomeDir->my_data;
```

### Distribution and Installation
If the module is missing from the environment, it can be installed via CPAN or Conda:
- **Conda**: `conda install -c bioconda perl-file-homedir`
- **CPAN**: `cpan File::HomeDir`

## Best Practices
- **Prefer `my_data` for Configs**: Instead of putting dotfiles directly in the home directory, use `File::HomeDir->my_data` to follow platform conventions (like `AppData` on Windows or `~/Library/Application Support` on macOS).
- **Check for Undef**: On some restricted systems or exotic platforms, these methods may return `undef`. Always verify the path exists before attempting to `chdir` or write files.
- **Cross-Platform Path Joining**: Always use `File::Spec` in conjunction with `File::HomeDir` to build full file paths:
  ```perl
  use File::HomeDir;
  use File::Spec;
  my $config_path = File::Spec->catfile(File::HomeDir->my_data, 'app_config.ini');
  ```

## Reference documentation
- [File::HomeDir on MetaCPAN](./references/metacpan_org_release_File-HomeDir.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-file-homedir_overview.md)