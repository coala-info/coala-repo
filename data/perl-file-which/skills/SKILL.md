---
name: perl-file-which
description: This tool provides a platform-independent way to find the full path of an executable across different operating systems. Use when user asks to find the location of an executable, check if a dependency is installed, or resolve absolute paths for system commands.
homepage: https://metacpan.org/pod/File::Which
---


# perl-file-which

## Overview
The `perl-file-which` skill provides a reliable, platform-independent method for finding the full path to an executable. While many systems provide a native `which` or `where` command, this Perl implementation ensures consistent behavior across Linux, macOS, and Windows. It is essential for automation scripts that need to verify the existence of dependencies or resolve absolute paths before execution.

## Usage Patterns

### Command Line Interface
If the `which` wrapper is installed via the package, use it as a drop-in replacement for the system utility:

```bash
# Find the path to an executable
which perl
which gcc
```

### Perl API Usage
For more robust scripting, use the `File::Which` module directly within Perl scripts.

#### Find a single executable
Returns the absolute path if found, or `undef` if not.
```perl
use File::Which;

my $exe_path = which('python3');
if ($exe_path) {
    print "Found python3 at: $exe_path\n";
}
```

#### Find all occurrences
In list context, it returns all instances of the executable found in the PATH.
```perl
use File::Which;

my @paths = which('node');
print "Found " . scalar(@paths) . " versions of node.\n";
```

## Best Practices
- **Cross-Platform Reliability**: Always prefer `File::Which` over backticks like `` `which $cmd` `` or `system("which $cmd")` to ensure your script works on Windows (where the command is typically `where`).
- **Path Resolution**: Use this tool to resolve symbolic links or relative paths to absolute paths before passing them to security-sensitive functions.
- **Dependency Checking**: Use the scalar return value in conditional blocks to gracefully handle missing system dependencies.

## Reference documentation
- [File::Which - Portable implementation of which](./references/metacpan_org_pod_File__Which.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-file-which_overview.md)