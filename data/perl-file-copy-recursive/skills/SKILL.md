---
name: perl-file-copy-recursive
description: This tool performs recursive copying and moving of files and directories while automatically creating missing destination paths. Use when user asks to recursively copy files or directories, move directory trees, or perform pattern-based copying with globbing.
homepage: https://metacpan.org/pod/File::Copy::Recursive
metadata:
  docker_image: "quay.io/biocontainers/perl-file-copy-recursive:0.45--pl5321h7b50bb2_5"
---

# perl-file-copy-recursive

## Overview
The `perl-file-copy-recursive` skill provides a robust interface for managing recursive file system operations. Unlike standard copy utilities, this tool automatically creates missing destination paths and can be configured to preserve file permissions. It is primarily used as a Perl module (`File::Copy::Recursive`) but is highly effective for quick file system manipulations via Perl one-liners or scripts in bioinformatics pipelines and system administration.

## Installation
To ensure the environment has the tool available:
```bash
conda install bioconda::perl-file-copy-recursive
```

## Common Usage Patterns

### Recursive Copying (Files or Directories)
The `rcopy` function is the most versatile as it automatically detects whether the source is a file or a directory.

**Perl One-liner:**
```bash
perl -MFile::Copy::Recursive=rcopy -e 'rcopy("source_path", "destination_path") or die $!'
```

### Recursive Moving
Use `rmove` to transfer a directory tree or file to a new location and remove the source.

**Perl One-liner:**
```bash
perl -MFile::Copy::Recursive=rmove -e 'rmove("old_dir", "new_dir") or die $!'
```

### Pattern-Based Copying (Globbing)
To copy multiple items matching a pattern (e.g., all results folders):
```bash
perl -MFile::Copy::Recursive=rcopy_glob -e 'rcopy_glob("sample_*/results", "backup_dir")'
```

## Expert Tips and Best Practices

### Preserving Permissions
By default, the tool attempts to preserve the mode (permissions) of the original files. To ensure directories are created with specific permissions, set the `$DirPerms` variable:
```perl
use File::Copy::Recursive qw(dircopy);
$File::Copy::Recursive::DirPerms = 0755;
dircopy($source, $target);
```

### Handling Errors (SkipFlop)
In large-scale recursive operations, a single permission error can stop the entire process. Use `SkipFlop` to force the tool to continue copying other files even if one fails:
```perl
local $File::Copy::Recursive::SkipFlop = 1;
rcopy($source, $dest);
```

### Depth Control
To prevent infinite loops or to limit how deep the recursion goes, use the `$MaxDepth` variable (default is 0, which is infinite):
```perl
$File::Copy::Recursive::MaxDepth = 3; # Only go 3 levels deep
```

### Cleaning Up Empty Paths
When moving files, you can force the removal of the parent directory structure if it becomes empty by setting `$RemvBase`:
```perl
local $File::Copy::Recursive::RemvBase = 1;
rmove("path/to/subdir", "new/location"); # Removes 'path/to' if empty after move
```

### Return Values
*   **In Scalar Context:** Returns the total number of files and directories acted upon.
*   **In List Context:** Returns `($num_files_and_dirs, $num_dirs, $depth_traversed)`. Use this for detailed logging in scripts.

## Reference documentation
- [File::Copy::Recursive - Perl extension for recursively copying files and directories](./references/metacpan_org_pod_File__Copy__Recursive.md)
- [perl-file-copy-recursive - bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-file-copy-recursive_overview.md)