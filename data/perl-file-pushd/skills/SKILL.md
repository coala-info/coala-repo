---
name: perl-file-pushd
description: perl-file-pushd provides a scoped guard for directory changes that automatically reverts to the original directory when the guard object goes out of scope. Use when user asks to change directories temporarily within a script, create and enter temporary directories, or manage filesystem navigation safely using the guard pattern.
homepage: https://github.com/dagolden/File-pushd
metadata:
  docker_image: "quay.io/biocontainers/perl-file-pushd:1.016--pl526_0"
---

# perl-file-pushd

## Overview
`perl-file-pushd` (File::pushd) is a Perl module that provides a scoped guard for directory changes. Unlike the standard `chdir`, which permanently alters the process's state, `pushd` creates an object that remembers the original directory. When that object goes out of scope (e.g., at the end of a function or a loop), the directory is automatically reverted. This is a critical pattern for writing robust, side-effect-free scripts that interact with the filesystem.

## Installation
To use this tool in your environment, install it via Conda or CPAN:

```bash
# Via Bioconda
conda install bioconda::perl-file-pushd

# Via CPAN
cpanm File::pushd
```

## Common Patterns and Usage

### Basic Scoped Change
The most common use case is changing a directory within a block. The directory reverts as soon as the variable `$dir` is destroyed.

```perl
use File::pushd;

{
    my $dir = pushd('/path/to/target');
    # Current working directory is now /path/to/target
    # Perform operations...
} 
# Directory automatically reverts to the original here
```

### Temporary Directory Creation
The `tempd` function is a shortcut for creating a temporary directory and pushing into it simultaneously.

```perl
use File::pushd;

my $dir = tempd(); 
# You are now in a fresh temporary directory
# The directory is deleted and you revert back when $dir goes out of scope
```

### One-Liner Usage
You can use `File::pushd` in Perl one-liners to safely perform operations in different directories without manually tracking the return path.

```bash
perl -MFile::pushd -e '{ my $df = pushd("subdir"); system("ls"); } print "Back in: ", `pwd`'
```

## Expert Tips and Best Practices

### Avoid Void Context
**Critical:** Never call `pushd` without assigning the result to a variable.
*   **Wrong:** `pushd('/tmp');` — The object is created and immediately destroyed, reverting the directory change before your next line of code runs.
*   **Right:** `my $guard = pushd('/tmp');`

### Multiple Pushd Objects
Avoid creating multiple `pushd` objects within the same lexical scope unless you strictly intend to nest them. If you assign a new `pushd` object to the same variable name, the previous one is destroyed, causing an immediate revert to the original directory before the second change takes effect.

### Error Handling
`File::pushd` is safer than `chdir` because it uses a "guard" pattern. Even if your script `die`s or encounters an exception inside a block, the object's destructor will attempt to return the process to the original directory, maintaining the integrity of the calling environment.

### Testing with Prove
If you are developing or patching Perl modules that use `File::pushd`, use the `prove` tool to verify behavior:

```bash
# Run all tests
prove -l

# Run a specific test file
prove -lv t/File_pushd.t
```

## Reference documentation
- [anaconda_org_channels_bioconda_packages_perl-file-pushd_overview.md](./references/anaconda_org_channels_bioconda_packages_perl-file-pushd_overview.md)
- [github_com_dagolden_File-pushd.md](./references/github_com_dagolden_File-pushd.md)
- [github_com_dagolden_File-pushd_commits_master.md](./references/github_com_dagolden_File-pushd_commits_master.md)