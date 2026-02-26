---
name: perl-file-path
description: The perl-file-path module provides functions for creating and removing directory trees recursively in Perl. Use when user asks to create nested directories, delete directory branches, or manage cross-platform filesystem paths.
homepage: http://metacpan.org/pod/File::Path
---


# perl-file-path

## Overview
The `File::Path` module is the standard Perl utility for recursive directory management. It allows for the creation of deeply nested paths in a single call and the removal of entire directory branches. This skill focuses on the functional interface provided by the module to ensure cross-platform compatibility and error handling when manipulating the filesystem.

## Core Functions

### Creating Directories
Use `make_path` to create nested directories. It accepts a list of paths and an optional hash of parameters.

```perl
use File::Path qw(make_path);

# Simple creation
make_path('data/logs/daily', 'backup/old');

# With options
make_path('archive/reports', {
    verbose => 1,
    mode    => 0755,
    error   => \my $err,
});
```

### Removing Directories
Use `remove_tree` to delete directories and their contents recursively.

```perl
use File::Path qw(remove_tree);

# Simple removal
remove_tree('tmp/work_dir');

# With safety and feedback options
remove_tree('data/cache', {
    verbose => 1,
    safe    => 1, # Does not delete files that are read-only
    keep_root => 1, # Deletes contents but keeps the directory itself
    error   => \my $err,
});
```

## Best Practices and Tips

- **Error Handling**: Always use the `error` parameter in production scripts. It populates an array reference with hashes containing the file/directory name and the associated error message.
- **Permissions**: When using `mode`, remember that it is modified by the current `umask`. If you need exact permissions, apply them after creation or adjust the umask.
- **One-Liners**: For quick filesystem cleanup or setup via CLI:
  - Create: `perl -MFile::Path=make_path -e 'make_path("a/b/c")'`
  - Remove: `perl -MFile::Path=remove_tree -e 'remove_tree("a/b/c")'`
- **Legacy Support**: Avoid using `mkpath` and `rmtree` in new code; they are older aliases for `make_path` and `remove_tree` with less flexible error handling.

## Reference documentation
- [File::Path - Create or remove directory trees](./references/metacpan_org_pod_File__Path.md)